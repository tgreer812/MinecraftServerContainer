param (
    [string]$storageAccountKey
)

# Path to the JSON file
$jsonPath = "..\config\deploy_args.json"

# Read and parse the JSON content
$jsonContent = Get-Content -Raw -Path $jsonPath | ConvertFrom-Json

# Initialize the base command
$command = @(
    "az container create",
    "--resource-group $($jsonContent.'resource-group')",
    "--name $($jsonContent.name)",
    "--image $($jsonContent.image)",
    "--cpu $($jsonContent.cpu)",
    "--memory $($jsonContent.memory)",
    "--ip-address $($jsonContent.'ip-address')"
)

# Add ports to the command
if ($jsonContent.ports -is [System.Array]) {
    $portsString = $jsonContent.ports -join ' '
    $command += "--ports $portsString"
} else {
    $command += "--ports $jsonContent.ports"
}

# Add Azure file share mount if specified
if ($jsonContent.'azure-file-volume-account-name' -and $storageAccountKey -and $jsonContent.'azure-file-volume-share-name' -and $jsonContent.'azure-file-volume-mount-path') {
    $command += "--azure-file-volume-account-name $($jsonContent.'azure-file-volume-account-name')"
    $command += "--azure-file-volume-account-key $storageAccountKey"
    $command += "--azure-file-volume-share-name $($jsonContent.'azure-file-volume-share-name')"
    $command += "--azure-file-volume-mount-path $($jsonContent.'azure-file-volume-mount-path')"
}

# Convert the command array to a single string
$commandString = $command -join " "

# Execute the command
Invoke-Expression $commandString
