# Path to the JSON file
$jsonPath = "..\..\config\deploy_args.json"

# Read and parse the JSON content
$jsonContent = Get-Content -Raw -Path $jsonPath | ConvertFrom-Json

# Execute the az container create command with the parameters from the JSON file
az container create `
    --resource-group $jsonContent.'resource-group' `
    --name $jsonContent.name `
    --image $jsonContent.image `
    --ports $jsonContent.ports `
    --cpu $jsonContent.cpu `
    --memory $jsonContent.memory `
    --ip-address $jsonContent.'ip-address'
