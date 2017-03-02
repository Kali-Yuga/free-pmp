#!/bin/bash
while [[ 1 ]]
do
clear
HEIGHT=17
WIDTH=50
CHOICE_HEIGHT=10
BACKTITLE="PMP v.0.0.7 by Kali_Yuga"
TITLE="PMP - Personal-Maintain-Program v.0.0.7"
MENU="Please choose one of the following Options:"

OPTIONS=(1 "Computer Maintenance"
         2 "System Monitor"
         3 "Kill Wine"
         4 "Ubuntu Software Center"
         5 "Install a Wifi USB Stick"
         6 "Select Nvidia Prime"
         7 "Tools & Extras"
         8 "Shut Down"
         9 "About"
         10 "Exit")

CHOICE=$(dialog --clear \
                --backtitle "$BACKTITLE" \
                --title "$TITLE" \
                --menu "$MENU" \
                $HEIGHT $WIDTH $CHOICE_HEIGHT \
                "${OPTIONS[@]}" \
                2>&1 >/dev/tty)
clear
	case $CHOICE in
        1)
	  clear
	  HEIGHT=16
	  WIDTH=40
	  CHOICE_HEIGHT=9
	  BACKTITLE="PMP v.0.0.7 by Kali_Yuga / Computer Maintenance"
	  TITLE="PMP - Maintenance"
	  MENU="Select one of the following Options:"

	  OPTIONS=(1 "Update"
		   2 "Auto Remove"
		   3 "Clean"
		   4 "Update Boot-Loader"
		   5 "Kernel Remover"
		   6 "Install Software"
		   7 "Remove Software"
		   8 "Search & Install Software"
		   9 "Program Problem detected FIX")

	  CHOICE=$(dialog --clear \
                --backtitle "$BACKTITLE" \
                --title "$TITLE" \
                --menu "$MENU" \
                $HEIGHT $WIDTH $CHOICE_HEIGHT \
                "${OPTIONS[@]}" \
                2>&1 >/dev/tty)
clear
	case $CHOICE in
	    
	    1)
	    TITLE="PMP - 0.0.7"
	    dialog \
	    --title "$TITLE" \
	    --backtitle "$BACKTITLE / Update" \
	    --yesno "do you want to Upgrade your System?" 6 35
	    if [ "$?" -eq 0 ]; then
	    clear
	    printf "==========================================\n";
	    printf "| Updating System                        |\n";
	    printf "==========================================\n";
            sudo apt-get update && sudo apt-get dist-upgrade && sudo update-grub
            elif [ "$?" -eq 1 ]; then
            dialog \
            --infobox "exiting..." 3 15
            sleep 1
            clear
            exit 0
            fi
            ;;
            2)
             dialog \
	    --title "Auto-Remove" \
	    --backtitle "PMP v.0.0.7 by Kali_Yuga / Auto-Remove" \
	    --yesno "Remove unnecessary files?" 5 31
	    if [ $? -eq 0 ]; then
	    clear
	    printf "==========================================\n";
	    printf "|                Autoremove              |\n";
	    printf "==========================================\n";
	    sudo apt-get autoremove
	    elif [ $? -eq 1 ]; then
	     dialog \
	    --title "Auto-Remove" \
	    --backtitle "PMP v.0.0.7 by Kali_Yuga / Auto-Remove" \
	    --infobox "exiting..." 3 20
	    sleep 2
	    clear
	    fi
	    exit 0
	    ;;
	    3)
	    printf "==========================================\n";
	    printf "|                 Autoclean 	         |\n";
	    printf "==========================================\n";
	    printf "'starting sudo'...\n";
	    sudo apt-get autoclean
	    printf "please wait...\n"
	    let x=5;while [ $x -gt 0 ];do echo "$x";let x=$x-1;sleep 1;done
	    ;;
	    4)
	    printf "==========================================\n";
	    printf "|         Update Grub Boot Loader	 |\n";
	    printf "==========================================\n";
            echo "Updating Grub Boot Loader"
            sleep 0.1
            printf "starting sudo...\n"
            sudo update-grub
            printf "please wait...\n"
            let x=5;while [ $x -gt 0 ];do echo "$x";let x=$x-1;sleep 1;done
            ;;
            5)
	      clear;
	      dialog --clear \
	      --backtitle "$BACKTITLE / Kernel Remover" \
	      --title "Welcome" \
	      --msgbox "Welcome to The Kernel Remover of PMP!\n\nTIP -- You can find Help & Information about Kernel Remover in the Help Section!" 8 50
	      while [[ 1 ]]
	      do
	      clear;
	      HEIGHT=13
	      WIDTH=52
	      CHOICE_HEIGHT=6
	      BACKTITLE="PMP v.0.0.7 by Kali_Yuga / Computer Maintenance / Kernel Remover"
	      TITLE="Kernel Remover 0.0.2"
	      MENU="Please choose one of the following Options:"
	      OPTIONS=(1 "Remove Kernel Images"
		     2 "Show all Kernel Images"
		     3 "Show removable Kernel Images"
		     4 "Understanding Package States"
		     5 "Help"
		     6 "Exit")
	      CHOICE=$(dialog --clear \
			--backtitle "$BACKTITLE" \
			--title "$TITLE" \
			--menu "$MENU" \
			$HEIGHT $WIDTH $CHOICE_HEIGHT \
			"${OPTIONS[@]}" \
			2>&1 >/dev/tty)
	      clear
	      case $CHOICE in
		  1)
		  x=$(dpkg --list | grep -i linux-image | grep ^rc| awk '{ print $2}')
		  printf "If this field is empty you have no unused Linux Kernel or config files:\n $x" > /tmp/space.txt
		  clear
		  dialog --clear \
		  --backtitle "$BACKTITLE" \
		  --title "$TITLE" \
		  --msgbox "Old kernel images & config files that can be removed will be displayed on the next page." 6 50
		  clear;
		  dialog --clear \
		  --backtitle "$BACKTITLE" \
		  --title "$TITLE" \
		  --textbox /tmp/space.txt 25 80
		  dialog --clear \
		  --backtitle "$BACKTITLE" \
		  --title "$TITLE" \
		  --yesno "Do you really want to remove all previous listed Kernel Images & Configuration Files?" 7 40
		  if [ "$?" -eq 0 ]; then
		  clear;
		  sudo apt-get --purge remove $x
		  dialog --clear \
		  --backtitle "$BACKTITLE" \
		  --title "$TITLE" \
		  --infobox "All Old Kernel Images & Configuration Files listed as 'rc' have been removed, You may restart./n\nThis Window will exit in 10 seconds" 9 20
		  sleep 10;
		  clear
		  elif [ "$?" -eq 1 ]; then
		  dialog \
		  --infobox "Exiting..." 3 15
		  sleep 2
		  clear
		  exit 0
		  fi
		  clear;
		  ;;
		  2)
		  dpkg --list | grep linux-image > /tmp/space.txt
		  dialog --clear \
		  --backtitle "PMP v.0.0.7 by Kali_Yuga / Computer Maintenance / All Kernel Images & Configuration files" \
		  --title "$TITLE" \
		  --textbox /tmp/space.txt 25 80
		  clear;
		  ;;
		  3)
		  x=$(dpkg --list | grep -i linux-image | grep ^rc| awk '{ print $2}')
		  printf "If this field is empty you have no unused Linux Kernel or config files:\n $x" > /tmp/space.txt
		  clear
		  dialog --clear \
		  --backtitle "PMP v.0.0.7 by Kali_Yuga / Computer Maintenance / Removable Kernel Images & Configuration Files" \
		  --title "$TITLE" \
		  --textbox /tmp/space.txt 25 80
		  clear;
		  ;;
		  4)
		  dialog --clear \
		  --title "$TITLE Info" \
		  --backtitle "PMP v.0.0.7 by Kali_Yuga / Computer Maintenance / Understanding Package States" \
		  --msgbox "Understanding package states in Ubuntu and Debian Linux\n-------------------------------------------------------\n\nrc: It means package is in remove/deinstall state and only config file exists.\n\n-----\n\nii: It means package is in install state and it is 100% installed on the system" 15 70
		  clear;
		  ;;
		  5)
		  dialog --clear \
		  --title "$TITLE Help" \
		  --backtitle "PMP v.0.0.7 by Kali_Yuga / Computer Maintenance / Help" \
		  --msgbox "Kernel Remover Help - TIP: Use Page Up & Page Down to Scroll\n-------------------------------------------------------\n\nOption 1, Remove Kernel Images:\n\nFirst, a Window Displays all Kernel Images & Configuration Files that can be removed.\nA question Window will pop up, if you really want to remove the previous listed kernel images & configuration files.\nIf you answered the question with yes,\nthe script will execute a\n'#apt-get --purge remove' command.\nThat will remove all packages that were found as 'not installed'.\nRoot privileges will be required.\nIt will prompt you for your password if you don't have privileges already.\nYou may update your Grub Bootloader after running this,\nso all your boot files are set for your next reboot.\nThis script will not update your boot configuration file!!\n--------------------\n\nOption 2, Show all Kernel Images:\n\nDisplays all Kernel Images & Configuration Files\nwith the respective install state displayed on the left as 'ii' or 'rc'.\n--------------------\n\nOption 3, Show removable Kernel Images:\n\nDisplays all Kernel Images & Configuration Files listed as not installed and shown as 'rc' in Option 2,\nand are able to remove.\n--------------------\n\nOption 4, Understanding package states in Ubuntu and Debian Linux:\n\nDisplays a short Information about what package states are.\n--------------------\n\nOption 5, Help:\n\nThis is the Help Section.\nDisplays Information & Help about the Kernel Remover & it's Options\n--------------------\nNo Warranty whatsoever!" 25 70
		  clear;
		  ;;
		  6)
		  dialog --title "Exit" \
		  --backtitle "$BACKTITLE / Exit" \
		  --infobox "Goodbye..." 3 20
		  sleep 2;
		  clear
		  exit 0
		  esac
		  done
		  ;;
            6)
            TITLE="PMP v0.0.7 - Install Software"
	    PROGRAM=$(dialog \
	    --title "$TITLE" \
	    --backtitle "$BACKTITLE / Install Software" \
	    --stdout \
	    --inputbox "Type in a Name to install something:" 7 40) ;
	    clear
	    sudo apt-get install $PROGRAM    
	    ;;
	    7)
	    TITLE="PMP v0.0.7 - Remove Software"
	    PROGRAM=$(dialog \
	    --title "$TITLE" \
	    --backtitle "$BACKTITLE / Remove Software" \
	    --stdout \
	    --inputbox "Remove:" 5 40) ;
	    clear
	    dialog \
	    --title "$TITLE" \
	    --backtitle "$BACKTITLE / Remove Software" \
	    --yesno "Do you really want to remove $PROGRAM ?" 7 30 ;
	    if [ "$?" -eq 0 ]; then
	    sudo apt-get remove --purge $PROGRAM 
	    elif [ "$?" -eq 1 ]; then
	    dialog --title "Cancelled" --backtitle "$BACKTITLE / Remove Software" --infobox "Exiting..." 3 25
	    sleep 2;
	    clear
	    fi
	    ;;
	    8)
	    BACKTITLE="PMP v.0.0.7 / Search Repository and Install Software"
	    TITLE="PMP - Search & Install from the Repository"
	    MENU="Select one of the following Options:"
	    FILE=$(dialog --clear \
	    --title "Search" \
	    --stdout \
	    --backtitle "$BACKTITLE / Search Repository & Install Software" \
	    --inputbox "Search the Repository for Programs:"  5 40) ;
	    clear
	    printf "==========================================\n";
	    printf "|           Searching Repository 	 |\n";
	    printf "==========================================\n";
	    apt-cache search $FILE
	    printf "\n*Exit with Ctrl + C\n"
	    printf "\nTo Install something,\nPaste in the Name of the Program that you want to install\n\nhere-->"
	    read file2
	    sudo apt-get install $file2
	    sleep 1;
	    exit 0;
	    ;;
	    9)
	    printf "==========================================\n";
	    printf "|   System Program Problem detected FIX  |\n";
	    printf "==========================================\n";
	    sudo rm /var/crash/*
	    sleep 1;
	    clear;
	    esac
	    ;;
        2)
	    clear
	    HEIGHT=16
	    WIDTH=50
	    CHOICE_HEIGHT=9
	    BACKTITLE="$BACKTITLE / System Monitor"
	    TITLE="PMP System Monitor 0.0.1"
	    MENU="Select one of the following Options:"

	    OPTIONS=(1 "Partition Info"
		     2 "USB Devices"
		     3 "PCI / Graphics Card Info"
		     4 "RAM Info"
		     5 "Process Manager"
		     6 "Battery/Power Info"
		     7 "CPU Info"
		     8 "Network Info"
		     9 "Kernel Info")

	    MENU=$(dialog --clear \
                --backtitle "$BACKTITLE" \
                --title "$TITLE" \
                --menu "$MENU" \
                $HEIGHT $WIDTH $CHOICE_HEIGHT \
                "${OPTIONS[@]}" \
                2>&1 >/dev/tty)
		clear
	    case $MENU in
		1)
		  df -h > '/tmp/space.txt'
		  dialog --clear \
		  --backtitle "$BACKTITLE / Partition Information" \
		  --title "$TITLE" \
		  --textbox /tmp/space.txt 20 75
		  clear
		  ;;
		2)
		  lsusb > '/tmp/space.txt'
		  dialog --clear \
		  --backtitle "$BACKTITLE / Connected USB Devices" \
		  --title "USB Devices" \
		  --textbox /tmp/space.txt 20 85
		  clear 
		  ;;
		3)
		  lspci > '/tmp/space.txt'
		  dialog --clear \
		  --backtitle "$BACKTITLE / PCI & Graphics Card Information" \
		  --title "PCI Devices" \
		  --textbox /tmp/space.txt 20 150
		  clear
		  ;;
		4)
		  free -m > '/tmp/space.txt'
		  dialog --clear \
		  --backtitle "$BACKTITLE / RAM Information" \
		  --title "Memory Information" \
		  --textbox /tmp/space.txt 10 70
		  clear
		  ;;
		5)
		  clear
		  printf "==========================================\n";
		  printf "|           Process Manager              |\n";
		  printf "==========================================\n";
		  PS3='Select Options: '
		  options=("List by Process ID" 
			"List by CPU Usage"
			"Kill by Name"
			"Kill with Mousepointer"
			"Kill with Process ID"
			"Exit")
		  select opt in "${options[@]}"
		  do
		  case $opt in
		  ("List by Process ID")
		  ps -ef;
		  sleep 1
		  echo "1) List by Process ID      4) Kill with Mousepointer
2) List by CPU Usage       5) Kill with Process ID
3) Kill by Name            6) Exit"
		  ;;	    
		  ("List by CPU Usage")
		  printf "Hit 'Q' to return to the Program\n";
		  printf "Press Enter to Continue:\n";
		  read
		  let x=2;while [ $x -gt 0 ];do echo "$x";let x=$x-1;sleep 1;done
		  clear;
		  top    
		  ;;
		  ("Kill by Name")
		  printf "Type in a Process you want to kill a.e 'firefox':";
		  read prc;
		  killall $prc
		  ;;
		  ("Kill with Mousepointer")
		  xkill
		  ;;
		  ("Kill with Process ID")
		  echo "Type in a valid process ID to kill it:";
		  read ID
		  kill $ID
		  echo "Process ID $ID killed"
		  ;;
		  ("Exit")
		  printf "==============================\n";
		  printf "|	  Good Bye           |\n";
		  printf "==============================\n";
		  exit 0;
		  esac
		  done
		  ;;
		6)
		  while [[ 1 ]]
		  do
		  HEIGHT=12
		  WIDTH=40
		  CHOICE_HEIGHT=4
		  BACKTITLE="$BACKTITLE"
		  TITLE="$TITLE"
		  MENU="Select one:"
		  OPTIONS=(1 "Install acpi"
		       	 2 "Power Status"
		       	 3 "Show more Info"
		       	 4 "Exit")
		  CHOICE=$(dialog --clear \
		  --backtitle "$BACKTITLE / Battery/Power Info" \
		  --title "$TITLE" \
		  --menu "$MENU" \
		  $HEIGHT $WIDTH $CHOICE_HEIGHT \
		  "${OPTIONS[@]}" \
		  2>&1 >/dev/tty)
		  clear
		  case $CHOICE in 
		  1)
		    dialog --clear \
		    --title "$TITLE" \
		    --backtitle "$BACKTITLE / Install acpi" \
		    --yesno "Do you want to install acpi?" 7 45
		    if [ "$?" -eq 0 ]; then
		    clear
		    sudo apt-get install acpi
		    elif [ "$?" -eq 1 ]; then
		    dialog --clear \
		    --title "$TITLE" \
		    --backtitle "$BACKTITLE / Install acpi" \
		    --msgbox "Goodbye!" 7 45
		    clear
		    exit 0
		    fi
		    ;;
		2)
		  acpi > '/tmp/space.txt'
	    	  dialog --clear \
	    	  --backtitle "$BACKTITLE / Power Status" \
	    	  --title "$TITLE" \
	      	  --textbox /tmp/space.txt 5 100
	      	  clear
		 ;;
		3)
		  acpi -b -a -t > '/tmp/space.txt'
	    	  dialog --clear \
	    	  --backtitle "$BACKTITLE / More Battery Information" \
	    	  --title "$TITLE" \
	      	  --textbox /tmp/space.txt 8 55
	      	  clear
		 ;;
		4)
		  dialog --clear \
		  --title "$TITLE" \
		  --backtitle "$BACKTITLE" \
		  --msgbox "Goodbye!" 5 45
		  clear
		  exit 0
		  esac
		  done
	         ;;
	      7)
		HEIGHT=12
		WIDTH=40
	      	CHOICE_HEIGHT=3
	      	BACKTITLE="$BACKTITLE / CPU Info"
	      	TITLE="$TITLE"
	      	MENU="Select one:"
	      	OPTIONS=(1 "General CPU Info"
			 2 "Show Number of Cores"
			 3 "Processor Details")
	      	CHOICE=$(dialog --clear \
                --backtitle "$BACKTITLE" \
                --title "$TITLE" \
                --menu "$MENU" \
                $HEIGHT $WIDTH $CHOICE_HEIGHT \
                "${OPTIONS[@]}" \
                2>&1 >/dev/tty)
                clear
		case $CHOICE in 
			1)
			  dialog --clear \
			  --backtitle "$BACKTITLE / General CPU Information" \
			  --title "$TITLE" \
			  --msgbox "INFO: Root privileges required" 12 30
			  clear
			  sudo lshw -class processor > '/tmp/space.txt'
			  sleep 3;
			  dialog --clear \
			  --backtitle "$BACKTITLE / General CPU Information" \
			  --title "$TITLE" \
			  --textbox /tmp/space.txt 25 75
			  clear
			  ;;
			  2)
			  cat /proc/cpuinfo | grep processor | wc -l > '/tmp/space.txt'
			  dialog --clear \
			  --backtitle "$BACKTITLE / Number of CPU Cores" \
			  --title "$TITLE" \
			  --textbox /tmp/space.txt 5 20
			  clear
			  ;;
			  3)
			  lscpu > '/tmp/space.txt'
			  dialog --clear \
			  --backtitle "$BACKTITLE / Processor Details" \
			  --title "Processor Details" \
			  --textbox /tmp/space.txt 20 49
			  clear
			  esac
			  ;;
	      8)
		HEIGHT=12
		WIDTH=40
	      	CHOICE_HEIGHT=3
	      	BACKTITLE="$BACKTITLE / Network Information"
	      	TITLE="$TITLE"
	      	MENU="Select one:"
	      	OPTIONS=(1 "View IP and Mac Address"
			 2 "Display Connection info"
			 3 "Ethernet & Wifi Card Info")
	      	MENU=$(dialog --clear \
                --backtitle "$BACKTITLE" \
                --title "$TITLE" \
                --menu "$MENU" \
                $HEIGHT $WIDTH $CHOICE_HEIGHT \
                "${OPTIONS[@]}" \
                2>&1 >/dev/tty)
                clear
		case $MENU in
		1)
		ifconfig > '/tmp/space.txt'
		dialog --clear \
	    	--backtitle "$BACKTITLE / IP and Mac Address" \
	    	--title "$TITLE" \
	      	--textbox /tmp/space.txt 25 150
		clear
		;;
	      	2)
	      	iwconfig > '/tmp/space.txt'
		dialog --clear \
	    	--backtitle "$BACKTITLE / Connection Information" \
	    	--title "$TITLE" \
	      	--textbox /tmp/space.txt 25 150
		clear
		;;
		3)
		lspci | egrep -i --color 'network|ethernet' > '/tmp/space.txt'
		dialog --clear \
	    	--backtitle "$BACKTITLE / Ethernet & Wifi Card Information" \
	    	--title "Network & Ethernet info" \
	      	--textbox /tmp/space.txt 10 150
		clear
		esac
		;;
	      9)
		uname -r > '/tmp/space.txt'
			  dialog --clear \
			  --backtitle "$BACKTITLE / Kernel Information" \
			  --title "    Linux Kernel" \
			  --textbox /tmp/space.txt 7 30
			  clear
			  esac
		;;
	3)
	    dialog \
	    --title "Wine Killer" \
	    --backtitle "PMP v.0.0.7 by Kali_Yuga / Kill Wine" \
	    --yesno "Do you want to kill all Wine processes?" 6 31
	    if [ "$?" -eq 0 ]; then
	    wineserver -k; killall -9 wine wineserver; for i in `ps ax|egrep "*\.exe"|grep -v 'egrep'|awk '{print $1 }'`;do kill -9 $i;done
	    dialog --infobox "Wine Processes killed,\nexiting..." 4 31
	    sleep 2
	    clear
	    exit 0
	    elif [ "$?" -eq 1 ]; then
	    dialog --infobox "exiting..." 3 15
	    sleep 2
	    fi
	    clear
	    exit 0
	    ;;
	4) 
	    printf "==========================================\n";
	    printf "|           Ubuntu Software Center 	 |\n";
	    printf "==========================================\n";
	    printf "\n\n"
	    printf "Please wait..."
	    software-center
	    ;;   
	5)
	    clear
	    HEIGHT=17
	    WIDTH=55
	    CHOICE_HEIGHT=10
	    BACKTITLE="$BACKTITLE / PMP Wifi"
	    TITLE="PMP Wifi v.0.0.3"
	    MENU="Select one of the following Options:"

	    OPTIONS=(1 "Quick WiFi Installer"
		     2 "Install Driver Utilities"
		     3 "Install Wifi Driver"
		     4 "Show Driver Configuration"
		     5 "Add Driver to Startup"
		     6 "Start Driver"
		     7 "Remove Wifi Driver"
		     8 "Remove Driver Utilities"
		     9 "Help"
		     10 "About")
	    CHOICE=$(dialog --clear \
	    --backtitle "$BACKTITLE" \
            --title "$TITLE" \
            --menu "$MENU" \
            $HEIGHT $WIDTH $CHOICE_HEIGHT \
            "${OPTIONS[@]}" \
            2>&1 >/dev/tty)            
            clear
	    case $CHOICE in
	    1)
		TITLE="PMP Wifi v.0.0.3"
		BACKTITLE="$BACKTITLE / Quick WiFi Installer"
		dialog \
		--title "$TITLE" \
		--backtitle "$BACKTITLE" \
		--msgbox "You need to choose the '.inf ' file in the next step.\n\nExample: '/home/user/wifidriver/driver.inf'\n\nYou can find more Information under 'Help' in the Main Menu." 14 60
		FILE=$(dialog --title "$TITLE" \
		--backtitle "$BACKTITLE" \
		--stdout \
		--title "Please choose the .inf file" \
		--fselect $HOME/  8 60) ;
		dialog \
		--title "$TITLE" \
		--backtitle "$BACKTITLE" \
		--yesno "Continue Installing this .inf file?\n\n$FILE" 10 40 ;
		if [ "$?" -eq 0 ]; then
		clear
		printf "===================================\n";
		printf "|1. Quick WiFi Installer 0.0.3    |\n";
		printf "===================================\n";
		sudo apt-get install dkms ndiswrapper-utils-1.9 ndiswrapper-common ndisgtk ndiswrapper-dkms gksu ndiswrapper-source
		clear
		dialog \
		--title "please wait..." \
		--backtitle "$BACKTITLE" \
		--infobox "Installing .inf Driver..." 3 40;
		sleep 1
		sudo ndiswrapper -i $FILE
		dialog \
		--title "please wait..." \
		--backtitle "$BACKTITLE" \
		--infobox "Adding Ndiswrapper to Startup..." 3 40;
		sleep 1
		sudo ndiswrapper -ma
		dialog --title "please wait..." --backtitle "$BACKTITLE" --infobox "Modprobing Driver..." 3 40;
		sleep 1
		sudo modprobe -v ndiswrapper
		clear
		dialog \
		--title "$TITLE" \
		--backtitle "$BACKTITLE" \
		--msgbox "Replug* your Wifi Stick now and Wait about 20 seconds to test your WiFi Stick.\n\n*Is your Wifi still not functioning?\nyou probably installed the wrong .inf Driver.\n\nUse 'Option 7. 'Delete Ndiswrapper driver' in PMP ver.0.0.3\nto delete any drivers.\n\nAfter pressing 'OK', we will display you the Status of the installed Driver." 15 80
		clear
		printf "===================================\n";
		printf "|1. PMP WiFi 0.0.3                |\n";
		printf "===================================\n\n\n";
		printf "YOUR DRIVER STATUS IS:\n";
		printf "======================\n";
		sudo ndiswrapper -l
		printf "======================\n";
		sleep 1
		printf "\n*If the Driver Status above displays: ' : driver installed '\n";
		printf "then the driver was installed correctly.\n\n";
		printf "Goodbye...\n\n";
		exit 0
		    elif [ "$?" -eq 1 ]; then
		    dialog \
		    --title "$TITLE" \
		    --backtitle "$BACKTITLE" \
		    --msgbox "You will need an .inf file to install any Wifi Drivers.\n\nRestart the program and give it the right path.\n\nGoodbye." 12 40
		    clear
		    exit 0
		    fi
		    ;;
	    2)
		TITLE="PMP Wifi v.0.0.3"
		BACKTITLE="$BACKTITLE / Installing Driver Utilities"
		dialog \
		--title "$TITLE" \
		--backtitle "$BACKTITLE" \
		--yesno "Do you want to install the Ndiswrapper Utility from the Repository?" 7 40
		if [ "$?" -eq 0 ]; then
		dialog \
		--title "$TITLE" \
		--backtitle "$BACKTITLE" \
		--pause "starting sudo\nPlease Wait" 10 30 3
		clear
		printf "=====================================\n";
		printf "|2. Installing Driver Utilities     |\n";
		printf "=====================================\n";
		sudo apt-get install dkms ndiswrapper-utils-1.9 ndiswrapper-common ndisgtk ndiswrapper-dkms gksu ndiswrapper-source
		elif [ "$?" -eq 1 ]; then
		dialog \
		--title "$TITLE" \
		--backtitle "$BACKTITLE" \
		--msgbox "You canceled the Ndiswrapper Installation.\n\nGoodbye!" 10 30
		clear
		fi
		;;
	    3) 
		TITLE="PMP Wifi v.0.0.3"
		BACKTITLE="$BACKTITLE / Install WiFi Driver"
		dialog \
		--title "$TITLE" \
		--backtitle "$BACKTITLE" \
		--msgbox "Choose the .inf file in the next step,\nExample: /home/user/wifidriver/driver.inf\n\nYou can find more Information under 'Help' in the Main Menu\n\n\n\n\n\nINFO: Be sure to get your driver in the right Architecture 32 or 64 bit\n" 20 80
		FILE=$(dialog \
		--title "$TITLE" \
		--backtitle "$BACKTITLE" \
		--stdout \
		--title "Please choose the .inf file" \
		--fselect $HOME/  20 80)
		dialog \
		--title "$TITLE" \
		--backtitle "$BACKTITLE" \
		--yesno "Continue Installing this .inf file?\n\n\n$FILE ?" 10 40
		if [ "$?" -eq 0 ]; then
		dialog \
		--title "$TITLE" \
		--backtitle "$BACKTITLE" \
		--pause "starting sudo\nPlease Wait..." 10 30 3
		clear
		sudo v
		clear
		printf "===================================\n";
		printf "|3. Install a Driver		  |\n";
		printf "===================================\n";
		sudo ndiswrapper -i $FILE
		clear
		printf "DRIVER STATUS:\n";
		printf "======================\n";
		sudo ndiswrapper -l
		printf "======================\n\n\n";
		printf "\nCheck your Driver status above!\n\n";
		printf "If the Driver Status above shows ' : driver installed ',\nThen the Installation was successfull\n";
		printf "\n\nPress Enter to Continue:";
		read
		dialog \
		--title "$TITLE" \
		--backtitle "$BACKTITLE" \
		--msgbox "\nYou will need to 'modprobe' an installed Driver in order for it to work.\n\nThis can be done by choosing Option 6\n'Load Ndiswrapper Module'\nin the Main Menu.\n\nTo delete a non 			functioning driver choose Option 7\n'Delete Ndiswrapper driver'\nin the Main Menu." 15 70
		clear
		elif [ "$?" -eq 1 ]; then
		    dialog --title "$TITLE" --backtitle "$BACKTITLE" --msgbox "You will need an .inf file to Continue installing Wifi Drivers\n\nRestart the program and give it the right path to the .inf File\n\nGoodbye!" 20 70
		    clear
		    exit 0
		fi
		;;
	    4)
		clear
		printf "=================================\n";
		printf "|4. Driver Configuration|\n";
		printf "=================================\n";
		printf "\n";
		echo "Your Wifi Device must be present."
		echo "Listing Configuration Files:"
		ls -rl /etc/ndiswrapper/*/*
		;;
	    5)
		TITLE="PMP Wifi v.0.0.3"
		BACKTITLE="$BACKTITLE / Set Ndiswrapper to Startup"
		dialog \
		--title "$TITLE" \
		--backtitle "$BACKTITLE" \
		--yesno "Do you want to add the Ndiswrapper Utilitie to the Systemstart?" 6 40
		if [ "$?" -eq 0 ]; then
		clear
		printf "==========================================\n";
		printf "|5. Add Ndiswrapper to the Systemstart   |\n";
		printf "==========================================\n";
		printf "starting sudo...\n"
		sudo ndiswrapper -ma
		dialog \
		--backtitle "$BACKTITLE" \
		--infobox "Done!\nPlease Wait..." 4 21
		sleep 3
		clear
		exit 0
		elif [ "$?" -eq 1 ]; then
		dialog --title "$TITLE" --backtitle "$BACKTITLE" --infobox "Exiting..." 3 20
		sleep 3
		clear
		exit 0
		fi
		;;
	    6)
		TITLE="PMP Wifi v.0.0.3"
		BACKTITLE="$BACKTITLE / Load Ndiswrapper Module"
		dialog \
		--title "$TITLE" \
		--backtitle "$BACKTITLE" \
		--yesno "Do you want to start the Ndiswrapper Module?" 6 30
		if [ "$?" -eq 0 ]; then
		clear
		printf "==========================================\n";
		printf "|6. Load Ndiswrapper Module              |\n";
		printf "==========================================\n";
		printf "starting sudo...\n"
		sudo modprobe -v ndiswrapper
		elif [ "$?" -eq 1 ]; then
		dialog --title "$TITLE" --backtitle "$BACKTITLE" --infobox "Exiting..." 3 20
		sleep 3
		clear
		exit 0
		fi
		;;
	    7)
		TITLE="PMP Wifi v.0.0.3"
		BACKTITLE="$BACKTITLE / Remove WiFi driver"
		dialog \
		--title "$TITLE" \
		--backtitle "$BACKTITLE" \
		--yesno "Do you want to delete a Wifi Driver?" 6 30
		if [ "$?" -eq 0 ]; then
		clear
		printf "==========================================\n";
		printf "|7. Uninstall WiFi driver                |\n";
		printf "==========================================\n";
		printf "\n\n";
		echo "Listing installed drivers:";
		echo "The Device must be present to display properly!"
		sleep 1;
		printf "\n";
		echo "========================";
		sudo ndiswrapper -l
		echo "========================";
		printf "\n";
		echo "*If the above field is empty you have no installed drivers.";
		echo "or Ndiswrapper is not Installed.";
		printf "\nIf any drivers are installed and listed above,\n" 
		printf "Enter Their Driver Name here:";
		read driver
		sleep 0.1
		echo "proceeding..."
		sleep 0.1
		sudo ndiswrapper -r $driver
		printf "\n"
		echo "DONE!"
		elif [ "$?" -eq 1 ]; then
		clear
		dialog \
		--title "$TITLE" \
		--backtitle "$BACKTITLE" \
		--infobox "Exiting..." 3 20
		sleep 3
		clear
		exit 0
		fi
		;;
	    8)	
		TITLE="PMP Wifi v.0.0.3"
		BACKTITLE="$BACKTITLE / Remove Driver Utilities"
		dialog \
		--title "$TITLE" \
		--backtitle "$BACKTITLE" \
		--yesno "Do you want to remove the Ndiswrapper Utility completely from your system?" 6 50
		if [ "$?" -eq 0 ]; then
		clear
		printf "==============================\n";
		printf "|8. Remove Ndiswrapper       |\n"
		printf "==============================\n";
		sudo apt-get remove --purge ndiswrapper*
		dialog  \
		--title "$TITLE" \
		--backtitle "$BACKTITLE" \
		--msgbox "DONE!.\n\nTo clear all configuration files, check /etc/ndiswrapper/ or use Option 6 in the PMP Wifi menu." 10 40
		clear
		exit 0
		elif [ "$?" -eq 1 ]; then
		dialog --title "$TITLE" \
		--backtitle "$BACKTITLE" \
		--infobox "Exiting..." 3 20
		sleep 3
		clear
		exit 0
		fi
		;;
	    9)
	      clear
	      printf "THIS IS AN OLD HELP SECTION IMPORT! BUT STILL ACCURATE.\nA NEW GUI 'HELP SECTION' WILL FOLLOW...maybe\n";
	      printf "==============================\n";
	      printf "|Tutorial 1 : GET A DRIVER!!!|\n";
	      printf "==============================\n";
	      printf "\n";
	      printf "1.) Make a New Folder in /Home\n";
	      printf "\n";
	      printf "2.) Download a Microsoft Windows® Wifi driver for your Wifi USB Stick to the New Folder we've just created\n";
	      printf "\n";
	      printf "3.) Extract the Windows .exe in your new Folder\n";
	      printf "\n";
	      printf "4.) There should be an .inf and the .sys File located in your folder!\n";
	      printf "\n";
	      printf "5.) Remember the path to the .inf file somewhere\n";	    
	      printf "    Example: '/home/user/wifidriver/driverexample.inf'\n";
	      printf "\n";
	      printf "INFO: Be sure to get your Driver in the right Architecture 32bit or 64bit\n";
	      printf "\n"
	      printf "      If you installed a wrong Driver,\n" ;
	      printf "      choose,\n";
	      printf "      Option 7) --Delete Ndiswrapper driver\n";
	      printf "      to delete any Drivers Installed\n";
	      printf "=================================================================================\n";
	      printf "IMPORTANT INFO: The .inf file holds all the necessary driver information!!!.\n";
	      printf "=================================================================================\n";
	      echo "Press Enter for More!";
	      read
	      clear;
	      printf "==============================\n";
	      printf "|Tutorial 2 : Options|||||||||\n";
	      printf "==============================\n";
	      printf "\n";
	      printf "			  Option 1 -- Quick Installer <---Recommended if unsure\n";
	      printf "		=======================================================\n";
	      printf "		  Insert the .inf path of your driver and Press install.\n";
	      printf "		  Everything will be installed and loaded in one rush.\n";
	      printf "		  A Lan connection is recommended\n";
	      printf "		  It is better to have no driver preinstalled when running this\n";
	      printf "				=================\n";
	      printf "\n";
	      printf "			  Option 2 -- Install Driver Utilities  \n";
	      printf "		=======================================================\n";
	      printf "\n";
	      printf "		  Install's the Driver Utility, Ndiswrapper from the Repository\n";
	      printf "				=================\n";
	      printf "\n";
	      printf "			  Option 3 -- Install Wifi Driver  \n";
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
	      printf "		  Option 5 -- Add Driver to Startup\n";
	      printf "		=======================================================\n";
	      printf "\n";
	      printf "		  Set's Ndiswrapper as a Start-up Program.\n" 
	      printf "		  Then your Driver will start automatically\n";
	      printf "		  when your system boot's up\n";
	      printf "				=================\n";
	      printf "showing 5 out of 10 Options\n";
	      echo "Press Enter for More!";
	      read
	      printf "			  Option 6 -- Start Driver  \n";
	      printf "		=======================================================\n";
	      printf "\n";
	      printf "		  Starts Ndiswrapper and it's Drivers.\n";	    
	      printf "		  You will need to 'replug' your Stick and wait about 20 seconds\n"
	      printf "		  after you loaded the ndiswrapper module.\n";
	      printf "		  Don't worry, It will spit out a Notification.\n"
	      printf "		  Make sure your Wifi Stick is inserted\n";
	      printf "		  and Drivers are installed before executing this Option.\n";
	      printf "				=================\n"
	      printf "\n"
	      printf "			  Option 7 -- Remove Wifi Driver  \n";
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
	      printf "			  Option 8 -- Remove Driver Utilities  \n";
	      printf "		=======================================================\n";
	      printf "\n";
	      printf "		  Will remove Ndistwrapper from your System\n";
	      printf "				=================\n";
	      printf "\n";
	      printf "			  Option 9 -- Help  \n";
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
	    10)
	      TITLE="About"
	      BACKTITLE="$BACKTITLE / About"
	      dialog \
		--title "$TITLE" \
		--backtitle "$BACKTITLE" \
		--msgbox "PMP WiFi 0.0.3\nPersonal Maintain Program\nver. 0.0.6\n\nwritten by Kali_Yuga\n2016\npoorly programmed. :D\n---------------------------\nAll Debian!.\nOnly runs with Debian Systems, like Debian, Ubuntu or Mint.\n\nHelps in installing & setting up Ndiswrapper!\n\nMade for beginners that switched from Windows\nto Linux.\n\nEasy Update & Maintain your System on the Terminal\nwithout having to know commands\nthis Bash script is not professional made.!\nBut it works for me.\nalso just a learning bash script for me.\nNo Warranty whatsoever!.\n" 26 80
	      clear
	      ;;
	      esac
	      ;;
	      
	 6)
	      HEIGHT=13
	      WIDTH=29
	      CHOICE_HEIGHT=3
	      BACKTITLE="$BACKTITLE / Nvidia Prime-select"
	      TITLE="PMP - Nvidia Prime-select"
	      MENU="ONLY FOR NVIDIA OPTIMUS"
	      OPTIONS=(1 "Select Nvidia GPU"
		       2 "Select Intel GPU"
		       3 "Currently running")
	      CHOICE=$(dialog --clear \
                --backtitle "$BACKTITLE" \
                --title "$TITLE" \
                --menu "$MENU" \
                $HEIGHT $WIDTH $CHOICE_HEIGHT \
                "${OPTIONS[@]}" \
                2>&1 >/dev/tty)
                clear
		case $CHOICE in 
                1)
		  clear
		  sudo prime-select nvidia
		  sleep 2;
		  printf "You selected:"
		  prime-select query
		  ;;
		2)
		  clear
		  sudo prime-select intel
		  sleep 2;
		  printf "You selected:"
		  prime-select query
		  ;;
		3)
		  prime-select query > '/tmp/space.txt'
		  dialog --backtitle "$BACKTITLE / Currently running" \
		  --textbox /tmp/space.txt 5 20
		  clear
		  esac
		  ;;
	 7)
	      HEIGHT=13
	      WIDTH=29
	      CHOICE_HEIGHT=5
	      BACKTITLE="$BACKTITLE / Tools & Extras"
	      TITLE="Tools 0.0.2"
	      MENU="Select one:"
	      OPTIONS=(1 "Md5Sum Check"
		       2 "DVD2Iso"
		       3 "HOUSENKA"
		       4 "Calculator"
		       5 "Time & Date")
	      CHOICE=$(dialog --clear \
                --backtitle "$BACKTITLE" \
                --title "$TITLE" \
                --menu "$MENU" \
                $HEIGHT $WIDTH $CHOICE_HEIGHT \
                "${OPTIONS[@]}" \
                2>&1 >/dev/tty)
                clear
		case $CHOICE in 
                1)
		  FILE=$(dialog --clear \
		  --backtitle "$BACKTITLE / Md5Sum Check" \
		  --title "Md5Sum" \
		  --stdout \
		  --fselect $HOME/  15 80)
		  clear
		  md5sum $FILE > '/tmp/space.txt'
		  dialog --backtitle "$BACKTITLE / Md5Sum Check" \
		  --title "Md5Sum" \
		  --textbox /tmp/space.txt 5 199
		  clear
		  ;;
                2)
		  HEIGHT=10
		  WIDTH=29
		  CHOICE_HEIGHT=2
		  BACKTITLE="$BACKTITLE / DVD2ISO 0.0.1"
		  TITLE="DvD2ISO 0.0.1"
		  MENU="Select one:"
		  OPTIONS=(1 "DvD2ISO"
			   2 "Info")
		  CHOICE=$(dialog --clear \
		  --backtitle "$BACKTITLE" \
		  --title "$TITLE" \
		  --menu "$MENU" \
                $HEIGHT $WIDTH $CHOICE_HEIGHT \
                "${OPTIONS[@]}" \
                2>&1 >/dev/tty)
                clear
		case $CHOICE in 
		  1)
		    DIR=`pwd`
		    dialog --clear \
		    --title "$TITLE" \
		    --backtitle "$BACKTITLE" \
		    --msgbox "Welcome to DvD2ISO" 5 40
		    clear
		    dialog --clear \
		    --title "$TITLE" \
		    --backtitle "$BACKTITLE" \
		    --msgbox "The Iso will be created in your current Work Directory:\n$DIR" 8 40
		    clear
		    FILE=$(dialog --clear \
		    --title "$TITLE" \
		    --stdout \
		    --backtitle "$BACKTITLE" \
		    --inputbox "Give your ISO a Name: a.e image_name.iso"  7 40)
		    dialog --clear \
		    --title "$TITLE" \
		    --stdout \
		    --backtitle "$BACKTITLE" \
		    --yesno "Save $FILE in $DIR"  7 40
		    if [ "$?" -eq 0 ]; then
		    clear
		    printf "==========================================\n";
		    printf "|19. DvD2ISO             	   	   |\n";
		    printf "==========================================\n\n";
		    sleep 1
		    printf "Saving '$FILE' in "
		    pwd
		    printf "\nPress 'Enter' to Convert or 'Ctrl + C' to exit:\n";
		    read
		    printf "starting coversion in:\n";
		    let x=4;while [ $x -gt 0 ];do echo "$x";let x=$x-1;sleep 1;done
		    printf "Please Wait...";
		    dd if=/dev/cdrom of=$FILE
		    sleep 3
		    printf "Done!\n"
		    printf "Press Enter to Finish..."
		    read
		    elif [ "$?" -eq 1 ]; then
		    dialog --clear \
		    --title "$TITLE" \
		    --backtitle "$BACKTITLE" \
		    --msgbox "Goodbye..." 5 40
		    clear
		    fi
		    ;;
		  2)
		    dialog --clear \
		    --title "$TITLE" \
		    --backtitle "$BACKTITLE / Information" \
		    --msgbox "The Iso will be created in your current Directory. To save your ISO file, put a CD/DVD in your CD/DVD tray and choose DVD2ISO to make an .iso 	''Virtual Disc'' from it. *sadly won't work with copyright protected DVD's" 20 40
		    clear
		    esac
		    ;;
		3)
	    ##############################################################################
	    #                                                                            #
	    #   Author : Martin "BruXy" Bruchanov, bruxy at regnet.cz			 #
	    #   URL    : http://bruxy.regnet.cz                                          #
	    #   Version: 1.01 (Wed Jan  9 20:04:26 CET 2013)                             #
	    #                                                                            #
	    ##############################################################################
	    ##############################################################################
	    #                                                                            #
	    #   English Translation & minor changes: Kali_Yuga                           #
	    #                                                                            #
	    ##############################################################################
	    MW=$(tput cols)
	    MH=$(tput lines)
	    MH=$[MH-1] # bottom line is used for info and score
	    CONFIG=~/.housenka
	    DEFAULT_FOOD_NUMBER=2 # reset after game over in func. new_level
	    FOOD_NUMBER=0
	    DEATH=0
	    SCORE=0
	    TIMING=0.1            # delay constant, lower value => faster moves
	    C=2                   # game cycle
	    declare -A FOOD
	    _STTY=$(stty -g)      # Save current terminal setup
	    printf "\e[?25l"      # Turn of cursor 
	    printf "\e]0;HOUSENKA\007"
	    stty -echo -icanon
	    USER=$(whoami)
	    NAME=$(grep $USER /etc/passwd | cut -d : -f 5)

	    #############
	    # ANSI data #
	    #############
	    GAME_OVER[0]="\e[1;35m    ╔═╗┌─┐┌┬┐┌─┐  ╔═╗┬  ┬┌─┐┬─┐   \e[0m"
	    GAME_OVER[1]="\e[0;31m    ║ ╦├─┤│││├┤   ║ ║└┐┌┘├┤ ├┬┘   \e[0m"
	    GAME_OVER[2]="\e[1;31m    ╚═╝┴ ┴┴ ┴└─┘  ╚═╝ └┘ └─┘┴└─   \e[0m"
	    GAME_OVER[3]="\e[0;32m╥────────────────────────────────╥\e[0m"
	    GAME_OVER[4]="\e[1;32m║  Press Enter for a new game!   ║\e[0m"
	    GAME_OVER[5]="\e[1;36m╨────────────────────────────────╨\e[0m"

	    #############
	    # FUNCTIONS #
	    #############

	    function at_exit() {
	    printf "\e[?9l"          # Turn off mouse reading
	    printf "\e[?12l\e[?25h"  # Turn on cursor
	    stty "$_STTY"            # reinitialize terminal settings
	    tput sgr0
	    clear
	    }

	    function get_first() {
	    # Return: first index of array
	    eval echo \${!$1[@]} | cut -d ' ' -f 1
	    }

	    function gen_food() {
	    local x y food
	    for ((i=0; i<$[2*$FOOD_NUMBER]; i++))
	    do
		x=$[RANDOM % (MW-2) + 2]
		y=$[RANDOM % (MH-2) + 2]
		# check if leaf position is unique
		if [ $(echo ${!FOOD[@]} | tr ' ' '\n' | grep -c "^$y;$x$") -gt 0 ] 
		then
			: $[i--]
			continue
		fi
		food=$[i & 1] # 0 -- poison, 1 -- leaf
		FOOD["$y;$x"]=$food
		if [ $food -eq 1 ] ; then 
			printf "\e[$y;${x}f\e[1;32m♧\e[0m";
		else 
			printf "\e[$y;${x}f\e[1;31m☠\e[0m"; 
		fi
	    done
	    }

	    function check_food() {

	local first
	# check what was eaten in garden
	if [ "${FOOD["$HY;$HX"]}" == "1" ] ; then
		unset FOOD["$HY;$HX"]
		: $[FOOD_NUMBER--] $[SCORE++]
		((FOOD_NUMBER==0)) && return 
	elif [ "${FOOD["$HY;$HX"]}" == "0" ] ; then 
		DEATH=1
	else
		first=$(get_first HOUSENKA)
		printf "\e[${HOUSENKA[$first]}f "
		unset HOUSENKA[$first]			
	fi
	# do not break into wall
	if [ $HY -le 1 ] || [ $HY -ge $MH ] || [ $HX -le 1 ] || [ $HX -ge $MW ] 
	then
		DEATH=2
	fi
	# check if Housenka does not bite herself
	if [ ! -z "$KEY" -a $C -gt 4 ] ; then
		local last
		last=${#HOUSENKA[@]}
		if [ $(echo ${HOUSENKA[@]} | tr ' ' '\n' | \
			   head -n $[last-2] | grep -c "^$HY;$HX$") -gt 0 ] ; then
			DEATH=3
		fi
	fi
	}

	function game_over() {
	trap : ALRM # disable interupt
	printf "\a"
	centered_window 34 ${#GAME_OVER[@]} GAME_OVER 
	if [ $SCORE -gt $TOP_SCORE ] ; then
		echo $SCORE > $CONFIG
		TOP_SCORE=$SCORE
	fi
	read
	DEATH=0 SCORE=0 DEFAULT_FOOD_NUMBER=2
	new_level
	}

	function centered_window() {
	# $1 width $2 height $3 content
	w=$1 h=$2
	x=$[(MW-w)/2]
	y=$[(MH-h)/2]
	ul=$y";"$x
	bl=$[y+h+1]";"$x
	printf "\e[${ul}f┌"; printf '─%.0s' $(eval echo {1..$w}); printf '┐\n'
	for i in $(eval echo {0..$h}); 
	do 
		printf "\e[$[y+i+1];${x}f│";
		echo -en "$(eval printf \"%s\" \"\${$3[\$i]}\")"
		printf "\e[$[y+i+1];$[x+w+1]f│";
	done
	printf "\e[${bl}f└"; printf '─%.0s' $(eval echo {1..$w}); printf '┘\n'
	}

	function move() {
	check_food
	if [ $DEATH -gt 0 ] ; then game_over; fi
	if [ $FOOD_NUMBER -eq 0 ] ; then new_level;	fi

	echo -en "\e[$HY;${HX}f\e[1;33;42m✱\e[0m"

	( sleep $TIMING; kill -ALRM $$ ) &

	case "$KEY" in
		A) HY=$[HY-1] ;; # Up
		B) HY=$[HY+1] ;; # Down
		C) HX=$[HX+1] ;; # Right	
		D) HX=$[HX-1] ;; # Left
	esac

	HOUSENKA[$C]="$HY;$HX"
	: $[C++]	
	game_info
	}

	function draw_area() {
	# draw play area
	printf "\e[31m"
	local x y o="█"
	for ((x=0;x<=$MW;x++))
	do
	printf  "\e[1;${x}f$o\e[$MH;${x}f$o"
	sleep 0.005
	done
	for ((y=0;y<=$MH;y++))
	do
	printf "\e[${y};1f$o\e[${y};${MW}f$o"
	sleep 0.01
	done
	}

	function new_level() {
	unset HOUSENKA
	for i in ${!FOOD[@]}; do unset FOOD[$i]; done # erase leaves and poison
	clear
	draw_area
	FOOD_NUMBER=$[DEFAULT_FOOD_NUMBER*=2]
	gen_food
	HX=$[MW/2] HY=$[MH/2]  # start position in the middle of the screen
	# body initialization
	HOUSENKA=([0]="$[HY-2];$HX" [1]="$[HY-1];$HX" [2]="$HY;$HX") 
	KEY='' 
	C=2
	trap move ALRM
	}

	function title_screen() {
	TITLE="QlpoOTFBWSZTWWMw1D8AAnd//X38AIhAA/24Cg2UCD7H13BVRH9ktkYEBAgAEABQ
	BHgAEQBSlBJEQhqaA0ZDQBoA0ABpoBo9Rk0Ghw00wQyGmmRkwgGmgDCaNMmABA0E
	KRJCTTIDIAAAAAyBkNDQNNHqHDTTBDIaaZGTCAaaAMJo0yYAEDQ4aaYIZDTTIyYQ
	DTQBhNGmTAAgadZFPhSv08GL4IDbz4ctYPMQnUncHF0csCYaeprXNsFiBI3jqAqr
	eZINIEZYBM0vKFjDLrT3O9d7u0YdyNmszDTqrCoaow3YRJGmq1mpO9ZAbqoXLRBc
	sNPFvNGSbnbbDlhVhwUxhQ2lyXlxhssjLVysN8tVGpyiODkVooK4kzcZBVBBouKq
	K4k3RKUuppicgMDWCYG23aU3vWmMOHN8HBjaSTYb43vjg4bTqDizjjW5iojfdt7O
	DhnoedhCmSaWgoUq6IyuzGTVFAUs66ujrbwJmIp54zi8U0Jvl2dG7jlOcZy0IU8Q
	HY32Ojyejm45lswDjSi5KwUwUUlAIQ01SRKUtKU1Hjwg4A7BIMFZ3MMYMQHc2nHg
	Fi88aPlyBeYkZTTyRgUml+nl5p3CxSMeGHDUCBTstZpOZckIU8f7lIckxlKZ53hT
	YzK0p+YzytGd2hNg2ZCrUpkv09fqowZ9vLuiQCDnIRUPoBDAIVRIZkQO0AKOpQ0o
	msRVHATFQU7vc7/1AfWSlJFEkFIrRKQUlVRCSlVNUlLQDMCxBAlAlIkEQTMFMkTM
	KkKVBJARFVEBD9hI9tR52USwDECnHMMIoyMqxgMsg0BodaBnMaMbCUaR1ZLkoYFR
	EgUFAFNBEoxRgYJqQNQg9r4/g7vn+99/Gsj4bVxAAJfFf177dEjRn5b+cAhI82SQ
	jRPNoFhdnAMJcvMkDUJEOiRqlRWaGSUhKgJZGIkiEkGS/jv9e9m2vitRmRjm0T38
	FrpAS4kkIYQliBkCQnEYYP80AEjqXFAyVSw1tRWIFcZFUcAwaeljJUjJfQ8Ph9X1
	Q+3t/mIXWLjCLuLwg1WEYiUo038wzoqSHpSaSOKUde7LhfHRdQzqlxs3rJKmOROc
	o6Y6ZDm+THkzMzIdPXzUOo4RVH/xdyRThQkGMw1D8A=="
	SCR=`echo "$TITLE" | base64 -d | bzcat` #unpack main screen
	local i j IFS=$'\n' 
	clear
	# center on screen
	for ((j=0;j<$[(MH-25)/2];j++)) do echo; done
	for i in $SCR
	do	
		for ((j=0;j<$[(MW-63)/2];j++)) do echo -n " "; done
		printf "%s\n" $i
	done
	read
	}

	function game_info() {
	printf "\e[$[MH+1];0fPlayer: $USER (Top Score: $TOP_SCORE)"
	printf "\e[$[MH+1];$[MW-12]fScore: %5d" $SCORE
	}

	########
	# MAIN #
	########

	exec 2>/dev/null
	trap at_exit ERR EXIT 
	if [ -f $CONFIG ] ; then
	TOP_SCORE=$(cat $CONFIG)
	else
	TOP_SCORE=0
	fi
	new_level
	move
	while :
	do
	read -rsn3 -d '' PRESS
	KEY=${PRESS:2}
	done
	;;
	4)
	bc -l
	;;
	5)
	  HEIGHT=10
	  WIDTH=15
	  CHOICE_HEIGHT=2
	  BACKTITLE="$BACKTITLE / Time & Date"
	  TITLE="Time & Date"
	  MENU="Select one:"
	  OPTIONS=(1 "Time"
		   2 "Calendar")
	  CHOICE=$(dialog --clear \
           --backtitle "$BACKTITLE" \
           --title "$TITLE" \
           --menu "$MENU" \
           $HEIGHT $WIDTH $CHOICE_HEIGHT \
           "${OPTIONS[@]}" \
           2>&1 >/dev/tty)
           clear
	    case $CHOICE in
	    1)
	      dialog                      \
		--title 'PMP Time'        \
		--backtitle "$BACKTITLE / Time"  \
		--timebox ''  \
		0 0
		clear
		;;
	     2)
	      dialog                      \
		--title "PMP Calendar"    \
		--backtitle "$BACKTITLE / Calendar"  \
		--calendar ''             \
		0 0
		clear
		esac
		esac
		;;
	8)
	 BACKTITLE="$BACKTITLE / Shutdown"
	 dialog --title "Shutdown" \
	 --backtitle "$BACKTITLE" \
	 --yesno "Do you want to turn off your Computer?" 6 35
	 if [ "$?" -eq 0 ]; then
	 clear
	 sudo shutdown -h now
	 elif [ "$?" -eq 1 ]; then
	 dialog --title "Cancel" --backtitle "$BACKTITLE / Shutdown" --infobox "Exiting..." 3 25
	 sleep 2
	 clear
	 fi
	 ;;
	9)
	    TITLE="About"
	    BACKTITLE="PMP v.0.0.7  by Kali_Yuga / About"
	    dialog \
	    --title "$TITLE" \
	    --backtitle "$BACKTITLE" \
	    --msgbox "PMP\nPersonal Maintain Program\nver. 0.0.7\n\nwritten by Kali_Yuga\n2017-2018\npoorly programmed. :D\n---------------------------\nAll Debian!.\nOnly runs with Debian Systems, like Debian, Ubuntu or Mint.\n\nMade for beginners that switched from Windows\nto Linux.\n\nEasy Update & Maintain your System on the Terminal\nwithout having to know commands\nso this is basically just a Bash script for learning and it is not professional made! Mainly use it myself\nso it works for me.\nNo warranty whatsoever!" 24 80
	      clear
	      ;;
	10)
	   dialog --title "Exit" \
		--backtitle "$BACKTITLE / Exit" \
		--infobox "Goodbye..." 3 20
		sleep 2;
		clear
		exit 0
		;;
esac
done