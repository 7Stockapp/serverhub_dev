# ServerHub Agent

ServerHub is a server monitoring solution that allows you to track your server's performance metrics and services.

## Installation Methods

There are multiple ways to install the ServerHub agent:

### 1. Interactive Installation (Recommended)

Download the script first, then run it to be prompted for your User Key:

```bash
# Download the script
curl -sSL https://raw.githubusercontent.com/7Stockapp/serverhub_dev/main/install.sh -o install.sh

# Make it executable
chmod +x install.sh

# Run it (will prompt for your USER_KEY)
sudo ./install.sh
```

> **Note**: The installation process may take a few minutes to complete, especially during the package download step. Please be patient and allow the script to finish.

### 2. Installation with Environment Variable

Provide your User Key as an environment variable:

```bash
# Replace "your-key-here" with your actual User Key
USER_KEY=your-key-here sudo -E bash -c "$(curl -sSL https://raw.githubusercontent.com/7Stockapp/serverhub_dev/main/install.sh)"
```

> **Note**: This method may also take a few minutes to complete during the download phase. If it appears to hang, consider using the manual installation method described in the troubleshooting section.

### 3. APT Repository Installation

You can also install the agent using our APT repository:

```bash
# Add the repository
echo "deb [trusted=yes] https://raw.githubusercontent.com/7Stockapp/serverhub_dev/main stable main" | sudo tee /etc/apt/sources.list.d/serverhub.list

# Update and install
sudo apt update --allow-insecure-repositories
sudo apt install -y serverhub-agent --allow-unauthenticated

# After installation, set your User Key
sudo mkdir -p /etc/serverhub
echo "USER_KEY=your-key-here" | sudo tee /etc/serverhub/config
sudo systemctl restart serverhub.service
```

## Configuration

The agent configuration file is located at:
- Linux: `/etc/serverhub/config`
- Windows: `C:\ProgramData\ServerHub\config.ini`

The configuration file requires your User Key:
```
USER_KEY=your-key-here
```

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

4. Common installation issues:
   - **APT lock errors**: If you get lock errors, try removing the locks:
     ```bash
     sudo rm /var/lib/dpkg/lock-frontend
     sudo rm /var/lib/apt/lists/lock
     sudo rm /var/lib/dpkg/lock
     sudo dpkg --configure -a
     ```
   - **Silent failure with curl pipe**: Use the download method instead of piping curl directly to bash
   - **Script hanging during download**: If the installation script appears to hang during the download phase, you can perform a manual installation:
     ```bash
     # Download the .deb package directly
     wget https://raw.githubusercontent.com/7Stockapp/serverhub_dev/main/pool/serverhub-agent.deb
     
     # Install dependencies and the package
     sudo apt install -y python3 python3-pip systemd
     sudo dpkg -i serverhub-agent.deb
     sudo apt install -f -y
     
     # Create configuration with your user key
     sudo mkdir -p /etc/serverhub
     echo "USER_KEY=your-key-here" | sudo tee /etc/serverhub/config
     
     # Start the service
     sudo systemctl daemon-reload
     sudo systemctl restart serverhub.service
     ```

## Uninstalling

To remove the ServerHub agent:

```bash
sudo systemctl stop serverhub.service
sudo apt remove serverhub-agent
sudo rm -rf /etc/serverhub
```

## Support

For support, please contact support@serverhub.dev
