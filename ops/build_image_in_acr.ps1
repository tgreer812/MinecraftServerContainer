param (
    [string]$configPath,
    [bool]$forge
)

# Load configuration from JSON file
$config = Get-Content -Raw -Path $configPath | ConvertFrom-Json

# Set forge to false if not specified
if (-not $forge) {
    $forge = $false
    Write-Host "Forge not specified. Defaulting to false."
} else {
    $forge = $true
    Write-Host "Forge specified. Using true."
}

# Function to check for errors and exit if an error occurs
function Check-Error {
    param ($message)
    if ($LASTEXITCODE -ne 0) {
        Write-Host $message
        exit $LASTEXITCODE
    }
}

# Verify the registry name
Write-Host "Verifying the registry name..."
$registryExists = az acr list --query "[?name=='$($config.registryName)'] | length(@)" --output tsv
if ($registryExists -eq 0) {
    Write-Host "Registry name '$($config.registryName)' does not exist. Exiting."
    exit 1
}

Write-Host "Registry name '$($config.registryName)' verified."

# Generate a random UUID for the image tag
$uuid = [guid]::NewGuid().ToString()

# Log configuration for debugging
Write-Host "Configuration:"
Write-Host "Registry Name: $($config.registryName)"
Write-Host "Task Name: $($config.taskName)"
Write-Host "Image Name: $($config.imageName):$uuid"
Write-Host "GitHub Repo: $($config.githubRepo)"
Write-Host "Dockerfile Path: $($config.dockerfilePath)"

# Create ACR task with source control triggers disabled
Write-Host "Creating ACR task..."

# Define the command parts
$commandParts = @(
    "az acr task create",
    "--registry $($config.registryName)",
    "--name $($config.taskName)",
    "--image $($config.imageName):$uuid",  # Use generated UUID
    "--context $($config.githubRepo)",
    "--file $($config.dockerfilePath)",
    "--commit-trigger-enabled false",
    "--pull-request-trigger-enabled false"
)

# Add build argument if specified
if ($forge -eq $true) {
    $commandParts += "--arg USE_FORGE=true"
}

# Join the command parts into a single string
$command = $commandParts -join " "

# Output the full command (for debugging)
Write-Host "Running command: $command"

# Run the command
Invoke-Expression $command
Check-Error "Failed to create ACR task. Exiting."

Write-Host "ACR task created successfully."

# Run the ACR task
Write-Host "Running ACR task..."
az acr task run --registry $config.registryName --name $config.taskName
