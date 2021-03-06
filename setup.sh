#!/bin/bash

# Declare vars
add_remotes="true";
install_all="true";

# Check for the distro
echo "Checking distro"
if [ -r /etc/os-release ]; then
    # freedesktop.org and systemd
    . /etc/os-release
    OS=$NAME
    VER=$VERSION_ID
    echo "Detected: $OS"
else
    echo "Didnt find /etc/os-release"
fi

# Packages to install
# FOSS flatpaks
declare -a flatpakApps=(
		"com.github.tchx84.Flatseal/x86_64/stable"
		"com.brave.Browser"
		"org.onlyoffice.desktopeditors"
		"com.nextcloud.desktopclient.nextcloud"
		"org.gimp.GIMP/x86_64/stable"
		"org.inkscape.Inkscape"
		"com.github.PintaProject.Pinta"
		"com.vscodium.codium/x86_64/stable"
		"com.github.phase1geo.minder/x86_64/stable"
		"org.qgis.qgis/x86_64/stable"
		"app/org.kicad.KiCad/x86_64/stable"
		"org.freecadweb.FreeCAD/x86_64/stable"
		"org.kde.kdenlive/x86_64/stable"
		"com.obsproject.Studio/x86_64/stable"
		"net.cozic.joplin_desktop"
		)
# Proprieatry flatpaks		
declare -a flatpakPropApps=(
		"com.spotify.Client/x86_64/stable"
		"app/com.dropbox.Client/x86_64/stable"
		)
		
declare -a packageManagerApps=(
		"flatpak"
		"git"
		"zsh"
		"wget"
		"neofetch"
		"terminator"
		"util-linux-user"
		"htop"
		)

# Distro ARCH specific
if [ "$OS" = "Arch Linux" ]; then
	echo "Distro: ARCH LINUX specific install"
	echo "Updating the system..."
	sudo pacman -Syu --noconfirm
	add_remotes="true";
	install_all="true";
	# Need to enable bluetooth on startup https://www.reddit.com/r/archlinux/comments/btdmhx/bluetooth_autoconnect_at_boot_for_trusted_and/
	# also need to enable bluetooth service
fi

# Distro FEDORA specific
if [ "$OS" = "Fedora Linux" ]; then
	echo "Distro: FEDORA LINUX specific install"
	echo "Updating the system..."
	sudo dnf update -y
	add_remotes="true";
	install_all="true";
fi

# Distro UBUNTU specific
if [ "$OS" = "Ubuntu" ]; then
	echo "Distro: UBUNTU specific install"
	sudo add-apt-repository ppa:flatpak/stable
	echo "Updating the system..."
	sudo apt update -y && sudo apt upgrade -y
	sudo apt install gnome-software-plugin-flatpak
	add_remotes="true";
	install_all="true";
fi

# Add remotes
if [ "$add_remotes" = true ]; then
	echo "Adding flathub remote"
	flatpak remote-add --if-not-exists flathub https://flathub.org/repo/flathub.flatpakrepo;
#	echo "Adding flathub-beta remote"
#	flatpak remote-add --if-not-exists flathub-beta https://flathub.org/beta-repo/flathub-beta.flatpakrepo;
fi

# Install all packages
if [ "$install_all" = true ]; then
	for str in ${packageManagerApps[@]}; do
		echo "Installing $str"
		if [ "$OS" = "Ubuntu" ]; then
			sudo apt install $str -y
		elif  [ "$OS" = "Fedora Linux" ]; then
			sudo dnf install $str -y
		elif  [ "$OS" = "Arch Linux" ]; then
			sudo pacman -S $str --noconfirm
		fi
	done
	# Install FOSS flatpaks
	for str in ${flatpakApps[@]}; do
		echo "Installing $str"
		flatpak install $str -y --app
	done
	# Install proprieatry flatpaks
	for str in ${flatpakPropApps[@]}; do
		echo "Installing $str"
		flatpak install $str -y --app
	done
	echo "Make zsh the default shell"
	chsh -s $(which zsh)
	echo "Installing ohmyzsh"
	sh -c "$(wget -O- https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"
	echo ""
	echo "Installation complete. Please REBOOT your system."
fi
