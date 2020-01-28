# Written by Samuel Burns Cohen
# Jan 28, 2019
# Makefile

DIR := ${CURDIR}

install: 
	ln -s ${DIR}/main.rb /usr/local/bin/ftouch

uninstall:
	rm /usr/local/bin/ftouch