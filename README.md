# CIDE

This repository contains playbooks and roles I use to deploy my personal cloud IDE based on [code-server](https://github.com/cdr/code-server).

## Getting Started

### Dependencies

* `python3`
* `python3-virtualenv`

### Installing

1. Clone this repo:
    ```bash
    git clone --recurse-submodules git@github.com:0x29a/cide.git && cd cide
    ```
1. Create virtual environment and install requirements
    ```bash
    virtualenv -p python3 .fenv
    . .fenv/bin/activate
    pip install -r requirements.txt
    ```

### Provisioning CIDE

1. Add the following to `/etc/hosts`:
    ```
    <ide_server_ip_address> cloud
    ```
1. Create `.vars.private.yml` and put to it all necessary secrets:
    ```bash
    cp example.vars.private.yml .vars.private.yml
    ```
1. Optionally, put `zsh` history to `roles/development/files/.zsh_history`.
1. Update Toggl transfer script timestamp in `roles/opencraft/files/.latest`.
1. Run playbook to deploy user and SSH keys:
    ```bash
    make init
    ```
1. If user and SSH keys were deployed successfully, deploy everything else:
    ```
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

### Post-installation steps

1. Open Nextcloud, set up encryption.
