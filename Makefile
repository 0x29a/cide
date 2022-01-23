init:
	ansible-playbook bootstrap.yml
deploy:
	ansible-playbook cide.yml --ask-become-pass

# Rebuilds CIDE Electron app and reinstalls it locally.
cide_app:
	ansible-playbook cide.yml --ask-become-pass --tags nativefier
	rm -rf ~/Soft/cide/CIDE-linux-x64
	mkdir -p ~/Soft/cide/
	scp -r $(USER)@cloud:~/Soft/cide/CIDE-linux-x64 ~/Soft/cide/CIDE-linux-x64
