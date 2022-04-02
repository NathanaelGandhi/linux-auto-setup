#!/bin/bash

# Declare vars
add_remotes="true";
install_all="true";

# Check for the distro
if [ -f /etc/os-release ]; then
    # freedesktop.org and systemd
    . /etc/os-release
    OS=$NAME
    VER=$VERSION_ID
fi

# Packages to install
declare -a flatpackApps=(
		"com.github.tchx84.Flatseal/x86_64/stable"
		"com.getferdi.Ferdi/x86_64/stable"
		"com.brave.Browser"
		"org.libreoffice.LibreOffice/x86_64/stable"
		"org.gimp.GIMP/x86_64/stable"
		"com.spotify.Client/x86_64/stable"
		"com.vscodium.codium/x86_64/stable"
		"com.github.phase1geo.minder/x86_64/stable"
		"app/com.dropbox.Client/x86_64/stable"
		"org.qgis.qgis/x86_64/stable"
		"app/org.kicad.KiCad/x86_64/stable"
		"org.freecadweb.FreeCAD/x86_64/stable"
		"org.kde.kdenlive/x86_64/stable"
		"com.obsproject.Studio/x86_64/stable"
		)

# Distro ARCH specific
if [ "$OS" = "Arch Linux" ]; then
	echo "Distro: ARCH detected"
	echo "Updating the system..."
	sudo pacman -Syu
	echo "Installing flatpak, git, zsh, wget, neofetch terminator"
	sudo pacman -S flatpak git zsh wget neofetch terminator
	echo "Installing ohmyzsh"
	sh -c "$(wget -O- https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"
fi

# Distro UBUNTU specific
if [ "$OS" = "Ubuntu" ]; then
	echo "Distro: UBUNTU detected"
	sudo apt install flatpak
	sudo add-apt-repository ppa:flatpak/stable
	sudo apt update
	sudo apt install flatpak
	sudo apt install gnome-software-plugin-flatpak
fi

# Add remotes
if [ "$add_remotes" = true ]; then
	echo "Adding flathub remote"
	flatpak remote-add --if-not-exists flathub https://flathub.org/repo/flathub.flatpakrepo;
	echo "Adding flathub-beta remote"
	flatpak remote-add --if-not-exists flathub-beta https://flathub.org/beta-repo/flathub-beta.flatpakrepo;
fi

# Install all packages
if [ "$install_all" = true ]; then
	for str in ${flatpackApps[@]}; do
		flatpak install $str -y --app
	done
fi

