#
# /etc/bash.bashrc
#

# If not running interactively, don't do anything
[[ $- != *i* ]] && return

[ -r /usr/share/bash-completion/bash_completion   ] && . /usr/share/bash-completion/bash_completion

#!/bin/sh

# alias
alias ls="ls -h --color=auto"
alias ll="ls -l"
alias la="ls -A"
alias l="ls -CF"
alias cl="clear"
alias grep="grep --color=auto"
alias back="cd $OLDPWD"
alias dfh="df -h"
alias ..='cd ..'
alias ...='cd ../..'
alias ....='cd ../../..'
alias .....='cd ../../../..'
alias dmesg="dmesg --color=always"
alias mkdir="mkdir -p -v"

# Listing changed configuration files
alias changed-files="pacman -Qii | awk '/^MODIFIED/ {print $2}'"

# Pacman alias examples
alias pacupg="pacman -Syu"     # Synchronize with repositories and then upgrade packages that are out of date on the local system.
alias pacdl="pacman -Sw"            # Download specified package(s) as .tar.xz ball
alias pacin="pacman -S"        # Install specific package(s) from the repositories
alias pacins="pacman -U"       # Install specific package not from the repositories but from a file 
alias pacre="pacman -R"        # Remove the specified package(s), retaining its configuration(s) and required dependencies
alias pacrem="pacman -Rns"     # Remove the specified package(s), its configuration(s) and unneeded dependencies
alias pacrep="pacman -Si"           # Display information about a given package in the repositories
alias pacreps="pacman -Ss"          # Search for package(s) in the repositories
alias pacloc="pacman -Qi"           # Display information about a given package in the local database
alias paclocs="pacman -Qs"          # Search for package(s) in the local database
alias paclo="pacman -Qdt"           # List all packages which are orphaned
alias pacc="pacman -Scc"       # Clean cache - delete all the package files in the cache
alias paclf="pacman -Ql"            # List all files installed by a given package
alias pacown="pacman -Qo"           # Show package(s) owning the specified file(s)
alias pacexpl="pacman -D --asexp"   # Mark one or more installed packages as explicitly installed 
alias pacimpl="pacman -D --asdep"   # Mark one or more installed packages as non explicitly installed

# Additional pacman alias examples
alias pacupd="pacman -Sy && sudo abs"         # Update and refresh the local package and ABS databases against repositories
alias pacinsd="pacman -S --asdeps"            # Install given package(s) as dependencies
alias pacmir="pacman -Syy"                    # Force refresh of all package lists after updating /etc/pacman.d/mirrorlist

# Prompt color and options
set_prompt () {
    local last_command=$? # Must come first!
    PS1=""
    local blue='\[\e[01;34m\]'
    local white='\[\e[01;37m\]'
    local red='\[\e[01;31m\]'
    local green='\[\e[01;32m\]'
    local reset='\[\e[00m\]'
    local fancyX='\342\234\227'
    local checkmark='\342\234\223'

# Add a bright white exit status for the last command
PS1+="$white\$? "
# If it was successful, print a green check mark. Otherwise, print
# a red X.
if [[ $last_command == 0 ]]; then
	PS1+="$green$checkmark "
else
	PS1+="$red$fancyX "
fi
# If root, just print the host in red. Otherwise, print the current user
# and host in green.
if [[ $EUID == 0 ]]; then
	PS1+="$red\\h "
else
	PS1+="$green\\u@\\h "
fi
# Print the working directory and prompt marker in blue, and reset
# the text color to the default.
PS1+="$blue\\w \\\$$reset "
}
PROMPT_COMMAND='set_prompt'

# Dir colors
if [[ -f ~/.dir_colors ]] ; then
	eval $(dircolors -b ~/.dir_colors)
elif [[ -f /etc/DIR_COLORS ]] ; then
	eval $(dircolors -b /etc/DIR_COLORS)
fi
