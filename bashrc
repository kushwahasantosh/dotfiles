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

## Modified commands
alias diff='colordiff'              # requires colordiff package
#alias grep='grep --color=auto'
alias more='less'
alias df='df -h'
alias du='du -c -h'
alias mkdir='mkdir -p -v'
alias nano='nano -w'
alias ping8='ping -c 5 8.8.8.8'
alias dmesg='dmesg -HL'
alias back="cd $OLDPWD"

## New commands
alias da='date "+%A, %B %d, %Y [%T]"'
alias du1='du --max-depth=1'
alias hist='history | grep'         # requires an argument
alias openports='ss --all --numeric --processes --ipv4 --ipv6'
alias pg='ps -Af | grep'           # requires an argument
alias ..='cd ..'

## ls
#alias ls='ls -hF --color=auto'
alias lr='ls -R'                    # recursive ls
alias ll='ls -l'
alias la='ll -A'
alias lx='ll -BX'                   # sort by extension
alias lz='ll -rS'                   # sort by size
alias lt='ll -rt'                   # sort by date
alias lm='la | more'

## Make Bash error tolerant
alias :q=' exit'
alias :Q=' exit'
alias :x=' exit'
alias cd..='cd ..'
alias cl='clear'

## vi specific
alias vibashrc="sudo vi /home/logic/.bashrc"
alias virootbash="vi /root/.bashrc"
alias vimake="sudo vi /etc/portage/make.conf"
alias viuse="sudo vi /etc/portage/package.use"
alias vi99="sudo vi /etc/portage/package.accept_keywords/9999.keywords"

## gentoo specific
alias esync="sudo eix-sync -a"
alias eupdate="sudo emerge -avuDN --with-bdeps=y @world"
alias epostupdate="sudo emerge --depclean && sudo revdep-rebuild"
alias emergefetch="sudo tail -f /var/log/emerge-fetch.log"
alias emerge="sudo emerge -av"
alias etcupdate="sudo etc-update"
#echo ".bashrc @ `date`" >> /home/logic/Data/dotfiles/exec_order

## gentoo kernel build
alias config="cd /usr/src/linux && sudo make menuconfig"

## useful functions

# start an init service.
function service() {
	sudo /etc/init.d/$1 $2
}
