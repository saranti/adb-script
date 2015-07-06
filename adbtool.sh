#!/bin/bash
#adb script for Linux
#Changelog: https://github.com/Art-Vanderlay/adb-script/blob/master/changelog
#testing


clear
echo ""
echo "              ==========================================="
echo "            ||                                           ||"
echo "            ||               PICK AN OPTION              ||"
echo "            ||                                           ||"
echo "            ||                1) install adb             ||"
echo "            ||                                           ||"
echo "            ||                2) adb pull                ||"
echo "            ||                                           ||"
echo "            ||                3) adb push                ||"
echo "            ||                                           ||"
echo "            ||                4) adb sideload            ||"
echo "            ||                                           ||"
echo "            ||                5) adb shell               ||"
echo "            ||                                           ||"
echo "            ||                6) logcat                  ||"
echo "            ||                                           ||"
echo "            ||                7) reboot                  ||"
echo "            ||                                           ||"
echo "            ||                8) reboot recovery         ||"
echo "            ||                                           ||"
echo "            ||                9) reboot bootloader       ||"
echo "            ||                                           ||"
echo "            ||                10) install apk            ||"
echo "            ||                                           ||"
echo "            ||                11) unlock bootloader      ||"
echo "            ||                                           ||"
echo "            ||                12) take screenshot        ||"
echo "            ||                                           ||"
echo "            ||                13) quit                   ||"
echo "            ||                                           ||"
echo "              ==========================================="   
echo ""

read first

if [ $first -eq 1 ]

    then sudo add-apt-repository ppa:phablet-team/tools && sudo apt-get update
    wait
    sudo apt-get install android-tools-adb android-tools-fastboot
    
fi
    
if [ $first -eq 2 ]
 
    then echo "Enter the file path"
    echo      "Example: /sdcard/Pictures/file.png"
    read input
    adb devices
    adb pull "$input" /$HOME/Desktop
    if [ "$?" -ne "0" ] ; then
        echo "Error while pulling $first"
    fi
fi

if [ $first -eq 3 ]

    then echo "Enter the file path"
    echo      "Example: $HOME/Desktop/file.txt"
    read input
    adb devices
    adb push "$input" /sdcard/
        if [ "$?" -ne "0" ] ; then
        echo "Error while pulling $first"
   fi
fi

if [ $first -eq 4 ]
    then echo "Enter the file path"
    echo      "Example: $HOME/Desktop/file.txt"
    read input
    adb devices
    adb sideload "$input"
        if [ "$?" -ne "0" ] ; then
        echo "Error while sideloading"
    fi
fi
    
if [ $first -eq 5 ]

    then adb devices
    adb shell
    fi

if [ $first -eq 6 ]
    then
    adb devices
    adb logcat
       
    fi   
    
if [ $first -eq 7 ]
    then
    adb devices
    adb reboot
    fi    
    
if [ $first -eq 8 ]
    then
    adb devices
    adb reboot recovery
    fi        
    
if [ $first -eq 9 ]
    then
    adb devices
    adb reboot bootloader
    fi        
    
if [ $first -eq 10 ]

    then echo "Enter the app's file path"
    echo      "Example: $HOME/Desktop/file.apk"
    read input
    adb devices
    adb install "$input" 
        if [ "$?" -ne "0" ] ; then
        echo "Error while installing $first"
   fi
fi

if [ $first -eq 11 ]

    then  adb devices
    adb reboot bootloader
    fastboot oem unlock
    fi      
    
if [ $first -eq 12 ]
    then adb shell screencap -p | perl -pe 's/\x0D\x0A/\x0A/g' > screen.png
fi

if [ $first -eq 13 ]
    then exit
fi
