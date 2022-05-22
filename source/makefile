
executable = home user user-stem user-subu
all: $(executable)

home : home.c
	gcc -o home home.c

user : user.c
	gcc -o user user.c

user-stem : user-stem.c
	gcc -o user-stem user-stem.c

user-subu : user-subu.c
	gcc -o user-subu user-subu.c

.PHONY: clean
clean:
	rm -f home user user-stem usr-subu

# installation must be done by an account that has sudo privs
.PHONY: install
install: $(executable)
	for ex in $(executable); do \
	  sudo chmod 755 $$ex; \
	  sudo chown root:root $$ex; \
	  sudo mv $$ex /usr/local/bin; \
	done
