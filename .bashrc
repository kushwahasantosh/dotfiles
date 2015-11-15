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
function buildkernel() {
	echo -e "\x1B[01;93m Copying config file.. \x1B[0m"
	sudo cp -f /home/logic/Data/dotfiles/sl410-config /usr/src/linux/
	if [ -f /usr/src/linux/sl410-config ]
	then
		echo -e "\x1B[01;92m file copied. \x1B[0m"
	else
		echo -e "\x1B[01;91m config file not copied. \x1B[0m"
		return 1
	fi
	cd /usr/src/linux
	sudo mv sl410-config .config
	sudo make menuconfig
	sudo make modules_prepare
	sudo make
	sudo make modules_install
	echo -e "\x1B[01;93m Mounting boot partition... \x1B[0m"
	if grep -qs '/dev/sda3' /proc/mounts
	then
		echo -e "\x1B[01;91m already mounted. \x1B[0m"
	else
		sudo mount /boot
		echo -e "\x1B[01;92m Mounted. \x1B[0m"
	fi
	echo -e "\x1B[01;93m Installing boot files to boot... \x1B[0m"
	sudo make install
	echo -e "\x1B[01;93m Installing ramdisk and copying it to boot... \x1B[0m"
	sudo genkernel --install initramfs
	echo -e "\x1B[01;93m Updating Grub bootloader. \x1B[0m"
	sudo grub2-mkconfig -o /boot/grub/grub.cfg
	echo -e "\x1B[01;92m Build and Installation finished. \x1B[0m"
	ls -clta /boot
	echo -e "\x1B[01;93m Unmounting boot.. \x1B[0m"
	sudo umount /boot
	echo -e "\x1B[01;92m boot unmounted. \x1B[0m"
	cd
}
