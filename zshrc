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
# HIST_STAMPS="mm/dd/yyyy"

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

# reboot / halt / poweroff
alias reboot='sudo /sbin/reboot'
alias poweroff='sudo /sbin/poweroff'
alias halt='sudo /sbin/halt'
alias shutdown='sudo /sbin/shutdown'

## pass options to free ##
alias meminfo='free -m -l -t |lolcat'

## get top process eating memory
alias psmem='ps auxf | sort -nr -k 4'
alias psmem10='ps auxf | sort -nr -k 4 | head -10'

## get top process eating cpu ##
alias pscpu='ps auxf | sort -nr -k 3'
alias pscpu10='ps auxf | sort -nr -k 3 | head -10'

## Get server cpu info ##
alias cpuinfo='lscpu |lolcat'
 
## older system use /proc/cpuinfo ##
##alias cpuinfo='less /proc/cpuinfo' ##

## get GPU ram on desktop / laptop##
alias gpumeminfo='grep -i --color memory /var/log/Xorg.0.log'

# become root #
alias root='sudo -i'
alias su='sudo -i'

## All of our servers eth1 is connected to the Internets via vlan / router etc  ##
alias dnstop='dnstop -l 5  eth1'
alias vnstat='vnstat -i eth1'
alias iftop='iftop -i eth1'
alias tcpdump='tcpdump -i eth1'
alias ethtool='ethtool eth1'
 
# work on wlan0 by default #
# Only useful for laptop as all servers are without wireless interface
alias iwconfig='iwconfig wlan0'


## this one saved by butt so many times ##
alias ports='netstat -tulanp'
alias path='echo -e ${PATH//:/\\n}'

# make directory and any parent directories needed
alias mkdir='mkdir -p'

# Give less options to man
export MANPAGER='less -s -M +Gg'

## this one saved by butt so many times ##
alias wget='wget -c'
alias ports='netstat -tulanp'
alias path='echo -e ${PATH//:/\\n}'


# ═══════════════════════════════════════
# OS POWER MANAGEMENT
# ═══════════════════════════════════════
# easy shutdown/reboot
alias reboot="sudo /sbin/reboot"
alias shutdown="sudo /sbin/shutdown"

# ═══════════════════════════════════════
# OS POWER MANAGEMENT
# ═══════════════════════════════════════
# easy shutdown/reboot
alias reboot="sudo /sbin/reboot"
alias shutdown="sudo /sbin/shutdown"

# ═══════════════════════════════════════
# DISK UTILS
# ═══════════════════════════════════════
# make common commands easier to read for humans
alias df="df -Tha --total"
alias du="du -ach | sort -h"
alias free="free -mth"

# ═══════════════════════════════════════
# TIME AND DATE
# ═══════════════════════════════════════
# easy time and date printing
alias now='date +"%T"'
alias dt='date "+%F %T"'

# ═══════════════════════════════════════
# PRETTY THINGS
# ═══════════════════════════════════════
# custom cmatrix
#alias cmatrix="cmatrix -bC yellow"

# ═══════════════════════════════════════
# PROCESS MANAGEMENT
# ═══════════════════════════════════════
# search processes (find PID easily)
alias psg="ps aux | grep -v grep | grep -i -e VSZ -e"
# show all processes
alias psf="ps auxfww"
#given a PID, intercept the stdout and stderr
alias intercept="sudo strace -ff -e trace=write -e write=1,2 -p" 
# kill a given process by name
function pskill() {
    ps ax | grep "$1" | grep -v grep | awk '{ print $1 }' | xargs kill
}

# ═══════════════════════════════════════
# NETWORKS AND FILES
# ═══════════════════════════════════════

# show current IP address
ipf() {
    pip=$(ifconfig | grep -Eo 'inet (addr:)?([0-9]*\.){3}[0-9]*' | grep -v ^$)
    echo "$pip" | grep -Eo '([0-9]*\.){3}[0-9]*' | grep -v '127.0.0.1'

}
alias ip=ipf

# super convenient HTTP server
# with python 3, it will be "python3 -m http.server"
alias http="python -m http.server"

# Show active http connections
alias ports='echo -e "\n${ECHOR}Open connections :$NC "; netstat -pan --inet;'

ssidf() {
	sudo ip link set wlp1s0 down
    sudo ip link set wlp1s0 up
	sudo iwlist scan 2>/dev/null | grep ESSID | sed 's/.*ESSID://' | sed 's/"//g' | grep -v '^$'
}
alias ssid=ssidf

alias ll="ls -lai"
alias ter="sensors"
alias net="ip -s addres"
alias untar='tar -zxvf'
alias ..='cd ..'
alias ...='cd ../..'
alias ....='cd ../../..'
alias .....='cd ../../../..'
alias ......='cd ../../../../..'
alias ls='ls --color=auto'
alias dir='dir --color=auto'
alias vdir='vdir --color=auto'
alias fgrep='fgrep --color=auto'
alias egrep='egrep --color=auto'
alias diff='colordiff'
alias mount='mount |column -t'
alias now='date +"%T"'
alias nowtime=now
alias nowdate='date +"%d-%m-%Y"'
alias search="xbps-query -Rs"
alias install="sudo xbps-install -S"
alias update="sudo xbps-install -Su"
alias clean="sudo xbps-remove -O"
alias remove="sudo xbps-remove -R"
alias reconf="sudo xbps-reconfigure"
alias update-grub="sudo grub-mkconfig -o /boot/grub/grub.cfg |lolcat"
alias psa="ps auxf"
alias probe="sudo -E hw-probe -all -upload"
alias trash="sudo rm -rf ~/.local/share/Trash/*"
alias mac="inxi -zv8 |lolcat"
alias weather="inxi -wxxx |lolcat"
alias machine="inxi -Fxxxrza |lolcat"
alias non-free="xbps-query -Mi --repo=https://alpha.de.repo.voidlinux.org/current/nonfree -s \* | lolcat"
alias doit="topgrade  && sudo xbps-remove -RO && sudo vkpurge rm all && hblock &&  git-update && xanmod && goodies && nvoid && cd ~ && clear"
alias etcher="cd ~/Plantillas/varios/etcher && npm start"
alias goodies="cd ~/Plantillas/void-linux/void-goodies && git pull"
alias xanmod="cd ~/Plantillas/void-linux/xanmod/void-packages && git pull"
alias nvoid="cd ~/Plantillas/void-linux/nvoid && git pull"
alias git-update=" cd ~/Plantillas/void-linux/void-packages && git pull &&  cd ~/Plantillas/void-linux/void-mklive && git pull && cd ~/Plantillas/void-linux/xdeb && git pull"
alias update-grub="sudo grub-mkconfig -o /boot/grub/grub.cfg |lolcat"
alias probe="sudo -E hw-probe -all -upload"
alias trash="sudo rm -rf ~/.local/share/Trash/*"
alias mac="inxi -zv8"
alias weather="inxi -wxxx"
alias loc="locate"
alias lc="lsd -lA"
alias ext="extract"
alias npmaf="npm audit fix"
alias cd..='cd ..'
alias pdw="pwd"
alias npmu="sudo npm upgrade -g npm |lolcat"
alias nzsh=" cd ~ && nano .zshrc"
alias sce=" cd ~ && source .zshrc"
alias del="rm -rf"
alias kzsh="kate ~/.zshrc"
alias gcor="kate ~/.corona"
alias ft="fc-cache -f -v"
alias showme="ytfzf -t"
alias pman="colorscript -e 30 | lolcat"
alias skull="colorscript -e 33 | lolcat"
alias spaceinvaders="colorscript -e 38 | lolcat"
alias fzsh="cd ~ && featherpad .zshrc"
alias ymir="cd ~/Plantillas/void-linux/ymir-linux/void-packages"
alias ymirp="cd ~/Plantillas/void-linux/ymir-linux/void-packages && git pull |lolcat"
alias voidp="git clone git://github.com/void-linux/void-packages.git && xbpsbb"
alias services="sudo sv status /var/service/*"
eval $(thefuck --alias joder)

#youtube-dl
alias yta-aac="youtube-dl --extract-audio --audio-format aac |lolcat"
alias yta-best="youtube-dl --extract-audio --audio-format best |lolcat"
alias yta-flac="youtube-dl --extract-audio --audio-format flac |lolcat"
alias yta-m4a="youtube-dl --extract-audio --audio-format m4a |lolcat"
alias yta-mp3="youtube-dl --extract-audio --audio-format mp3 |lolcat"
alias yta-opus="youtube-dl --extract-audio --audio-format opus |lolcat"
alias yta-vorbis="youtube-dl --extract-audio --audio-format vorbis |lolcat"
alias yta-wav="youtube-dl --extract-audio --audio-format wav |lolcat"

alias ytv-best="youtube-dl -f bestvideo+bestaudio |lolcat"

#Corona
alias ccli=" sudo npm install -g corona-cli"

# corona-cli needed
alias cct="corona -s cases-today -l 10" 
alias cct2="corona -s cases-today -l 20"
alias cct3="corona -s cases-today -l 30 |lolcat"
alias cdt="corona -s deaths-today -l 10"
alias cdt2="corona -s death-today -l 20"
alias cdt3="corona -s death-today -l 30 |lolcat"
alias cpm="corona -s per-million -l 10"
alias cpm2="corona -s per-million -l 20"
alias cpm3="corona -s per-million -l 30 |lolcat"

# Corona Nothing needed
alias es1="curl https://corona-stats.online/spain\?source=1 |lolcat"
alias es2="curl https://corona-stats.online/spain\?source=2 |lolcat"
alias at1="curl https://corona-stats.online/austria\?source=1|lolcat"
alias at2="curl https://corona-stats.online/austria\?source=2|lolcat"
alias uk1="curl https://corona-stats.online/gb\?source=1 |lolcat"
alias uk2="curl https://corona-stats.online/uk\?source=2 |lolcat"
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

alias chartes="curl -L covid19.trackercli.com/history/charts/es"
alias chartess="chartes && scrot -d5 '%Y-%m-%d_$wx$h_covid-es.jpg' -e 'mv $f ~/Imágenes/shots/es/' -e 'sxiv %Y-%m-%d_$wx$h_covid-es.jpg'"
alias chartat="curl -L covid19.trackercli.com/history/charts/at"
alias chartats="chartat && scrot -d5  '%Y-%m-%d_$wx$_covid-at.jpg' -e 'mv $f ~/Imágenes/shots/at/' -e 'sxiv %Y-%m-%d_$wx$h_covid-at.jpg'"
alias chartuk="curl -L covid19.trackercli.com/history/charts/uk"
alias chartuks="chartes && scrot -d5 '%Y-%m-%d_$wx$h_covid-uk.jpg' -e 'mv $f ~/Imágenes/shots/uk/' -e 'sxiv %Y-%m-%d_$wx$h_covid-uk.jpg'"
alias watches=" watch -c -n 600 'curl -s -L covid19.trackercli.com/es'"
alias watchat=" watch -c -n 600 'curl -s -L covid19.trackercli.com/at'"
alias watchuk=" watch -c -n 600 'curl -s -L covid19.trackercli.com/uk'"
alias all3="at2 && es2 && uk2"
alias all="at1 && es1 && uk1"
alias fc="fc-cache -f -v"
alias pipesa="cpipes -p30 -r1"
alias pipesb="cpipes -p100 -r0 -i1"
alias ytfzfim="curl -sL "https://raw.githubusercontent.com/thatonecalculator/ytfzfim/master/ytfzf" | sudo tee /usr/bin/ytfzf >/dev/null && sudo chmod 755 /usr/bin/ytfzf"
alias void="cd /home/jose/Plantillas/void-linux/void-packages"
alias mklive="cd /home/jose/Plantillas/void-linux/void-mklive"
alias descargas="cd /home/jose/Descargas"
alias videos="cd /home/jose/Vídeos"
alias themes="cd /usr/share/themes"
alias fonts="cd /usr/share/fonts"
alias icons="cd /usr/share/icons"
alias ignpa="echo "ignorepkg=pulseaudio" | sudo tee -a /etc/xbps.d/XX-ignore.conf"
alias agar="cd  ~/Público/AgarimOS/"
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

wal -n -q -i /home/jose/Imágenes/walls/wall8.jpg
export PATH="$HOME/.local/bin:$PATH"
neofetch

