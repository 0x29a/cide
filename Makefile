init:
	ansible-playbook bootstrap.yml
deploy:
	ansible-playbook cide.yml --ask-become-pass
