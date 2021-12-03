# linux-auto-setup
Script to download and install applications I use daily on to a fresh Linux install.

Written by [Nathanael Gandhi](https://nathanaelgandhi.com/)

---

This is aimed at beginner - advanced users, and as such will only focus on 3 main distrobutions.
- [LinuxMint](https://linuxmint.com/download.php) (most similar to windows - NEW USERS)
- [Ubuntu](https://ubuntu.com/download/desktop) (most popular, most support - POWER USERS)
- [Fedora](https://getfedora.org/en/workstation/download/) (explore possibilities with bleeding-edge software - ADVANCED USERS)


---

## 1. Downloading the script
To run the script clone this repo from https://github.com/NathanaelGandhi/linux-auto-setup by clicking ``` Code ``` dropdown and selecting download zip. 

Alternativley if you are familiar with using git, in a terminal run 

``` git clone https://github.com/NathanaelGandhi/linux-auto-setup.git ```

## 2. Running the script
Open a terminal and change directory (type: cd pathToFolder) to the downloaded folder. 

``` cd linux-auto-setup ```

Now run the installer.sh script

``` ./installer.sh ```

## 3. Follow the prompts to install applications
Please check the table below for compatability with linux distributions.

| Distro | Assumed Working | Confirmed Working |
| ------ | ---------------- | ----------------- |
| LinuxMint 20.2 Cinnamon| Yes | - |
| Ubuntu 20.04 LTS | Yes | - |
| Ubuntu 21.10 | Yes | - |
| Fedora 35 Workstation | Yes | - |

## Notes
- Flatpak has been preferred where possible
- Snaps are used when the flatpak is unavailable
- Package managers (apt/dnf) are used when the Flatpak and Snap are unavailable. 

- IT CAN BE DANGEROUS TO DOWNLOAD AND RUN SCRIPTS OFF THE INTERNET WITHOUT UNDERSTANDING WHAT THEY DO. PLEASE VIEW THE SCRIPT ON GITHUB FIRST AND TRY TO UNDERSTAND EACH AND EVERY COMMAND.