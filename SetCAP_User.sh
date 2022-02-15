#!/usr/bin/env bash

list=`find /bin /sbin /lib /usr/bin /usr/sbin /usr/lib -perm /4000 -user root`


for item in $list; do
    ls -all $item 
    # chmod u-s $item
    if [ $item == "/usr/bin/su" ]; then
	chmod u-s $item
	setсap cap_setgid,cap_setuid+ep $item
    elif [ $item == "/usr/bin/sg" ]; then
	chmod u-s $item
	setсap cap_setgid,cap_setuid+ep $item
    elif [ $item == "/usr/bin/crontab" ]; then
	chmod u-s $item
	setcap cap_dac_override,cap_setgid+ep $item
    elif [ $item == "/usr/bin/rsh" ]; then
	chmod u-s $item
	setcap cap_net_bind_service+ep $item
    elif [ $item == "/usr/bin/rcp" ]; then
	chmod u-s $item
	setcap cap_net_bind_service+ep $item
    elif [ $item == "/usr/bin/rlogin" ]; then
	chmod u-s $item
	setcap cap_net_bind_service+ep $item
    elif [ $item == "/sbin/unix_chkpwd" ]; then
        chmod u-s $item
        setcap cap_dac_read_search+ep $item
    elif [ $item == "/usr/bin/unix_chkpwd" ]; then
        chmod u-s $item
        setcap cap_dac_read_search+ep $item
    elif [ $item == "/usr/bin/chage" ]; then
        chmod u-s $item
        setcap cap_dac_read_search+ep $item
    elif [ $item == "/usr/bin/chfn" ]; then
        chmod u-s $item
        setcap cap_chown,cap_setuid+ep $item
    elif [ $item == "/usr/bin/chsh" ]; then
        chmod u-s $item
        setcap cap_chown,cap_setuid+ep $item
    elif [ $item == "/usr/bin/expiry" ]; then
        chmod u-s $item
	setcap cap_dac_override,cap_setgid+ep $item
    elif [ $item == "/usr/bin/gpasswd" ]; then
        chmod u-s $item
        setcap cap_chown,cap_dac_override,cap_setuid+ep $item
    elif [ $item == "/usr/bin/newgrp" ]; then
	chmod u-s $item
	setcap cap_dac_override,cap_setgid+ep $item
    elif [ $item == "/usr/bin/passwd" ]; then
	chmod u-s $item
	setcap cap_chown,cap_dac_override,cap_fowner+ep $item
    elif [ $item == "/usr/bin/Xorg" ]; then
	chmod u-s $item
	setcap cap_chown,cap_dac_override,cap_sys_rawio,cap_sys_admin+ep $item
    elif [ $item == "/usr/lib/Xorg.wrap" ]; then
	chmod u-s $item
	setcap cap_chown,cap_dac_override,cap_sys_rawio,cap_sys_admin+ep $item
    elif [ $item == "/usr/bin/sg" ]; then
	chmod u-s $item
    elif [ $item == "/usr/bin/ksu" ]; then
	chmod u-s $item
    elif [ $item == "/usr/lib/electron14/chrome-sandbox" ]; then
	chmod u-s $item
    elif [ $item == "/usr/lib/electron/chrome-sandbox" ]; then
	chmod u-s $item
    fi

done
