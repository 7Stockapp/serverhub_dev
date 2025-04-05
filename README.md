# ServerHub Agent

ServerHub is a server monitoring solution that allows you to track your server's performance metrics and services.

## Installation Methods

There are two ways to install the ServerHub agent:

### 1. Direct Installation (Recommended)

The easiest way to install the ServerHub agent is by using our direct installation script:

```bash
# Run this command as root or with sudo
curl -sSL https://raw.githubusercontent.com/7Stockapp/serverhub_dev/main/install.sh | sudo bash
```

This will download and install the agent automatically with all its dependencies.

### 2. APT Repository Installation

You can also install the agent using our APT repository:

```bash
# Add the repository
echo "deb [trusted=yes] https://raw.githubusercontent.com/7Stockapp/serverhub_dev/main stable main" | sudo tee /etc/apt/sources.list.d/serverhub.list

# Update and install
sudo apt update --allow-insecure-repositories
sudo apt install -y serverhub-agent --allow-unauthenticated
```

## Configuration

The agent configuration file is located at:
- Linux: `/etc/serverhub/config`
- Windows: `C:\ProgramData\ServerHub\config.ini`

You may need to update your user key in this file.

## Checking Service Status

After installation, you can check the status of the service:

```bash
systemctl status serverhub.service
```

## Troubleshooting

If you encounter any issues:

1. Check the service status:
   ```bash
   systemctl status serverhub.service
   ```

2. View the logs:
   ```bash
   journalctl -u serverhub.service
   ```

3. Check the configuration file:
   ```bash
   cat /etc/serverhub/config
   ```

## Uninstalling

To remove the ServerHub agent:

```bash
sudo systemctl stop serverhub.service
sudo apt remove serverhub-agent
```

## Support

For support, please contact support@serverhub.dev
