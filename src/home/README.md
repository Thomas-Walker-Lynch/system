# home
pulls home directory from etc/password

Typically used by scripts that do not want to be sensitive to getting the home directory from the $HOME environment variable.  Install this in a places such as /usr/local/bin  and then so something such as HOME=home at the top of scripts.
