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
echo "      ||   1) install adb & fastboot            8) reboot recovery        ||"
echo "      ||                                                                  ||"
echo "      ||   2) adb pull                          9) reboot bootloader      ||"
echo "      ||                                                                  ||"
echo "      ||   3) adb push                          10) install apk           ||"
echo "      ||                                                                  ||"
echo "      ||   4) adb sideload                      11) unlock bootloader     ||"
echo "      ||                                                                  ||"
echo "      ||   5) adb shell                         12) take screenshot       ||"
echo "      ||                                                                  ||"
echo "      ||   6) take logcat                       13) factory reset         ||"
echo "      ||                                                                  ||"
echo "      ||   7) reboot                            14) quit                  ||"
echo "      ||                                                                  ||"
echo "      ||                                                                  ||"
echo "       ===================================================================="   
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

    then echo "This action will unlock your bootloader."
    echo "All your data will be erased and your warranty may be void."
    echo "Are you sure you want to continue? [y/n]"
    
    read input
    case $input in

    [yY]* ) adb devices
                adb reboot bootloader
                  fastboot oem unlock
              echo "Done";;

    [nN]* ) exit;;
    
    * ) echo "please enter again";;
    esac

fi      
    
if [ $first -eq 12 ]
    then adb shell screencap -p | perl -pe 's/\x0D\x0A/\x0A/g' > screen.png
    echo ""
    echo "Your image is located in $HOME and is named 'screen.png'"
    echo ""
fi

if [ $first -eq 13 ]
    
    then echo "All your data will be erased." 
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
fi

if [ $first -eq 14 ]
    then exit
fi
