BIN=.fenv/bin

set_up_localhost:
	chmod 600 ~/.ssh/id_ed25519 ~/.ssh/id_ed25519.pub
	virtualenv -p python3 .fenv
	$(BIN)/pip install -r requirements.txt
	$(BIN)/ansible-playbook playbooks/localhost.yml

bootstrap:
	$(BIN)/ansible-playbook playbooks/bootstrap.yml

deploy:
	$(BIN)/ansible-playbook playbooks/cide.yml --ask-become-pass

# Rebuilds CIDE Electron app and reinstalls it locally.
cide_app:
	$(BIN)/ansible-playbook playbooks/cide.yml --ask-become-pass --tags nativefier
	rm -rf ~/Soft/cide/CIDE-linux-x64
	mkdir -p ~/Soft/cide/
	scp -r $(USER)@cloud:~/Soft/cide/CIDE-linux-x64 ~/Soft/cide/CIDE-linux-x64
