#!/bin/bash
clear;
  echo "MaintainPC v0.0.1 / Mod.0.0.2 Backport CLI version"
  echo "PMP ver.0.0.2/CLI Version"
  echo "always exit this Program by pressing 'Ctrl + C' on your keyboard.";
  echo "written by Kali_Yuga";
  let x=3;while [ $x -gt 0 ];do echo "$x";let x=$x-1;sleep 1;done
clear;
  echo "MaintainPC v0.0.1 / Mod.0.0.2 Backport CLI version"
  echo "PMP ver.0.0.2/CLI Version"
  echo "always exit this Program by pressing 'Ctrl + C' on your keyboard.";
  echo "written by Kali_Yuga";
  echo "=============================";
  echo "The Time is"; date
  echo "=============================";
sleep 1;
  echo "	  ==Menu=="
  echo ""
sleep 0.1;  
  echo "1.  Full System Update";
sleep 0.1;
  echo "2.  Harddrive Partitions";
sleep 0.1; 
  echo "3.  USB Devices";
sleep 0.1;
  echo "4.  Kernel Remover";
sleep 0.1;
  echo "5.  PCI Devices";
sleep 0.1;
  echo "6.  Update Grub-Boot Manager";
sleep 0.1;
  echo "7.  System Program Problem detected FIX";
sleep 0.1;
  echo "8.  Ubuntu Software Center";
sleep 0.1;
  echo "9.  Search & Install";
sleep 0.1;
  echo "10. Ethernet and Wifi Card";
sleep 0.1;
  echo "11. Kill Wine";
sleep 0.1;
  echo "12. Install a Program";
sleep 0.1;
  echo "13. Remove a Program";
sleep 0.1;
  echo "14. Auto-remove";
sleep 0.1;
  echo "15. Autoclean";
sleep 0.1;
  echo "16. Clean";  
sleep 0.1;
  echo "17. Processes Killer";
sleep 0.1;
  echo "18. Install a Wifi USB Adapter";
sleep 0.1;  
  echo "19. About";
sleep 0.1;
  echo "20. Exit";
sleep 0.1;
  echo "============================="
sleep 1; 
  echo -n "select by typing in the menu number:" #Menu
  
read num
echo

if [ "$num" -eq 1 ]; then
sudo apt-get update && sudo apt-get dist-upgrade # Update your System
elif [ "$num" -eq 2 ]; then
df -h #List Partitions and Harddrives
elif [ "$num" -eq 3 ]; then
lsusb #List all usb devices
elif [ "$num" -eq 4 ]; then
clear 	    
	    echo "mpmp-kernel-remover v.0.0.2";
            echo "by Kali_Yuga";
	    echo "==========================";
	    echo "DO NOT REMOVE THIS KERNEL!";
	    uname -r;
	    echo "==========================";
            PS3='Please enter your choice: '
	    options=("-- List all Kernel's" "-- List unused Kernel's" "-- Remove all unused Kernels" "-- Exit") #Menu Kernel Remover
	    select opt in "${options[@]}"
	    do
	    case $opt in
	    "-- List all Kernel's") # First Option
            dpkg --list | grep linux-image | awk '{ print $2 }' | sort -V 
            ;;
	    "-- List unused Kernel's") #Second Option
            dpkg --list | grep linux-image | awk '{ print $2 }' | sort -V | sed -n '/'`uname -r`'/q;p'
            printf "If field is empty, you have no unused/old Kernel...\n"
            ;;
	    "-- Remove all unused Kernels") #Third Option
	    echo "Going to remove old Kernel's...";
	    echo -n "keeping Kernel version: "
	    uname -r;
	    echo "WARNING: ALL OLD KERNEL VERSIONS ARE GOING TO BE REMOVED!"
	    echo "Press Ctrl + C to abort!"
	    echo -n "Press Enter to Confirm";
	    echo " "
	    read;
	    echo "starting sudo...";
	    let x=3;while [ $x -gt 0 ];do echo "$x";let x=$x-1;sleep 1;done
	    dpkg --list | grep linux-image | awk '{ print $2 }' | sort -V | sed -n '/'`uname -r`'/q;p' | xargs sudo apt-get -y purge
	    sudo update-grub;
	    ;;
	    "-- Exit") #Exit command
	    printf "Good Bye...\n"
	    exit 0
            ;;
	    *) echo invalid option;;
    esac
done
	    read f2 #reads Kernel Menu Option
	    if [ "$f2" -eq 1 ]; then
	    dpkg --list | grep linux-image | awk '{ print $2 }' | sort -V 
	    elif [ "$f2" -eq 2 ]; then
	    dpkg --list | grep linux-image | awk '{ print $2 }' | sort -V | sed -n '/'`uname -r`'/q;p'
	    elif [ "$f2" -eq 3 ]; then
	    echo "using: dpkg --list | grep linux-image | awk '{ print $2 }' | sort -V | sed -n '/'`uname -r`'/q;p' | xargs sudo apt-get -y purge
	    && sudo update-grub to remove unused Kernel's";
	    echo -n "Press Enter...";
	    read;
	    clear;
	    echo "starting sudo...";
	    let x=3;while [ $x -gt 0 ];do echo "$x";let x=$x-1;sleep 1;done
	    dpkg --list | grep linux-image | awk '{ print $2 }' | sort -V | sed -n '/'`uname -r`'/q;p' | xargs sudo apt-get -y purge
	    sudo update-grub;
	    elif [ "$f2" -eq 4 ]; then
	    exit
	    fi;
	    
elif [ "$num" -eq 5 ]; then
lspci
elif [ "$num" -eq 6 ]; then
sudo update-grub
elif [ "$num" -eq 7 ]; then
sudo rm /var/crash/*
elif [ "$num" -eq 8 ]; then
software-center
elif [ "$num" -eq 9 ]; then
  echo -n "Search for Software:";
read prog
  echo "Searching the Repository for $prog ...";
sleep 2;
apt-cache search $prog
  echo "========================================================================";
  echo "Ctrl + C to abort..."
  echo -n "Or Install Software with copying and pasting the Software Name here: ";
read prog2
sleep 1;
  echo "starting sudo...";
sudo apt-get install $prog2
elif [ "$num" -eq 10 ]; then
  echo "Listing Ethernet and Wifi Adapters...";
sleep 1
lspci | egrep -i --color 'network|ethernet'
elif [ "$num" -eq 11 ]; then
wineserver -k; killall -9 wine wineserver; for i in `ps ax|egrep "*\.exe"|grep -v 'egrep'|awk '{print $1 }'`;do kill -9 $i;done
sleep 1;
  echo "Wine processes successfully closed";
elif [ "$num" -eq 12 ]; then
  echo "which program do you want to install";
read install
  echo "starting sudo...";
let x=3;while [ $x -gt 0 ];do echo "$x";let x=$x-1;sleep 1;done
sudo apt-get install $install
elif [ "$num" -eq 13 ]; then
  echo "which program do you want to remove";
read remove
  echo "starting sudo...";
let x=3;while [ $x -gt 0 ];do echo "$x";let x=$x-1;sleep 1;done
sudo apt-get remove $remove
elif [ "$num" -eq 14 ]; then
printf "===================================\n";
printf "|14. Auto-remove    |\n";
printf "===================================\n";
sudo apt-get autoremove
elif [ "$num" -eq 15 ]; then
  echo -n "Please press Enter to Continue...";
read;
sudo apt-get autoclean
elif [ "$num" -eq 16 ]; then
  echo -n "Please press Enter to Continue...";
read;
sudo apt-get clean
elif [ "$num" -eq 17 ]; then
 
	    printf "process killer v.0.0.2\n"
	    PS3='Enter 5 to Exit or Select Options: '
	    options=("List Programs by Program ID" 
		     "List Processes by CPU Usage"
		     "Kill by Program Name"
		     "Kill with Mousepointer"
		     "Exit")
	    select opt in "${options[@]}"
	    do
	    case $opt in
	    ("List Programs by Program ID")
	    ps -ef;
	    ;;	    
	    ("List Processes by CPU Usage")
	    printf "Hit 'Q' to return to the Program\n";
	    printf "Press Enter to Continue:\n"
	    read
	    let x=2;while [ $x -gt 0 ];do echo "$x";let x=$x-1;sleep 1;done
	    clear;
	    top	    
	    ;;
	    ("Kill by Program Name")
	    echo "Type in a Process you want to kill a.e 'firefox'";
	    read prc;
	    killall $prc
	    ;;
	    ("Kill with Mousepointer")
	    xkill
	    ;;
	    ("Exit")
	    echo "Good Bye...";
	    exit
            esac;
            done;
            
elif [ "$num" -eq 18 ]; then
clear
sleep 0.1;
echo "PMP - Linux Wifi Stick Helper 0.0.2 by Kali_Yuga";
sleep 0.1;
echo ""
echo "PMP Personal-Maintain-Program ver.0.0.2 CLI Version";
sleep 0.1;
echo "============================================================";
sleep 0.1;
echo "There is a more detailed Guide in the Tutorial & Info Section"
echo "============================================================"
echo "			==MENU=="
                     PS3='Enter (10) to Exit, or Enter your Choise: '
	    options=("--Quick Installer"
		     "--Install Ndiswrapper"
		     "--Install a Driver" 
		     "--Show Driver Configuration" 
		     "--Load ndiswrapper driver at System Start" 
		     "--Load ndiswrapper module"
		     "--Delete Ndiswrapper driver" 
		     "--Delete Ndiswrapper completely"  
		     "--Tutorial & Info"
		     "--Exit")
	    select opt in "${options[@]}"
	    do
	    case $opt in
	    "--Quick Installer")
	    clear
	    echo "To Exit this Program press 'Ctrl + C'";
	    printf "===================================\n"
	    let x=3;while [ $x -gt 0 ];do echo "$x";let x=$x-1;sleep 1;done
	    clear
	    echo "To Exit this Program press 'Ctrl + C'";
	    printf "===================================\n";
	    printf "|2. Quick Wifi Installer 0.0.2    |\n";
	    printf "===================================\n";
	    printf "You will need to specify a Path to the .inf File in the next Step.\n";
	    echo "";
	    echo "Find more Information in 'Option 9 in PMP's Wifi Helper Menu."
	    echo "--Tutorial & Info"
	    echo "";
	    echo "Plug-in your Wifi Stick and have a LAN Connection ready";
	    printf "===================================\n";
	    echo "";
	    printf "Hit Enter to proceed:"
	    read
	    let x=2;while [ $x -gt 0 ];do echo "$x";let x=$x-1;sleep 1;done
	    clear
	    echo "To Exit this Program press 'Ctrl + C'";
	    printf "===================================\n"
	    printf "Insert a Path to the .inf file\n"; 
	    printf "for exapmle: '/home/user/wifidriver/driverexample.inf\n"
	    printf "Here:";
	    read path
	    clear
	    echo "To Exit this Program press 'Ctrl + C'";
	    printf "===================================\n"
	    echo "Is the .inf Path correct?: '$path'";
	    echo "Press Enter to proceed (You will be promted for your Password):";
	    read
	    echo "starting sudo...";
	      let x=4;while [ $x -gt 0 ];do echo "$x";let x=$x-1;sleep 1;done
	      sudo apt-get install dkms ndiswrapper-utils-1.9 ndiswrapper-common ndisgtk ndiswrapper-dkms gksu ndiswrapper-source
	      echo "DONE!";
	      echo "Installing Driver"
	      sudo ndiswrapper -i $path
	      sleep 1.5
	      echo "DONE!";
	      echo "Adding Ndiswrapper to Startup"
	      sudo ndiswrapper -ma
	      sleep 1.5
	      echo "DONE!";
	      echo "Loading installed Driver"
	      sudo modprobe -v ndiswrapper
	      sleep 1.5
	      echo "DONE!";
	      echo "DRIVER STATUS:";
	      echo "======================";
	      sudo ndiswrapper -l
	      echo "======================";
	      printf "Proceed with Enter:";
	      read
	      clear
	      echo "DRIVER STATUS:";
	      echo "======================";
	      sudo ndiswrapper -l
	      echo "======================";
	      let x=3;while [ $x -gt 0 ];do echo "$x";let x=$x-1;sleep 1;done
	    printf "===================================\n";
	    printf "|2. Quick Wifi Installer 0.0.2    |\n";
	    printf "===================================\n";
	      echo "--If the Driver Status is ' : driver installed ', Unplug your LAN Cable now";
	      echo "  and 'Replug' your Wifi Stick and Wait about 20 seconds to see if it works";
	      echo "====================";
	      echo "--Did it Fail?: Read the error output to get more Information";
	      echo "====================";
	      echo "--Is your Wifi is still not functioning?" 
	      echo "  you probably installed the wrong .inf Driver";
	      echo "  Use 'Option 7. in PMP ver.0.0.3";
	      echo "  to delete drivers";
	      echo " ";
	      echo " ";
	      
	    ;;
	    "--Install Ndiswrapper")
	    clear
	    printf "===================================\n";
	    printf "|2. Installing Ndiswrapper Utility|\n";
	    printf "===================================\n";
	    echo "starting sudo:";
            let x=2;while [ $x -gt 0 ];do echo "$x";let x=$x-1;sleep 1;done
            sudo apt-get install dkms ndiswrapper-utils-1.9 ndiswrapper-common ndisgtk ndiswrapper-dkms gksu ndiswrapper-source
            ;;
	    "--Install a Driver")
	    clear
	    printf "===============================\n";
	    printf "|3. Install Ndiswrapper Driver|\n";
	    printf "===============================\n";
	    printf "\n";
	    printf "Paste the path of your .inf file below\n";
	    printf "Example: '/home/user/wifidriver/driver.inf'\n";
	    printf "\n"
	    printf "To get more Tutorials & Information\n"
	    printf "check out Tutorial & Info (Option 9) in the Menu\n";
	    sleep 0.1;
	    printf "===========================================================\n"
	    printf "the .inf file holds all the necessary driver information!!!.\n";
	    printf "===========================================================\n"
	    printf "You must Enter the path of the .inf here:";
		    read ndisk
		    sudo ndiswrapper -i $ndisk
		    echo "DONE!"
	    printf "If you selected the right .inf file\n" 
	    printf "your driver should be installed now\n";
	    printf "To check if a driver is installed,\n" 
	    printf "choose Option 4 --Show Driver Configuration\n"
		    ;;
	    "--Show Driver Configuration")
	    clear
	    printf "=================================\n";
	    printf "|4. Current Driver Configuration|\n";
	    printf "=================================\n";
	    printf "\n";
	    echo "Listing Configuration Files:"
	    let x=3;while [ $x -gt 0 ];do echo "$x";let x=$x-1;sleep 1;done
	    clear
	    ls -rl /etc/ndiswrapper/*/*
	    echo "DONE!"
	    echo "To make ndiswrapper a startup application," 
	    echo "choose Option 5 --Load ndiswrapper driver at System Start"
	    ;;
	    "--Load ndiswrapper driver at System Start")
	    clear
	    printf "==========================================\n";
	    printf "|5.Start Ndiswrapper when Computer starts|\n";
	    printf "==========================================\n";
	    echo "You will be promted for a password,"
	    echo "to load Ndiswrapper into the Systemstart"; 
	    echo "";
	    echo "Press Enter to Continue";
	    read;
	    sudo ndiswrapper -ma
	    echo "Ndiswrapper will now start when your System starts";
	    echo "choose Option 6 --Load Ndiswrapper Module," 
	    echo "to test & load your Driver"
	    echo "DONE!"
	    ;;
	    "--Load ndiswrapper module")
	    clear
	    printf "===================================\n";
	    printf "|6.Load Ndiswrapper Module        |\n";
	    printf "===================================\n";
	    echo "Make sure your Wifi Stick is inserted";
	    echo "and Drivers are Installed";
	    echo "Press Enter to Continue:";
	    read
	    echo "=========";
	    sudo modprobe -v ndiswrapper
	    echo "=========";
	    echo "If Failed: Read the error output for more Information"
	    echo " ";
	    echo "DONE!";
	    echo "Please Replug your Wifi Stick now... Wait about 20 seconds";
	    echo "";
	    echo "If your Wifi is still not functioning you probably installed";
	    echo "the wrong Driver, use 'Option 7 --Delete Ndiswrapper driver'";
	    echo "to delete any Drivers";
	    ;;
	    "--Delete Ndiswrapper driver")
		    clear
	    printf "==============================\n";
	    printf "|7.Delete Ndiswrapper Driver |\n";
	    printf "==============================\n";
		    echo "You will be promt to provide a password"
		    echo "Press Enter to Continue:"		    
		    read
		    echo "Listing installed drivers:"
		    echo "=============="
		    sudo ndiswrapper -l
		    echo "=============="
		    echo "If the above field is empty you have no installed drivers.";
		    echo "or Ndiswrapper is not Installed.";
		    printf "====\n";
		    echo "If drivers are installed," 
		    printf "paste in the driver Name listed above to remove it\n";
		    printf "Enter driver Name here:";
		    read driver
		    sleep 0.1
		    echo "proceeding..."
		    sudo ndiswrapper -r $driver
		    echo "DONE!"		    
		    ;;
	    "--Delete Ndiswrapper completely")
	    clear
	    printf "==============================\n";
	    printf "|8. Remove Ndiswrapper       |\n"
	    printf "==============================\n";
	    echo "Do you want to remove Ndiswrapper completely"
	    echo "Enter (1) for Yes"
	    echo "Enter (2) for No! Exit!"
	    read yesno
	    if [ "$yesno" -eq 1 ];then
	    echo "starting sudo"; 
		    sudo apt-get remove --purge ndiswrapper*
		    echo "DONE!";
		    echo "To clear all configuration files check /etc/ndiswrapper/ or use Option 6 in the PMP Wifi menu";
	    elif [ "$yesno" -eq 2 ];then
	    printf "==============================\n";
	    printf "|Good Bye       		 |\n"
	    printf "==============================\n";
	    exit
	    fi
            ;;
	    "--Tutorial & Info")
	    clear
	    printf "==============================\n";
	    printf "|Tutorial 1 : GET A DRIVER!!!|\n";
	    printf "==============================\n";
	    printf "\n";
	    printf "1.) Make a New Folder in /Home\n";
	    printf "\n";
	    printf "2.) Download Your Wifidriver to your New Folder you've just created\n";
	    printf "\n";
	    printf "3.) Right Click and Click 'Extract Here' your Wifidriver.exe\n";
	    printf "\n";
	    printf "4.) Be sure the .inf and the .sys File are located there now!\n";
	    printf "\n";
	    printf "5.) Save your .inf path somewhere\n";	    
	    printf "    Example: '/home/user/wifidriver/driverexample.inf'\n";
	    printf "\n";
	    printf "INFO: Be sure to get your Driver in the right Architecture 32bit or 64bit\n";
	    printf "\n"
	    printf "      If you installed a wrong Driver,\n" ;
	    printf "      choose,\n";
	    printf "      Option 6) --Delete Ndiswrapper driver\n";
	    printf "      to delete any Drivers Installed\n";
	    printf "===========================================================\n";
	    printf "the .inf file holds all the necessary driver information!!!.\n";
	    printf "===========================================================\n";
	    echo "Press Enter for More!";
	    read
	    clear;
	    printf "==============================\n";
	    printf "|Tutorial 2 : Options|||||||||\n";
	    printf "==============================\n";
	    printf "\n";
	    printf "			  Option 1 -- Quick Installer\n";
	    printf "		=======================================================\n";
	    printf "		  Insert the .inf driver path and Press install.\n";
	    printf "		  Everything will be installed and loaded in one rush.\n";
	    printf "		  A Lan connection is required\n";
	    printf "		  Can Fail !\n";
	    printf "		  It is better to have no driver preinstalled when running this\n";
	    printf "				=================\n";
	    printf "\n";
	    printf "			  Option 2 -- Install Ndiswrapper  \n";
	    printf "		=======================================================\n";
	    printf "\n";
	    printf "		  Install's the Driver Utility, Ndiswrapper from the Repository\n";
	    printf "				=================\n";
	    printf "\n";
	    printf "			  Option 3 -- Install a Driver  \n";
	    printf "		=======================================================\n";
	    printf "\n";
	    printf "		  Is the Driver Installation Process\n";
	    printf "		  Follow the Tutorial 1 GET A DRIVER\n";
	    printf "		  Keep your .inf File ready!!!\n";
	    printf "		  You will need to specify the .inf path there\n";
	    printf "		  Example: /home/user/wifidriver/driverexample.inf\n";
	    printf "				=================\n";
	    printf "showing 3 out of 10 Options\n";
	    echo "Press Enter for More!";
	    read
	    printf "			  Option 4 -- Show Driver configuration  \n";
	    printf "		=======================================================\n";
	    printf "\n";
	    printf "		  Shows you the current Driver Configuration you have Installed\n";
	    printf "				=================\n"
	    printf "\n"
	    printf "		  Option 5 -- Load ndiswrapper driver at System Start\n";
	    printf "		=======================================================\n";
	    printf "\n";
	    printf "		  Set's Ndiswrapper as a Start-up Program.\n" 
	    printf "		  Then your Driver will start automatically\n";
	    printf "		  when your system boot's up\n";
	    printf "				=================\n";
	    printf "showing 5 out of 10 Options\n";
	    echo "Press Enter for More!";
	    read
	    printf "			  Option 6 -- Load ndiswrapper module  \n";
	    printf "		=======================================================\n";
	    printf "\n";
	    printf "		  Starts Ndiswrapper and it's Drivers.\n";	    
	    printf "		  You will need to 'replug' your Stick and wait about 20 seconds\n"
	    printf "		  after you loaded the ndiswrapper module.\n";
	    printf "		  Don't worry, It will spit out a Notification.\n"
	    printf "		  Make sure your Wifi Stick is inserted\n";
	    printf "		  and Drivers are installed before executing this Option!\n";
	    printf "				=================\n"
	    printf "\n"
	    printf "			  Option 7 --Delete Ndiswrapper driver  \n";
	    printf "		=======================================================\n";
	    printf "\n"
	    printf "		  will Delete installed drivers.\n";
	    printf "		  You will be promted for a password\n" 
	    printf "		  The installed Driver will be shown in a field\n";
	    printf "		  Then Copy&Paste in the Driver's Name that is listed above to remove it\n";
	    printf "				=================\n";
	    printf "showing 7 out of 10 Options\n";
	    echo "Press Enter for More!";
	    read
	    printf "			  Option 8 --Delete Ndiswrapper  \n";
	    printf "		=======================================================\n";
	    printf "\n";
	    printf "		  Will remove Ndistwrapper from your System\n";
	    printf "				=================\n";
	    printf "\n";
	    printf "			  Option 9 --Tutorial Section  \n";
	    printf "		=======================================================\n";
	    printf "\n";
	    printf "		  Is the Section you are currently reading.\n";
	    printf "\n";
	    printf "				=================\n";
	    printf "\n";
	    printf "			 Option 10 --Exit \n"	;
	    printf "		=======================================================\n";
	    printf "\n";
	    printf "		  Will Exit This Program with a Good Bye saying :)\n";
	    printf "				=================\n";
	    printf "\n";
	    printf "showing 10 out of 10 Options\n";
	    ;;
            "--Exit")
	    printf "==============================\n";
	    printf "|	    Good Bye	     |\n"
	    printf "==============================\n";
            exit;
            ;;
            esac
            done
            elif [ "$num" -eq 19 ]; then
clear 
printf "==============================\n";
printf "|	    About      	     |\n"
printf "==============================\n";
printf "===================================================================\n";           
echo "MaintainPC v0.0.1 / 0.0.2 Backport CLI Version"
echo "Modified with Backport Support from GUI version 0.0.2"
echo "===="
echo "MaintainPC ver.0.0.1 your PC easy without having to know commands!"
echo "Made by Kali_Yuga"
echo "always exit this Program by pressing 'Ctrl + C' on your keyboard.";
            printf "===================================================================\n";
            printf "About PMP 0.0.2"
	    printf "\n";
	    printf "Personal Maintain Program\n";
	    printf "==========\n";
	    printf "ver. 0.0.1\n";
	    printf "written by Kali_Yuga\n";
	    printf "2016\n";
	    printf "Made for beginners that switched from Windows\n";
	    printf "to Linux. Easy Update & Maintain your System on the Terminal\n";
	    printf "without having to know commands\n";
	    printf "also a learning bash script for me\n" 
	    printf "don't take this as a serious Program\n"
	    printf "that means no warranty!!\n";
	    printf "===================================================================\n";
	    
   elif [ "$num" -eq 20 ]; then
printf "==============================\n";
printf "|	    Good Bye	     |\n"
printf "==============================\n";
exit 0
fi;