
export TIME_STYLE=long-iso
if [ -n "$INSIDE_EMACS" ]; then 
  echo Hello Emacs
fi

umask 0007
export HOME=$(/usr/local/bin/home)
export PS_FORMAT=user:15,pid,%cpu,%mem,vsz,rss,tty,stat,start,time,command
export EDITOR=emacs

export PS1='\n$(/usr/local/bin/Z)\n\u@\h§\w§\n> '
export PS2='>>'

# Make jupyterlab happy
#   exucutables really shouldn't be put in hidden directories, consider making that a symbolic link to the
#   ~/bin
#  export PATH=~/bin:~/.local/bin:"$PATH"

# repos/resources/bin
#
  export PATH=~/resources/bin:"$PATH"

#eval $(ssh-agent)
#ssh-add ~/.ssh/key

# show the user where executables will come from
echo $PATH

