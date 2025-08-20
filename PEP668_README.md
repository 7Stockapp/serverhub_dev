# PEP 668 Compatible ServerHub Agent Package

## Changes

### Version 1.0.3 (PEP 668 Compatible)

**Previous Version (1.0.2):**
- `Depends: python3 (>= 3.8.0), python3-pip, systemd`
- `postinst` script was using `pip3 install` command
- Installation was failing on Ubuntu 24.04 due to PEP 668 restrictions

**New Version (1.0.3):**
- `Depends: python3 (>= 3.8.0), python3-psutil (>= 5.9.0), python3-websockets (>= 10.3), python3-requests (>= 2.28.0), python3-dateutil (>= 2.8.2), systemd`
- `pip3 install` command removed from `postinst` script
- All Python dependencies are installed as apt-packaged packages

## What is PEP 668?

PEP 668 is a security measure that prevents pip from installing packages to the system Python. It is enabled by default in Ubuntu 24.04.

## Benefits

1. **Security**: Prevents accidental package installation to system Python
2. **Stability**: Apt-installed packages are more stable and tested
3. **Updates**: Automatically updated with system updates
4. **Compatibility**: Works seamlessly on Ubuntu 24.04 and later versions

## Installation

```bash
# Add repository
echo "deb [signed-by=/usr/share/keyrings/serverhub.gpg] https://your-repo-url stable main" | sudo tee /etc/apt/sources.list.d/serverhub.list

# Add GPG key
wget -O- https://your-repo-url/KEY.gpg | sudo gpg --dearmor -o /usr/share/keyrings/serverhub.gpg

# Update package list
sudo apt update

# Install ServerHub Agent
sudo apt install serverhub-agent
```

## Package Structure

```
serverhub-agent_1.0.3/
├── DEBIAN/
│   ├── control          # PEP 668 compatible dependencies
│   └── postinst         # Script without pip usage
├── etc/
│   ├── systemd/system/serverhub.service
│   └── serverhub/
├── usr/
│   └── lib/serverhub/
│       ├── check_server.py
│       └── requirements.txt
```

## Requirements

- Ubuntu 20.04+ (Python 3.8+)
- systemd
- python3-psutil
- python3-websockets  
- python3-requests
- python3-dateutil
