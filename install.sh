#!/bin/bash
set -e

echo "ServerHub Agent Direct Installer"
echo "================================"

# Check if running as root
if [ "$EUID" -ne 0 ]; then
  echo "Please run as root"
  exit 1
fi

# Prompt for user key
echo ""
echo "Please enter your ServerHub User Key:"
read -p "> " USER_KEY

if [ -z "$USER_KEY" ]; then
  echo "Error: User Key is required. Please run the installer again with a valid key."
  exit 1
fi

# Create temporary directory
TEMP_DIR=$(mktemp -d)
cd "$TEMP_DIR"

# Download the agent package
echo "Downloading serverhub-agent..."
wget -q https://raw.githubusercontent.com/7Stockapp/serverhub_dev/main/pool/serverhub-agent.deb -O serverhub-agent.deb

if [ ! -f serverhub-agent.deb ]; then
  echo "Error: Failed to download serverhub-agent.deb"
  exit 1
fi

# Install dependencies with error handling
echo "Installing dependencies..."
# Try with --allow-insecure-repositories first
apt-get update --allow-insecure-repositories || apt-get update || true
# Install dependencies anyway - if they're already installed this will work
apt-get install -y python3 python3-pip systemd || {
  echo "Warning: Couldn't install all dependencies through apt, attempting critical ones directly"
  # Attempt to install only if not already installed
  command -v python3 >/dev/null || apt-get install -y python3
  command -v pip3 >/dev/null || apt-get install -y python3-pip
}

# Install the package
echo "Installing serverhub-agent..."
dpkg -i serverhub-agent.deb || true

# Fix any dependency issues
apt-get install -f -y || true

# Create configuration directory and file
echo "Creating configuration..."
mkdir -p /etc/serverhub
cat > /etc/serverhub/config << EOF
USER_KEY=$USER_KEY
EOF
chmod 644 /etc/serverhub/config

# Reload systemd to recognize the new service
systemctl daemon-reload

# Verify installation
if systemctl is-active --quiet serverhub.service; then
  echo "ServerHub agent installed and running!"
  echo "Service status:"
  systemctl status serverhub.service --no-pager
else
  echo "Starting serverhub service..."
  systemctl start serverhub.service || true
  sleep 2
  if systemctl is-active --quiet serverhub.service; then
    echo "ServerHub agent installed and running!"
    echo "Service status:"
    systemctl status serverhub.service --no-pager
  else
    echo "Warning: Service not running. Checking logs..."
    journalctl -u serverhub.service --no-pager -n 20
    echo ""
    echo "Checking if the package was installed successfully:"
    dpkg -l | grep serverhub
    echo ""
    echo "Your configuration has been saved to /etc/serverhub/config"
  fi
fi

# Cleanup
echo "Cleaning up..."
cd
rm -rf "$TEMP_DIR"

echo ""
echo "Installation completed!"
echo "User key has been saved to /etc/serverhub/config"
echo "To check service status at any time, run: systemctl status serverhub.service" 