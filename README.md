# 🚀 ServerHub Agent Installation Guide

Welcome to the **ServerHub Agent** installation guide! Follow these simple steps to set up and start using the ServerHub Agent on your system.

---

## 📋 Prerequisites

Before starting, ensure you have the following:

- ✅ A Debian-based Linux distribution (e.g., Ubuntu).
- ✅ `sudo` privileges to install packages.
- ✅ Internet access to download the repository or package.

---

## ⚙️ Installation Methods

You can install the **ServerHub Agent** using either of the two methods below:

---

### Method 1: Install via Repository (Advanced)

This method adds the ServerHub repository to your system but may require additional flags to bypass security checks.

#### 1️⃣ Step 1: Download and Add the GPG Key

The GPG key ensures the authenticity of the ServerHub repository. Run the following command:

```bash
curl -fsSL https://raw.githubusercontent.com/7Stockapp/serverhub_dev/main/KEY.asc | sudo gpg --dearmor -o /usr/share/keyrings/serverhub-archive-keyring.gpg
```

#### 2️⃣ Step 2: Verify the GPG Key Fingerprint

Verify that the GPG key has been added correctly:

```bash
gpg --no-default-keyring --keyring /usr/share/keyrings/serverhub-archive-keyring.gpg --list-keys
```

#### 3️⃣ Step 3: Add the Repository

Add the ServerHub repository to your system's package sources:

```bash
echo "deb [signed-by=/usr/share/keyrings/serverhub-archive-keyring.gpg arch=amd64 trusted=yes] https://raw.githubusercontent.com/7Stockapp/serverhub_dev/main/ stable main" | sudo tee /etc/apt/sources.list.d/serverhub.list
```

#### 4️⃣ Step 4: Update and Install

Update your package list and install the **ServerHub Agent**:

```bash
# Using security bypass flags (required)
sudo apt update --allow-insecure-repositories && sudo apt install -y serverhub-agent --allow-unauthenticated
```

> **Note:** The `--allow-insecure-repositories` and `--allow-unauthenticated` flags are required because GitHub's raw content delivery is not designed for APT repositories. If you encounter any issues with this method, please use Method 2 instead.

---

### Method 2: Install via Direct Download (⭐ RECOMMENDED) 

This is the **recommended method** for a simpler and more reliable installation process.

#### 1️⃣ Step 1: Download the `.deb` Package

Download the latest `.deb` package using `wget`:

```bash
wget https://raw.githubusercontent.com/7Stockapp/serverhub_dev/main/pool/serverhub-agent.deb
```

#### 2️⃣ Step 2: Install the Package

Install the downloaded package using `dpkg`:

```bash
sudo dpkg -i serverhub-agent.deb
```

#### 3️⃣ Step 3: Install Missing Dependencies

If there are missing dependencies, resolve them using:

```bash
sudo apt-get install -f
```

---

## 🎉 Success!

The **ServerHub Agent** is now installed on your system! You're ready to start using it. 🛠️

---

## ❓ Troubleshooting

If you encounter any issues during the installation:

- 🔍 **"Clearsigned file isn't valid, got 'NOSPLIT'"**: This is a known issue with hosting on GitHub. Use Method 2 (direct .deb download) instead, or add `trusted=yes` to your sources.list entry and use the `--allow-insecure-repositories` and `--allow-unauthenticated` flags.

- 🔍 **"The repository is no longer signed"**: This error occurs because GitHub's raw content hosting isn't optimized for APT repositories. Use Method 2 for a more reliable installation.

- 🔄 **"Unable to locate package serverhub-agent"**: Ensure you've correctly configured the repository or use Method 2 (direct .deb download).

- 🔎 **Other repository errors**: Method 2 is the most reliable approach and avoids repository configuration issues completely.

- 🔑 **Check `sudo` permissions** if you encounter permission errors.

- 🛠️ **Open an issue** in the [GitHub Issues](https://github.com/7Stockapp/serverhub_dev/issues) section for further assistance.

---

## 📄 License

This project is governed by the [Terms of Use](https://serverhub.dev/terms-of-use/). By installing and using the software, you agree to comply with these terms.

---

## 💬 Questions or Feedback?

Feel free to open a discussion or issue in the repository. Your feedback is welcome!

---

> _Created with ❤️ by 7Stockapp OÜ_
