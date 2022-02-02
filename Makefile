BIN=.fenv/bin

virtualenv:
	if ! [ -d ".fenv" ] ; then virtualenv -p python3 .fenv ; fi

requirements: virtualenv
	chmod 600 ~/.ssh/id_ed25519 ~/.ssh/id_ed25519.pub
	$(BIN)/pip install -r requirements.txt
	$(BIN)/ansible-galaxy install -r requirements.yml

set_up_localhost: requirements
	$(BIN)/ansible-playbook playbooks/localhost.yml --ask-become-pass

set_up_localhost.%: requirements
	$(BIN)/ansible-playbook playbooks/localhost.yml --ask-become-pass --tags=$*

bootstrap: virtualenv
	$(BIN)/ansible-playbook playbooks/bootstrap.yml

bootstrap.%: virtualenv
	$(BIN)/ansible-playbook playbooks/bootstrap.yml --tags=$*

deploy: virtualenv
	$(BIN)/ansible-playbook playbooks/cide.yml --ask-become-pass

deploy.%: virtualenv
	$(BIN)/ansible-playbook playbooks/cide.yml --ask-become-pass --tags=$*

# Rebuilds CIDE Electron app and reinstalls it locally.
cide_app: virtualenv
	$(BIN)/ansible-playbook playbooks/cide.yml --ask-become-pass --tags nativefier
	rm -rf ~/Soft/cide/CIDE-linux-x64
	mkdir -p ~/Soft/cide/
	scp -r $(USER)@cloud:~/Soft/cide/CIDE-linux-x64 ~/Soft/cide/CIDE-linux-x64
