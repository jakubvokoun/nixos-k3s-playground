# Nix K3s VM

A minimal NixOS VM configuration with K3s (lightweight Kubernetes) enabled.

## Features

- Minimal NixOS configuration
- K3s server enabled
- SSH access configured
- Basic firewall setup
- Prague timezone
- Enhanced terminal experience with bash completion, fzf, and useful aliases

## Requirements

- Nix with flakes support
- `just` command runner

## Usage

Build and run the VM:

```bash
just vm
just run-vm
```

Clean up:

```bash
just clean
```

## VM Details

- Hostname: `nixos-vm`
- Users: `root` and `nixos` (both with password `test`)
- Packages: `vim`, `htop`, `fzf`, `curlie`, `systemctl-tui`, `kubectl`, `helm`, `k9s`, `kubectx`
- Services: SSH (password auth enabled), K3s
- Firewall: Ports 22 (SSH) and 6443 (K3s API) open
- KUBECONFIG environment variable set to K3s admin config

## Authentication

Both `root` and `nixos` users have the password `test`. SSH access is enabled with password authentication.

## K3s Access

Once the VM is running, K3s will be available on port 6443. The KUBECONFIG environment variable is automatically set, so you can use kubectl directly:

```bash
kubectl get nodes
k get nodes  # Short alias for kubectl
k9s
```

Or use the K3s kubectl:

```bash
sudo k3s kubectl get nodes
```