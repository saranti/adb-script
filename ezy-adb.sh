#!/bin/bash
#Ezy-Adb by Tom Sarantis (Art-Vanderlay)
#testing

 
inst() { if egrep -qi "ubuntu|debian|mint" /proc/version; then
          	 sudo apt-get install android-tools-adb android-tools-fastboot
     fi
     
          if grep -qi "suse" /proc/version; then
          	sudo zypper install android-tools 	
     fi				

          if egrep -qi "mint|linuxmint" /proc/version; then
             sudo apt-get install libncurses5:i386
     fi
 
          if egrep -qi "redhat|centos" /proc/version; then
             wget http://dl.fedoraproject.org/pub/epel/6/x86_64/epel-release-6-8.noarch.rpm
             sudo rpm -Uvh epel-release-6*.rpm
     fi
           
          if egrep -qi "redhat|fedora|centos" /proc/version; then
		     sudo yum install epel-release
		     wait
           	 sudo yum install android-tools

     fi

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
sudo cp /tmp/android.rules /etc/udev/rules.d/51-android.rules;sudo chmod 644   /etc/udev/rules.d/51-android.rules;sudo chown root. /etc/udev/rules.d/51-android.rules;sudo killall adb;rm /tmp/android.rules;echo "";echo "Please disconnect and then reconnect your device to use adb.";echo "";sleep 4s;
   
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

oemu() {  echo "This action will unlock your bootloader."
          echo "All your data will be erased and your warranty may be void."
          echo "Are you sure you want to continue? [y/n]"
    
    read input
    case $input in

    [yY]* ) adb devices
                adb reboot bootloader
                echo "Waiting for fastboot device..."
                sleep 6s
                  fastboot devices
                  fastboot oem unlock
              echo "Done";;
             

    [nN]* ) exit;;
    
    * ) echo "please enter again";;
    
    esac
    sleep 3s

}      


exb() {	fastboot devices
	fastboot reboot
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
echo "         1) install adb & fastboot           8) reboot recovery         "
echo "                                                                        "
echo "         2) adb pull                         9) reboot bootloader       "
echo "                                                                        "
echo "         3) adb push                         10) exit fastboot mode     "
echo "                                                                        "
echo "         4) adb sideload                     11) install apk            "
echo "                                                                        "
echo "         5) adb shell                        12) unlock bootloader      "
echo "                                                                        "
echo "         6) take logcat                      13) take screenshot        "
echo "                                                                        "
echo "         7) reboot                            q) exit                   "
echo "                                                                        "
echo "                                                                        "
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
	    12)    exb ;;
	    13)    scrn;;
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
