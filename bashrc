# This file is sourced by all *interactive* bash shells on startup,
# including some apparently interactive shells such as scp and rcp
# that can't tolerate any output. So make sure this doesn't display
# anything or bad things will happen !

# Test for an interactive shell. There is no need to set anything
# past this point for scp and rcp, and it's important to refrain from
# outputting anything in those cases.

if [[ $- != *i* ]] ; then
	# Shell is non-interactive.  Be done now!
	return
fi

# wrap these commands for interactive use to avoid accidental overwrites.
rm() { command rm -iv "$@"; }
cp() { command cp -iv "$@"; }
mv() { command mv -iv "$@"; }

# alias
#alias ls="ls -h --color=auto"
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

# Pacman alias examples
alias pacupg="sudo pacman -Syu"     # Synchronize with repositories and then upgrade packages that are out of date on the local system.
alias pacdl="pacman -Sw"            # Download specified package(s) as .tar.xz ball
alias pacin="sudo pacman -S"        # Install specific package(s) from the repositories
alias pacins="sudo pacman -U"       # Install specific package not from the repositories but from a file 
alias pacre="sudo pacman -R"        # Remove the specified package(s), retaining its configuration(s) and required dependencies
alias pacrem="sudo pacman -Rns"     # Remove the specified package(s), its configuration(s) and unneeded dependencies
alias pacrep="pacman -Si"           # Display information about a given package in the repositories
alias pacreps="pacman -Ss"          # Search for package(s) in the repositories
alias pacloc="pacman -Qi"           # Display information about a given package in the local database
alias paclocs="pacman -Qs"          # Search for package(s) in the local database
alias paclo="pacman -Qdt"           # List all packages which are orphaned
alias pacc="sudo pacman -Scc"       # Clean cache - delete all the package files in the cache
alias paclf="pacman -Ql"            # List all files installed by a given package
alias pacown="pacman -Qo"           # Show package(s) owning the specified file(s)
alias pacexpl="pacman -D --asexp"   # Mark one or more installed packages as explicitly installed 
alias pacimpl="pacman -D --asdep"   # Mark one or more installed packages as non explicitly installed

# Additional pacman alias examples
alias pacupd="sudo pacman -Sy && sudo abs"         # Update and refresh the local package and ABS databases against repositories
alias pacinsd="sudo pacman -S --asdeps"            # Install given package(s) as dependencies
alias pacmir="sudo pacman -Syy"                    # Force refresh of all package lists after updating /etc/pacman.d/mirrorlist
# Listing changed configuration files
alias changed-files="pacman -Qii | awk '/^MODIFIED/ {print $2}'"

# User Functions
# For recursively removing orphans and their configuration files: 
orphans() {
if [[ ! -n $(pacman -Qdt) ]]; then
  echo "No orphans to remove."
else
  sudo pacman -Rns $(pacman -Qdtq)
fi
}

# Getting the size of several packages
pacman-size() {
CMD="pacman -Si"
SEP=": "
TOTAL_SIZE=0

RESULT=$(eval "${CMD} $@ 2>/dev/null" | awk -F "$SEP" -v filter="Size" -v pkg="^Name" \
'$0 ~ pkg {pkgname=$2} $0 ~ filter {gsub(/\..*/,"") ; printf("%6s KiB %s\n", $2, pkgname)}' | sort -u -k3)

echo "$RESULT"

## Print total size.
echo "$RESULT" | awk '{TOTAL=$1+TOTAL} END {printf("Total : %d KiB\n", TOTAL)}'
}
