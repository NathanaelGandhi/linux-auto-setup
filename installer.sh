## Written by Nathanael Gandhi
## https://nathanaelgandhi.com/
## https://github.com/NathanaelGandhi

#!/bin/bash

# Select your distribution
PS3="Choose your distribution: "
options=(LinuxMint-20.2 Ubuntu-20.04-LTS Ubuntu-21.10 Fedora-35-Workstation)
select menu in "${options[@]}";
do
    echo -e "\nyou picked $menu ($REPLY)"
    if [[ $menu == "LinuxMint-20.2" ]]; then
        # LINUXMINT
        REDHAT=0;
        DEBIAN=1;
        LINUXMINT=1;
        UBUNTU=0;
        FEDORA=0;
        break;
    else
        if [[ $menu == "Ubuntu-20.04-LTS" || $menu == "Ubuntu-21.10" ]]; then
            # UBUNTU
            REDHAT=0;
            DEBIAN=1;
            LINUXMINT=0;
            UBUNTU=1;
            FEDORA=0;
            break;
        else
            if [[ $menu == "Fedora-35-Workstation" ]]; then
                # RED HAT
                REDHAT=1;
                DEBIAN=0;
                LINUXMINT=0;
                UBUNTU=0;
                FEDORA=1;
                break;
            else
                # Incorrect Selection
                DEBIAN=0;
                REDHAT=0;
                LINUXMINT=0;
                UBUNTU=0;
                FEDORA=0;
                echo " --- Incorrect Selection ---"
            fi
        fi
    fi
done

# DEBIAN
if [ $DEBIAN -eq 1 ]; then
    # INSTALL VIA APT
    echo "UPDATING THE SYSTEM"
    sudo apt update
    sudo apt upgrade -y
    echo "INSTALLING VIA APT"
    sudo apt install git -y
    sudo apt install terminator -y
    sudo apt install syncthing -y
fi

# RED HAT
if [ $REDHAT -eq 1 ]; then
    # INSTALL VIA DNF
    echo "UPDATING THE SYSTEM"
    sudo dnf update -y
    echo "INSTALLING VIA DNF"
    sudo dnf install git -y
    sudo dnf install terminator -y
    sudo dnf install syncthing -y
fi

# LINUXMINT
if [ $LINUXMINT -eq 1 ]; then
    # FLATPAK is already installed by default
    echo "FLATPAK is already installed by default"
    # Snap is not installed by defualt
    echo "INSTALLING SNAP"
    sudo rm /etc/apt/preferences.d/nosnap.pref
    sudo apt update
    sudo apt install snapd -y
fi

# UBUNTU
if [ $UBUNTU -eq 1 ]; then
    # INSTALL FLATPAK
    echo "INSTALLING FLATPAK"
    sudo apt install flatpak -y
    sudo apt install gnome-software-plugin-flatpak -y
fi

# FEDORA
if [ $FEDORA -eq 1 ]; then
    # FLATPAK is already installed by default
    echo "FLATPAK is already installed by default"
    # Snap is not installed by defualt
    echo "INSTALLING SNAP"
    sudo dnf install snapd -y
    # Snaps using classic confinement, such as code editors, also require a symlink from /var/lib/snapd/snap to /snap.
    sudo ln -s /var/lib/snapd/snap /snap
fi

echo "ADDING FLATHUB REMOTE"
flatpak remote-add --if-not-exists flathub https://flathub.org/repo/flathub.flatpakrepo
flatpak update -y

# FLATPAK INSTALLS
echo "FLATPAK INSTALLS"
# Communication
flatpak install flathub com.slack.Slack -y
flatpak install flathub com.discordapp.Discord -y
flatpak install flathub us.zoom.Zoom -y
flatpak install flathub com.microsoft.Teams -y
flatpak install flathub com.valvesoftware.Steam -y
flatpak install flathub com.getmailspring.Mailspring -y
flatpak install flathub com.sindresorhus.Caprine -y	# FB Messenger

# Productivity
flatpak install flathub com.dropbox.Client -y
flatpak install flathub com.github.alainm23.planner -y
flatpak install flathub com.github.subhadeepjasu.pebbles -y
flatpak install flathub org.gnome.Solanum -y
flatpak install flathub com.github.phase1geo.minder -y
flatpak install flathub com.jgraph.drawio.desktop -y

# Engineering
flatpak install flathub com.vscodium.codium -y
flatpak install flathub org.qgis.qgis/x86_64/stable -y
flatpak install flathub org.freecadweb.FreeCAD -y
flatpak install flathub org.kicad.KiCad -y

# Video & Graphics
flatpak install flathub org.videolan.VLC -y
flatpak install flathub com.github.PintaProject.Pinta -y
flatpak install flathub org.gimp.GIMP -y
flatpak install flathub org.kde.kdenlive -y

# Other
flatpak install flathub com.spotify.Client -y
flatpak install flathub org.gnome.Weather -y
flatpak install flathub org.gnome.Connections -y
#flatpak install flathub me.kozec.syncthingtk -y # Havent got this gui working properly. WEBUI seems suitable for now
#flatpak install flathub org.gnome.Fractal -y # Unsure if I want this yet
#flatpak install flathub org.gnome.Boxes -y	# Try this instead of virtualbox - Not yet verified as an alternative

# SNAP INSTALLS
echo "SNAP INSTALLS"
sudo snap install brave

echo "CREATING GIT DIRECTORY"
mkdir -p ~/git

echo "Hamachi needs manual install"
echo "ROS needs manual install"
echo "VirtualBox needs manual install"
echo "----"
echo "DONE"