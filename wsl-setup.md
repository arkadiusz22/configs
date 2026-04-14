# WSL

## Install WSL & Ubuntu

In powershell

```
wsl --install -d Ubuntu-24.04
```

## .wslconfig

Create in `%USERPROFILE%\.wslconfig`

```
[wsl2]

# ─── Resources ────────────────────────────────────────────────────────────────
memory=16GB

# give WSL 8 cores, keep 6 for Windows
processors=8

# Swap space on disk for when WSL hits memory limit
swap=4GB

# ─── Networking ───────────────────────────────────────────────────────────────
# WSL shares Windows network interfaces — same IP, IPv6, LAN access
networkingMode=mirrored

# Access WSL services via localhost from Windows (e.g. http://localhost:3000)
localhostForwarding=true

# WSL respects Windows Defender Firewall rules
firewall=true

# ─── Features ─────────────────────────────────────────────────────────────────
# Allows running VMs or Docker-in-Docker inside WSL
nestedVirtualization=true

[experimental]

# Virtual disk only uses space actually needed — saves SSD space
sparseVhd=true

# Actively reclaims WSL memory when idle
autoMemoryReclaim=dropcache

dnsTunneling=true
```

## wsl.conf

Create `/etc/wsl.conf`

```
[boot]
systemd=true

[user]
default=arekz
```

## .bashrc

Leverage symlink from `~/projects/configs/.bashrc` to `~/.bashrc`.
Keep `.bash_aliases` in `~/projects/configs`.
Keep `.bash_secrets` in `~/`.

```bash
ln -sf ~/projects/configs/.bashrc ~/.bashrc
```

## Apps

### System Package Updates

```bash
sudo apt update && sudo apt upgrade -y
```

### NVM for Node.js

```bash
curl -o- https://raw.githubusercontent.com/nvm-sh/nvm/v0.40.4/install.sh | bash

nvm install --lts
```

### pnpm

```bash
curl -fsSL https://get.pnpm.io/install.sh | sh -

# Then install pnpm completions
```

### Docker

Install Docker directly in WSL following the [official Docker docs for Ubuntu](https://docs.docker.com/engine/install/ubuntu/) .

```bash
curl -fsSL https://get.docker.com | sh
sudo usermod -aG docker $USER
```
