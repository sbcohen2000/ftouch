# Written by Samuel Burns Cohen
# Jan 28, 2019
# Makefile

DIR := ${CURDIR}

install: 
	ln -s ${DIR}/ftouch.rb /usr/local/bin/ftouch

uninstall:
	rm /usr/local/bin/ftouch