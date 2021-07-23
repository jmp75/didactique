# Debian install on new laptop keywest


Starting from the [testing (bullseye) version](https://www.debian.org/devel/debian-installer/)

F12 to have a one time boot option. USB boot option appears available. "UEFI: Generic usb flash disk (there is also a partition 2 entry for USB. Using the first only)

graphical install, usual
at first ethernet card not detected; 
go back and try again. wifi nonfree drivers missing, skip. 
This time eth cards detected, but there are three so need to say which one. Not obvious that this was the "uncpesified one" for the dock; the onw with mroe info was the laptop port but that is not active. 

## new laptop

"adduser" is not found in the command line, so `apt install mlocate`

`/usr/sbin/usermod -aG sudo per202`

Nope, seems to have done bugger all

Trying:

`EDITOR=nano /usr/sbin/visudo`

## old laptiop

usermod -a -G sftp_users per202

but seems not to wrk as expected. Not in that group.

systemctl restart sshd

These instructions seem to work: https://www.tecmint.com/restrict-sftp-user-home-directories-using-chroot/  

```sh
sudo su
usermod -G sftp_users per202
nano /etc/ssh/sshd_config
systemctl restart sshd
cd /home
chmod 700 per202/
```

## new laptop

transfering .bashrc, .mixxx, .profile, .jackdrc, .ssh, .gitconfig,

Moving on to replicate my source repo lists sources.list and co for apt. The netinstall has created one with bullseye as the remote, currently testing (though in RC) I prefer to stay on testing. Change. Was using aarnet but I seem to have had issues from time to time. Reverd to tometing else and see how this goes. 

modify sources.list

transfer repo list, apt.conf.d, gpg keys. Note not sure about sftp> get trusted.gpg. Try and see.

```text
W: GPG error: https://dl.yarnpkg.com/debian stable InRelease: The following signatures were invalid: EXPKEYSIG 23E7166788B63E1E Yarn Packaging <yarn@dan.cx>
E: The repository 'https://dl.yarnpkg.com/debian stable InRelease' is not signed.
```

get rid of yarn for now. 

vscode insiders: `sudo apt install code-insiders` worked just fine, then sync setting too

/home/per202/config/ via sftp but was a git repo anyway.

```sh
fn=`locate config | grep \.git/config | grep /home/per202`

for f in $fn ; do 
    echo $f ; 
    cat $f | grep url ;     
done
```

cd $HOME
git clone ssh://git@bitbucket.csiro.au:7999/~per202/my_bin.git bin
warning..
cd bin
git checkout main

cd $HOME
git clone ssh://git@bitbucket.csiro.au:7999/~per202/my_secrets.git credentials
unxip etc.

Now trying to get the Biomass notebooks going:

https://docs.conda.io/en/latest/miniconda.html

Moving the registered kernel configs under /home/per202/tmp/kernels/ , seems to work OK.

copying the tarball of ~/.mozilla/firefox : all good...

## Package installation

Doing a diff of postprocessed output of e.g.:

I only want the topost installed, not the automatic dependancies.

`apt list --installed | grep \\[installed\\] > installed_here.txt`

Note also `sudo dpkg-query -f '${binary:Package}\n' -W`  may be useful but not sure how to get only manually specs packages.

```text
aptitude
bc
binutils-dev
blueman bluez-firmware
build-essential
bumblebee-nvidia
catch
cifs-utils
cinnamon-core
cmake
curl
debhelper
default-jre
desktop-base
devscripts
dh-cmake
dh-make
dh-r
docker-compose
doctest-dev
dos2unix
doxygen-doc
doxygen-gui
eog
equivs
evince
exuberant-ctags
firejail
firetools
firmware-iwlwifi
firmware-linux
g++
gcc
gconf2
gcovr
gdb
gdebi
gitg
gpustat
graphviz
libblas-dev

libboost-atomic-dev
libboost-chrono-dev
libboost-date-time-dev
libboost-filesystem-dev
libboost-graph-dev
libboost-python-dev
libboost-regex-dev
libboost-system-dev
libboost-thread-dev

libbz2-dev
libcairo2-dev
libegl1-mesa
libeigen3-dev
libexpat1-dev
libgdal-dev
libgit2-dev
libgl1-mesa-glx
libglib2.0-bin
libgtest-dev
libiberty-dev
libidn11

libjpeg-dev
libjpeg62-turbo-dev
libjson-c-dev
libjsoncpp-dev
liblzma-dev
libmagick++-dev
# libncurses5-dev: probably libncurses6 now.  Wait.

libnetcdf-dev
libpcre3-dev
libpopt-dev
libqt5charts5-dev
libreadline-dev
libssl-dev
libtbb-dev
libtiff5-dev
libudunits2-dev
libx11-dev
libxi-dev
libxml2-dev
libxt-dev
libyaml-cpp-dev
libyaml-dev
linux-headers-amd64

lsb-release
markdown
meld
mixxx
mpack
pandoc-citeproc
pandoc

# debian packaging, if I recall?
reprepro

sloccount
snapd


spotify-client

synaptic

valgrind

workrave-data
workrave

x11proto-core-dev

zlib1g-dev

```

```sh
sudo apt-get install aptitude bc binutils-dev blueman bluez-firmware build-essential bumblebee-nvidia catch cifs-utils cinnamon-core cmake curl debhelper default-jre desktop-base devscripts dh-cmake dh-make dh-r docker-compose doctest-dev dos2unix doxygen-doc doxygen-gui eog equivs evince exuberant-ctags firejail firetools firmware-iwlwifi firmware-linux g++ gcc gconf2 gcovr gdb gdebi gitg gpustat graphviz libblas-dev


sudo apt-get install  libboost-atomic-dev libboost-chrono-dev libboost-date-time-dev libboost-filesystem-dev libboost-graph-dev libboost-python-dev libboost-regex-dev libboost-system-dev libboost-thread-dev

sudo apt-get install libbz2-dev libcairo2-dev libegl1-mesa libeigen3-dev libexpat1-dev libgdal-dev libgit2-dev libgl1-mesa-glx libglib2.0-bin libgtest-dev libiberty-dev libidn11 libjpeg-dev libjpeg62-turbo-dev libjson-c-dev libjsoncpp-dev liblzma-dev libmagick++-dev

The following packages have unmet dependencies:
 libodbc1 : PreDepends: multiarch-support but it is not installable
 odbcinst1debian2 : PreDepends: multiarch-support but it is not installable
E: Unable to correct problems, you have held broken packages.


sudo apt update --fix-missing # ?
sudo apt upgrade 


sudo apt install libnetcdf-dev libpcre3-dev libpopt-dev libqt5charts5-dev libreadline-dev libssl-dev libtbb-dev libtiff5-dev libudunits2-dev libx11-dev libxi-dev libxml2-dev libxt-dev libyaml-cpp-dev libyaml-dev linux-headers-amd64

sudo apt install lsb-release markdown meld mpack pandoc-citeproc pandoc

# personal, sort of:
sudo apt install mixxx spotify-client

sudo apt install reprepro sloccount snapd synaptic valgrind workrave-data workrave x11proto-core-dev zlib1g-dev




sudo apt install bison gnupg google-earth-pro-stable  libarmadillo-dev libeigen3-dev


sudo apt install libexpat1-dev libgdal-dev


```

wifi connections:  transfer /etc/NetworkManager/system-connections/  by the look of it. BUT configt files have a mac address... need to replace in all files. 

`ip addr` :

```
4: wlo1: <NO-CARRIER,BROADCAST,MULTICAST,UP> mtu 1500 qdisc noqueue state DOWN group default qlen 1000
    link/ether 11:22:33:44:55:66 brd ff:ff:ff:ff:ff:ff permaddr ec:63:ec:63:ec:63
    altname wlp0s20f3
```

as root:

```sh
cd /etc/NetworkManager/system-connections
more * | grep mac
more * | grep 77:88:99:77:88:99
sed -i -e 's/77:88:99:77:88:99/11:22:33:44:55:66/' *
```

`systemctl restart NetworkManager`

Hmmm. no not sure that worked. Nope. Need to reenter credentials for eduroam, new profile connection creted. So long, maybe what is needed. 
