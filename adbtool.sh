#!/bin/bash
#adb script for Linux
#Changelog: https://github.com/Art-Vanderlay/adb-script/blob/master/changelog
#testing




inst() {  if [ -f /etc/lsb-release ]; then
           sudo add-apt-repository ppa:phablet-team/tools && sudo apt-get update
           wait
           sudo apt-get install android-tools-adb android-tools-fastboot
           
          elif [ -f /etc/fedora-release ]; then
            sudo yum install android-tools;
          elif [ -f /etc/redhat-release ]; then
            sudo yum install android-tools;
    fi
            
}
 
pull() {  echo "Enter the file path"
          echo      "Example: /sdcard/Pictures/file.png"
          read input
          adb devices
          adb pull "$input" /$HOME/Desktop
    if [ "$?" -ne "0" ] ; then
        echo "Error while pulling $first"
        sleep 3s
    
    fi
}

push() {  echo "Enter the file path"
        echo      "Example: $HOME/Desktop/file.txt"
        read input
        adb devices
        adb push "$input" /sdcard/
    if [ "$?" -ne "0" ] ; then
        echo "Error while pushing $first"
        sleep 3s
   
    fi
}

side() {  echo "Enter the file path"
         echo      "Example: $HOME/Desktop/file.txt"
         read input
          adb devices
          adb sideload "$input"
      if [ "$?" -ne "0" ] ; then
        echo "Error while sideloading"
        sleep 3s
    fi
}
    
shell() { adb devices
          adb shell   
}
 
log() {   adb devices
          adb logcat
} 
  
reb() {   adb devices
          adb reboot
}    
    
rec() {   adb devices
    adb reboot recovery
}        
    
boot() {   adb devices
    adb reboot bootloader
}        
    
app() {   echo "Enter the app's file path"
          echo      "Example: $HOME/Desktop/file.apk"
          read input
             adb devices
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

    [yY]* ) adb devices
                adb reboot bootloader
                sleep 3s
                  echo "Waiting for fastboot device..."
                  fastboot devices
                  fastboot oem unlock
              echo "Done";;
             

    [nN]* ) exit;;
    
    * ) echo "please enter again";;
    
    esac
    sleep 3s

}      
    
scrn() {   adb shell screencap -p | perl -pe 's/\x0D\x0A/\x0A/g' > /$HOME/Desktop/screen.png
             if [ -f $HOME/Desktop/screen.png ]; then
           echo ""
             echo "Your image is located in $HOME/Desktop and is named 'screen.png'"
                echo ""
                sleep 3s
    
    fi
}

ex() {  exit
}


udev() { if [ -f /etc/lsb-release ]; then  
   cat >/tmp/android.rules << "EOF"
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
sudo cp /tmp/android.rules /etc/udev/rules.d/51-android.rules;sudo chmod 644   /etc/udev/rules.d/51-android.rules;sudo chown root. /etc/udev/rules.d/51-android.rules;sudo service udev restart;sudo killall adb;rm /tmp/android.rules;echo "";echo "Please disconnect and then reconnect your device to use adb.";echo "";sleep 4s;
    fi
fi



if [ -f /etc/redhat-release ]; then
   cat >/tmp/android.rules << "EOF"
SUBSYSTEM=="usb", SYSFS{idVendor}=="502", SYMLINK+="android_adb",MODE="0666", GROUP="plugdev"
SUBSYSTEM=="usb", SYSFS{idVendor}=="0b05", SYMLINK+="android_adb",MODE="0666", GROUP="plugdev"
SUBSYSTEM=="usb", SYSFS{idVendor}=="413c", SYMLINK+="android_adb",MODE="0666", GROUP="plugdev"
SUBSYSTEM=="usb", SYSFS{idVendor}=="489", SYMLINK+="android_adb",MODE="0666", GROUP="plugdev"
SUBSYSTEM=="usb", SYSFS{idVendor}=="04c5", SYMLINK+="android_adb",MODE="0666", GROUP="plugdev"
SUBSYSTEM=="usb", SYSFS{idVendor}=="04c5", SYMLINK+="android_adb",MODE="0666", GROUP="plugdev"
SUBSYSTEM=="usb", SYSFS{idVendor}=="091e", SYMLINK+="android_adb",MODE="0666", GROUP="plugdev"
SUBSYSTEM=="usb", SYSFS{idVendor}=="18d1", SYMLINK+="android_adb",MODE="0666", GROUP="plugdev"
SUBSYSTEM=="usb", SYSFS{idVendor}=="109b", SYMLINK+="android_adb",MODE="0666", GROUP="plugdev"
SUBSYSTEM=="usb", SYSFS{idVendor}=="0bb4", SYMLINK+="android_adb",MODE="0666", GROUP="plugdev"
SUBSYSTEM=="usb", SYSFS{idVendor}=="12d1", SYMLINK+="android_adb",MODE="0666", GROUP="plugdev"
SUBSYSTEM=="usb", SYSFS{idVendor}=="24000", SYMLINK+="android_adb",MODE="0666", GROUP="plugdev"
SUBSYSTEM=="usb", SYSFS{idVendor}=="2116", SYMLINK+="android_adb",MODE="0666", GROUP="plugdev"
SUBSYSTEM=="usb", SYSFS{idVendor}=="482", SYMLINK+="android_adb",MODE="0666", GROUP="plugdev"
SUBSYSTEM=="usb", SYSFS{idVendor}=="17ef", SYMLINK+="android_adb",MODE="0666", GROUP="plugdev"
SUBSYSTEM=="usb", SYSFS{idVendor}=="1004", SYMLINK+="android_adb",MODE="0666", GROUP="plugdev"
SUBSYSTEM=="usb", SYSFS{idVendor}=="22b8", SYMLINK+="android_adb",MODE="0666", GROUP="plugdev"
SUBSYSTEM=="usb", SYSFS{idVendor}=="409", SYMLINK+="android_adb",MODE="0666", GROUP="plugdev"
SUBSYSTEM=="usb", SYSFS{idVendor}=="2080", SYMLINK+="android_adb",MODE="0666", GROUP="plugdev"
SUBSYSTEM=="usb", SYSFS{idVendor}=="955", SYMLINK+="android_adb",MODE="0666", GROUP="plugdev"
SUBSYSTEM=="usb", SYSFS{idVendor}=="2257", SYMLINK+="android_adb",MODE="0666", GROUP="plugdev"
SUBSYSTEM=="usb", SYSFS{idVendor}=="10a9", SYMLINK+="android_adb",MODE="0666", GROUP="plugdev"
SUBSYSTEM=="usb", SYSFS{idVendor}=="1d4d", SYMLINK+="android_adb",MODE="0666", GROUP="plugdev"
SUBSYSTEM=="usb", SYSFS{idVendor}=="471", SYMLINK+="android_adb",MODE="0666", GROUP="plugdev"
SUBSYSTEM=="usb", SYSFS{idVendor}=="04da", SYMLINK+="android_adb",MODE="0666", GROUP="plugdev"
SUBSYSTEM=="usb", SYSFS{idVendor}=="05c6", SYMLINK+="android_adb",MODE="0666", GROUP="plugdev"
SUBSYSTEM=="usb", SYSFS{idVendor}=="1f53", SYMLINK+="android_adb",MODE="0666", GROUP="plugdev"
SUBSYSTEM=="usb", SYSFS{idVendor}=="400000000", SYMLINK+="android_adb",MODE="0666", GROUP="plugdev"
SUBSYSTEM=="usb", SYSFS{idVendor}=="04dd", SYMLINK+="android_adb",MODE="0666", GROUP="plugdev"
SUBSYSTEM=="usb", SYSFS{idVendor}=="054c", SYMLINK+="android_adb",MODE="0666", GROUP="plugdev"
SUBSYSTEM=="usb", SYSFS{idVendor}=="0fce", SYMLINK+="android_adb",MODE="0666", GROUP="plugdev"
SUBSYSTEM=="usb", SYSFS{idVendor}=="2340", SYMLINK+="android_adb",MODE="0666", GROUP="plugdev"
SUBSYSTEM=="usb", SYSFS{idVendor}=="930", SYMLINK+="android_adb",MODE="0666", GROUP="plugdev"
SUBSYSTEM=="usb", SYSFS{idVendor}=="19d2", SYMLINK+="android_adb",MODE="0666",
EOF


if [ -f /tmp/android.rules ]; then
sudo cp /tmp/android.rules /etc/udev/rules.d/51-android.rules;sudo chmod 644   /etc/udev/rules.d/51-android.rules;sudo chown root. /etc/udev/rules.d/51-android.rules;sudo service udev restart;sudo killall adb;rm /tmp/android.rules;udevcontrol reload_rules;echo "";echo "Please disconnect and then reconnect your device to use adb.";echo "";sleep 4s;
    fi
fi

}



restart() {
clear
echo ""
echo ""
echo ""
echo "                                      EZY-ADB                           "
echo "         _____________________________________________________________"
echo ""
echo "                               CHOOSE FROM THE MENU"
echo "                                                                        "
echo "         1) install adb & fastboot            9) reboot bootloader      "
echo "                                                                        "
echo "         2) adb pull                         10) install apk            "
echo "                                                                        "
echo "         3) adb push                         11) unlock bootloader      "
echo "                                                                        "
echo "         4) adb sideload                     12) take screenshot        "
echo "                                                                        "
echo "         5) adb shell                        13)  configure udev rules  "
echo "                                                  (for no permissions   "
echo "         6) take logcat                           error)                "
echo "                                                                        "
echo "         7) reboot                            q) quit                   "
echo "                                                                        "
echo "         8) reboot recovery                                             "
echo "        ______________________________________________________________"   
echo ""

read first

	case "$first" in       
	
		 1)    inst ;;
		 2)    pull ;;
		 3)    push ;;
		 4)    side ;;
		 5)    shell ;;
		 6)    log ;;
		 7)    reb ;;
		 8)    rec ;;
		 9)    boot ;;
	    10)    app ;;
	    11)    oemu ;;
	    12)    scrn ;;
	    13)    rcrd ;;
	    14)    udev ;;
	     q)    ex ;;
	     *)
			echo "Unknown command: '$first'"
        ;;
	esac
}

while [ "1" = "1" ] ;
do restart
done
exit 0

