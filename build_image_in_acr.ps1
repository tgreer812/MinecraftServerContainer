# Load configuration from JSON file
$config = Get-Content -Raw -Path "./config.json" | ConvertFrom-Json

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
az acr task create --registry $config.registryName --name $config.taskName --image "$($config.imageName):{{.Run.ID}}" --context $config.githubRepo --file $config.dockerfilePath --commit-trigger-enabled false --pull-request-trigger-enabled false
Check-Error "Failed to create ACR task. Exiting."

# Run ACR task
Write-Host "Running ACR task..."
az acr task run --registry $config.registryName --name $config.taskName
Check-Error "Failed to run ACR task. Exiting."

Write-Host "Done."
pause
