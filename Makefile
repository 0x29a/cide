init:
	ansible-playbook -i bootstrap bootstrap.yml
deploy:
	ansible-playbook cide.yml --ask-become-pass
