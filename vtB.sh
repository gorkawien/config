#! /bin/sh

# OBSERVACIÓN
# Debido a que '~' es un símbolo propio del shell utilizado para expandir el directorio personal del usurio,
# se opta por reemplazarlo por la variable de entorno $HOME para evitar problemas de expasión cuando se
# utilicen comillas dobles " "

ACTUAL_DIR="$(dirname $(readlink -f "$0"))"
LOG_FILE="$HOME/.post-install.log"

packages_void () {
	# https://notabug.org/reback00/void-goodies
	# https://github.com/ymir-linux/void-packages
	
	# OBSERVACIÓN
	# sudo echo "foo" >> /path/file no funcionará si el usuario actual no tiene permisos de
	# escritura sobre el archivo file. Esto se debe a que la redirección se procesa antes de que se ejecute el comando
	
	echo "permit nopass keepenv $USER" | sudo tee -a /etc/doas.conf
	echo "ignorepkg=linux-firmware-nvidia" | sudo tee -a /etc/xbps.d/00-ignore.conf
	# sudo echo "ignorepkg=linux5.12" >> /etc/xbps.d/00-ignore.conf
	
	sudo xbps-install -Suy xbps
	sudo xbps-install -Suy
	sudo xbps-install -Suy xorg-minimal xinit nano git bash-completion setxkbmap opendoas
	sudo xbps-remove -y linux-firmware-nvidia

	sudo xbps-install -y nnn rxvt-unicode dbus sxhkd lemonbar-xft bspwm
	
	sudo xbps-install -y gcc make  libX11-devel libXft-devel libXinerama-devel 
	sudo xbps-install -y pkg-config
	
	sudo xbps-install -y xrandr xdo xdotool curl xwallpaper xrdb xclip jq unzip xsetroot
	sudo xbps-install -y picom pcmanfm lxappearance archlabs-themes papirus-icon-theme mpv libnotify
	sudo ln -s /etc/sv/dbus /var/service

	echo "[$(date '+%Y-%m-%d %H:%M.%s')] default packages done" >> "$LOG_FILE"
}


basicfolders () {
	# La expansión de llaves {...} no está definida por el estándar POSIX, por esa razón se recurre a un ciclo FOR
	for dir in downloads music bin/dwm pictures/walls videos; do
		mkdir -p "$HOME/$dir"
	done
	
	if [ ! -d /opt/git ]; then
		sudo mkdir /opt/git
		sudo chown "$USER:$USER" /opt/git
		cp -r "$ACTUAL_DIR" /opt/git
	else
		cp -r "$ACTUAL_DIR" /opt/git
	fi

	cd "$ACTUAL_DIR" || return
	cp bin/colors.sh bin/getcolor bin/nnnopen bin/pirokit bin/scratchpad bin/updatehosts bin/vm.sh bin/ytp bin/wallpaper* bin/encpass.sh bin/share "$HOME/bin"
	cp -r dmenu "$HOME/bin"
	chmod u+x "$HOME/bin/*" "$HOME/bin/dmenu/*"
	echo "! Xresources configs --- " >> "$HOME/.Xresources"
	echo "[$(date '+%Y-%m-%d %H:%M.%S')] home folders created" >> "$LOG_FILE"
}

fonts() {
	mkdir /tmp/nerdfonts
	cd /tmp/nerdfonts || return
	curl -L -o ubuntu.zip https://github.com/ryanoasis/nerd-fonts/releases/download/v2.1.0/Ubuntu.zip
	curl -L -o hack.zip https://github.com/source-foundry/Hack/releases/download/v3.003/Hack-v3.003-ttf.zip
	curl -L -o awesome-5-15.zip https://github.com/FortAwesome/Font-Awesome/releases/download/5.15.4/fontawesome-free-5.15.4-web.zip 
	curl -L -o jetbrains.zip https://download.jetbrains.com/fonts/JetBrainsMono-1.0.0.zip?fromGitHub
	unzip "*.zip"
	rm *Windows*
	sudo mkdir -p /usr/share/fonts/truetype/newfonts

	find . -name '*.ttf' >tmp
	while read file
	do
		sudo cp "$file" /usr/share/fonts/truetype/newfonts
	done<tmp
	sudo fc-cache -f -v
	echo "[$(date '+%Y-%m-%d %H:%M.%S')] fonts added" >> "$LOG_FILE"
}


gitrepos() {
	# dmenu from suckless
	git clone --depth 1  https://git.suckless.org/dmenu /opt/git/dmenu 
	cd /opt/git/dmenu || return
	git apply "$ACTUAL_DIR/dwm_patches/dmenu-border-20201112-1a13d04.diff"
	git apply "$ACTUAL_DIR/dwm_patches/dmenu-center-20200111-8cd37e1.diff"
	make && strip dmenu stest
	for i in dmenu dmenu_* stest; do
		sudo ln -sf "$PWD/$i" /usr/local/bin
	done
	
	# Crear enlace de manuales de usuario
	for i in *.1; do
		sudo ln -sf "$PWD/$i" /usr/local/share/man/man1/
	done
	
	echo "[$(date '+%Y-%m-%d %H:%M.%S')] git repos cloned, compiled and installed ($1)" >> "$LOG_FILE"
}

get_herbe() {
	git clone --depth 1  https://github.com/dudik/herbe /opt/git/herbe
	cd /opt/git/herbe || return
	curl -o patch_Xresources.diff https://patch-diff.githubusercontent.com/raw/dudik/herbe/pull/11.diff
	git apply patch_Xresources
	make && strip herbe
	sudo ln -fs "$PWD/herbe" /usr/local/bin
	echo "[$(date '+%Y-%m-%d %H:%M.%S')] herbe repo cloned and installed with Xresources support" >> "$LOG_FILE"
}

defaultbspwm () {
	for dir in bspwm sxhkd; do
		mkdir -p "$HOME/.config/$dir"
	done
	cp /usr/share/doc/bspwm/examples/bspwmrc "$HOME/.config/bspwm/"
	cp /opt/git/dotfiles/bspwm/sxhkdrc "$HOME/.config/sxhkd/"
	chmod u+x "$HOME/.config/bspwm/bspwmrc"
	chmod u+x "$HOME/.config/sxhkd/sxhkdrc"
	sed -i 's/urxvt/urxvtc/' "$HOME/.config/sxhkd/sxhkdrc"
	sed -i 's/urxvtcc/urxvtc/' "$HOME/.config/sxhkd/sxhkdrc"
	
	sed -i 's/super + @space/super + p/' "$HOME/.config/sxhkd/sxhkdrc"

	# scratchpads (using instance name, not class name)
	echo "bspc rule -a \"*:scratchpad\"     sticky=on state=floating"  >> "$HOME/.config/bspwm/bspwmrc"
	echo "bspc rule -a \"*:scratchurxvt\"   sticky=on state=floating"  >> "$HOME/.config/bspwm/bspwmrc"
	echo "bspc rule -a \"*:stmusic\"        sticky=on state=floating"  >> "$HOME/.config/bspwm/bspwmrc"
	echo "xsetroot -cursor_name left_ptr &" >> "$HOME/.config/bspwm/bspwmrc"
	echo "picom &" >> "$HOME/.config/bspwm/bspwmrc"
	echo "# dunst &" >> "$HOME/.config/bspwm/bspwmrc"
	echo "urxvtd -q -o -f &" >> "$HOME/.config/bspwm/bspwmrc"

	echo " " >> "$HOME/.config/sxhkd/sxhkdrc"
	echo "#super + ntilde" >> "$HOME/.config/sxhkd/sxhkdrc"
	echo "#    /home/$USER/bin/scratchpad" >> "$HOME/.config/sxhkd/sxhkdrc"
	
	echo "[$(date '+%Y-%m-%d %H:%M.%S')] bspwm & sxhkd installed and configured" >> "$LOG_FILE"
}

lemonbarpanelbsp () {
	mkdir -p "$HOME/bin/bspwm"
	cp "$ACTUAL_DIR/bspwm/panel*" "$HOME/bin/bspwm"
	cp "$ACTUAL_DIR/bspwm/launch-bar" "$HOME/bin/bspwm"
	chmod u+x "$HOME/bin/bspwm/*"
	echo '"$HOME/bin/bspwm/launch-bar" &' >> "$HOME/.config/bspwm/bspwmrc"
	echo "[$(date '+%F %T')] lemonbar panel configured" >> "$LOG_FILE"
}

walls () {
	cd "$HOME/pictures/walls" || return
	curl -O http://static.simpledesktops.com/uploads/desktops/2012/01/25/enso3.png
	curl -O http://static.simpledesktops.com/uploads/desktops/2018/07/29/night.png
	curl -O http://static.simpledesktops.com/uploads/desktops/2018/03/29/ESTRES.png
	curl -O http://static.simpledesktops.com/uploads/desktops/2016/07/19/Path.png
	curl -O http://static.simpledesktops.com/uploads/desktops/2013/02/22/Desktop_Squares.png
	curl -O http://static.simpledesktops.com/uploads/desktops/2014/10/15/tetons-at-night.png
	curl -O http://static.simpledesktops.com/uploads/desktops/2015/03/21/coffee-pixels.png
	curl -O http://static.simpledesktops.com/uploads/desktops/2015/03/02/mountains-on-mars.png
	curl -O http://static.simpledesktops.com/uploads/desktops/2015/02/20/zentree_1.png
	curl -O http://static.simpledesktops.com/uploads/desktops/2013/09/18/wallpaper.png
	echo "wallpaper-loop &" >> "$HOME/.config/bspwm/bspwmrc"
	echo "[$(date '+%Y-%m-%d %H:%M.%S')] wallpapers downloaded and working" >> "$LOG_FILE"
}

finalsetup () {
	youtube_downloader
	notify_dunst
	cd "$ACTUAL_DIR" || return
	cat Xresources >> "$HOME/.Xresources"
	echo 'xrdb -merge "$HOME/.Xresources" &' >> "$HOME/.xinitrc"
	echo "setxkbmap at &" >> "$HOME/.xinitrc"
	echo "exec bspwm" >> "$HOME/.xinitrc"
	cat bashrc >> "$HOME/.bashrc"
	echo "[$(date '+%Y-%m-%d %H:%M.%S')] xinitrc & bash alias setups done" >> "$LOG_FILE"
}

packages_void && basicfolders && fonts && gitrepos && get_herbe && defaultbspwm && lemonbarpanelbsp && walls && finalsetup

