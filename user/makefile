SHELL=/usr/bin/bash

.PHONEY: all
all:
	sudo pwd

.PHONEY: install
install:
	sudo pwd
	cd cantari_C && make install
	cd cantari_interpreted; sudo install -m 755 * /usr/local/bin

