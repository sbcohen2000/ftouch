# Written by Samuel Burns Cohen
# Jan 28, 2019
# Makefile

DIR := ${CURDIR}

install: 
	ln -s ${DIR}/ftouch.rb /usr/local/bin/ftouch
	mkdir ~/.ftouch_configs
	cp -r ./configs/* ~/.ftouch_configs

uninstall:
	rm /usr/local/bin/ftouch
	rm -r ~/.ftouch_configs