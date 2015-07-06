#!/bin/bash
#adb script for Linux
#Changelog:
#testing


clear
echo "             _____________________________________________"
echo "            ||                                           ||"
echo "            ||               PICK AN OPTION              ||"
echo "            ||                                           ||"
echo "            ||                 1) adb pull               ||"
echo "            ||                                           ||"
echo "            ||                2) adb push                ||"
echo "            |                                             |"
echo "            |                3) adb sideload              |"
echo "            |                                             |"
echo "            |                4) adb shell                 |"
echo "            |                                             |"
echo "            |                5) logcat                    |"
echo "            |                                             |"
echo "            |                6) reboot                    |"
echo "            |                                             |"
echo "            |                7) reboot recovery           |"
echo "            |                                             |"
echo "            |                8) reboot bootloader         |"
echo "            |                9) install apk               |"
echo "            |                                             |"
echo "            |                10) quit                     |"
echo "            |                                             |"
echo "            |_____________________________________________|"   


read first

if [ $first -eq 1 ]
 
    then echo "Enter the file path"
    echo      "Example: /sdcard/Pictures/file.png"
    read input
    adb devices
    adb pull "$input" /$HOME/Desktop
    if [ "$?" -ne "0" ] ; then
        echo "Error while pulling $first"
    fi
fi

if [ $first -eq 2 ]

    then echo "Enter the file path"
    echo      "Example: $HOME/Desktop/file.txt"
    read input
    adb devices
    adb push "$input" /sdcard/
        if [ "$?" -ne "0" ] ; then
        echo "Error while pulling $first"
   fi
fi

if [ $first -eq 3 ]
    then echo "Enter the file path"
    echo      "Example: $HOME/Desktop/file.txt"
    read input
    adb devices
    adb sideload "$input"
        if [ "$?" -ne "0" ] ; then
        echo "Error while sideloading"
    fi
fi
    
if [ $first -eq 4 ]

    then adb devices
    adb shell
    fi

if [ $first -eq 5 ]
    then
    adb devices
    adb logcat
       
    fi   
    
if [ $first -eq 6 ]
    then
    adb devices
    adb reboot
    fi    
    
if [ $first -eq 7 ]
    then
    adb devices
    adb reboot recovery
    fi        
    
if [ $first -eq 8 ]
    then
    adb devices
    adb reboot bootloader
    fi        
    
if [ $first -eq 9 ]

    then echo "Enter the app's file path"
    echo      "Example: $HOME/Desktop/file.apk"
    read input
    adb devices
    adb install "$input" 
        if [ "$?" -ne "0" ] ; then
        echo "Error while installing $first"
   fi
fi

if [ $first -eq 10 ]
    then  exit
    
    fi      
