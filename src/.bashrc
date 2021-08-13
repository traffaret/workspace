# ANSI color codes
RS="\e[0m"    # reset
HC="\e[1m"    # hicolor
UL="\e[4m"    # underline
INV="\e[7m"   # inverse background and foreground
FBLK="\e[30m" # foreground black
FRED="\e[31m" # foreground red
FGRN="\e[32m" # foreground green
FYEL="\e[33m" # foreground yellow
FBLE="\e[34m" # foreground blue
FMAG="\e[35m" # foreground magenta
FCYN="\e[36m" # foreground cyan
FWHT="\e[37m" # foreground white
BBLK="\e[40m" # background black
BRED="\e[41m" # background red
BGRN="\e[42m" # background green
BYEL="\e[43m" # background yellow
BBLE="\e[44m" # background blue
BMAG="\e[45m" # background magenta
BCYN="\e[46m" # background cyan
BWHT="\e[47m" # background white

color_prompt=yes

export EDITOR=vim
export PHPBREW_SET_PROMPT=1

[[ -e ~/.phpbrew/bashrc ]] && source ~/.phpbrew/bashrc

function set_prompt() {
# Get Virtual Env
	if [[ $VIRTUAL_ENV != "" ]]
	then
	    # Strip out the path and just leave the env name
		venv="$FYEL(${VIRTUAL_ENV##*/}) "
	else
	    # In case you don't have one activated
	    venv=''
	fi

	if [ "$color_prompt" = yes ]; then
        _PS1="$HC$FYEL[ $venv$FRED${debian_chroot:+($debian_chroot)}\u@\h: $FGRN\w $FYEL]\\$ $RS"
	else
	    _PS1='${debian_chroot:+($debian_chroot)}\u:\w\$ '
	fi

	export PS1=$_PS1
    echo -ne "\033]0;${USER}@${HOSTNAME}\007"
}

# Ping рф domains
pingrf() {
    ping $(idn --quiet "$@")
}

#cur_tty="$(tty)" ; cur_tty="${cur_tty:5}" # The tty we are working on
PROMPT_COMMAND=set_prompt
alias ls="ls --color=auto"
LS_COLORS="di=31;1:ln=36;1:ex=31;1:*~=31;1:*.html=31;1:*.shtml=37;1"
export LS_COLORS
