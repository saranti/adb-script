#!/bin/bash
#adb script for Linux
#Changelog: https://github.com/Art-Vanderlay/adb-script/blob/master/changelog
#testing






inst() {  sudo add-apt-repository ppa:phablet-team/tools && sudo apt-get update
        wait
        sudo apt-get install android-tools-adb android-tools-fastboot
}
    

    

 
pull() {  echo "Enter the file path"
        echo      "Example: /sdcard/Pictures/file.png"
        read input
        adb devices
        adb pull "$input" /$HOME/Desktop
    if [ "$?" -ne "0" ] ; then
        echo "Error while pulling $first"
    
fi
}


push() {  echo "Enter the file path"
        echo      "Example: $HOME/Desktop/file.txt"
        read input
        adb devices
        adb push "$input" /sdcard/
    if [ "$?" -ne "0" ] ; then
        echo "Error while pulling $first"
   
fi
}


side() {  echo "Enter the file path"
         echo      "Example: $HOME/Desktop/file.txt"
         read input
          adb devices
          adb sideload "$input"
      if [ "$?" -ne "0" ] ; then
        echo "Error while sideloading"
    
fi
}
    


shell() {   adb devices
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
  
fi
}


oemu() {   echo "This action will unlock your bootloader."
          echo "All your data will be erased and your warranty may be void."
          echo "Are you sure you want to continue? [y/n]"
    
    read input
    case $input in

    [yY]* ) adb devices
                adb reboot bootloader
                wait
                  fastboot oem unlock
              echo "Done";;

    [nN]* ) exit;;
    
    * ) echo "please enter again";;
    esac

}      
    
scrn() {     adb shell screencap -p | perl -pe 's/\x0D\x0A/\x0A/g' > screen.png
             if [ -f $HOME/Desktop/screen.png ]; then
           echo ""
             echo "Your image is located in $HOME and is named 'screen.png'"
                echo ""
    
fi
}

fact() {   echo "All your data will be erased." 
          echo "This action cannot be undone."
          echo "Are you sure you want to continue? [y/n]"
          read input
          case $input in

    [yY]* ) adb devices
                adb shell
                  recovery --wipe_data;;
    
    [nN]* ) exit;;
    
    * ) echo "please enter again";;
    esac
}

ex() {  exit
}



udev() {    cat >/tmp/android.rules << "EOF"
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
sudo cp /tmp/android.rules /etc/udev/rules.d/51-android.rules;sudo chmod 644   /etc/udev/rules.d/51-android.rules;sudo chown root. /etc/udev/rules.d/51-android.rules;sudo service udev restart;sudo killall adb;rm /tmp/android.rules; echo "";echo "Please disconnect and then reconnect your device to use adb.";echo "";sleep 7s;
fi

}



restart() {
clear
echo "       ===================================================================="
echo "      ||                                                                  ||"
echo "      ||                               ADB TOOL                           ||"
echo "      ||                                                                  ||"
echo "      ||==================================================================||"
echo "      ||                                                                  ||"
echo "      ||                         CHOOSE FROM THE MENU                     ||"
echo "      ||                                                                  ||"
echo "      ||                                                                  ||"
echo "      ||   1) install adb & fastboot           9) reboot bootloader       ||"
echo "      ||                                                                  ||"
echo "      ||   2) adb pull                         10) install apk            ||"
echo "      ||                                                                  ||"
echo "      ||   3) adb push                         11) unlock bootloader      ||"
echo "      ||                                                                  ||"
echo "      ||   4) adb sideload                     12) take screenshot        ||"
echo "      ||                                                                  ||"
echo "      ||   5) adb shell                        13) factory reset          ||"
echo "      ||                                                                  ||"
echo "      ||   6) take logcat                      14) quit                   ||"
echo "      ||                                                                  ||"
echo "      ||   7) reboot                           15) configure udev rules   ||"
echo "      ||                                           (for no permissions    ||"
echo "      ||   8) reboot recovery                      error)                 ||"
echo "      ||                                                                  ||"
echo "       ===================================================================="   
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
	    11)    boot ;;
	    12)    scrn ;;
	    13)    fact ;;
	    14)    ex ;;
	    15)    udev ;;
	     *)
			echo "Unknown command: '$first'"
        ;;
	esac
}

while [ "1" = "1" ] ;
do restart
done
exit 0
