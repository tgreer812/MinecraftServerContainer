# MinecraftServerContainer

## Overview
MinecraftServerContainer is a solution for deploying and managing a Minecraft server on Azure using Docker containers. This project includes PowerShell scripts to automate the deployment process on Azure.

## Features
- **Azure Deployment:** Deploys Minecraft server containers on Azure.
- **Custom Configuration:** Easily configurable settings for the Minecraft server.
- **Automated Deployment:** PowerShell scripts for automated deployment and management.

## Getting Started

### Prerequisites
- Azure CLI installed.
- PowerShell installed.
- Basic knowledge of Azure and PowerShell.

### Installation

1. Clone the repository:
   ```sh
   git clone https://github.com/tgreer812/MinecraftServerContainer.git
   cd MinecraftServerContainer
   ```

### Configuration
The server can be configured by modifying the files in the `config` directory. These configurations are automatically applied during deployment.

### Scripts
- `deploy_mc_container.ps1`: PowerShell script to deploy the Minecraft server container on Azure.

### Usage

1. Update the configuration files in the `config` directory as needed.
2. Run the deployment script:
   ```sh
   .\scripts\deploy_mc_container.ps1
   ```

## License
This project is licensed under the MIT License. See the [LICENSE](LICENSE) file for details.

## Contributing
Contributions are not being accepted at this time. If there are issues you may submit a bug report.

## Issues
If you encounter any issues, please open a new issue on the GitHub repository.
