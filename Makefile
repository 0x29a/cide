BIN=.fenv/bin

virtualenv:
	if ! [ -d ".fenv" ] ; then virtualenv -p python3 .fenv ; fi

keys:
	chmod 600 ~/.ssh/id_ed25519 ~/.ssh/id_ed25519.pub

requirements: virtualenv
	if [ ! -f $(BIN)/ansible-galaxy ]; then $(BIN)/pip install -r requirements.txt; fi
	if [ ! -d /home/$(USER)/.ansible/collections/ ]; then $(BIN)/ansible-galaxy install -r requirements.yml; fi

set_up_localhost: keys requirements
	$(BIN)/ansible-playbook playbooks/localhost.yml --ask-become-pass

set_up_localhost.%: keys requirements
	$(BIN)/ansible-playbook playbooks/localhost.yml --ask-become-pass --tags=$*

bootstrap: requirements
	$(BIN)/ansible-playbook playbooks/bootstrap.yml

bootstrap.%: requirements
	$(BIN)/ansible-playbook playbooks/bootstrap.yml --tags=$*

deploy: requirements
	$(BIN)/ansible-playbook playbooks/cide.yml --ask-become-pass

deploy.%: requirements
	$(BIN)/ansible-playbook playbooks/cide.yml --ask-become-pass --tags=$*

# Rebuilds CIDE Electron app and reinstalls it locally.
cide_app: requirements
	$(BIN)/ansible-playbook playbooks/cide.yml --ask-become-pass --tags nativefier
	rm -rf ~/Soft/cide/CIDE-linux-x64
	mkdir -p ~/Soft/cide/
	scp -r $(USER)@cloud:~/Soft/cide/CIDE-linux-x64 ~/Soft/cide/CIDE-linux-x64

save_guake_settings:
	guake --save-preferences ~/Projects/cide/playbooks/roles/localhost/files/guake_preferences
