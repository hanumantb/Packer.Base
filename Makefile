prepare:
	cd ansible; \
	ansible-galaxy install -r ./requirements.yml

clean:
	rm -rf ./packer_cache \
	       ./builds \
	       ./output \
	       ./ansible/vendor

ubuntu1804: prepare ubuntu1804-build ubuntu1804-upload clean

ubuntu1804-build:
	packer build -var-file=./ubuntu-1804.json ./ubuntu.json

ubuntu1804-upload:
	./vagrantboxuploader vvv-base ubuntu1804 $$(date +%s) virtualbox ./builds/virtualbox-ubuntu1804.box

ubuntu1604: prepare ubuntu1604-build ubuntu1604-upload clean

ubuntu1604-build:
	packer build -var-file=./ubuntu-1604.json ./ubuntu.json

ubuntu1604-upload:
	./vagrantboxuploader vvv-base ubuntu1604 $$(date +%s) virtualbox ./builds/virtualbox-ubuntu1604.box
