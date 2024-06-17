# Path to the JSON file
$jsonPath = "..\..\config\deploy_args.json"

# Read and parse the JSON content
$jsonContent = Get-Content -Raw -Path $jsonPath | ConvertFrom-Json

# Determine if ports is an array or a single value
if ($jsonContent.ports -is [System.Array]) {
    $portsString = $jsonContent.ports -join ' '
} else {
    $portsString = $jsonContent.ports.ToString()
}

# Execute the az container create command with the parameters from the JSON file
az container create `
    --resource-group $jsonContent.'resource-group' `
    --name $jsonContent.name `
    --image $jsonContent.image `
    --ports $portsString `
    --cpu $jsonContent.cpu `
    --memory $jsonContent.memory `
    --ip-address $jsonContent.'ip-address'