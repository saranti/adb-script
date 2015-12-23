#!/bin/bash
#Ezy-Adb Copyright (C) 2015  Tom Sarantis
#By Art Vanderlay @xda-developers
#v1.4.1


restart() {
clear
printf '\e[8;38;90t'
echo ""
echo "  "
echo "                    EZY-ADB  "
echo "  -------------------------------------------"
echo "   * * * * * * * * Main Menu * * * * * * * *"
echo "  -------------------------------------------"
echo ""
echo "	[1] install adb & fastboot"
echo "	[2] check connection"
echo "	[3] adb over network"
echo ""
echo "	[4] adb pull"
echo "	[5] adb push"
echo "	[6] adb sideload"
echo "	[7] adb shell"
echo ""
echo "	[8] reboot menu"
echo ""
echo "	[9] install apk"  
echo "	[10] uninstall package"
echo ""
echo "	[11] unlock bootloader"
echo ""
echo "	[12] backup sdcard" 
echo "	[13] restore sdcard backup"
echo ""
echo "	[14] take screenshot"
echo "	[15] record screen"
echo ""
echo "	[16] Diagnostic tools menu"
echo "	[17] configure udev rules separately"
echo ""
echo "	[18] useful links & info"
echo "	[q] quit"
echo ""
echo "    -------------------------------------------"

echo ""

read first

	case "$first" in

		1) inst ;;
		2) chadb ;;
		3) wifi ;;
		4) pull ;;
		5) push ;;
		6) side ;;
		7) shell ;;
		8) reb ;;
		9) app ;;
		10) apprm ;;
		11) oemu ;;
		12) sdbak ;;
		13) rest ;;
		14) scrn ;;
		15) recd ;;
		16) diag ;;
		17) udev ;;
		18) stuff ;;
		q) ex ;;
		*) echo "Unknown command: '$first'" 
		sleep 1s
		restart ;;
	esac
	sleep 2s
}

#################### detect linux version and install correct package

inst() {

if egrep -qi "ubuntu|debian|mint" /proc/version; then
	sudo apt-get install android-tools-adb android-tools-fastboot
fi

if egrep -qi "mint|linuxmint" /proc/version; then
	sudo apt-get install libncurses5:i386

elif egrep -qi "mageia" /proc/version; then
	sudo urpmi android-tools

elif egrep -qi "suse|opensuse" /proc/version; then
	sudo zypper install android-tools

elif egrep -qi "redhat|centos" /proc/version; then
	sudo yum install epel-release
	sudo yum install android-tools
fi

if egrep -qi "fedora" /proc/version; then
	sudo dnf install android-tools


elif egrep -qi "elementary OS" /etc/lsb-release; then
        sudo add-apt-repository ppa:nilarimogard/webupd8
        sudo apt-get update
fi	

	echo ""
	echo "Configure udev rules? [y/n] (recommended)"

	read ud
		case "$ud" in

			[yY]* ) udev ;;
			[nN]* ) restart ;;
				* ) echo "please enter again";;
		esac	
}

#################### 51-android-rules file for /etc/udev

udev()  { cat >/tmp/android.rules << "EOF"
SUBSYSTEM=="usb", ATTRS{idVendor}=="0bb4", MODE="0666"
SUBSYSTEM=="usb", ATTRS{idVendor}=="0e79", MODE="0666"
SUBSYSTEM=="usb", ATTRS{idVendor}=="0502", MODE="0666"
SUBSYSTEM=="usb", ATTRS{idVendor}=="0b05", MODE="0666"
SUBSYSTEM=="usb", ATTRS{idVendor}=="413c", MODE="0666"
SUBSYSTEM=="usb", ATTRS{idVendor}=="0489", MODE="0666"
SUBSYSTEM=="usb", ATTRS{idVendor}=="091e", MODE="0666"
SUBSYSTEM=="usb", ATTRS{idVendor}=="18d1", MODE="0666"
SUBSYSTEM=="usb", ATTRS{idVendor}=="0bb4", MODE="0666"
SUBSYSTEM=="usb", ATTRS{idVendor}=="12d1", MODE="0666"
SUBSYSTEM=="usb", ATTRS{idVendor}=="24e3", MODE="0666"
SUBSYSTEM=="usb", ATTRS{idVendor}=="2116", MODE="0666"
SUBSYSTEM=="usb", ATTRS{idVendor}=="0482", MODE="0666"
SUBSYSTEM=="usb", ATTRS{idVendor}=="17ef", MODE="0666"
SUBSYSTEM=="usb", ATTRS{idVendor}=="1004", MODE="0666"
SUBSYSTEM=="usb", ATTRS{idVendor}=="22b8", MODE="0666"
SUBSYSTEM=="usb", ATTRS{idVendor}=="0409", MODE="0666"
SUBSYSTEM=="usb", ATTRS{idVendor}=="2080", MODE="0666"
SUBSYSTEM=="usb", ATTRS{idVendor}=="0955", MODE="0666"
SUBSYSTEM=="usb", ATTRS{idVendor}=="2257", MODE="0666"
SUBSYSTEM=="usb", ATTRS{idVendor}=="10a9", MODE="0666"
SUBSYSTEM=="usb", ATTRS{idVendor}=="1d4d", MODE="0666"
SUBSYSTEM=="usb", ATTRS{idVendor}=="0471", MODE="0666"
SUBSYSTEM=="usb", ATTRS{idVendor}=="04da", MODE="0666"
SUBSYSTEM=="usb", ATTRS{idVendor}=="05c6", MODE="0666"
SUBSYSTEM=="usb", ATTRS{idVendor}=="1f53", MODE="0666"
SUBSYSTEM=="usb", ATTRS{idVendor}=="04e8", MODE="0666"
SUBSYSTEM=="usb", ATTRS{idVendor}=="04dd", MODE="0666"
SUBSYSTEM=="usb", ATTRS{idVendor}=="0fce", MODE="0666"
SUBSYSTEM=="usb", ATTRS{idVendor}=="0930", MODE="0666"
SUBSYSTEM=="usb", ATTRS{idVendor}=="19d2", MODE="0666"
EOF


#################### move 51-android-rules to /etc/udev, change ownership and give x permission

if [ -f /tmp/android.rules ]; 
	then sudo cp /tmp/android.rules /etc/udev/rules.d/51-android.rules;sudo chmod 644 /etc/udev/rules.d/51-android.rules;sudo chown root. /etc/udev/rules.d/51-android.rules;rm /tmp/android.rules;echo "";echo "Please disconnect and then reconnect your device to use adb.";echo "";sleep 4s;
	fi
	restart
}

#################### adb over network
wifi() {

DEV=$(adb devices 2>&1 | tail -n +2 | sed '/^$/d')
if [ -z "$DEV" ]
then
   echo "No devices attached. Exiting " >&2
	sleep 2s
	restart
else
echo "Your device must be connected via usb to begin this process."
echo ""
adb tcpip 5555
sleep 5s
adb shell ip route > addrs.txt
ip_addrs=$(awk {'if( NF >=9){print $9;}'} addrs.txt)
sleep 5s
adb connect $ip_addrs
echo "Unplug you device to start network session"
rm addrs.txt
sleep 4s
restart
fi
}

#################### check connection
chadb() { 
echo ""
adb devices
echo ""
echo "Connection mode:"
adb get-state
sleep 4s
restart
}

#################### adb pull
pull() {

DEV=$(adb devices 2>&1 | tail -n +2 | sed '/^$/d')
if [ -z "$DEV" ]
then
   echo "No devices attached. Exiting " >&2
	sleep 2s
	restart
else
if [ ! -d ~/EZY_ADB/Pull_Files ]; then
	mkdir -p ~/EZY_ADB/Pull_Files
fi 
	echo "Enter the file path"
	echo "Example: /sdcard/Pictures/file.png"
	read input
		adb pull "$input" ~/EZY_ADB/Pull_Files 
	echo "$input has been saved to ~/EZY_ADB/Pull_Files"
	sleep 3s

if [ "$?" -ne "0" ] ; then
	echo "Error while pulling $first"
	sleep 3s
fi
restart
fi
}

#################### adb push
push() {

DEV=$(adb devices 2>&1 | tail -n +2 | sed '/^$/d')
if [ -z "$DEV" ]
then
   echo "No devices attached. Exiting " >&2
	sleep 2s
	restart
else
echo "Enter the file path"
echo "Example: $HOME/Desktop/file.txt"
read input
	adb push "$input" /sdcard/
if [ "$?" -ne "0" ] ; then
	echo "Error while pushing $first"
	sleep 3s
else
echo ""
echo "File pushed to internal storage"
sleep 3s
fi
restart
fi
}

#################### adb sideload
side() {

DEV=$(adb devices 2>&1 | tail -n +2 | sed '/^$/d')
if [ -z "$DEV" ]
then
   echo "No devices attached. Exiting " >&2
	sleep 2s
	restart
else
echo "Enter the file path"
echo "Example: $HOME/Desktop/file.txt"
read input
	adb sideload "$input"

if [ "$?" -ne "0" ] ; then
	echo "Error while sideloading"
	sleep 3s
else
echo ""
echo "Sideload complete."
sleep 3s
fi
restart
fi
}

shell() {

DEV=$(adb devices 2>&1 | tail -n +2 | sed '/^$/d')
if [ -z "$DEV" ]
then
   echo "No devices attached. Exiting " >&2
	sleep 2s
	restart
else
clear
adb shell
restart
fi
}

#------------------------------ REBOOT MENU ----------------------------------------------

reb() {

DEV=$(adb devices 2>&1 | tail -n +2 | sed '/^$/d')
if [ -z "$DEV" ]
then
   echo "No devices attached. Exiting " >&2
	sleep 2s
	restart
else
clear
echo ""
echo "  "
echo "                   EZY-ADB"
echo "  ------------------------------------------"
echo "   * * * * * * * Reboot Menu * * * * * * * "
echo "  ------------------------------------------"
echo ""
echo "	[1] system"
echo "	[2] recovery"
echo "	[3] bootloader"
echo ""
echo "	[q] go back"
echo ""
echo " -------------------------------------------"
echo ""

read rbmenu

	case "$rbmenu" in
 	
		1) adb reboot ;;
		2) adb reboot recovery ;;
		3) adb reboot bootloader ;;
		q) restart ;;
		*) echo "Unknown command: '$rbmenu'" ;;
	esac
	reb
	fi
}

#---------------------------------------------------------------------------

#################### install app
app() {

DEV=$(adb devices 2>&1 | tail -n +2 | sed '/^$/d')
if [ -z "$DEV" ]
then
   echo "No devices attached. Exiting " >&2
	sleep 2s
	restart
else
echo "Enter the app's file path"
echo "Example: $HOME/Desktop/file.apk"
read input
	adb install "$input"
fi
if [ "$?" -ne "0" ] ; then
	echo "Error while installing $first"
	sleep 3s
restart
fi
}

#################### uninstall package
apprm() {

DEV=$(adb devices 2>&1 | tail -n +2 | sed '/^$/d')
if [ -z "$DEV" ]
then
   echo "No devices attached. Exiting " >&2
	sleep 2s
	restart
else
echo "Enter the package name"
echo "Example: com.<package>"
read input
	adb uninstall "$input"
	sleep 3s
restart
fi
}

#################### unlock bootloader
oemu() {

DEV=$(adb devices 2>&1 | tail -n +2 | sed '/^$/d')
if [ -z "$DEV" ]
then
   echo "No devices attached. Exiting " >&2
	sleep 2s
	restart
else
echo "This action will unlock your bootloader."
echo "All your data will be erased and your warranty may be void."
echo "Are you sure you want to continue? [y/n]"

	read input
    case $input in

		[yY]* ) adb reboot bootloader
			echo "Waiting for fastboot device..."
			sleep 4s
			fastboot devices
			fastboot oem unlock
			echo "Done";;

		[nN]* ) restart;;
			* ) echo "please enter again";;

	esac
	sleep 3s
	restart
	fi
}

#################### adb backup
sdbak()  {

DEV=$(adb devices 2>&1 | tail -n +2 | sed '/^$/d')
if [ -z "$DEV" ]
then
   echo "No devices attached. Exiting " >&2
	sleep 2s
	restart
else
if [ ! -d ~/EZY_ADB/SD_Backup ]; then
	mkdir -p ~/EZY_ADB/SD_Backup
fi 
SD="$(date +%d%m%y).ab"
	adb backup -apk -shared -all -f ~/EZY_ADB/SD_Backup/sdbak-$SD
	echo "backup has been saved to ~/EZY_ADB/SD_Backup "
	sleep 3s
	restart
	fi
}

#################### adb restore
rest()  {

DEV=$(adb devices 2>&1 | tail -n +2 | sed '/^$/d')
if [ -z "$DEV" ]
then
   echo "No devices attached. Exiting " >&2
	sleep 2s
	restart
else
echo "Enter the file name of your backup file"
echo "Example: $HOME/EZY_ADB/sdbak-xxxx.ab"
read back
echo "Please wait while your backup is restored"
	adb restore "$back"
restart
fi
}

#################### screenshot
scrn() {
if [ ! -d ~/EZY_ADB/ScreenShots ]; then
	mkdir -p ~/EZY_ADB/ScreenShots
fi

DEV=$(adb devices 2>&1 | tail -n +2 | sed '/^$/d')
if [ -z "$DEV" ]
then
   echo "No devices attached. Exiting " >&2
	sleep 2s
	restart
else
	adb shell screencap -p | perl -pe 's/\x0D\x0A/\x0A/g' > ~/EZY_ADB/ScreenShots/$(date '+%Y%m%d%H%M%S').png
echo ""
echo "The file has been saved to ~/EZY_ADB/ScreenShots"
sleep 3s
restart
fi
}

#################### record screen
recd() {

DEV=$(adb devices 2>&1 | tail -n +2 | sed '/^$/d')
if [ -z "$DEV" ]
then
   echo "No devices attached. Exiting " >&2
	sleep 2s
	restart
else
echo ""
echo "Recording in progress. Press Ctrl and c to stop"
echo ""
echo "The file will be dumped to your sdcard"

RD="$(date +%Y%m%d%H%M%S)"
	adb shell screenrecord /sdcard/ScrRecord-$RD.mp4
echo ""
restart
fi
}


#-------------------------------- SUB MENU FOR DUMPSYS -----------------------------------------------

diag() {
if [ ! -d ~/EZY_ADB/Dump_files ]; then
	mkdir -p ~/EZY_ADB/Dump_files
fi 

DEV=$(adb devices 2>&1 | tail -n +2 | sed '/^$/d')
if [ -z "$DEV" ]
then
   echo "No devices attached. Exiting " >&2
	sleep 2s
	restart
else
dt="$(date +%d%m%y)"
clear
echo ""
echo "  "
echo "                    EZY-ADB  "
echo "  -------------------------------------------"
echo "   * * * * * Diagnostic Tools Menu * * * * *"
echo "  -------------------------------------------"
echo ""
echo "	 [1] logcat"
echo "	 [2] dump log to file"
echo "	 [3] sysdump"
echo "	 [4] battery stats"
echo "	 [5] cpu info"
echo "	 [6] mem info"
echo "	 [7] proc stats"
echo "	 [8] netstats"
echo "	 [9] account info"
echo "	[10] disk stats"
echo "	[11] usage stats"
echo "	[12] power manager"
echo "	[13] dump build prop"
echo ""
echo "	[q] go back"
echo " -------------------------------------------"
echo ""

read diagst

	case "$diagst" in
 	
		1) adb logcat ;;

		2) LOG="$(date +%d%m%y)log.txt"

			if [ ! -d ~/EZY_ADB/Log ]; then
				mkdir -p ~/EZY_ADB/Log
			fi 
				touch ~/EZY_ADB/Log/$LOG
				echo "logcat has been saved to ~/EZY_ADB/Log. Press ctrl & c "
				adb logcat > ~/EZY_ADB/Log/$LOG ;;

		3) adb shell dumpsys > ~/EZY_ADB/Dump_files/sysdump-$dt ;; 
		4) adb shell dumpsys batterystats > ~/EZY_ADB/Dump_files/batstats-$dt ;;
		5) adb shell dumpsys cpuinfo > ~/EZY_ADB/Dump_files/cpu-info-$dt ;;
		6) adb shell dumpsys meminfo > ~/EZY_ADB/Dump_files/mem-info-$dt ;;
		7) adb shell dumpsys procstats --hours 3 > ~/EZY_ADB/Dump_files/proc-stats-$dt ;;
		8) adb shell dumpsys netstats > ~/EZY_ADB/Dump_files/net-stats-$dt ;;
		9) adb shell dumpsys account > ~/EZY_ADB/Dump_files/acc-dump-$dt ;;
		10) adb shell dumpsys diskstats > ~/EZY_ADB/Dump_files/disk-stats-$dt ;;
		11) adb shell dumpsys usagestats > ~/EZY_ADB/Dump_files/use-stats-$dt ;;
		12) adb shell dumpsys power > ~/EZY_ADB/Dump_files/power-stats-$dt ;;

		13) if [ ! -d ~/EZY_ADB/Dump_files/Build_prop ]; then
				mkdir -p ~/EZY_ADB/Dump_files/Build_prop
			fi

				adb pull /system/build.prop ~/EZY_ADB/Dump_files/Build_prop ;;
		q) restart ;;
			*) echo "Unknown command: '$diagst'" ;;
	esac
	diag
	fi
}

#---------------------------------------------------------------------------------------------

ex() {
exit
}

stuff()  {
clear
printf '\e[8;38;97t'
echo ""
echo "          Further reading "
echo "__________________________________________________________"
echo ""
echo "Google developer guide to adb: http://developer.android.com/tools/help/adb.html"
echo ""
echo "Fastboot guide by Ricky Divjakovski: http://forum.xda-developers.com/showthread.php?t=2225405"
echo ""
echo "Adb and fastboot for Windows: http://forum.xda-developers.com/showthread.php?t=2317790"
echo "__________________________________________________________"
echo ""
echo "Press Enter to go back"
read bac
case "$bac" in
*) restart ;;
esac
}

restart
