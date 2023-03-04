BIN=.fenv/bin
# ansible-playbook
AP=$(BIN)/ansible-playbook

virtualenv:
	if ! [ -d ".fenv" ] ; then virtualenv -p python3 .fenv ; fi

keys:
	chmod 600 ~/.ssh/id_ed25519 ~/.ssh/id_ed25519.pub

ansible_requirements: virtualenv
	$(BIN)/ansible-galaxy install -r requirements.yml

requirements: virtualenv
	if [ ! -f $(BIN)/ansible-galaxy ]; then $(BIN)/pip install -r requirements.txt; fi
	if [ ! -d /home/$(USER)/.ansible/collections/ ]; then $(BIN)/ansible-galaxy install -r requirements.yml; fi

set_up_localhost: keys requirements
	$(AP) playbooks/localhost.yml --ask-become-pass

set_up_localhost.%: keys requirements
	$(AP) playbooks/localhost.yml --ask-become-pass --tags=$*

bootstrap: requirements
	$(AP) playbooks/bootstrap.yml

bootstrap.%: requirements
	$(AP) playbooks/bootstrap.yml --tags=$*

deploy: requirements
	$(AP) playbooks/cide.yml --ask-become-pass

deploy.%: requirements
	$(AP) playbooks/cide.yml --ask-become-pass --tags=$*

zsh: requirements
	$(AP) playbooks/localhost.yml --tags=zshrc

zsh.cide: requirements
	$(AP) playbooks/cide.yml --tags=zshrc

jira: requirements
	$(AP) playbooks/localhost.yml --tags=go_jira_config

# Rebuilds CIDE Electron app and reinstalls it locally.
cide_app: requirements
	$(AP) playbooks/cide.yml --ask-become-pass --tags nativefier
	rm -rf ~/Soft/cide/CIDE-linux-x64
	mkdir -p ~/Soft/cide/
	scp -r $(USER)@cloud:~/Soft/cide/CIDE-linux-x64 ~/Soft/cide/CIDE-linux-x64

save_guake_settings:
	guake --save-preferences ~/Projects/cide/playbooks/roles/localhost/files/guake_preferences
