# If you come from bash you might have to change your $PATH.
# export PATH=$HOME/bin:/usr/local/bin:$PATH

# Path to your oh-my-zsh installation.
export ZSH="/home/jose/.oh-my-zsh"

# Set name of the theme to load --- if set to "random", it will
# load a random theme each time oh-my-zsh is loaded, in which case,
# to know which specific one was loaded, run: echo $RANDOM_THEME
# See https://github.com/ohmyzsh/ohmyzsh/wiki/Themes
ZSH_THEME="0i0"

# Set list of themes to pick from when loading at random
# Setting this variable when ZSH_THEME=random will cause zsh to load
# a theme from this variable instead of looking in $ZSH/themes/
# If set to an empty array, this variable will have no effect.
# ZSH_THEME_RANDOM_CANDIDATES=( "robbyrussell" "agnoster" )

# Uncomment the following line to use case-sensitive completion.
# CASE_SENSITIVE="true"

# Uncomment the following line to use hyphen-insensitive completion.
# Case-sensitive completion must be off. _ and - will be interchangeable.
# HYPHEN_INSENSITIVE="true"

# Uncomment the following line to disable bi-weekly auto-update checks.
# DISABLE_AUTO_UPDATE="true"

# Uncomment the following line to automatically update without prompting.
# DISABLE_UPDATE_PROMPT="true"

# Uncomment the following line to change how often to auto-update (in days).
# export UPDATE_ZSH_DAYS=13

# Uncomment the following line if pasting URLs and other text is messed up.
# DISABLE_MAGIC_FUNCTIONS="true"

# Uncomment the following line to disable colors in ls.
# DISABLE_LS_COLORS="true"

# Uncomment the following line to disable auto-setting terminal title.
# DISABLE_AUTO_TITLE="true"

# Uncomment the following line to enable command auto-correction.
# ENABLE_CORRECTION="true"

# Uncomment the following line to display red dots whilst waiting for completion.
# Caution: this setting can cause issues with multiline prompts (zsh 5.7.1 and newer seem to work)
# See https://github.com/ohmyzsh/ohmyzsh/issues/5765
# COMPLETION_WAITING_DOTS="true"

# Uncomment the following line if you want to disable marking untracked files
# under VCS as dirty. This makes repository status check for large repositories
# much, much faster.
# DISABLE_UNTRACKED_FILES_DIRTY="true"

# Uncomment the following line if you want to change the command execution time
# stamp shown in the history command output.
# You can set one of the optional three formats:
# "mm/dd/yyyy"|"dd.mm.yyyy"|"yyyy-mm-dd"
# or set a custom format using the strftime function format specifications,
# see 'man strftime' for details.
HIST_STAMPS="dd.mm.yyyy"

# Would you like to use another custom folder than $ZSH/custom?
# ZSH_CUSTOM=/path/to/new-custom-folder

# Which plugins would you like to load?
# Standard plugins can be found in $ZSH/plugins/
# Custom plugins may be added to $ZSH_CUSTOM/plugins/
# Example format: plugins=(rails git textmate ruby lighthouse)
# Add wisely, as too many plugins slow down shell startup.

plugins=(extract
git
git-extras
you-should-use
zfzf
zsh-autosuggestions
zsh-completions
zsh-syntax-highlighting
zsh-thefuck
history-substring-search)


source $ZSH/oh-my-zsh.sh

# User configuration

# export MANPATH="/usr/local/man:$MANPATH"

# You may need to manually set your language environment
 export LANG=es_ES.UTF-8
 
 #LOCAL bin directory
export PATH="$HOME/.local/bin:$PATH"

# Expand the history size
export HISTFILESIZE=10000
export HISTSIZE=500

# Don't put duplicate lines in the history and do not add lines that start with a space
export HISTCONTROL=erasedups:ignoredups:ignorespace

# Note: bind used instead of sticking these in .inputrc
if [[ $iatest > 0 ]]; then bind "set completion-ignore-case on"; fi

# Show auto-completion list automatically, without double tab
if [[ $iatest > 0 ]]; then bind "set show-all-if-ambiguous On"; fi

# To have colors for ls and all grep commands such as grep, egrep and zgrep
export CLICOLOR=1
export LS_COLORS='no=00:fi=00:di=00;34:ln=01;36:pi=40;33:so=01;35:do=01;35:bd=40;33;01:cd=40;33;01:or=40;31;01:ex=01;32:*.tar=01;31:*.tgz=01;31:*.arj=01;31:*.taz=01;31:*.lzh=01;31:*.zip=01;31:*.z=01;31:*.Z=01;31:*.gz=01;31:*.bz2=01;31:*.deb=01;31:*.rpm=01;31:*.jar=01;31:*.jpg=01;35:*.jpeg=01;35:*.gif=01;35:*.bmp=01;35:*.pbm=01;35:*.pgm=01;35:*.ppm=01;35:*.tga=01;35:*.xbm=01;35:*.xpm=01;35:*.tif=01;35:*.tiff=01;35:*.png=01;35:*.mov=01;35:*.mpg=01;35:*.mpeg=01;35:*.avi=01;35:*.fli=01;35:*.gl=01;35:*.dl=01;35:*.xcf=01;35:*.xwd=01;35:*.ogg=01;35:*.mp3=01;35:*.wav=01;35:*.xml=00;31:'
#export GREP_OPTIONS='--color=auto' #deprecated
alias grep="/usr/bin/grep $GREP_OPTIONS"
unset GREP_OPTIONS

# Color for manpages in less makes manpages a little easier to read
export LESS_TERMCAP_mb=$'\E[01;31m'
export LESS_TERMCAP_md=$'\E[01;31m'
export LESS_TERMCAP_me=$'\E[0m'
export LESS_TERMCAP_se=$'\E[0m'
export LESS_TERMCAP_so=$'\E[01;44;33m'
export LESS_TERMCAP_ue=$'\E[0m'
export LESS_TERMCAP_us=$'\E[01;32m'

# kill a given process by name
function pskill() {
    ps ax | grep "$1" | grep -v grep | awk '{ print $1 }' | xargs kill
}

# Copy file with a progress bar
cpp()
{
	set -e
	strace -q -ewrite cp -- "${1}" "${2}" 2>&1 \
	| awk '{
	count += $NF
	if (count % 10 == 0) {
		percent = count / total_size * 100
		printf "%3d%% [", percent
		for (i=0;i<=percent;i++)
			printf "="
			printf ">"
			for (i=percent;i<100;i++)
				printf " "
				printf "]\r"
			}
		}
	END { print "" }' total_size=$(stat -c '%s' "${1}") count=0
}

# Copy and go to the directory
cpg ()
{
	if [ -d "$2" ];then
		cp $1 $2 && cd $2
	else
		cp $1 $2
	fi
}

# Move and go to the directory
mvg ()
{
	if [ -d "$2" ];then
		mv $1 $2 && cd $2
	else
		mv $1 $2
	fi
}

# Create and go to the directory
mkdirg ()
{
	mkdir -p $1
	cd $1
}

# Goes up a specified number of directories  (i.e. up 4)
up ()
{
	local d=""
	limit=$1
	for ((i=1 ; i <= limit ; i++))
		do
			d=$d/..
		done
	d=$(echo $d | sed 's/^\///')
	if [ -z "$d" ]; then
		d=..
	fi
	cd $d
}

# Preferred editor for local and remote sessions
# if [[ -n $SSH_CONNECTION ]]; then
#   export EDITOR='vim'
# else
#   export EDITOR='mvim'
# fi

# Compilation flags
# export ARCHFLAGS="-arch x86_64"

# Set personal aliases, overriding those provided by oh-my-zsh libs,
# plugins, and themes. Aliases can be placed here, though oh-my-zsh
# users are encouraged to define aliases within the ZSH_CUSTOM folder.
# For a full list of active aliases, run `alias`.
#
# Example aliases
# alias zshconfig="mate ~/.zshrc"
# alias ohmyzsh="mate ~/.oh-my-zsh"

#Void Linux
alias search="xbps-query -Rs"
alias install="sudo xbps-install -S"
alias update="sudo xbps-install -Su"
alias clean="sudo xbps-remove -O"
alias remove="sudo xbps-remove -R"
alias reconf="sudo xbps-reconfigure"
alias update-grub="sudo grub-mkconfig -o /boot/grub/grub.cfg"
alias restricted="void && grep -rl '^restricted=' srcpkgs/"
alias services="sudo sv status /var/service/*"
alias non-free="xbps-query -Mi --repo=https://alpha.de.repo.voidlinux.org/current/nonfree -s \*"
alias doit="src && topgrade && clean && hblock && ytfzfi && clear"
alias void="cd /home/jose/Plantillas/void-linux/void-packages"
alias mklive="cd /home/jose/Plantillas/void-linux/void-mklive"
alias ignpa="echo "ignorepkg=pulseaudio" | sudo tee -a /etc/xbps.d/XX-ignore.conf"
alias etcher="cd ~/Plantillas/varios/etcher && npm start"
alias goodies="cd ~/Plantillas/void-linux/void-goodies && git pull"
alias xanmod="cd ~/Plantillas/void-linux/xanmod/void-packages && git pull"
alias nvoid="cd ~/Plantillas/void-linux/nvoid && git pull"
alias git-update="cd ~/Plantillas/void-linux/void-packages && git pull &&  cd ~/Plantillas/void-linux/void-mklive && git pull"
alias ymir="cd ~/Plantillas/void-linux/ymir-linux/void-packages"
alias ymirp="cd ~/Plantillas/void-linux/ymir-linux/void-packages && git pull"
alias voidp="git clone git://github.com/void-linux/void-packages.git && xbpsbb"
alias agar="cd  ~/Público/AgarimOS/"

#youtube-dl
alias yta-aac="youtube-dl --extract-audio --audio-format aac"
alias yta-best="youtube-dl --extract-audio --audio-format best"
alias yta-flac="youtube-dl --extract-audio --audio-format flac"
alias yta-m4a="youtube-dl --extract-audio --audio-format m4a"
alias yta-mp3="youtube-dl --extract-audio --audio-format mp3"
alias yta-opus="youtube-dl --extract-audio --audio-format opus"
alias yta-vorbis="youtube-dl --extract-audio --audio-format vorbis"
alias yta-wav="youtube-dl --extract-audio --audio-format wav"

alias ytv-best="youtube-dl -f bestvideo+bestaudio"

# Corona
alias top10="curl 'https://corona-stats.online?top=10&source=2&minimal=true&emojis=true'"
alias top20="curl 'https://corona-stats.online?top=20&source=2&minimal=true&emojis=true'"
alias top30="curl 'https://corona-stats.online?top=30&source=2&minimal=true&emojis=true'"
alias top40="curl 'https://corona-stats.online?top=40&source=2&minimal=true&emojis=true'"

alias coves="curl -L covid19.trackercli.com/es"
alias covat="curl -L covid19.trackercli.com/at"
alias covuk="curl -L covid19.trackercli.com/gb"
alias covde="curl -L covid19.trackercli.com/de"
alias covfr="curl -L covid19.trackercli.com/fr"
alias covru="curl -L covid19.trackercli.com/ru"
alias covil="curl -L covid19.trackercli.com/il"
alias covit="curl -L covid19.trackercli.com/it"
alias covbe="curl -L covid19.trackercli.com/be"
alias covpt="curl -L covid19.trackercli.com/pt"
alias covnl="curl -L covid19.trackercli.com/nl"
alias covch="curl -L covid19.trackercli.com/ch"

# Alias's for multiple directory listing commands
alias la='ls -Alh' # show hidden files
alias ls='ls -aFh --color=always' # add colors and file type extensions
alias lx='ls -lXBh' # sort by extension
alias lk='ls -lSrh' # sort by size
alias lc='ls -lcrh' # sort by change time
alias lu='ls -lurh' # sort by access time
alias lr='ls -lRh' # recursive ls
alias lt='ls -ltrh' # sort by date
alias lm='ls -alh |more' # pipe through 'more'
alias lw='ls -xAh' # wide listing format
alias ll='ls -Fls' # long listing format
alias labc='ls -lap' #alphabetical sort
alias lf="ls -l | egrep -v '^d'" # files only
alias ldir="ls -l | egrep '^d'" # directories only

# I am lazy
alias ..='cd ..'
alias ...='cd ../..'
alias ....='cd ../../..'
alias .....='cd ../../../..'
alias ......='cd ../../../../..'
alias descargas="cd /home/jose/Descargas"
alias videos="cd /home/jose/Vídeos"
alias themes="cd /usr/share/themes"
alias fonts="cd /usr/share/fonts"
alias icons="cd /usr/share/icons"
alias trash="sudo rm -rf ~/.local/share/Trash/*"
alias npmu="sudo npm upgrade -g npm"
alias nzsh=" cd ~ && nano .zshrc"
alias sce=" cd ~ && source .zshrc"
alias del="rm -rf"
alias ft="fc-cache -f -v"
alias kzsh="kate ~/.zshrc"
alias probe="sudo -E hw-probe -all -upload"
alias fzsh="cd ~ && featherpad .zshrc"
alias npmaf="npm audit fix"
alias ter="sensors"
alias diff='colordiff'
alias untar='tar -zxvf'
alias multitail='multitail --no-repeat -c'
alias loc="locate"
alias lc="lsd -lA"
alias ext="extract"
alias vi="vim"
alias mount='mount |column -t'
alias chsh="chsh -s /bin/bash"
#Inxi
alias mac="inxi -zv8"
alias weather="inxi -wxxx"
alias machine="inxi -Fxxxrza"

# Kitty
alias icat="kitty +kitten icat"
alias d="kitty +kitten diff"
alias clip="kitty +kitten clipboard"

#Ricing
alias nerdfetch="curl -fsSL https://raw.githubusercontent.com/ThatOneCalculator/NerdFetch/master/nerdfetch | sh"
alias pipesa="cpipes -p30 -r1"
alias pipesb="cpipes -p100 -r0 -i1"
alias pman="colorscript -e 30"
alias skull="colorscript -e 33"
alias spaceinvaders="colorscript -e 38"

#Ytfzf
alias showme="ytfzf -t"
alias ytfzfi="curl -sL "https://raw.githubusercontent.com/pystardust/ytfzf/master/ytfzf" | sudo tee /usr/local/bin/ytfzf >/dev/null && sudo chmod 755 /usr/local/bin/ytfzf"

#Common mistakes

alias cd..='cd ..'
alias pdw="pwd"
alias isntall="install"

#Other aliases

# reboot / halt / poweroff
alias reboot='sudo /sbin/reboot'
alias poweroff='sudo /sbin/poweroff'
alias halt='sudo /sbin/halt'
alias shutdown='sudo /sbin/shutdown'

# alias chmod commands
alias mx='chmod a+x'
alias 000='chmod -R 000'
alias 644='chmod -R 644'
alias 666='chmod -R 666'
alias 755='chmod -R 755'
alias 777='chmod -R 777'

# Search command line history
alias h="history | grep "
alias tree='tree -CAhF --dirsfirst'
alias treed='tree -CAFd'
alias mountedinfo='df -hT'

# cd into the old directory
alias bd='cd "$OLDPWD"'

# Remove a directory and all files
alias rmd='/bin/rm  --recursive --force --verbose'

# Stop after sending count ECHO_REQUEST packets #
alias ping='ping -c 5'

# Do not wait interval 1 second, go fast #
alias fastping='ping -c 100 -s.2'

## shortcut  for iptables and pass it via sudo#
alias ipt='sudo /sbin/iptables'
 
# display all rules #
alias iptlist='sudo /sbin/iptables -L -n -v --line-numbers'
alias iptlistin='sudo /sbin/iptables -L INPUT -n -v --line-numbers'
alias iptlistout='sudo /sbin/iptables -L OUTPUT -n -v --line-numbers'
alias iptlistfw='sudo /sbin/iptables -L FORWARD -n -v --line-numbers'
alias firewall=iptlist

# do not delete / or prompt if deleting more than 3 files at a time #
alias rm='rm -I --preserve-root'
 
# get web server headers #
alias header='curl -I'
 
# find out if remote server supports gzip / mod_deflate or not #
alias headerc='curl -I --compress'

# confirmation #
alias mv='mv -i'
alias cp='cp -i'
alias ln='ln -i'

# Parenting changing perms on / #
alias chown='chown --preserve-root'
alias chmod='chmod --preserve-root'
alias chgrp='chgrp --preserve-root'

## pass options to free ##
alias meminfo='free -m -l -t'

## get top process eating memory
alias psmem='ps auxf | sort -nr -k 4'
alias psmem10='ps auxf | sort -nr -k 4 | head -10'

## get top process eating cpu ##
alias pscpu='ps auxf | sort -nr -k 3'
alias pscpu10='ps auxf | sort -nr -k 3 | head -10'

## Get server cpu info ##
alias cpuinfo='lscpu'
 
## get GPU ram on desktop / laptop##
alias gpumeminfo='grep -i --color memory /var/log/Xorg.0.log'

# become root #
alias root='sudo -i'
alias su='sudo -i'

# Time 
alias now='date +"%T"'
alias nowtime='now'
alias nowdate='date +"%d-%m-%Y"'

# make directory and any parent directories needed
alias mkdir='mkdir -p'

# Give less options to man
export MANPAGER='less -s -M +Gg'

## this one saved by butt so many times ##
alias wget='wget -c'
alias path='echo -e ${PATH//:/\\n}'

# make common commands easier to read for humans
alias df="df -Tha --total"
alias du="du -ach | sort -h"
alias free="free -mth"

# custom cmatrix
#alias cmatrix="cmatrix -bC yellow"

# search processes (find PID easily)
alias psg="ps aux | grep -v grep | grep -i -e VSZ -e"
# show all processes
alias psf="ps auxfww"
#given a PID, intercept the stdout and stderr
alias intercept="sudo strace -ff -e trace=write -e write=1,2 -p" 

#
# # ex - archive extractor
# # usage: ex <file>
ex ()
{
  if [ -f $1 ] ; then
    case $1 in
      *.tar.bz2)   tar xjf $1   ;;
      *.tar.gz)    tar xzf $1   ;;
      *.bz2)       bunzip2 $1   ;;
      *.rar)       unrar x $1     ;;
      *.gz)        gunzip $1    ;;
      *.tar)       tar xf $1    ;;
      *.tbz2)      tar xjf $1   ;;
      *.tgz)       tar xzf $1   ;;
      *.zip)       unzip $1     ;;
      *.Z)         uncompress $1;;
      *.7z)        7z x $1      ;;
      *)           echo "'$1' cannot be extracted via ex()" ;;
    esac
  else
    echo "'$1' is not a valid file"
  fi
}

eval $(thefuck --alias joder)
wal -n -q -i /home/jose/Imágenes/walls/wall12.jpg
neofetch
