prepare:
	cd ansible; \
	ansible-galaxy install -r ./requirements.yml

clean:
	rm -rf ./packer_cache \
	       ./builds \
	       ./ansible/vendor

ubuntu1804: prepare ubuntu1804-build ubuntu1804-upload clean

ubuntu1804-build:
	packer build ./ubuntu-18.04.json

ubuntu1804-upload:
	./vagrantboxuploader vvv-base ubuntu1804 $$(date +%s) virtualbox ./builds/virtualbox-ubuntu1804.box
