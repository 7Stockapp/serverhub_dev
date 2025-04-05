# 🚀 ServerHub Agent Installation Guide

This guide provides multiple methods to install the ServerHub Agent on your system.

## 📋 Prerequisites

- ✅ A Debian-based Linux distribution (e.g., Ubuntu).
- ✅ `sudo` privileges to install packages.
- ✅ Internet access to download the package.

## ⚙️ Installation Methods

### Method 1: Direct Installation Script (⭐ RECOMMENDED)

The simplest way to install the agent is using our direct installation script:

```bash
curl -sSL https://raw.githubusercontent.com/7Stockapp/serverhub_dev/main/install.sh | sudo bash
```

This script:
- Downloads the .deb package automatically
- Installs all required dependencies
- Sets up and starts the service
- Verifies the installation

### Method 2: APT Repository

If you prefer using apt, you can add our repository:

```bash
# Add the repository source
echo "deb [trusted=yes] https://raw.githubusercontent.com/7Stockapp/serverhub_dev/main stable main" | sudo tee /etc/apt/sources.list.d/serverhub.list

# Update and install
sudo apt update --allow-insecure-repositories
sudo apt install serverhub-agent --allow-unauthenticated
```

The `--allow-insecure-repositories` and `--allow-unauthenticated` flags are required because the repository is hosted on GitHub Raw content which doesn't support signed repositories.

### Method 3: Manual .deb Installation

For a direct manual installation:

```bash
# Download the .deb package
wget https://raw.githubusercontent.com/7Stockapp/serverhub_dev/main/pool/serverhub-agent.deb

# Install dependencies and the package
sudo apt update
sudo apt install -y python3 python3-pip systemd
sudo dpkg -i serverhub-agent.deb
sudo apt install -f -y  # Fix any dependency issues
```

## 🔧 Post-Installation

After installation, the agent should start automatically. You can verify using:

```bash
systemctl status serverhub.service
```

### Configuration

The configuration file is located at:
- Linux: `/etc/serverhub/config`
- Windows: `C:\ProgramData\ServerHub\config.ini`

You may need to update your user key in this config file.

## ❓ Troubleshooting

If you encounter any issues:

1. **Check Service Status**:
   ```bash
   systemctl status serverhub.service
   ```

2. **View Logs**:
   ```bash
   journalctl -u serverhub.service -n 50
   ```

3. **Verify Configuration**:
   ```bash
   cat /etc/serverhub/config
   ```

4. **Common Repository Errors**:
   - "Clearsigned file isn't valid": Use direct installation or add `trusted=yes` flag
   - "The repository is no longer signed": Use the `--allow-unauthenticated` flag

## 🗑️ Uninstallation

To remove the agent:

```bash
sudo systemctl stop serverhub.service
sudo apt remove serverhub-agent
sudo rm /etc/apt/sources.list.d/serverhub.list  # If using repository method
```

---

For support, please contact support@serverhub.dev 