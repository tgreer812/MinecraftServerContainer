param (
    [string]$configPath,
    [bool]$forge
)

# Load configuration from JSON file
$config = Get-Content -Raw -Path $configPath | ConvertFrom-Json

# Set forge to false if not specified
if (-not $forge) {
    $forge = $false
} else {
    $forge = $true
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

# Log configuration for debugging
Write-Host "Configuration:"
Write-Host "Registry Name: $($config.registryName)"
Write-Host "Task Name: $($config.taskName)"
Write-Host "Image Name: $($config.imageName):{{.Run.ID}}"
Write-Host "GitHub Repo: $($config.githubRepo)"
Write-Host "Dockerfile Path: $($config.dockerfilePath)"

# Create ACR task with source control triggers disabled
Write-Host "Creating ACR task..."

# Initialize the base command
$command = "az acr task create"

# Add arguments one at a time
$command += " --debug"
$command += " --verbose"
$command += " --registry $($config.registryName)"
$command += " --name $($config.taskName)"
$command += " --image $($config.imageName):{{.Run.ID}}"
$command += " --context $($config.githubRepo)"
$command += " --file $($config.dockerfilePath)"
$command += " --commit-trigger-enabled false"
$command += " --pull-request-trigger-enabled false"

# Add the build argument if the forge flag is set
if ($forge) {
    $command += " --arg USE_FORGE=true"
}

# Output the full command (for debugging)
Write-Host "Running command: $command"

# Run the command
Invoke-Expression $command
Check-Error "Failed to create ACR task. Exiting."


Write-Host "Done."
pause
