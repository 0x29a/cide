# CIDE

**Note**: this repository needs to be cleaned up and refactored. There are many roles and playbooks that are not used anymore, and some of them are not even working. I'm planning to do this in the nearest future. Don't use this repository as a reference for now.

This repository contains playbooks and roles, that I use to:
- Configure my local development environment, from wallpapers and keyboard shortcuts to byobu, firejail and VSCode.
- Configure my remote development environment on a dedicated server, which usually does all heavy lifting.
- Deploy many other self-hosted services, such as [SearX](https://searx.me/) or [Firefly III](https://www.firefly-iii.org/).

## Getting Started

### Localhost

#### Before OS reinstall

1. Backup database:
    ```sh
    cp -r ~/Cloud /media/<username>/<ID>/Cloud
    ```
1. Backup zsh history:
    ```sh
    cp ~/.zsh_history /media/<username>/<ID>/.zsh_history
    ```
1. Check that KeePass database isn't corrupted.

#### After OS reinstall

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
    git clone https://github.com/0x29a/cide.git --recursive && cd cide
    ```
1. Insert backup USB, open KeePassXC (`SSH`) and export ssh keys to the `~/.ssh/` directory.
1. Create `.vars.private.yml` and put to it all necessary secrets from KeePassXC (`CIDE private vars`):
    ```sh
    cp example.vars.private.yml .vars.private.yml
    ```
1. [Optionally] Put zsh history in place:
    ```sh
    cp /media/<username>/<ID>/.zsh_history playbooks/roles/zsh/files/.zsh_history.localhost
    ```
1. Run installation:
    ```sh
    make set_up_localhost
    ```
1. Log in and log out to activate new default shell.
1. Open [Syncthing Web UI](http://127.0.0.1:8384/), remove default folder and configure all devices.
1. Run the follwing in `tridactyl`:
    ```
    autocmd TriStart .* source --url https://raw.githubusercontent.com/0x29a/cide/master/playbooks/roles/localhost/files/.tridactylrc
    ```
    I need this workaround because `tridactyl` native messenger is tricky to set up in a firejail.
1. [TO AUTOMATE] Add a new keyboard layout and set <Left Shift><Right Shift> shortcut.
1. [TO AUTOMATE] Install Tor Browser.
1. [TO AUTOMATE] Reverse touchpad scroll.
1. [TO AUTOMATE] Add [custom certificates](https://gitlab.com/opencraft/documentation/private/-/tree/master/vault#browser-access) for Vault.
1. [TO AUTOMATE] OBS collections and profiles import.

### Provisioning CIDE

1. Add the following to `/etc/hosts`:
    ```
    <ide_server_ip_address> cloud
    ```
1. Create `.vars.private.yml` and put to it all necessary secrets:
    ```sh
    cp example.vars.private.yml .vars.private.yml
    ```
1. [Optionally] Put zsh history in place:
    ```sh
    cp /media/<username>/<ID>/.zsh_history playbooks/roles/zsh/files/.zsh_history.cloud
    ```
1. Update Toggl transfer script timestamp in `roles/opencraft/files/.latest`.
1. Add an additional IP address: `sudo ip address add <SECONDARY_IP_ADDRESS>/32 dev <INTERFACE>`.
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
    1. `sainnhe.gruvbox-material`.
