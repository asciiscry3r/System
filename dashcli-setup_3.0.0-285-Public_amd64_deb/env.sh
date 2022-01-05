#!/bin/sh
OS=`uname -s`
KK=`grep "^NAME=" /etc/*release |cut -d "=" -f 2 | sed -e 's/^"//' -e 's/"$//'`
if [ "${OS}" = "Linux" ] ; then
    if [ "${KK}" = "Ubuntu" ] ; then
	    sudo apt-get install libsdl1.2debian libsdl2-2.0-0 mono-devel curl putty
    elif [ "${KK}" = "Fedora" ] ; then
	    sudo dnf install SDL SDL2 mono-devel curl putty
    elif [ "${KK}" = "openSUSE" ] ; then
	    sudo zypper install libSDL-1_2-0 libSDL2-2_0-0 mono-complete putty
    else
	    echo "Please install libSDL, mono-devel, curl and putty package first"

    fi
fi
