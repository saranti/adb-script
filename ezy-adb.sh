#!/bin/bash
#Ezy-Adb by Art-Vanderlay
#


restart() {
clear
printf '\e[8;45;90t'
echo ""
echo ""
echo ""
echo "                       EZY-ADB "
echo "__________________________________________________________"
echo ""
echo "                 CHOOSE FROM THE MENU"
echo ""
echo "__________________________________________________________"
echo ""
echo "		1) install adb & fastboot"
echo "		2) check connection"
echo ""
echo "		3) adb pull"
echo "		4) adb push"
echo "		5) adb sideload"
echo "		6) adb shell"
echo ""
echo "		7) take logcat"
echo "		8) Dump log to file"
echo ""
echo "		9) reboot"
echo "		10) reboot recovery"
echo "		11) reboot bootloader"  
echo ""
echo "		12) install apk"
echo ""
echo "		13) unlock bootloader" 
echo ""
echo "		14) backup sdcard"
echo "		15) restore sdcard backup"
echo ""
echo "		16) take screenshot"
echo "		17) record screen"
echo ""
echo "		18) configure udev rules seperately"
echo ""
echo "		19) useful links & info"
echo ""
echo "		q) quit"
echo "__________________________________________________________"
echo ""
echo ""
echo ""

read first

	case "$first" in

		 1)    inst ;;
		 2)    chadb ;;
		 3)    pull ;;
		 4)    push ;;
		 5)    side ;;
		 6)    shell ;;
		 7)    log ;;
		 8)    ldump ;;
		 9)    reb ;;
		 10)   rec ;;
	    	 11)   boot ;;
	         12)   app ;;
	         13)   oemu ;;
		 14)   sdbak ;;
		 15)   rest ;;
	  	 16)   scrn ;;
	         17)   recd ;;
	         18)   udev ;;
	         19)   stuff ;;
	         q)    ex ;;
	  	 *)
			echo "Unknown command: '$first'"
        ;;
	esac
}

inst() { if egrep -qi "ubuntu|debian|mint" /proc/version; then
	    sudo apt-get install android-tools-adb android-tools-fastboot
         fi

         if egrep -qi "mint|linuxmint" /proc/version; then
            sudo apt-get install libncurses5:i386
	 fi

         if egrep -qi "suse|opensuse" /proc/version; then
            sudo zypper install android-tools

         elif egrep -qi "redhat|centos" /proc/version; then
	    sudo yum install epel-release
	    sudo yum install android-tools
         fi

	 if egrep -qi "fedora" /proc/version; then
	    sudo dnf install android-tools
	 fi

	 echo ""
	 echo "Configure udev rules? [y/n] (recommended)"

	 read sto
	     case "$sto" in

	        [yY]* ) udev ;;
                [nN]* ) restart ;;
                    * ) echo "please enter again";;
	     esac	
}

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



if [ -f /tmp/android.rules ]; then
sudo cp /tmp/android.rules /etc/udev/rules.d/51-android.rules;
sudo chmod 644 /etc/udev/rules.d/51-android.rules;
sudo chown root. /etc/udev/rules.d/51-android.rules;
sudo killall adb;rm /tmp/android.rules;echo "";
echo "Please disconnect and then reconnect your device to use adb.";echo "";sleep 4s;
	fi
}

chadb() { echo ""
	  adb devices
	  echo ""
	  echo "Connection mode:"
 	  adb get-state
	  sleep 4s
}

pull() {  if [ ! -d ~/EZY_ADB/Pull_Files ]; then
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

}

push() {  echo "Enter the file path"
          echo "Example: $HOME/Desktop/file.txt"
          read input
              adb push "$input" /sdcard/
          if [ "$?" -ne "0" ] ; then
             echo "Error while pushing $first"
             sleep 3s
	  fi

}

side() {  echo "Enter the file path"
          echo "Example: $HOME/Desktop/file.txt"
          read input
              adb sideload "$input"

          if [ "$?" -ne "0" ] ; then
              echo "Error while sideloading"
              sleep 3s
	  fi
}

shell() {  clear
 	   adb shell
}

log() {   adb logcat
}

ldump() { LOG="$(date +%d%m%y)log.txt"

 	  if [ ! -d ~/EZY_ADB/Log ]; then
	      mkdir -p ~/EZY_ADB/Log
	  fi 
	   echo "logcat has been saved to ~/EZY_ADB/Log. press ctrl & c to quit"
	   adb logcat > $HOME/EZY_ADB/Log/$LOG
	  echo "Done."
}	

reb() {   adb reboot
}

rec() {   adb reboot recovery
}

boot() {   adb reboot bootloader
}

app() {   echo "Enter the app's file path"
          echo "Example: $HOME/Desktop/file.apk"
          read input
             adb install "$input"
        if [ "$?" -ne "0" ] ; then
             echo "Error while installing $first"
             sleep 3s
    fi
}

oemu() {   echo "This action will unlock your bootloader."
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


    [nN]* ) exit;;

    * ) echo "please enter again";;

    esac
    sleep 3s

}

sdbak()  {  if [ ! -d ~/EZY_ADB/SD_Backup ]; then
	      mkdir -p ~/EZY_ADB/SD_Backup
	  fi 
	  SD="$(date +%d%m%y).ab"
	  adb backup -apk -shared -all -f ~/EZY_ADB/SD_Backup/sdbak-$SD
          echo "backup has been saved to ~/EZY_ADB/SD_Backup "
}

rest()  {  echo "Enter the file name of your backup file"
	   echo "Example: $HOME/EZY_ADB/sdbak-xxxx.ab"
	   read back
	   adb restore "$back"
	   
	   echo "Please wait while your backup is restored"
	   sleep 5s

}

scrn() {  if [ ! -d ~/EZY_ADB/ScreenShots ]; then
	     mkdir -p ~/EZY_ADB/ScreenShots
fi
	     adb shell screencap -p | perl -pe 's/\x0D\x0A/\x0A/g' > ~/EZY_ADB/ScreenShots/screen.png
             if [ -f ~/EZY_ADB/ScreenShots/screen.png ]; then
           	 echo ""
             	 echo "Screenshot has been saved to ~/EZY_ADB/ScreenShots "
                 echo ""
           	 echo "Rename the image file to avoid it being overwritten"
           	 echo ""
                 sleep 3s

    fi
}

recd() {   echo ""
	   	echo "Recording in progress. Press Ctrl and c to stop"
	   	echo ""
		echo "The file will be dumped to your sdcard"

		RD="$(date +%d%m%y)"
		    adb shell screenrecord /sdcard/ScrRecord-$RD.mp4

	        
           	echo ""
}

ex() {  exit
}

stuff()  {

echo ""
echo "          Further reading "
echo "__________________________________________________________"
echo ""
echo "  Google developer guide to adb: http://developer.android.com/tools/help/adb.html"
echo ""
echo "  Fastboot guide by Ricky Divjakovski: http://forum.xda-developers.com/showthread.php?t=2225405"
echo ""
echo "  Adb and fastboot for Windows: http://forum.xda-developers.com/showthread.php?t=2317790"
echo "__________________________________________________________"
sleep 60s
}



while [ "1" = "1" ] ;
do restart
done
exit 0
