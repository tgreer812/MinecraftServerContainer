$configPath = "..\config\vanilla_task_args.json"

# Run build_image_in_acr.ps1
& .\build_image_in_acr.ps1 -configPath $configPath -forge $false
