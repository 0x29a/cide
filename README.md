# CIDE

This repository contains playbooks and roles, that I use to:
- Set up my local development machine.
- Deploy my personal cloud IDE based on [code-server](https://github.com/cdr/code-server).
- Deploy other self-hosted services, such as [SearX](https://searx.me/).

## Getting Started

### Localhost

1. Upgrade packages:
    ```sh
    sudo apt update && sudo apt upgrade -y
    ```
1. Install required packages:
    ```sh
    sudo apt install -y git keepassxc python3 python3-pip python3-virtualenv make
    ```
1. Clone `CIDE` repo:
    ```sh
    mkdir -p ~/Projects && cd ~/Projects
    git clone https://github.com/0x29a/cide.git && cd cide
    ```
1. Insert backup USB, open KeePassXC (`SSH`) and export ssh keys to the `~/.ssh/` directory.
1. Create `.vars.private.yml` and put to it all necessary secrets from KeePassXC (`CIDE private vars`):
    ```sh
    cp example.vars.private.yml .vars.private.yml
    ```
1. Run installation:
    ```sh
    make set_up_localhost
    ```

### Provisioning CIDE

1. Add the following to `/etc/hosts`:
    ```
    <ide_server_ip_address> cloud
    ```
1. Create `.vars.private.yml` and put to it all necessary secrets:
    ```sh
    cp example.vars.private.yml .vars.private.yml
    ```
1. Optionally, put `zsh` history to `roles/development/files/.zsh_history`.
1. Update Toggl transfer script timestamp in `roles/opencraft/files/.latest`.
1. Run playbook to deploy user and SSH keys:
    ```sh
    make bootstrap
    ```
1. If user and SSH keys were deployed successfully, deploy everything else:
    ```sh
    make deploy
    ```
1. Change default SSH port for CIDE, add the following to `~/.ssh/config`:
    ```
    Host cloud
        HostName cloud
        Port 2123
        ForwardAgent yes
    ```
1. Open SSH tunnel, open `127.0.0.1:8137` and install these addons:
    1. `bungcip.better-toml`
    1. `ms-azuretools.vscode-docker`
    1. `dbaeumer.vscode-eslint`
    1. `eamodio.gitlens`
    1. `ms-toolsai.jupyter`.
    1. `ms-python.python`.
    1. `vscode-icons-team.vscode-icons`.
    1. `redhat.vscode-yaml`.
    1. `esbenp.prettier-vscode`.
    1. `ms-vscode.vscode-typescript-tslint-plugin`.

### Post-installation steps

1. Open tunnel to the Syncthing Web UI, add host to the network.
