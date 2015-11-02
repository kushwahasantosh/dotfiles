# This file is sourced by bash for login shells.
# An interactive login shell is started after a successful login, using a login program,
# by reading the /etc/passwd file; normally reads /etc/profile and ~/.bash_profile upon
# startup.
# An interactive non-login shell is normally started at the command-line using a shell
# program (e.g. [prompt]$/bin/bash) or by the /bin/su command. It is also started with
# a terminal program such as xterm or konsole from within a graphical environment.This
# type of shell invocation normally copies the parent environment and then reads the
# user's ~/.bashrc file for additional startup configuration.
# A non-interactive shell is usually present when a shell script is running. It is non
# interactive because it is processing a script and not waiting for the user's input
# between commands. For these shell invocations, only the environment inherited from 
# the parent shell is used.

# Test for interactive(non login) shell (pattern *i*) and then source .bashrc

case $- in 
  *i*)  # interactive shell
	if [ -r ~/.bashrc ]; then
	  #echo "Sourcing ~/.bashrc from ~/.bash_profile @ `date`" >> /home/logic/Data/dotfiles/exec_order
          . ~/.bashrc; 
	  #echo "Sourced ~/.bashrc from ~/.bash_profile @ `date`" >> /home/logic/Data/dotfiles/exec_order
        fi ;; 
esac

# Personal environment variables and startup programs

# Auto "cd" when entering just a path 
shopt -s autocd

# Line wrap on window resize
shopt -s checkwinsize

# Enable history appending instead of overwriting.
shopt -s histappend

# no double entries in the shell history
export HISTCONTROL="$HISTCONTROL erasedups:ignoreboth"

# do not overwrite files when redirecting output by default.
set -o noclobber


# Add user bin directory to path.
if [ -d "$HOME/bin" ] ; then
  export PATH=$HOME/bin:${PATH}
fi
  
# Add user script directory to path
if [ -d "$HOME/Scripts" ] ; then
  export PATH=$HOME/Scripts:${PATH}
fi 

# Removes the Vim Warning "No Protocol Specified"
export XAUTHORITY=/home/logic/.Xauthority

# Path for android sdk
export PATH=$PATH:/home/logic/AndroidSdk/platform-tools:/home/logic/AndroidSdk/tools

# Coursera specific directory aliases
export uwhpsc=/home/logic/Data/mooc/Coursera/HighPerformanceScientificComputing/uwhpsc
export hw_hpsc=/home/logic/Data/mooc/Coursera/HighPerformanceScientificComputing/hw_hpsc

# Colored output through environment variables
export LESS_TERMCAP_mb=$'\E[01;31m'
export LESS_TERMCAP_md=$'\E[01;31m'
export LESS_TERMCAP_me=$'\E[0m'
export LESS_TERMCAP_se=$'\E[0m'
export LESS_TERMCAP_so=$'\E[01;33m'
export LESS_TERMCAP_ue=$'\E[0m'
export LESS_TERMCAP_us=$'\E[01;32m'
export LESS='-R '

# To disable "sgr escape sequences"
export GROFF_NO_SGR=1

# Path settings for drjava for algorithm course
export PATH=$PATH:/home/logic/algs4/bin

# google drive settings based on go language
export PATH=$PATH:/home/logic/.gopath:/home/logic/.gopath/bin

# settings for go language
export GOPATH=~/go
export PATH=$PATH:~/go/bin 

# Enable Xft for older gtk and qt based applications
export GDK_USE_XFT=1
export QT_XFT=true

# dot file execution order 
#echo ".bash_profile @ `date`" >> /home/logic/Data/dotfiles/exec_order

# libraries and function used in Algorithm-1 Course by Coursera (Princeton) are contained in algs4.jar
# to access it use either DrJava or add the classpath manually to java 
#export CLASSPATH=$CLASSPATH:/home/logic/algs4/algs4.jar
