set_up_localhost:
	chmod 600 ~/.ssh/id_ed25519 ~/.ssh/id_ed25519.pub
	virtualenv -p python3 .fenv
	. .fenv/bin/activate
	pip install -r requirements.txt

bootstrap:
	ansible-playbook bootstrap.yml

deploy:
	ansible-playbook cide.yml --ask-become-pass

# Rebuilds CIDE Electron app and reinstalls it locally.
cide_app:
	ansible-playbook cide.yml --ask-become-pass --tags nativefier
	rm -rf ~/Soft/cide/CIDE-linux-x64
	mkdir -p ~/Soft/cide/
	scp -r $(USER)@cloud:~/Soft/cide/CIDE-linux-x64 ~/Soft/cide/CIDE-linux-x64
