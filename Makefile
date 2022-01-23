BIN=.fenv/bin

ensure_virtualenv:
	if ! [ -d ".fenv" ] ; then virtualenv -p python3 .fenv ; fi

set_up_localhost: ensure_virtualenv
	chmod 600 ~/.ssh/id_ed25519 ~/.ssh/id_ed25519.pub
	$(BIN)/pip install -r requirements.txt
	$(BIN)/ansible-playbook playbooks/localhost.yml

bootstrap: ensure_virtualenv
	$(BIN)/ansible-playbook playbooks/bootstrap.yml

deploy: ensure_virtualenv
	$(BIN)/ansible-playbook playbooks/cide.yml --ask-become-pass

# Rebuilds CIDE Electron app and reinstalls it locally.
cide_app: ensure_virtualenv
	$(BIN)/ansible-playbook playbooks/cide.yml --ask-become-pass --tags nativefier
	rm -rf ~/Soft/cide/CIDE-linux-x64
	mkdir -p ~/Soft/cide/
	scp -r $(USER)@cloud:~/Soft/cide/CIDE-linux-x64 ~/Soft/cide/CIDE-linux-x64
