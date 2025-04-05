#!/bin/bash
set -e

echo "ServerHub Agent Direct Installer"
echo "================================"

# Check if running as root
if [ "$EUID" -ne 0 ]; then
  echo "Please run as root"
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

# Install dependencies
echo "Installing dependencies..."
apt-get update
apt-get install -y python3 python3-pip systemd

# Install the package
echo "Installing serverhub-agent..."
dpkg -i serverhub-agent.deb || true

# Fix any dependency issues
apt-get install -f -y

# Verify installation
if systemctl is-active --quiet serverhub.service; then
  echo "ServerHub agent installed and running!"
  echo "Service status:"
  systemctl status serverhub.service --no-pager
else
  echo "Starting serverhub service..."
  systemctl start serverhub.service
  sleep 2
  if systemctl is-active --quiet serverhub.service; then
    echo "ServerHub agent installed and running!"
    echo "Service status:"
    systemctl status serverhub.service --no-pager
  else
    echo "Warning: Service not running. Checking logs..."
    journalctl -u serverhub.service --no-pager -n 20
  fi
fi

# Cleanup
echo "Cleaning up..."
cd
rm -rf "$TEMP_DIR"

echo ""
echo "Installation completed!"
echo "To check service status at any time, run: systemctl status serverhub.service" 