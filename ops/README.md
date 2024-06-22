# Ops Folder

This folder contains scripts for building and deploying containers to Azure.

## Prerequisites

Before running the scripts, make sure you have the following prerequisites installed:

- Docker: [Download and install Docker](https://www.docker.com/get-started)
- Azure CLI: [Install Azure CLI](https://docs.microsoft.com/en-us/cli/azure/install-azure-cli)

## Usage

1. Clone this repository:

    ```bash
    git clone https://github.com/your-username/MinecraftServerContainer.git
    ```

2. Navigate to the `ops` folder:

    ```ps1
    .\build_image_in_acr.ps1
    ```

3. Use the desired deploy script:

    ```ps1
    # Vanilla
    .\deploy_vanilla_mc_container.ps1

    # Forge
    .\deploy_forge_mc_container.ps1
    ```    

## Contributing

Contributions to this project are not currently accepted.

## License

This project is licensed under the [MIT License](LICENSE).