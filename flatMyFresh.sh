#!/bin/bash

# Declare vars
add_remotes="true";
distro_arch="true";
distro_ubuntu="false";
install_all="true";

# Packages to install
declare -a myArray=(
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
if [ "$distro_arch" = true ] ; then
	echo "Distro: ARCH selected"
	echo "Installing flatpak"
	sudo pacman -S flatpak
fi

# Distro UBUNTU specific
if [ "$distro_arch" = true ] ; then
	echo "Distro: UBUNTU selected"
	sudo apt install flatpak
	sudo add-apt-repository ppa:flatpak/stable
	sudo apt update
	sudo apt install flatpak
	sudo apt install gnome-software-plugin-flatpak
fi

# Add remotes
if [ "$add_remotes" = true ] ; then
	echo "Adding flathub remote"
	flatpak remote-add --if-not-exists flathub https://flathub.org/repo/flathub.flatpakrepo;
	echo "Adding flathub-beta remote"
	flatpak remote-add --if-not-exists flathub-beta https://flathub.org/beta-repo/flathub-beta.flatpakrepo;
fi

# Install all packages
if [ "$install_all" = true ] ; then
	for str in ${myArray[@]}; do
		flatpak install $str -y --app
	done
fi

