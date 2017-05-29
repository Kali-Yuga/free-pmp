#!/bin/bash
while [[ 1 ]]
do
dpkg -s dialog &> /dev/null #Check's if Dialog is installed
if [ "$?" -eq 0 ]; then #Dialog Installed
clear
HEIGHT=17
WIDTH=50
CHOICE_HEIGHT=9
BACKTITLE="PMP v.0.0.13 by Kali_Yuga"
TITLE="PMP - Personal-Maintain-Program v.0.0.13"
MENU="Select one of the following Options:"

OPTIONS=(1 "Computer Maintenance"
         2 "System Monitor"
         3 "Kill Wine"
         4 "Ubuntu Software Center"
         5 "Install a Wifi USB Stick"
         6 "Extras"
         7 "Shut Down"
         8 "About"
         9 "Exit") ##Main Menu

CHOICE=$(dialog --clear \
                --backtitle "$BACKTITLE" \
                --title "$TITLE" \
                --menu "$MENU" \
                $HEIGHT $WIDTH $CHOICE_HEIGHT \
                "${OPTIONS[@]}" \
                2>&1 >/dev/tty)
        if [ "$?" -eq 0 ]; then
case $CHOICE in
        1) ##Computer Maintenance Menu
	  while [[ 1 ]]
	  do
	  clear
	  HEIGHT=17
	  WIDTH=40
	  CHOICE_HEIGHT=10
	  BACKTITLE="PMP v.0.0.13 by Kali_Yuga / Computer Maintenance"
	  TITLE="PMP - Maintenance"
	  MENU="Select one of the following Options:"

	  OPTIONS=(1 "Update"
		   2 "Auto-Remove"
		   3 "Clean"
		   4 "Update Boot-Loader"
		   5 "Kernel Remover"
		   6 "Install Software"
		   7 "Remove Software"
		   8 "Search & Install Software"
		   9 "Nvidia Driver Manager"
		   10 "Next Page →")

	  CHOICE=$(dialog --clear \
                --backtitle "$BACKTITLE" \
                --title "$TITLE" \
                --menu "$MENU" \
                $HEIGHT $WIDTH $CHOICE_HEIGHT \
                "${OPTIONS[@]}" \
                2>&1 >/dev/tty)
        if [ "$?" -eq 0 ]; then ##Pressed 'Okay' Computer Maintenance Menu
	    case $CHOICE in ##Choice in Maintenance Menu
		  1) ##UPDATE/UPGRADE
		  TITLE="PMP - 0.0.13"
		  dialog \
		  --title "$TITLE" \
		  --backtitle "$BACKTITLE / Update" \
		  --yesno "do you want to Upgrade your System?" 6 35
		      if [ "$?" -eq 0 ]; then ##YESNO Question Update
		  clear
		  printf "==========================================\n";
		  printf "| Updating System                        |\n";
		  printf "==========================================\n";
		  sudo apt-get update && sudo apt-get dist-upgrade && sudo update-grub
		  printf "\nPress Enter to Return to the Program\n"
		  read
		      elif [ "$?" -eq 1 ]; then ##YESNO Question Update
		  dialog \
		  --infobox "cancelled..." 3 15
		  sleep 1
		      fi
		  ;;
		  2) ##Auto-Remove
		  dialog \
		  --title "Auto-Remove" \
		  --backtitle "PMP v.0.0.13 by Kali_Yuga / Computer Maintenance / Auto-Remove" \
		  --yesno "Remove unnecessary files?" 5 31
		      if [ $? -eq 0 ]; then ##YESNO Question
		  clear
		  printf "==========================================\n";
		  printf "|                Autoremove              |\n";
		  printf "==========================================\n";
		  sudo apt-get autoremove
		  printf "\nPress Enter to Return to the Program\n"
		  read
		      elif [ $? -eq 1 ]; then ##YESNO Question
		  dialog \
		  --title "Auto-Remove" \
		  --backtitle "PMP v.0.0.13 by Kali_Yuga / Computer Maintenance / Auto-Remove" \
		  --infobox "cancelled..." 3 20
		  sleep 1
		      fi
		  ;;
		  3) ##Autoclean
		  clear
		  printf "==========================================\n";
		  printf "|                 Autoclean 	         |\n";
		  printf "==========================================\n";
		  printf "'starting sudo'...\n";
		  sudo apt-get autoclean
		  printf "please wait...\n"
		  let x=5;while [ $x -gt 0 ];do echo "$x";let x=$x-1;sleep 1;done
		  ;;
		  4) ##Update Grub-Bootloader
		  clear
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
		  5) ##Kernel-Remover
		  while [[ 1 ]]
		  do
		  HEIGHT=14
		  WIDTH=45
		  CHOICE_HEIGHT=6
		  BACKTITLE="PMP v.0.0.13 by Kali_Yuga / Computer Maintenance / Kernel Remover"
		  TITLE="Kernel Remover 0.0.3"
		  MENU="Please choose one of the following Options:"
		  OPTIONS=(1 "Remove Kernel Images"
		     2 "Show all Kernel Images"
		     3 "Show removable Kernel Images"
		     4 "Force Remove Kernels"
		     5 "Understanding Package States"
		     6 "Help")
		  CHOICE=$(dialog --clear \
			--backtitle "$BACKTITLE" \
			--title "$TITLE" \
			--menu "$MENU" \
			$HEIGHT $WIDTH $CHOICE_HEIGHT \
			"${OPTIONS[@]}" \
			2>&1 >/dev/tty) ##Kernel Remover Menu
		  if [ "$?" -eq 0 ]; then ##Pressed Okay in Kernel-Remover
		    case $CHOICE in
			1) ##Remove Kernel Images
			x=$(dpkg --list | grep -i linux-image | grep ^rc| awk '{ print $2}')
			clear
			    dialog --clear \
			    --backtitle "$BACKTITLE / Remove Kernel Images" \
			    --title "$TITLE" \
			    --msgbox "Listed kernels & config files can be removed.\nYou have no unused Linux Kernel or config files,\nif field below is empty!\n========================================================\n$x" 18 60
			    dialog --clear \
			    --backtitle "$BACKTITLE / Remove Kernel Images" \
			    --title "$TITLE" \
			    --yesno "Do you want to remove previous shown Kernel Images & Configuration Files?" 7 40
			if [ "$?" -eq 0 ]; then ##YESNO Remove Kernel Images YES
			    clear
			    sudo apt-get --purge remove $x
			    dialog --clear \
			    --backtitle "$BACKTITLE / Remove Kernel Images" \
			    --title "$TITLE" \
			    --infobox "All Old Kernel Images & Configuration Files listed as 'rc' have been removed, please wait..." 9 20
			    sleep 3;
			    clear
			elif [ "$?" -eq 1 ]; then ##YESNO Remove Kernel Images NO
			    clear
			fi
			;;
			2) ##Show all Kernel Images
			dpkg --list | grep linux-image > /tmp/space.txt
			dialog --clear \
			--backtitle "$BACKTITLE / All Kernel Images & Configuration files" \
			--title "$TITLE" \
			--textbox /tmp/space.txt 18 70
			clear;
			;;
			3) ##Show removable Kernel Images
			x=$(dpkg --list | grep -i linux-image | grep ^rc| awk '{ print $2}')
			printf "You have no unused Linux Kernel or config files,\nif field below is empty!:\n-------------------------------------------------------\n$x" > /tmp/space.txt
			clear
			dialog --clear \
			--backtitle "$BACKTITLE / Removable Kernel Images & Configuration Files" \
			--title "$TITLE" \
			--textbox /tmp/space.txt 18 70
			clear;
			;;
			4)
			while [[ 1 ]]
			do
			HEIGHT=12
			WIDTH=38
			CHOICE_HEIGHT=2
			BACKTITLE="$BACKTITLE"
			TITLE="$TITLE"
			MENU="Please choose one of the following Options:"
			OPTIONS=(1 "Show unused Kernels"
				 2 "Remove unused Kernels")
			CHOICE=$(dialog --clear \
			--backtitle "$BACKTITLE" \
			--title "$TITLE" \
			--menu "$MENU" \
			$HEIGHT $WIDTH $CHOICE_HEIGHT \
			"${OPTIONS[@]}" \
			2>&1 >/dev/tty) ##Kernel Remover Menu
			if [ "$?" -eq 0 ]; then ##Okay in Force Kernel-Remover
			  case $CHOICE in
			    1)
			      printf "Make sure your current running Kernel is not on this list!\n----------------------------------------------------------\n" > /tmp/space.txt
			      dpkg -l linux-{image,headers}-"[0-9]*" | awk '/^ii/{ print $2}' | grep -v -e `uname -r | cut -f1,2 -d"-"` | grep -e '[0-9]' >> /tmp/space.txt
			      dialog --clear \
				     --backtitle "$BACKTITLE / Show unused Kernel" \
				     --title "$TITLE" \
				     --textbox /tmp/space.txt 15 65
			    ;;
			    2)
			    Kernel=$(uname -r)
			    dialog --clear \
				   --backtitle "$BACKTITLE" \
				   --title "$TITLE" \
				   --yesno "This Option will remove all Kernel Images besides the current Kernel.\nOnly '$Kernel' will remain!\nAre you sure you want to Continue?" 8 45
			    if [ "$?" -eq 0 ]; then ##Yes in Force Kernel-Remover
			      clear
			      dpkg -l linux-{image,headers}-"[0-9]*" | awk '/^ii/{ print $2}' | grep -v -e `uname -r | cut -f1,2 -d"-"` | grep -e '[0-9]' | xargs sudo apt-get -y purge
			      printf "\nPress Enter to Return to the Program\n"
			      read
			    elif [ "$?" -eq 1 ]; then ##No in Force Kernel-Remover
			      dialog \
			      --infobox "cancelled..." 3 15
			    sleep 1
			    clear;
			    fi
			    ;;
			  esac
			elif [ "$?" -eq 1 ]; then ##Cancel in Force Kernel-Remover
			break
			fi
			done
			;;
			5)
			##Understanding Package States
			dialog --clear \
			--title "$TITLE Info" \
			--backtitle "$BACKTITLE / Understanding Package States" \
			--msgbox "Understanding package states in Ubuntu and Debian Linux\n-------------------------------------------------------\n\nrc: It means package is in remove/deinstall state and only config file exists.\n\n-----\n\nii: It means package is in install state and it is 100% installed on the system" 15 70
			clear;
			;;
			6) ##Kernel Remover Help
			printf "Kernel Remover Help - TIP: Use Page Up & Page Down or the arrow keys to Scroll\n-------------------------------------------------------\n\nOption 1, Remove Kernel Images:\n\nFirst, a Window Displays all Kernel Images & Configuration Files\nthat can be removed.\nA question Window will pop up, if you really want to remove\nthe previous listed kernel images & configuration files.\nIf you answered the question with yes,\nthe script will execute a\n'#apt-get --purge remove' command.\nThat will remove all packages that were found as 'not installed'.\nRoot privileges will be required.\nIt will prompt you for your password if you don't have privileges already.\nYou may update your Grub Bootloader after running this,\nso all your boot files are set for your next reboot.\nThis script will not update your boot configuration file!!\n--------------------\n\nOption 2, Show all Kernel Images:\n\nDisplays all Kernel Images & Configuration Files\nwith the respective install state displayed on the left as 'ii'\nor 'rc'.\n--------------------\n\nOption 3, Show removable Kernel Images:\n\nDisplays all Kernel Images & Configuration Files listed as\nnot installed and shown as 'rc' in Option 2,\nand are able to remove.\n--------------------\n\nOption 4, Force Kernel Remover:\n\nRemoves all Kernel Images besides the one currently in use\nindependent of their install state.\nUseful to clean up the /boot partition.\n--------------------\n\nOption 5, Understanding package states in Ubuntu and Debian Linux:\n\nDisplays a short Information about what package states are.\n--------------------\nNo Warranty whatsoever!" 18 70 > /tmp/space.txt
			dialog --clear \
			--backtitle "$BACKTITLE / Removable Kernel Images & Configuration Files" \
			--title "$TITLE" \
			--textbox /tmp/space.txt 18 70
			clear;
			;;
		    esac
		  elif [ "$?" -eq 1 ]; then ##Pressed Cancel in Kernel-Remover
		  break
		  fi
		    done ## End while loop Kernel remover
		  ;;
		  6) ## 'Install Software' Computer Maintenance
		      TITLE="PMP v0.0.13 - Install Software"
		      PROGRAM=$(dialog \
		      --title "$TITLE" \
		      --backtitle "$BACKTITLE / Install Software" \
		      --stdout \
		      --inputbox "Type in a Software Name to install something:" 7 40) ;
		  if [ "$?" -eq 0 ]; then
		      clear
		  sudo apt-get install $PROGRAM
		  printf "\nPress Enter to Return to the Program\n"
		  read
		      elif [ "$?" -eq 1 ]; then
		      dialog \
		      --infobox "cancelled..." 3 15
		  sleep 1
		  fi
		  ;;
		  7) ##Remove Software
		  TITLE="PMP v0.0.13 - Remove Software"
		  PROGRAM=$(dialog \
		  --title "$TITLE" \
		  --backtitle "$BACKTITLE / Remove Software" \
		  --stdout \
		  --inputbox "Type in a Software Name to remove something:" 7 40) ;
		  if [ "$?" -eq 0 ]; then ##inputbox Okay
		      dialog --clear \
			     --title "$TITLE" \
			     --backtitle "$BACKTITLE / Remove Software" \
			     --yesno "Do you really want to remove $PROGRAM ?" 6 30 ;
			  if [ "$?" -eq 0 ]; then ##YESNO Remove Software YES
			  clear
			  sudo apt-get remove --purge $PROGRAM
			  printf "\nPress Enter to Return to the Program\n"
			  read
			  elif [ "$?" -eq 1 ]; then ##YESNO Remove Software NO
			  dialog \
			  --infobox "cancelled..." 3 15
			  sleep 1
			  fi
		  elif [ "$?" -eq 1 ]; then ##inputbox Cancel
		  dialog \
		      --infobox "cancelled..." 3 15
		  sleep 1
		  fi
		  ;;
		  8) ##Search Repository and Install Software
		  while [[ 1 ]]
		  do
		    clear;
		    HEIGHT=10
		    WIDTH=35
		    CHOICE_HEIGHT=2
		    BACKTITLE="PMP v.0.0.13 by Kali_Yuga / Computer Maintenance / Search & Install Software"
		    TITLE="Search & Install Software"
		    MENU="Please choose one of the following Options:"
		    OPTIONS=(1 "Search for Software"
				 2 "Install Software")
			CHOICE=$(dialog --clear \
			--backtitle "$BACKTITLE" \
			--title "$TITLE" \
			--menu "$MENU" \
			$HEIGHT $WIDTH $CHOICE_HEIGHT \
			"${OPTIONS[@]}" \
			2>&1 >/dev/tty) ##Search & Install Menu
		  if [ "$?" -eq 0 ]; then ##Pressed Okay in search & install software
			clear
		  case $CHOICE in
		    1) ##Search Repository
			FILE=$(dialog --clear \
			--title "Search" \
			--stdout \
			--backtitle "$BACKTITLE / Search Repository" \
			--inputbox "Search the Repository for Programs:"  7 40) ;
		  if [ "$?" -eq 0 ]; then
			  printf "TIP - Use the arrow keys 'up, down, left & right' to scroll, if writing exceeds window!\n------------------------------\n" > /tmp/space.txt
			  apt-cache search $FILE >> /tmp/space.txt
			  dialog --clear \
			  --backtitle "$BACKTITLE / Search Repository" \
			  --title "$TITLE" \
			  --textbox /tmp/space.txt 20 90
		  elif [ "$?" -eq 1 ]; then
			  dialog \
			  --infobox "cancelled..." 3 15
			  sleep 1
		  fi
			;;
		    2) ##Install Software
			INSTL=$(dialog --clear \
			--title "Search" \
			--stdout \
			--backtitle "$BACKTITLE / Install Software" \
			--inputbox "Type in a Software Name to install something:"  7 40) ;
			if [ "$?" -eq 0 ]; then ##inputbox Okay
			    clear
			    dialog \
			      --title "$TITLE" \
			      --backtitle "$BACKTITLE / Remove Software" \
			      --yesno "Do you really want to install\n$INSTL ?" 7 30 ;
			      if [ "$?" -eq 0 ]; then ##YESNO Install YES
				clear
				sudo apt-get install $INSTL
				printf "\nPress Enter to Return to the Program\n"
				read
			      elif [ "$?" -eq 1 ]; then ##YESNO Install NO
				dialog \
			      --infobox "cancelled..." 3 15
			      sleep 1
			      fi ##YESNO end 
			elif [ "$?" -eq 1 ]; then ##inputbox cancel
			    dialog \
			      --infobox "cancelled..." 3 15
			    sleep 1
			fi ##inputbox end
			;;
		    esac
		  elif [ "$?" -eq 1 ]; then ##inputbox Cancel
			  break
		  fi
		  done
		  ;;
		  9) ## Nvidia Driver Manager
		  while [[ 1 ]]
		  do
		  BACKTITLE="PMP v.0.0.13 by Kali_Yuga / Computer Maintenance / Nvidia Driver Manager"
		  HEIGHT=14
		  WIDTH=40
		  CHOICE_HEIGHT=5
		  TITLE="$TITLE"
		  MENU="Select one:"
		  OPTIONS=(1 "Show Installed Driver"
			   2 "Available Nvidia Driver"
			   3 "Install Nvidia Driver"
			   4 "Remove all Nvidia Driver"
			   5 "Help"
			   6 "Switch GPU *ONLY NVIDIA PRIME")
		  CHOICE=$(dialog --clear \
		  --backtitle "$BACKTITLE" \
		  --title "$TITLE" \
		  --menu "$MENU" \
		  $HEIGHT $WIDTH $CHOICE_HEIGHT \
		  "${OPTIONS[@]}" \
		  2>&1 >/dev/tty)
		  if [ "$?" -eq 0 ]; then
		      case $CHOICE in
		      1) ##Show Installed Driver
		      dpkg -l | grep nvidia > /tmp/space.txt
		      dialog --clear \
		      --backtitle "$BACKTITLE / Installed Driver" \
		      --title "$TITLE" \
		      --textbox /tmp/space.txt 15 75
		      ;;
		      2) ##Available Nvidia Driver
		      apt-cache search nvidia | grep -P '^nvidia-[0-9]+\s' > '/tmp/space.txt'
		      dialog --clear \
		      --backtitle "$BACKTITLE / Available Nvidia Driver" \
		      --title "$TITLE" \
		      --textbox /tmp/space.txt 20 75
		      clear
		      ;;
		      3) ##Install Nvidia Driver
		      BACKTITLE="$BACKTITLE / Install Nvidia Driver"
		      TITLE="Install Nvidia Driver"
		      dialog --clear \
		      --backtitle "$BACKTITLE" \
		      --title "Welcome" \
		      --msgbox "Only install driver,\nthat are listed under\n'Available Nvidia Driver'\nin the Nvidia Driver Manager Menu.\n\nAdministrative privileges are required!." 12 35
		      DRVNR=$(dialog \
		      --title "$TITLE" \
		      --backtitle "$BACKTITLE / Install Nvidia Driver" \
		      --stdout \
		      --inputbox "Type in a version number a.e, nvidia-340:" 7 40 nvidia-) ;
		      if [ "$?" -eq 0 ]; then
			      dialog \
				--title "$TITLE" \
				--backtitle "$BACKTITLE" \
				--yesno "Sure you want to install $DRVNR ?" 6 35 ##YESNO Nvidia driver
			    if [ "$?" -eq 0 ]; then ##YES Nvidia
				sudo apt-get install $DRVNR
				printf "\nPress Enter to Return to the Program\n"
				read
			    elif [ "$?" -eq 1 ]; then ##NO Nvidia
				dialog \
				--infobox "cancelled..." 3 15
			    sleep 1
			    fi
		      elif [ "$?" -eq 1 ]; then
			  dialog \
			  --infobox "cancelled..." 3 15
			    sleep 1
		      fi
		      ;;
		      4) ##Remove Nvidia Driver
		      BACKTITLE="$BACKTITLE / Remove Nvidia Driver"
		      TITLE="Remove Nvidia Driver"
		      dialog --clear \
		      --backtitle "$BACKTITLE" \
		      --title "Warning!" \
		      --msgbox "This Option will delete all Nvidia driver installed on the System!.\n\nAdministrative privileges are required!." 10 35
		      printf "Listing all currently installed Nvidia driver once more:\n\n" > /tmp/space.txt
		      dpkg -l | grep nvidia >> /tmp/space.txt
		      dialog --clear \
		      --backtitle "$BACKTITLE" \
		      --title "$TITLE" \
		      --textbox /tmp/space.txt 25 80
		         dialog \
		      --title "$TITLE" \
		      --backtitle "$BACKTITLE" \
		      --yesno "Everything related to nvidia will be removed!\nAre you sure you want to continue?" 8 35
		      if [ "$?" -eq 0 ]; then ##YES remove Nvidia driver
		      clear
		      sudo apt-get remove --purge nvidia-*
		      printf "\nPress Enter to Return to the Program\n"
		      read
		      elif [ "$?" -eq 1 ]; then ##NO remove Nvidia driver
		      dialog \
		      --infobox "cancelled..." 3 15
		      sleep 2
		      fi
		      ;;
		      5) ##Help
		      printf "TIP - Use Page up & Page Down or the arrow keys to scroll.\n\n1.) Show Installed Driver --\n\nWill list any Nvidia drivers installed on your system.\n--------------------\n\n2.) Available Nvidia Driver --\n\nShows Nvidia drivers you can install.\n--------------------\n\n3.) Install Nvidia Driver --\n\nBe careful which driver you choose!.\nThe higher the version number is, the newer is the driver.\nCompatibility is not always working!.\nLook under your available drivers\nand type in the version number you want to install.\nThe driver will be installed from your repository.\n--------------------\n\n4.) Remove all Nvidia Driver --\n\nIf you installed a wrong driver,\nthe computer could start with a black screen\nand nothing would show up anymore.\nIf that happens you can do the following:\nLet your system boot up normally and\njust ignore the black screen for a moment.\nPress 'Ctrl + Alt + F1'.\nThis is how you get into a Terminal called 'tty'.\nOn a regular Linux Desktop, you can usually open a tty 1-6\nwith all keys between F1 - F6 respectively.\n'Ctrl + Alt + F7' will bring you back to your Desktop.\nIt will ask you for your login details.\nIn the upper left corner type in your username\nand press Enter.\nNext, type in your normal login password.\n*You won't see the password you type,\nbut it's beeing registered.\nWhen you are logged in, you have control over your terminal.\nNow you can remove the non working driver with:\n\n          sudo apt-get remove --purge nvidia-*\n-To remove everything from Nvidia.\n\n-Or define the version number a.e:\n          sudo apt-get remove --purge nvidia-340\n\nYou can also follow these steps and open this program\nin your tty!.\nwith ./PMP0.0.13.sh and choose Option 4\n'Remove Nvidia driver'\nto remove any Nvidia drivers you have installed." > /tmp/space.txt
		      dialog --clear \
			     --title "Nvidia Driver Manager - Help" \
			     --backtitle "$BACKTITLE" \
			     --textbox /tmp/space.txt 20 66
		      ;;
		      6)
		      while [[ 1 ]]
			do
		      HEIGHT=10
		      WIDTH=35
		      CHOICE_HEIGHT=3
		      BACKTITLE="$BACKTITLE / Nvidia Prime-select"
		      TITLE="PMP - Nvidia Prime-select"
		      MENU="ONLY FOR NVIDIA PRIME/OPTIMUS"
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
		      if [ "$?" -eq 0 ]; then ##Okay Nvidia Prime-select
			case $CHOICE in 
		      1) ##select Nvidia GPU
		      clear
			sudo prime-select nvidia
		      sleep 2;
			printf "You selected:"
		      prime-select query
		      ;;
		      2) ##select Intel GPU
		     clear
			sudo prime-select intel
		     sleep 2;
			printf "You selected:"
		      prime-select query
		      ;;
		      3) ##Currently running
		      prime-select query > '/tmp/space.txt'
			dialog --backtitle "$BACKTITLE / Currently running" \
			--textbox /tmp/space.txt 5 20
		      clear
		    ;;
			esac
		      elif [ "$?" -eq 1 ]; then ##Cancel Nvidia Prime-select
		    clear
		  break
		      fi
                done
		      esac ##end Nvidia Driver Manager menu
		  elif [ "$?" -eq 1 ]; then
		  break
		  fi
		  done
		  ;;
		  10) ##Next Page
		  while [[ 1 ]]
		      do
		      clear
		      HEIGHT=17
		      WIDTH=40
		      CHOICE_HEIGHT=2
		      BACKTITLE="PMP v.0.0.13 by Kali_Yuga / Computer Maintenance"
		      TITLE="PMP - Get Support"
		      MENU="Select one of the following Options:"

		      OPTIONS=(1 "Find Linux Support"
				2 "Program Problem detected FIX")

		      CHOICE=$(dialog --clear \
				    --backtitle "$BACKTITLE" \
				  --title "$TITLE" \
				  --menu "$MENU" \
		      $HEIGHT $WIDTH $CHOICE_HEIGHT \
		      "${OPTIONS[@]}" \
		      2>&1 >/dev/tty) ##Main Menu
		      if [ "$?" -eq 0 ]; then ## Okay Computer Maintenance 
			  case $CHOICE in
			  1) ##Get Support
			    while [[ 1 ]]
			    do
			      HEIGHT=13
			      WIDTH=35
			      CHOICE_HEIGHT=4
			      BACKTITLE="PMP v.0.0.13 by Kali_Yuga / Computer Maintenance / Find Linux Support"
			      TITLE="$TITLE"
			      MENU="Select one:"
			      OPTIONS=(1 "Connect to Freenode"
				    2 "How to Register"
				    3 "Freenode Channel list"
				    4 "Install IRC Client")
			      CHOICE=$(dialog --clear \
			      --backtitle "$BACKTITLE" \
			      --title "$TITLE" \
			      --menu "$MENU" \
			      $HEIGHT $WIDTH $CHOICE_HEIGHT \
			      "${OPTIONS[@]}" \
			      2>&1 >/dev/tty)
			      if [ "$?" -eq 0 ]; then ##'Okay' Find Support on Freenode
				  case $CHOICE in
				      1) ##Connect to Freenode
				      SERVER="irc.freenode.net"
				      PORT=6667
				      CHANNEL="#Ubuntu"
				      NICK=$(dialog \
				      --title "$TITLE" \
				      --backtitle "$BACKTITLE / Connect to freenode" \
				      --stdout \
				      --inputbox "Type in your Nickname:" 7 40)
					  if [ "$?" -eq 0 ]; then ##Okay Nickname
						PW=$(dialog \
						      --title "$TITLE" \
						      --backtitle "$BACKTITLE / Connect to freenode" \
						      --stdout \
						      --insecure \
						      --passwordbox "freenode.net password:" 7 40)
						      if [ "$?" -eq 0 ]; then ##Okay Password
							  irssi --connect=$SERVER --password=$PW --port=$PORT --nick=$NICK
						      elif [ "$?" -eq 1 ]; then ##Cancel Password
							  dialog \
							  --infobox "cancelled..." 3 15
							  sleep 2
						      fi ##End freenode Password
					  elif [ "$?" -eq 1 ]; then ##Cancel Nickname
					  dialog \
					    --infobox "cancelled..." 3 15
					    sleep 2
					  fi ## end Nickname Freenode
				      ;;
				      2) ##How to Register
					  printf "Leave the password field blank and type:\n\n/msg NickServ REGISTER password youremail@example.com\n\ninto Irssi to register an account on freenode.\nYou need to verify your e-mail address\nbefore you are able to log in.\n\nyou can find more information here:\n'https://freenode.net/kb/answer/registration" > /tmp/space.txt
					  dialog \
					  --title "$TITLE" \
					  --backtitle "$BACKTITLE / How to Register" \
					  --textbox /tmp/space.txt 14 58
					clear
				      ;;
				      3)
				      printf "TIP - Use Page up & Page Down or the arrow keys to scroll:\nTo join channels,\nuse: /join #channelname\nHere are some support channels for Linux:\n---------------------------------------------------------------\n##Linux      General Linux support channel.\n#debian      Debian help channel\n#ubuntu      Ubuntu help channel\n#kubuntu     Kubuntu help channel\n#xubuntu     Xubuntu help channel\n#lubuntu     Lubuntu help channel\n#edubuntu    Edubuntu help channel\nFind even more Ubuntu Support Channels near you at:\nhttps://wiki.ubuntu.com/IRC/ChannelList\n---------------------------------------------------------------\n" > /tmp/space.txt
				      dialog --clear \
					     --title "$TITLE" \
					     --backtitle "$BACKTITLE / Freenode Channel list" \
					     --textbox /tmp/space.txt 20 65
				      ;;
				      4)
				      dialog --clear \
					     --title "$TITLE" \
					     --backtitle "$BACKTITLE / Install IRC Client" \
					     --yesno "You are about to install the IRC Client 'Irssi' from the Repositories.\nDo you wish to Continue?" 8 35
					  if [ "$?" -eq 0 ]; then ##YES Install Irssi
					    clear
					    sudo apt-get install irssi
					  elif [ "$?" -eq 1 ]; then ##NO Install Irssi
					    dialog --infobox "cancelled..." 3 15
					      sleep 2
					  fi
				      ;;
				  esac
			      elif [ "$?" -eq 1 ]; then ##'Cancel' Find Support on Freenode
				  break
			      fi
			     done
			  ;;
			  2) ##Program Problem detected FIX
			  clear
			  printf "==========================================\n";
			  printf "|   System Program Problem detected FIX  |\n";
			  printf "==========================================\n";
			  sudo rm /var/crash/*
			  sleep 1;
			  clear;
			  ;;
			  esac
		      elif [ "$?" -eq 1 ]; then ##Cancel Computer Maintenance 
		      clear
		      break
		      fi
		      done
		      ;;
    esac ## end statement Menu Options Computer Maintenance
	elif [ "$?" -eq 1 ]; then ##CANCEL Computer Maintenance Menu
		break
	fi
	done ##end Computer Maintenance Menu
	;;
        2) ##System Monitor
	while [[ 1 ]]
	do
	    clear
	    HEIGHT=18
	    WIDTH=40
	    CHOICE_HEIGHT=10
	    BACKTITLE="PMP v.0.0.13 by Kali_Yuga / System Monitor"
	    TITLE="PMP System Monitor 0.0.2"
	    MENU="Select one of the following Options:"

	    OPTIONS=(1 "Disk Space"
		     2 "USB Devices"
		     3 "PCI / Graphics Card Info"
		     4 "RAM Info"
		     5 "Process Manager"
		     6 "Battery/Power Info"
		     7 "CPU Info"
		     8 "Network Info"
		     9 "Kernel Info"
		     10 "Next Page →")

	    MENU=$(dialog --clear \
                --backtitle "$BACKTITLE" \
                --title "$TITLE" \
                --menu "$MENU" \
                $HEIGHT $WIDTH $CHOICE_HEIGHT \
                "${OPTIONS[@]}" \
                2>&1 >/dev/tty)
		if [ "$?" -eq 0 ]; then ##Okay System Monitor
		    case $MENU in
		    1) ##Disk Space
		    df -h > '/tmp/space.txt'
		    dialog --clear \
		    --backtitle "$BACKTITLE / Disk Space" \
		    --title "$TITLE" \
		    --textbox /tmp/space.txt 20 75
		    clear
		    ;;
		    2) ##USB Devices
		    lsusb > '/tmp/space.txt'
		    dialog --clear \
		    --backtitle "$BACKTITLE / Connected USB Devices" \
		    --title "USB Devices" \
		    --textbox /tmp/space.txt 20 85
		    clear 
		    ;;
		    3) ##PCI
		    printf "TIP - You can use arrow keys 'up, down, left & right' to scroll!\n" > /tmp/space.txt
		    lspci >> '/tmp/space.txt'
		    dialog --clear \
		    --backtitle "$BACKTITLE / PCI & Graphics Card Information" \
		    --title "PCI Devices" \
		    --textbox /tmp/space.txt 20 150
		    clear
		    ;;
		    4) ##RAM
		    free -m > '/tmp/space.txt'
		    dialog --clear \
		    --backtitle "$BACKTITLE / RAM Information" \
		    --title "Memory Information" \
		    --textbox /tmp/space.txt 10 70
		    clear
		    ;;
		    5) ##process Manager
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
		    clear
		    printf "==============================\n";
		    printf "|	  Good Bye           |\n";
		    printf "==============================\n";
		    sleep 2
		    break
		    esac
		    done
		    ;;
		    6)
		    while [[ 1 ]]
		    do
		      HEIGHT=12
		      WIDTH=40
		      CHOICE_HEIGHT=3
		      TITLE="$TITLE"
		      MENU="Select one:"
		      OPTIONS=(1 "Install acpi"
			    2 "Power Status"
			    3 "Show more Info")
		      CHOICE=$(dialog --clear \
		      --backtitle "PMP v.0.0.13 by Kali_Yuga / System Monitor / Battery & Power Info" \
		      --title "$TITLE" \
		      --menu "$MENU" \
		      $HEIGHT $WIDTH $CHOICE_HEIGHT \
		      "${OPTIONS[@]}" \
		      2>&1 >/dev/tty)
		    if [ "$?" -eq 0 ]; then ##okay Battery & Power Info
			case $CHOICE in
			      1) ##Install ACPI
				  dialog --clear \
				      --title "$TITLE" \
				      --backtitle "PMP v.0.0.13 by Kali_Yuga / System Monitor / Battery & Power Info / Install acpi" \
				      --yesno "Do you want to install acpi?" 7 45
			      if [ "$?" -eq 0 ]; then
				      clear
				      sudo apt-get install acpi
			      elif [ "$?" -eq 1 ]; then
				  dialog --clear \
				      --title "$TITLE" \
				      --backtitle "PMP v.0.0.13 by Kali_Yuga / System Monitor / Battery & Power Info / Install acpi" \
				      --msgbox "Goodbye!" 7 45
				      clear
				 break
			      fi
			      ;;
			      2) ##Power Status
			      acpi > '/tmp/space.txt'
				  dialog --clear \
				      --backtitle "PMP v.0.0.13 by Kali_Yuga / System Monitor / Battery & Power Info / Power Status" \
				      --title "$TITLE" \
				      --textbox /tmp/space.txt 5 100
				    clear
			      ;;
			      3)
			      acpi -b -a -t > '/tmp/space.txt'
				  dialog --clear \
				      --backtitle "PMP v.0.0.13 by Kali_Yuga / System Monitor / Battery & Power Info / More Battery Information" \
				      --title "$TITLE" \
				      --textbox /tmp/space.txt 8 55
				    clear
			      ;;
			esac
		    elif [ "$?" -eq 1 ]; then ##cancel Battery & Power Info
		    break
		    fi
		    done
		    ;;
		    7) ##System Monitor / CPU INFO 
		    while [[ 1 ]]
		      do
		    HEIGHT=12
		    WIDTH=40
		    CHOICE_HEIGHT=3
		    BACKTITLE="PMP v.0.0.13 by Kali_Yuga / System Monitor / CPU Info"
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
		    if [ "$?" -eq 0 ]; then
			case $CHOICE in 
			    1)
				  dialog --clear \
				  --backtitle "$BACKTITLE / General CPU Information" \
				  --title "$TITLE" \
				  --yesno "INFO: Root privileges required!\nDo you want to use sudo?" 7 30
			      if [ "$?" -eq 0 ]; then ##YES CPU privileges
				clear
				  sudo lshw -class processor > '/tmp/space.txt'
				  dialog --clear \
				  --backtitle "$BACKTITLE / General CPU Information" \
				  --title "$TITLE" \
				  --textbox /tmp/space.txt 25 75
			      elif [ "$?" -eq 1 ]; then ##NO CPU privileges
				  dialog \
				  --backtitle "$BACKTITLE" \
				  --infobox "cancelled..." 3 20
				sleep 1.2
			      fi
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
			;;
			esac
		    elif [ "$?" -eq 1 ]; then ##Cancel CPU Info
			clear
		    break
		    fi
		    done
		    ;;
		    8) ##Network Information
		    while [[ 1 ]]
		    do
		    HEIGHT=12
		    WIDTH=38
		    CHOICE_HEIGHT=3
		    BACKTITLE="PMP v.0.0.13 by Kali_Yuga / System Monitor / Network Information"
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
		    if [ "$?" -eq 0 ]; then ##okay Network Information
			case $MENU in
			      1)
				  printf "TIP - You can use arrow keys 'up, down, left & right' to scroll!\n" > /tmp/space.txt
				  ifconfig >> '/tmp/space.txt'
				  dialog --clear \
				  --backtitle "$BACKTITLE / IP and Mac Address" \
				  --title "$TITLE" \
				  --textbox /tmp/space.txt 20 85
				clear
			      ;;
			      2)
				  iwconfig > '/tmp/space.txt'
				  dialog --clear \
				  --backtitle "$BACKTITLE / Connection Information" \
				  --title "$TITLE" \
				  --textbox /tmp/space.txt 20 85
				clear
			      ;;
			      3)
				printf "TIP - You can use arrow keys 'up, down, left & right' to scroll!\n" > /tmp/space.txt
				  lspci | egrep -i --color 'network|ethernet' >> '/tmp/space.txt'
				  dialog --clear \
				  --backtitle "$BACKTITLE / Ethernet & Wifi Card Information" \
				  --title "Network & Ethernet info" \
				  --textbox /tmp/space.txt 10 100
				clear
			      ;;
			  esac
		      elif [ "$?" -eq 1 ]; then ##cancel Network Information
		      break
		      fi
		      done
		    ;;
		    9)
		      uname -r > '/tmp/space.txt' ##Kernel Information, current linux Kernel
			  dialog --clear \
			  --backtitle "$BACKTITLE / Kernel Information" \
			  --title "    Linux Kernel" \
			  --textbox /tmp/space.txt 5 30
		      clear
		    ;;
		    10)
		    while [[ 1 ]]
		      do
		      clear
		      HEIGHT=17
		      WIDTH=40
		      CHOICE_HEIGHT=1
		      BACKTITLE="PMP v.0.0.13 by Kali_Yuga / System Monitor"
		      TITLE="PMP - System Monitor 0.0.2"
		      MENU="Select one of the following Options:"

		      OPTIONS=(1 "Distribution Details")
		      CHOICE=$(dialog --clear \
				    --backtitle "$BACKTITLE" \
				  --title "$TITLE" \
				  --menu "$MENU" \
		      $HEIGHT $WIDTH $CHOICE_HEIGHT \
		      "${OPTIONS[@]}" \
		      2>&1 >/dev/tty) ##Main Menu
		      if [ "$?" -eq 0 ]; then ## Okay System Monitor
			case $CHOICE in
			  1)
			  uname -romi > /tmp/space.txt
			  lsb_release -a >> /tmp/space.txt
			  dialog \
			  --title "Distro Details" \
			  --backtitle "$BACKTITLE / Distribution Details" \
			  --textbox /tmp/space.txt 10 55
			  ;;
			esac
		      elif [ "$?" -eq 1 ]; then ## Cancel System Monitor
		      break
		      fi
		      done
		    ;;
		    esac
		elif [ "$?" -eq 1 ]; then ##Cancel System Monitor
		break
		fi
	done
        ;;
	3)
	    dialog \
		--title "Wine Killer" \
		--backtitle "PMP v.0.0.13 by Kali_Yuga / Kill Wine" \
		--yesno "Do you want to kill all Wine processes?" 6 31
	if [ "$?" -eq 0 ]; then
	    wineserver -k; killall -9 wine wineserver; for i in `ps ax|egrep "*\.exe"|grep -v 'egrep'|awk '{print $1 }'`;do kill -9 $i;done
	    dialog --infobox "All Wine Processes killed,\n" 4 31
	    sleep 2
	  clear
	elif [ "$?" -eq 1 ]; then
	    dialog --infobox "cancelled..." 3 16
	    sleep 2
	fi
	;;
	4)
	 clear
	   printf "==========================================\n";
	   printf "|           Ubuntu Software Center 	 |\n";
	   printf "==========================================\n";
	   printf "\n\n"
	   printf "Please wait..."
	   software-center
	;;
	5)
	while [[ 1 ]] 
	do
	    clear
	    HEIGHT=18
	    WIDTH=55
	    CHOICE_HEIGHT=10
	    BACKTITLE="PMP v.0.0.13 by Kali_Yuga / PMP Wifi"
	    TITLE="PMP Wifi v.0.0.4"
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
        if [ "$?" -eq 0 ]; then ##Okay PMP Wifi
	    case $CHOICE in
		1) ##Quick WiFi Installer
		  TITLE="PMP Wifi v.0.0.4"
		  BACKTITLE="PMP v.0.0.13 by Kali_Yuga / PMP Wifi / Quick WiFi Installer"
		    dialog \
		    --title "$TITLE" \
		    --backtitle "$BACKTITLE" \
		    --msgbox "You need to choose the '.inf ' file in the next step.\n\nExample: '/home/user/wifidriver/driver.inf'\n\nYou can find more Information under 'Help' in the Main Menu." 14 60
		  FILE=$(dialog --title "$TITLE" \
		    --backtitle "$BACKTITLE" \
		    --stdout \
		    --title "Please choose the .inf file" \
		    --fselect $HOME/  8 60) ;
		if [ "$?" -eq 0 ]; then ##Okay Fselect
			dialog \
			--title "$TITLE" \
			--backtitle "$BACKTITLE" \
			--yesno "Continue Installing this .inf file?\n\n$FILE" 10 40 ;
		    if [ "$?" -eq 0 ]; then ##nyeess Wifi driver
			clear
			printf "===================================\n";
			printf "|1. Quick WiFi Installer 0.0.4    |\n";
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
			    dialog --title "please wait..." \
			    --backtitle "$BACKTITLE" \
			    --infobox "Modprobing Driver..." 3 40;
			sleep 1
			sudo modprobe -v ndiswrapper
			clear
			    dialog \
			    --title "$TITLE" \
			    --backtitle "$BACKTITLE" \
			    --msgbox "Replug* your Wifi Stick and Wait about 20 seconds to test your WiFi Stick.\n\nIs your Wifi still not functioning?\nyou might have installed the wrong .inf driver...\n\nUse 'Option 7. 'Delete Ndiswrapper driver' in PMP WiFi v.0.0.4\nto delete any drivers.\n\nAfter pressing 'OK', the driver status will be displayed." 15 80
			clear
			printf "The Driver status below must display,\n'driver installed' to work properly!:\n=====================================\n\n" > /tmp/space.txt
			sudo ndiswrapper -l >> /tmp/space.txt ##Driver Status
			    dialog \
			    --title "$TITLE" \
			    --backtitle "$BACKTITLE" \
			    --textbox /tmp/space.txt 12 45
			clear
		    elif [ "$?" -eq 1 ]; then ##No Wifi driver
			    dialog \
			  --title "$TITLE" \
			  --backtitle "$BACKTITLE" \
			  --msgbox "You will need an .inf file to install any Wifi Drivers.\n\nRestart the program and give it the right path.\n\nGoodbye." 12 40
		    fi
		elif [ "$?" -eq 1 ]; then ##Okay Fselect
		    dialog --infobox "cancelled..." 3 16
		fi
		;;
		2) ##Installing Driver Utilities
		TITLE="PMP Wifi v.0.0.4"
		BACKTITLE="PMP v.0.0.13 by Kali_Yuga / PMP Wifi / Installing Driver Utilities"
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
		    --infobox "You cancelled the Ndiswrapper Installation.\nplease wait..." 5 30
		sleep 3
		clear
		fi
		;;
		3) ##Install WiFi Driver
		TITLE="PMP Wifi v.0.0.4"
		BACKTITLE="PMP v.0.0.13 by Kali_Yuga / PMP Wifi / Install WiFi Driver"
		    dialog \
		    --title "$TITLE" \
		    --backtitle "$BACKTITLE" \
		    --msgbox "Please choose the .inf file in the next step,\nExample: /home/user/wifidriver/driver.inf\n\nYou can find more Information under 'Help' in the PMP WiFi Menu.\n\nINFO: Be sure to get your driver in the right Architecture 32 or 64 bit!" 13 50
		FILE=$(dialog \
		    --title "$TITLE" \
		    --backtitle "$BACKTITLE" \
		    --stdout \
		    --title "Please choose the .inf file" \
		    --fselect $HOME/  15 70)
		if [ "$?" -eq 0 ]; then ##Fselect Install WiFi Driver YES
			dialog \
			--title "$TITLE" \
			--backtitle "$BACKTITLE" \
			--yesno "Continue Installing this .inf file?\n\n\n$FILE ?" 10 40
		    if [ "$?" -eq 0 ]; then ##YES .inf driver
			dialog \
			--title "$TITLE" \
			--backtitle "$BACKTITLE" \
			--pause "starting sudo\nPlease Wait..." 10 30 3
			clear
		    printf "===================================\n";
		    printf "|3. Install a Driver		  |\n";
		    printf "===================================\n";
			sudo ndiswrapper -i $FILE
		    let x=5;while [ $x -gt 0 ];do echo "$x";let x=$x-1;sleep 1;done
			clear
		    printf "The Driver status shown below\nmust display: 'driver installed'\nto work properly!:\n=====================================\n\n" > /tmp/space.txt
			sudo ndiswrapper -l >> /tmp/space.txt ##Driver Status
			dialog \
			--title "$TITLE" \
			--backtitle "$BACKTITLE" \
			--textbox /tmp/space.txt 11 40
			clear
			dialog \
			--title "$TITLE" \
			--backtitle "$BACKTITLE" \
			--infobox "please wait..." 3 20
		sleep 3
		    elif [ "$?" -eq 1 ]; then ##NO .inf driver
			dialog --title "$TITLE" --backtitle "$BACKTITLE" --msgbox "You will need the .inf file to install any Wifi Drivers.\n\nPlease restart the program and give it the right path to the .inf File" 9 40
		    clear
		    fi
		elif [ "$?" -eq 1 ]; then ##Fselect Install WiFi Driver NO
		    dialog \
		    --backtitle "$BACKTITLE" \
		    --infobox "cancelled..." 3 16
			  sleep 1.2
		fi
		;;
		4) ##Driver Configuration
		x=$(ls -rl /etc/ndiswrapper/*/* > /tmp/space.txt)
		    dialog \
		    --title "Driver Configuration" \
		    --backtitle "PMP v.0.0.13 by Kali_Yuga / PMP Wifi / Driver Configuration" \
		    --textbox /tmp/space.txt 20 100
		;;
		5) ##Set Ndiswrapper to Startup
		TITLE="PMP Wifi v.0.0.4"
		BACKTITLE="PMP v.0.0.13 by Kali_Yuga / PMP Wifi / Set Ndiswrapper to Startup"
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
		elif [ "$?" -eq 1 ]; then
		    dialog --title "$TITLE" --backtitle "$BACKTITLE" --infobox "cancelled..." 3 16
		    sleep 3
		  clear
		fi
		;;
		6) ##Load Ndiswrapper Module
		TITLE="PMP Wifi v.0.0.4"
		BACKTITLE="PMP v.0.0.13 by Kali_Yuga / PMP Wifi / Load Ndiswrapper Module"
		    dialog \
		    --title "$TITLE" \
		    --backtitle "$BACKTITLE" \
		    --yesno "Do you want to start the Ndiswrapper Module?" 6 30
		if [ "$?" -eq 0 ]; then ##Yes Modprobe
		    clear
		    printf "==========================================\n";
		    printf "|6. Load Ndiswrapper Module              |\n";
		    printf "==========================================\n";
		    printf "starting sudo...\n"
		    sudo modprobe -v ndiswrapper
		elif [ "$?" -eq 1 ]; then ##No Modprobe
		    dialog --title "$TITLE" --backtitle "$BACKTITLE" --infobox "cancelled..." 3 16
		  sleep 3
		clear
		fi
		;;
		7) ##Remove WiFi driver
		TITLE="PMP Wifi v.0.0.4"
		BACKTITLE="PMP v.0.0.13 by Kali_Yuga / PMP Wifi / Remove WiFi driver"
		   clear
		ndiswrapper -l > /tmp/space.txt
		x=$(cat /tmp/space.txt | awk  '{print $1}')
		    dialog \
		    --title "$TITLE" \
		    --backtitle "$BACKTITLE" \
		    --yesno "Do you want to delete the installed Wifi Driver:\n====================\n$x\n====================\n?" 10 35
		if [ "$?" -eq 0 ]; then ##Yes Remove Wifi driver
			dialog \
			--title "$TITLE" \
			--backtitle "$BACKTITLE" \
			--pause "starting sudo..." 8 35 3
		    clear
		    sudo ndiswrapper -r $x
		    clear
			dialog \
			--title "$TITLE" \
			--backtitle "$BACKTITLE" \
			--infobox "$x was removed.\nplease wait..." 4 30
		  sleep 3
		    clear
		elif [ "$?" -eq 1 ]; then ##No Remove Wifi driver
			 dialog \
			  --backtitle "$BACKTITLE" \
			  --infobox "cancelled..." 3 16
			  sleep 1.2
		fi
		;;
		8) ##Remove Driver Utilities
		TITLE="PMP Wifi v.0.0.4"
		BACKTITLE="PMP v.0.0.13 by Kali_Yuga / PMP Wifi / Remove Driver Utilities"
			dialog \
			--title "$TITLE" \
			--backtitle "$BACKTITLE" \
			--yesno "Do you want to remove the Ndiswrapper Utility completely from your system?" 6 50
		if [ "$?" -eq 0 ]; then ##YES Remove Ndiswrapper
		    clear
		  printf "==============================\n";
		  printf "|8. Remove Ndiswrapper       |\n"
		  printf "==============================\n";
		    sudo apt-get remove --purge ndiswrapper*
		  let x=5;while [ $x -gt 0 ];do echo "$x";let x=$x-1;sleep 1;done
			dialog  \
			--title "$TITLE" \
			--backtitle "$BACKTITLE" \
			--msgbox "DONE!.\n\nTo clear all configuration files, check /etc/ndiswrapper/ or use Option 7 in the PMP Wifi menu." 10 40
		    clear
		elif [ "$?" -eq 1 ]; then ##NO Remove Ndiswrapper
			dialog --title "$TITLE" \
			--backtitle "$BACKTITLE" \
			--infobox "cancelled...." 3 16
		  sleep 1.2
		clear
		fi
		;;
		9) ##HELP PMP WIFI
		 printf "PMP WiFi Help - TIP - You can use the arrow keys to scroll!\n==============================\n|1.Tutorial: GET A DRIVER!!! |\n==============================\n\n============================================================================\nIMPORTANT INFO: The .inf file holds all the necessary driver information!!!.\n============================================================================\n\n1.) Make a New Folder in /Home\n2.) Download a Microsoft Windows® Wifi driver for your Wifi USB Stick to the\n    New Folder we've just created\n3.) Extract the Windows .exe in your new Folder\n4.) There should be an .inf and the .sys File located in your folder!\n\n5.) Remember the path to the .inf file somewhere\nExample: '/home/user/wifidriver/driverexample.inf'\n\nINFO: Be sure to get your Driver in the right Architecture 32bit or 64bit\n\nIf you installed a wrong Driver,\nchoose,\nOption 7) -- Delete Ndiswrapper driver\nto delete any Drivers Installed\n\n==============================\n|2. Options                  |\n==============================\n\n=======================================================\nOption 1) -- Quick WiFi Installer <---recommended if unsure.\nInsert the .inf path of your driver and Press install.\nEverything will be installed and loaded in one rush.\nA Lan connection is required.\nDon't have a driver preinstalled when running this!\n=======================================================\n\n=======================================================\nOption 2) -- Install Driver Utilities\nInstall's the Driver Utility, Ndiswrapper from the repository.\n=======================================================\n\n=======================================================\nOption 3) -- Install Wifi Driver\nIs the Driver Installation Process\nFollow the Tutorial 1 GET A DRIVER\nKeep your .inf File ready!!!\nYou will need to specify the .inf path there\nExample: /home/user/wifidriver/driverexample.inf\n=======================================================\n\n=======================================================\nOption 4) -- Show Driver configuration\nShows you the current Driver Configuration you have Installed\n=======================================================\n\n=======================================================\nOption 5) -- Add Driver to Startup\nSet's Ndiswrapper as a Start-up Program.\nThen your Driver will start automatically\nwhen your system boot's up\n=======================================================\n\n=======================================================\nOption 6) -- Start Driver  \nStarts Ndiswrapper and it's Drivers.\nYou will need to 'replug' your stick and wait about 20 seconds\nafter you loaded the ndiswrapper module.\nDon't worry, It will spit out a notification.\nMake sure your Wifi Stick is inserted\nand Drivers are installed before executing this Option.\n=======================================================\n\n=======================================================\nOption 7) -- Remove Wifi Driver  \nWill Delete installed drivers.\nYou will be promted for a password.\nThe removable driver will be shown in a field.\n=======================================================\n\n=======================================================\nOption 8) -- Remove Driver Utilities\nWill remove Ndistwrapper from your system.\n=======================================================\n\n=======================================================\nOption 9) -- Help\nIs the Section you are currently reading.\n=======================================================\n\n=======================================================\nOption 10) -- About\nAbout PMP.\n=======================================================\n\n=======================================================\nOption 11) -- Exit\nExit's PMP.\n=======================================================\n" > /tmp/space.txt
		 dialog \
		 --backtitle "$BACKTITLE /HELP" \
		 --title "HELP" \
		 --colors \
		 --textbox /tmp/space.txt 25 80
		clear
		;;
		10) ##About PMP Wifi
		printf "PMP WiFi 0.0.4\nPersonal Maintain Program\nver. 0.0.13\n\nwritten by Kali_Yuga\n2017\npoorly programmed. :D\n---------------------------\nAll Debian!.\nOnly runs with Debian Systems, like Debian, Ubuntu or Mint.\n\nHelps installing & setting up Ndiswrapper!\n\nMade for beginners that switched from Windows\nto Linux.\n\nEasy Update & Maintain your System on the Terminal\nwithout having to know commands\nthis Bash script is not professional made.!\njust a learning bash script for me.\nNo Warranty whatsoever!." > /tmp/space.txt
		TITLE="About"
		BACKTITLE="PMP v.0.0.13 by Kali_Yuga / PMP Wifi / About"
		      dialog \
		      --title "$TITLE" \
		      --backtitle "$BACKTITLE" \
		      --textbox /tmp/space.txt 25 80
		  clear
		;;
	    esac
        elif [ "$?" -eq 1 ]; then ##CANCEL PMP Wifi
	      break
        fi
        done   
	;;
	6)
	while [[ 1 ]]
	      do
	      HEIGHT=13
	      WIDTH=29
	      CHOICE_HEIGHT=5
	      BACKTITLE="PMP v.0.0.13 by Kali_Yuga / Extras"
	      TITLE="Extras 0.0.2"
	      MENU="Select one:"
	      OPTIONS=(1 "Tools"
		       2 "Games"
		       3 "Music Player"
		       4 "Calculator"
		       5 "Time & Date")
	      CHOICE=$(dialog --clear \
                --backtitle "$BACKTITLE" \
                --title "$TITLE" \
                --menu "$MENU" \
                $HEIGHT $WIDTH $CHOICE_HEIGHT \
                "${OPTIONS[@]}" \
                2>&1 >/dev/tty)
                if [ "$?" -eq 0 ]; then ##Okay Extras
		  case $CHOICE in ##start menu extras
		      1)
		      while [[ 1 ]]
		      do
		      HEIGHT=13
		      WIDTH=29
		      CHOICE_HEIGHT=4
		      BACKTITLE="PMP v.0.0.13 by Kali_Yuga / Extras / Tools"
		      TITLE="Extras 0.0.2"
		      MENU="Select one:"
		      OPTIONS=(1 "Md5Sum Check"
			       2 "DVD to .Iso"
			       3 "Toggle Bluetooth"
			       4 "Screensaver")
		      CHOICE=$(dialog --clear \
				      --backtitle "$BACKTITLE" \
				      --title "$TITLE" \
				     --menu "$MENU" \
		      $HEIGHT $WIDTH $CHOICE_HEIGHT \
		      "${OPTIONS[@]}" \
		      2>&1 >/dev/tty)
		      if [ "$?" -eq 0 ]; then ##Okay tools
		      case $CHOICE in ##start menu tools
		      1)
		      FILE=$(dialog --clear \
			    --backtitle "$BACKTITLE / Md5Sum Check" \
			    --title "Md5Sum" \
			    --stdout \
			    --fselect $HOME/  15 80)
			    if [ "$?" -eq 0 ]; then ##Okay Fselect Md5sum Check
			md5sum $FILE > '/tmp/space.txt'
			     dialog --backtitle "$BACKTITLE / Md5Sum Check" \
			    --title "Md5Sum" \
			    --textbox /tmp/space.txt 5 199
			    elif [ "$?" -eq 1 ]; then ##Cancel Fselect Md5sum Check
				clear
			    fi
		      ;;
		      2)
		      dialog --clear \
			     --title "$TITLE" \
			     --backtitle "$BACKTITLE" \
			     --msgbox "Welcome to DvD2ISO" 5 40
			     DIR=$(dialog --clear \
			     --title "Choose the destination for your .Iso File:" \
			     --backtitle "$BACKTITLE" \
			     --stdout \
			     --fselect $HOME/  15 80)
		      if [ "$?" -eq 0 ]; then ##YES ISO destination
				    FILE=$(dialog --clear \
					--title "$TITLE" \
					--stdout \
					--backtitle "$BACKTITLE" \
					--inputbox "Give your ISO a Name: a.e image_name.iso"  7 40)
			  if [ "$?" -eq 0 ]; then ##YES ISO Inputbox
						       dialog --clear \
							      --title "$TITLE" \
							      --stdout \
							      --backtitle "$BACKTITLE" \
							      --yesno "Save $FILE in\n$DIR ?"  7 40
			    if [ "$?" -eq 0 ]; then ##YES File in DIR
					clear
					printf "==========================================\n";
					printf "|19. DvD2ISO             	   	   |\n";
					printf "==========================================\n\n";
					sleep 1
					printf "\nHi,\nPress 'Enter' to Convert $FILE' in $DIR, or press 'Ctrl + C' to exit:\n";
					read
					printf "starting coversion in:\n";
					let x=4;while [ $x -gt 0 ];do echo "$x";let x=$x-1;sleep 1;done
					printf "Please Wait...";
					cd $DIR
					dd if=/dev/cdrom of=$FILE
					sleep 3
					printf "Done! $FILE saved in $DIR\n"
					printf "Press Enter to Finish..."
					read
			    elif [ "$?" -eq 0 ]; then ##NO File in DIR
				dialog --clear \
				       --backtitle "$BACKTITLE" \
				       --infobox "cancelled..." 3 16
			 sleep 1.2
			 clear
		  fi ##END File in Dir
		  elif [ "$?" -eq 1 ]; then ##NO ISO Inputbox
					dialog \
					--backtitle "$BACKTITLE" \
					--infobox "cancelled..." 3 16
					sleep 1.2
					clear
				    fi ## END ISO Inputbox
		  elif [ "$?" -eq 1 ]; then ##NO ISO destination
			    dialog \
			    --backtitle "$BACKTITLE" \
			    --infobox "cancelled..." 3 16
			sleep 1.2
		      clear
		  fi ##END ISO File destination
		      ;;
		3)
		 while [[ 1 ]]
		  do
		  HEIGHT=12
		  WIDTH=28
		  CHOICE_HEIGHT=4
		  BACKTITLE="PMP v.0.0.13 by Kali_Yuga / Extras / Tools / Toggle Bluetooth"
		  TITLE="Toggle Bluetooth"
		  MENU="Select one of the following Options:"
		  OPTIONS=(1 "Bluetooth start"
			2 "Bluetooth stop"
			3 "Bluetooth restart"
			4 "Bluetooth status")
		  CHOICE=$(dialog --clear \
			    --backtitle "$BACKTITLE" \
			  --title "$TITLE" \
			  --menu "$MENU" \
		  $HEIGHT $WIDTH $CHOICE_HEIGHT \
		  "${OPTIONS[@]}" \
		  2>&1 >/dev/tty) ##Main Menu
		  if [ "$?" -eq 0 ]; then ## Okay Bluetooth Menu
		      case $CHOICE in
			1)
			clear
			sudo service bluetooth start &> /tmp/space.txt
			dialog \
			--title "Bluetooth" \
			--backtitle "$BACKTITLE" \
			--textbox /tmp/space.txt 6 60
			;;
			2)
			clear
			sudo service bluetooth stop &> /tmp/space.txt
			dialog \
			--title "Bluetooth" \
			--backtitle "$BACKTITLE" \
			--textbox /tmp/space.txt 6 60
			;;
			3)
			clear
			sudo service bluetooth restart &> /tmp/space.txt
			dialog \
			--title "Bluetooth" \
			--backtitle "$BACKTITLE" \
			--textbox /tmp/space.txt 6 60
			;;
			4)
			clear
			sudo service bluetooth status &> /tmp/space.txt
			dialog \
			--title "Bluetooth" \
			--backtitle "$BACKTITLE" \
			--textbox /tmp/space.txt 6 60
			;;
		      esac
		  elif [ "$?" -eq 1 ]; then ## Cancel Bluetooth Menu
		  break
		  fi
		  done
		  ;;
		4)
		      while [[ 1 ]]
		      do
			HEIGHT=12
			WIDTH=29
			CHOICE_HEIGHT=2
			BACKTITLE="PMP v.0.0.13 by Kali_Yuga / Extras / Tools / Screensaver"
			TITLE="CLI Screensaver"
			MENU="Select one:"
			OPTIONS=(1 "Pipes"
				2 "Rain")
			CHOICE=$(dialog --clear \
			 --backtitle "$BACKTITLE" \
			 --title "$TITLE" \
			 --menu "$MENU" \
			$HEIGHT $WIDTH $CHOICE_HEIGHT \
			"${OPTIONS[@]}" \
		      2>&1 >/dev/tty)
		      if [ "$?" -eq 0 ]; then ##Okay screensaver
			case $CHOICE in
1)
#!/bin/bash
# The author of the original script is unknown to me. The first entry I can
# find was posted at 2010-03-21 09:50:09 on Arch Linux Forums (doesn't mean the
# poster is the author at all):
#
#   https://bbs.archlinux.org/viewtopic.php?pid=728932#p728932
#
# I, Yu-Jie Lin, made a few changes and additions:
#
#   -p, -t, -R, and -C
#
#   Screenshot: http://flic.kr/p/dRnLVj
#   Screencast: http://youtu.be/5XnGSFg_gTk
#
# And push the commits to Gist:
#
#   https://gist.github.com/4689307
#
# I, Devin Samarin, made a few changes and additions:
#
#   -r can be 0 to mean "no limit".
#   Reset cursor visibility after done.
#   Cleanup for those people who want to quit with ^C
#
#   Pushed the changes to https://gist.github.com/4725048

p=1
f=75 s=13 r=2000 t=0
w=$(tput cols) h=$(tput lines)
# ab -> idx = a*4 + b
# 0: up, 1: right, 2: down, 3: left
# 00 means going up   , then going up   -> ┃
# 12 means going right, then going down -> ┓
sets=(
    "┃┏ ┓┛━┓  ┗┃┛┗ ┏━"
    "│╭ ╮╯─╮  ╰│╯╰ ╭─"
    "│┌ ┐┘─┐  └│┘└ ┌─"
    "║╔ ╗╝═╗  ╚║╝╚ ╔═"
)
v="${sets[0]}"
RNDSTART=0
NOCOLOR=0

OPTIND=1
while getopts "p:t:f:s:r:RCh" arg; do
case $arg in
    p) ((p=(OPTARG>0)?OPTARG:p));;
    t) ((OPTARG>=0 && OPTARG<${#sets[@]})) && v="${sets[OPTARG]}";;
    f) ((f=(OPTARG>19 && OPTARG<101)?OPTARG:f));;
    s) ((s=(OPTARG>4 && OPTARG<16 )?OPTARG:s));;
    r) ((r=(OPTARG>=0)?OPTARG:r));;
    R) RNDSTART=1;;
    C) NOCOLOR=1;;
    h) echo -e "Usage: $(basename $0) [OPTION]..."
        echo -e "Animated pipes terminal screensaver.\n"
        echo -e " -p [1-]\tnumber of pipes (D=1)."
        echo -e " -t [0-$((${#sets[@]} - 1))]\ttype of pipes (D=0)."
        echo -e " -f [20-100]\tframerate (D=75)."
        echo -e " -s [5-15]\tprobability of a straight fitting (D=13)."
        echo -e " -r LIMIT\treset after x characters, 0 if no limit (D=2000)."
        echo -e " -R \t\trandom starting point."
        echo -e " -C \t\tno color."
        echo -e " -h\t\thelp (this screen).\n"
        exit 0;;
    esac
done

cleanup() {
    tput rmcup
    tput cnorm
    exit 0
}
trap cleanup SIGHUP SIGINT SIGTERM

for (( i=1; i<=p; i++ )); do
    c[i]=$((i%8)) n[i]=0 l[i]=0
    ((x[i]=RNDSTART==1?RANDOM*w/32768:w/2))
    ((y[i]=RNDSTART==1?RANDOM*h/32768:h/2))
done

tput smcup
tput reset
tput civis
while ! read -t0.0$((1000/f)) -n1; do
    for (( i=1; i<=p; i++ )); do
        # New position:
        ((${l[i]}%2)) && ((x[i]+=-${l[i]}+2,1)) || ((y[i]+=${l[i]}-1))

        # Loop on edges (change color on loop):
        ((${x[i]}>w||${x[i]}<0||${y[i]}>h||${y[i]}<0)) && ((c[i]=RANDOM%8))
        ((x[i]=(x[i]+w)%w))
        ((y[i]=(y[i]+h)%h))

        # New random direction:
        ((n[i]=RANDOM%s-1))
        ((n[i]=(${n[i]}>1||${n[i]}==0)?${l[i]}:${l[i]}+${n[i]}))
        ((n[i]=(${n[i]}<0)?3:${n[i]}%4))

        # Print:
        tput cup ${y[i]} ${x[i]}
        [[ $NOCOLOR == 0 ]] && echo -ne "\033[1;3${c[i]}m"
        echo -n "${v:l[i]*4+n[i]:1}"
        l[i]=${n[i]}
    done
    ((r>0 && t*p>=r)) && tput reset && tput civis && t=0 || ((t++))
done

cleanup
;;
2)
#!/bin/bash
# Let it Rain!
# Copyright (C) 2011, 2013 by Yu-Jie Lin
#
# Permission is hereby granted, free of charge, to any person obtaining a copy
# of this software and associated documentation files (the "Software"), to deal
# in the Software without restriction, including without limitation the rights
# to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
# copies of the Software, and to permit persons to whom the Software is
# furnished to do so, subject to the following conditions:
#
# The above copyright notice and this permission notice shall be included in
# all copies or substantial portions of the Software.
#
# THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
# IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
# FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
# AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
# LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
# OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
# THE SOFTWARE.
#
# Blog: http://blog.yjl.im/2013/07/let-it-rain.html
# Gist: https://gist.github.com/livibetter/5933594
# Gif : https://lh5.googleusercontent.com/-0WJ1vSZcFPs/UdadOwdPEXI/AAAAAAAAE-c/6kuH9hP3cUo/s800/rain.sh.gif
# Clip: http://youtu.be/EssRgAh2w_c
#
# Modified from falling-<3s.sh:
#   http://blog.yjl.im/2011/02/time-to-have-falling-hearts-screensaver.html

RAINS=("|" "│" "┃" "┆" "┇" "┊" "┋" "╽" "╿")
COLORS=("\e[37m" "\e[37;1m")
# More from 256 color mode
for i in {244..255}; do
  COLORS=("${COLORS[@]}" "\e[38;5;${i}m")
done
NRAINS=${#RAINS[@]}
NCOLORS=${#COLORS[@]}
NUM_RAIN_METADATA=5


sigwinch() {
  TERM_WIDTH=$(tput cols)
  TERM_HEIGHT=$(tput lines)
  STEP_DURATION=0.025
  ((MAX_RAINS = TERM_WIDTH * TERM_HEIGHT / 4))
  ((MAX_RAIN_LENGTH = TERM_HEIGHT < 10 ? 1 : TERM_HEIGHT / 10))
  # In percentage
  ((NEW_RAIN_ODD = TERM_HEIGHT > 50 ? 100 : TERM_HEIGHT * 2))
  ((NEW_RAIN_ODD = NEW_RAIN_ODD * 75 / 100))
  ((FALLING_ODD = TERM_HEIGHT > 25 ? 100 : TERM_HEIGHT * 4))
  ((FALLING_ODD = FALLING_ODD * 90 / 100))
  }

do_exit() {
  echo -ne "\e[${TERM_HEIGHT};1H\e[0K"

  # Show cursor and echo stdin
  echo -ne "\e[?25h"
  stty echo
  exit 0
  }

do_render() {
  # Clean screen first
  for ((idx = 0; idx < num_rains * NUM_RAIN_METADATA; idx += NUM_RAIN_METADATA)); do
    X=${rains[idx]}
    Y=${rains[idx + 1]}
    LENGTH=${rains[idx + 4]}
    for ((y = Y; y < Y + LENGTH; y++)); do
      (( y < 1 || y > TERM_HEIGHT )) && continue
      echo -ne "\e[${y};${X}H "
    done
  done

  for ((idx = 0; idx < num_rains * NUM_RAIN_METADATA; idx += NUM_RAIN_METADATA)); do
    if ((100 * RANDOM / 32768 < FALLING_ODD)); then
      # Falling
      if ((++rains[idx + 1] > TERM_HEIGHT)); then
        # Out of screen, bye sweet <3
        rains=("${rains[@]:0:idx}"
               "${rains[@]:idx+NUM_RAIN_METADATA:num_rains*NUM_RAIN_METADATA}")
        ((num_rains--))
        continue
      fi
    fi
    X=${rains[idx]}
    Y=${rains[idx + 1]}
    RAIN=${rains[idx + 2]}
    COLOR=${rains[idx + 3]}
    LENGTH=${rains[idx + 4]}
    for ((y = Y; y < Y + LENGTH; y++)); do
      (( y < 1 || y > TERM_HEIGHT )) && continue
      echo -ne "\e[${y};${X}H${COLOR}${RAIN}"
    done
  done
  }

trap do_exit TERM INT
trap sigwinch WINCH
# No echo stdin and hide the cursor
stty -echo
echo -ne "\e[?25l"

echo -ne "\e[2J"
rains=()
sigwinch
while :; do
  read -n 1 -t $STEP_DURATION ch
  case "$ch" in
    q|Q)
      do_exit
      ;;
  esac

  if ((num_rains < MAX_RAINS)) && ((100 * RANDOM / 32768 < NEW_RAIN_ODD)); then
    # Need new |, 1-based
    RAIN="${RAINS[NRAINS * RANDOM / 32768]}"
    COLOR="${COLORS[NCOLORS * RANDOM / 32768]}"
    LENGTH=$((MAX_RAIN_LENGTH * RANDOM / 32768 + 1))
    X=$((TERM_WIDTH * RANDOM / 32768 + 1))
    Y=$((1 - LENGTH))
    rains=("${rains[@]}" "$X" "$Y" "$RAIN" "$COLOR" "$LENGTH")
    ((num_rains++))
  fi

  # Let rain fall!
  do_render
done
			;;
			esac
		      elif [ "$?" -eq 1 ]; then ##Cancel screensaver
			break
		      fi
		    done
		      ;;
		      esac
		  elif [ "$?" -eq 1 ]; then ##Cancel Tools
		   break
		 fi
	      done
;;
	      2)
	      HEIGHT=12
	      WIDTH=29
	      CHOICE_HEIGHT=5
	      BACKTITLE="$BACKTITLE / Games"
	      TITLE="Games 0.0.2"
	      MENU="Select one:"
	      OPTIONS=(1 "HOUSENKA"
		       2 "Space Invaders"
		       3 "Snake"
		       4 "Arkanoid"
		       5 "About")
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
	    ##############################################################################
	    #                                                                            #
	    #   Author : Martin "BruXy" Bruchanov, bruxy at regnet.cz                    #
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
	2)
		stty -echo

	# Make the cursor invisible (man terminfo)
	tput civis
	clear

	cat - << EOF



          SPACE INVADERS

	  LEFT:      a
	  RIGHT:     l
	  FIRE:      f

	  QUIT:      q

                            Press any key.
EOF
	  read -s -n 1

	  row0=( 0 30 30 30 30 30 30 30 30 )
	  row1=( 0 20 20 20 20 20 20 20 20 )
	  row2=( 0 15 15 15 15 15 15 15 15 )
	  row3=( 0 10 10 10 10 10 10 10 10 )
	  row4=( 0 5 5 5 5 5 5 5 5 )
	  row5=( 0 1 1 1 1 1 1 1 1 )

	  aliens1=( '\033[1;32m|0|\033[0m' '\033[1;34m\-/\033[0m'
		    '\033[1;35m:x:\033[0m' '\033[1;38m:#:\033[0m'
		    '\033[1;33m!|!\033[0m' '\033[1;39m:-:\033[0m' )
	  aliens2=( '\033[1;32m:0:\033[0m' '\033[1;34m/-\\\033[0m'
		    '\033[1;35m-x-\033[0m' '\033[1;38m-#-\033[0m'
		    '\033[1;33m:|:\033[0m' '\033[1;39m-:-\033[0m' )

	  score=0

	  # farthest right that the *leftmost* alien can go to
	  MAXRIGHT=46
	  # furthest right that the ship can go to
	  FARRIGHT=73

	  # Ship's current position (x-axis)
	  ship=30
	  # Cannon column; remains the same even if ship moves
	  cannonX=$ship
	  # Cannon height; 0 means it's ready to fire
	  cannonY=0
	  # Positive direction to right, Negative to left
	  direction=1
	  offset=20
	  bottom=20
	  ceiling=4
	  MAXCEILING=6
	  DELAY=0.4

	  function drawrow
	  {
	    # draw a row of aliens; return the index of any alien killed
	    # note that only one alien can be killed at any time.
	    alientype=$1
	    shift
	    let row="$alientype * 2 + $ceiling"
	    aliensonrow=`echo $@ | tr ' ' '+' | bc`
	    if [ $aliensonrow -eq 0 ]; then
	    # Nothing to do here. In particular, do not detect failure.
	    # Just clear the previous line (it may contain the final explosion
	    # on that row) and return.
	    tput cup $row 0
	    printf "%80s" " "
	    return 0
	    fi
	    if [ $row -eq $bottom ]; then
	    tput cup `expr $bottom - 4` 6
	    trap exit ALRM
	    echo "YOU LOSE"
	    sleep $DELAY
	    stty echo
	    tput cvvis
	    exit 1
	    fi
	    declare -a thisrow
	    thisrow=( `echo $@` )

	    tput cup 0 0
	    printf "Score: %-80d" $score

	    killed=0
	    # Clear the previous line
	    tput cup `expr $row - 1` 0
	    printf "%80s" " "

	    tput cup $row 0
	    printf "%80s" " "
	    tput cup $row 0
	    printf "%-${offset}s"

	    # Don't do this calculation in the for loop, it is slow even without expr
	    if (( $offset % 2 == 0 )); then
	    thisalien=${aliens1[$alientype]}
	    else
	    thisalien=${aliens2[$alientype]}
	    fi

	    # there are 8 aliens per row.
	    for i in `seq 1 8`
	    do
	    value=${thisrow[$i]}
	    avatar=$thisalien
 
	    if [ $value -gt 0 ]; then
	    # detect and mark a collision
	    if [ $row -eq $cannonY ]; then
	    let LEFT="$i * 4 + $offset - 4"
	    let RIGHT="$i * 4 + $offset - 1"
	    if [ $cannonX -ge $LEFT ] && [ $cannonX -le $RIGHT ]; then
	    killed=$i
	    avatar='\033[1;31m***\033[0m'
	    ((score=$score + $value))
	    cannonY=0
	  fi
	fi
      fi

	    if [ $value -eq 0 ]; then
	    printf "    "
	    else
	    echo -en "${avatar} "
	    fi
	    done
	    return $killed
	    }

	    function drawcannon
	    {
	      # move the cannon up one
	      if [ $cannonY -eq 0 ]; then
	      # fell off the top of the screen
	      return
	  fi

	    tput cup $cannonY $cannonX
	    printf " "
	    ((cannonY=cannonY-1))
	    tput cup $cannonY $cannonX
	    echo -en "\033[1;31m*\033[0m"
	    }

	    function drawship
	    {
	    tput cup $bottom 0
	    printf "%80s" " "
	    tput cup $bottom $ship
	    # Show cannon state by its color in the spaceship
	    if [ $cannonY -eq 0 ]; then
	    col=31
	else
	    col=30
      fi
  echo -en "|--\033[1;${col}m*\033[0m--|"
}

function move
{
  # shift aliens left or right
  # move cannon, check for collision

  (sleep $DELAY && kill -ALRM $$) &
 
  # Change direction if hit the side of the screen
  if [ $offset -gt $MAXRIGHT ] && [ $direction -eq 1 ]; then
    # speed up if hit the right side of the screen
    DELAY=`echo $DELAY \* 0.90 | bc`
    direction=-1
    ((ceiling++))
  elif [ $offset -eq 0 ] && [ $direction -eq -1 ]; then
    direction=1
  fi
 
  ((offset=offset+direction))
 
  drawrow 0 ${row0[@]}
  row0[$?]=0
  drawrow 1 ${row1[@]}
  row1[$?]=0
  drawrow 2 ${row2[@]}
  row2[$?]=0
  drawrow 3 ${row3[@]}
  row3[$?]=0
  drawrow 4 ${row4[@]}
  row4[$?]=0
  drawrow 5 ${row5[@]}
  row5[$?]=0

  aliensleft=`echo ${row0[@]} ${row1[@]} ${row2[@]} ${row3[@]}\
         ${row4[@]} ${row5[@]} \
      | tr ' ' '+' | bc`
  if [ $aliensleft -eq 0 ]; then
    tput cup 5 5
    trap exit ALRM
    echo "YOU WIN"
    sleep $DELAY
    tput echo
    tput cvvis
    echo; echo; echo
    exit 0
  fi

  drawcannon
  drawship
}

trap move ALRM

clear
drawship
# Start the aliens moving...
move
while :
do
  read -s -n 1 key
  case "$key" in
    a)
       [ $ship -gt 0 ] && ((ship=ship-1))
	drawship
	;;
    l)
       [ $ship -lt $FARRIGHT ] && ((ship=ship+1))
	drawship
	;;
    f)
	if [ $cannonY -eq 0 ]; then
          let cannonX="$ship + 3"
	  cannonY=$bottom
        fi
	;;
    q)
	echo "Goodbye!"
	tput cvvis
	stty echo
	trap exit ALRM
	sleep $DELAY
	exit 0
	esac
	done
	;;
	3)
	#!/bin/bash
	#
	# Centipede game
	#
	# v2.0
	#
	# Author: sol@subnetzero.org
	#
	# Functions

	drawborder() {
	# Draw top
	tput setf 6
	tput cup $FIRSTROW $FIRSTCOL
	x=$FIRSTCOL
	while [ "$x" -le "$LASTCOL" ];
	do
	printf %b "$WALLCHAR"
	x=$(( $x + 1 ));
	done

	# Draw sides
	x=$FIRSTROW
	while [ "$x" -le "$LASTROW" ];
	do
	tput cup $x $FIRSTCOL; printf %b "$WALLCHAR"
	tput cup $x $LASTCOL; printf %b "$WALLCHAR"
	x=$(( $x + 1 ));
	done

	# Draw bottom
	tput cup $LASTROW $FIRSTCOL
	x=$FIRSTCOL
	while [ "$x" -le "$LASTCOL" ];
	do
	printf %b "$WALLCHAR"
	x=$(( $x + 1 ));
	done
	tput setf 9
	}

	apple() {
	# Pick coordinates within the game area
	APPLEX=$[( $RANDOM % ( $[ $AREAMAXX - $AREAMINX ] + 1 ) ) + $AREAMINX ]
	APPLEY=$[( $RANDOM % ( $[ $AREAMAXY - $AREAMINY ] + 1 ) ) + $AREAMINY ]
	}

	drawapple() {
	# Check we haven't picked an occupied space
	LASTEL=$(( ${#LASTPOSX[@]} - 1 ))
	x=0
	apple
	while [ "$x" -le "$LASTEL" ];
	do
	if [ "$APPLEX" = "${LASTPOSX[$x]}" ] && [ "$APPLEY" = "${LASTPOSY[$x]}" ];
	then
         # Invalid coords... in use
         x=0
         apple
	else
         x=$(( $x + 1 ))
	fi
	done
	tput setf 4
	tput cup $APPLEY $APPLEX
	printf %b "$APPLECHAR"
	tput setf 9
	}

	growsnake() {
	# Pad out the arrays with oldest position 3 times to make snake bigger
	LASTPOSX=( ${LASTPOSX[0]} ${LASTPOSX[0]} ${LASTPOSX[0]} ${LASTPOSX[@]} )
	LASTPOSY=( ${LASTPOSY[0]} ${LASTPOSY[0]} ${LASTPOSY[0]} ${LASTPOSY[@]} )
	RET=1
	while [ "$RET" -eq "1" ];
	do
	apple
	RET=$?
	done
	drawapple
	}

	move() {
	case "$DIRECTION" in
	u) POSY=$(( $POSY - 1 ));;
	d) POSY=$(( $POSY + 1 ));;
	l) POSX=$(( $POSX - 1 ));;
	r) POSX=$(( $POSX + 1 ));;
	esac

	# Collision detection
	( sleep $DELAY && kill -ALRM $$ ) &
	if [ "$POSX" -le "$FIRSTCOL" ] || [ "$POSX" -ge "$LASTCOL" ] ; then
	tput cup $(( $LASTROW + 1 )) 0
	stty echo
	echo " GAME OVER! You hit a wall!"
	gameover
	elif [ "$POSY" -le "$FIRSTROW" ] || [ "$POSY" -ge "$LASTROW" ] ; then
	tput cup $(( $LASTROW + 1 )) 0
	stty echo
	echo " GAME OVER! You hit a wall!"
	gameover
	fi

	# Get Last Element of Array ref
	LASTEL=$(( ${#LASTPOSX[@]} - 1 ))
	#tput cup $ROWS 0
	#printf "LASTEL: $LASTEL"

	x=1 # set starting element to 1 as pos 0 should be undrawn further down (end of tail)
	while [ "$x" -le "$LASTEL" ];
	do
	if [ "$POSX" = "${LASTPOSX[$x]}" ] && [ "$POSY" = "${LASTPOSY[$x]}" ];
	then
         tput cup $(( $LASTROW + 1 )) 0
         echo " GAME OVER! YOU ATE YOURSELF!"
         gameover
      fi
      x=$(( $x + 1 ))
      done

      # clear the oldest position on screen
      tput cup ${LASTPOSY[0]} ${LASTPOSX[0]}
      printf " "

      # truncate position history by 1 (get rid of oldest)
      LASTPOSX=( `echo "${LASTPOSX[@]}" | cut -d " " -f 2-` $POSX )
      LASTPOSY=( `echo "${LASTPOSY[@]}" | cut -d " " -f 2-` $POSY )
      tput cup 1 10
      #echo "LASTPOSX array ${LASTPOSX[@]} LASTPOSY array ${LASTPOSY[@]}"
      tput cup 2 10
      echo "SIZE=${#LASTPOSX[@]}"

      # update position history (add last to highest val)
      LASTPOSX[$LASTEL]=$POSX
      LASTPOSY[$LASTEL]=$POSY

      # plot new position
      tput setf 2
      tput cup $POSY $POSX
      printf %b "$SNAKECHAR"
      tput setf 9

      # Check if we hit an apple
      if [ "$POSX" -eq "$APPLEX" ] && [ "$POSY" -eq "$APPLEY" ]; then
      growsnake
      updatescore 10
      fi
      }

      updatescore() {
      SCORE=$(( $SCORE + $1 ))
      tput cup 2 30
      printf "SCORE: $SCORE"
      }
      randomchar() {
      [ $# -eq 0 ] && return 1
      n=$(( ($RANDOM % $#) + 1 ))
      eval DIRECTION=\${$n}
      }

      gameover() {
      tput cvvis
      stty echo
      sleep $DELAY
      trap exit ALRM
      tput cup $ROWS 0
      exit
      }

      ###########################END OF FUNCS##########################

      # Prettier characters but not supported
      # by all termtypes/locales
      #SNAKECHAR="\0256"                      # Character to use for snake
      #WALLCHAR="\0244"                       # Character to use for wall
      #APPLECHAR="\0362"                      # Character to use for apples
      #
      # Normal boring ASCII Chars
      SNAKECHAR="@"                           # Character to use for snake
      WALLCHAR="X"                            # Character to use for wall
      APPLECHAR="o"                           # Character to use for apples
      #
      SNAKESIZE=3                             # Initial Size of array aka snake
      DELAY=0.2                               # Timer delay for move function
      FIRSTROW=3                              # First row of game area
      FIRSTCOL=1                              # First col of game area
      LASTCOL=40                              # Last col of game area
      LASTROW=20                              # Last row of game area
      AREAMAXX=$(( $LASTCOL - 1 ))            # Furthest right play area X
      AREAMINX=$(( $FIRSTCOL + 1 ))           # Furthest left play area X
      AREAMAXY=$(( $LASTROW - 1 ))            # Lowest play area Y
      AREAMINY=$(( $FIRSTROW + 1))            # Highest play area Y
      ROWS=`tput lines`                       # Rows in terminal
      ORIGINX=$(( $LASTCOL / 2 ))             # Start point X - use bc as it will round
      ORIGINY=$(( $LASTROW / 2 ))             # Start point Y - use bc as it will round
      POSX=$ORIGINX                           # Set POSX to start pos
      POSY=$ORIGINY                           # Set POSY to start pos

      # Pad out arrays
      ZEROES=`echo |awk '{printf("%0"'"$SNAKESIZE"'"d\n",$1)}' | sed 's/0/0 /g'`
      LASTPOSX=( $ZEROES )                    # Pad with zeroes to start with
      LASTPOSY=( $ZEROES )                    # Pad with zeroes to start with

      SCORE=0                                 # Starting score

      clear
      echo "
      Keys:

      W - UP
      S - DOWN
      A - LEFT
      D - RIGHT
      X - QUIT

      If characters do not display properly, consider changing
      SNAKECHAR, APPLECHAR and WALLCHAR variables in script.
      Characters supported depend upon your terminal setup.

      Press Return to continue
      "

      stty -echo
      tput civis
      read RTN
      tput setb 0
      tput bold
      clear
      drawborder
      updatescore 0

      # Draw the first apple on the screen
      # (has collision detection to ensure we don't draw
      # over snake)
      drawapple
      sleep 1
      trap move ALRM

      # Pick a random direction to start moving in
      DIRECTIONS=( u d l r )
      randomchar "${DIRECTIONS[@]}"

      sleep 1
      move
      while :
      do
      read -s -n 1 key
      case "$key" in
      w)   DIRECTION="u";;
      s)   DIRECTION="d";;
      a)   DIRECTION="l";;
      d)   DIRECTION="r";;
      x)   tput cup $COLS 0
        echo "Quitting..."
        tput cvvis
        stty echo
        tput reset
        printf "Bye Bye!\n"
        trap exit ALRM
        sleep $DELAY
        exit 0
        esac
        done
        ;;
	4)
	stty -echo

	# Init output
	OLD_IFS="$IFS"
	IFS=

	DELAY=0.2

	tput civis
	clear

	SCREEN_WIDTH=$(tput cols)
	SCREEN_HEIGHT=$(($(tput lines) - 1))
	WIDTH=$((40 % (SCREEN_WIDTH - 2)))
	HEIGHT=$((14 % (SCREEN_HEIGHT - 2)))

	HALF_WIDTH=$((WIDTH/2))
	HALF_HEIGHT=$((HEIGHT/2))

	TOP=$(((SCREEN_HEIGHT - HEIGHT) / 2))
	LEFT=$(((SCREEN_WIDTH - WIDTH) / 2))
	BOTTOM=$((TOP + HEIGHT))
	RIGHT=$((LEFT + WIDTH))

	STATE='stop'

	plateX=$((LEFT + HALF_WIDTH))
	plateW=5
	plateS=""

	ballY=$((BOTTOM - 1))
	ballX=$((LEFT + HALF_WIDTH + plateW / 2))
	ballDY=-1
	ballDX=-1
	ballColors=(52 88 124 160 196)
	currentColor=0
	ballChar="+"
	state="stop"
	lifes=3
	
	bricks=()

	function putBrik {
	index=1$1\0$2
	briks[$index]=1
	tput cup $1 $2
	echo '='
	}

	function drawBricks {
	for (( row = $((TOP + 2)); row <= $((TOP + 7)); row++ ))
	do
	for (( column = $((LEFT + 3)); column <= $((RIGHT - 3)); column++ ))
	do
	  if [ $(($column % 3)) == 0 ]
      then
        tput setaf 83
        putBrik $row $column
      fi
    done
  done

  for (( column = $((LEFT + 3)); column <= $((RIGHT - 3)); column++ ))
  do
    if [ $(($column % 2)) == 0 ]
    then
      tput setaf 84
      putBrik $((TOP + 3)) $column
    fi
    if [ $(($column % 3)) == 0 ]
    then
      tput setaf 85
      putBrik $((TOP + 6)) $column
    fi
  done

  for (( column = $((LEFT + 2)); column <= $((RIGHT - 2)); column++ ))
  do
    if [ $(($column % 4)) == 0 ]
    then
      tput setaf 86
      putBrik $((TOP + 8)) $column
    fi
    if [ $(($column % 2)) == 0 ]
    then
      tput setaf 86
      tput setaf 87
      putBrik $((TOP + 4)) $column
    fi
  done
}

function drawBorder {
  tput setaf 244
  tput cup $((TOP - 5)) $((LEFT + 5))
  echo "         _               _   _ "
  tput cup $((TOP - 4)) $((LEFT + 5))
  echo " ___ ___| |_ ___ ___ ___|_|_| |"
  tput cup $((TOP - 3)) $((LEFT + 5))
  echo "| .'|  _| '_| .'|   | . | | . |"
  tput cup $((TOP - 2)) $((LEFT + 5))
  echo "|__,|_| |_,_|__,|_|_|___|_|___|"

  line=""
  tput setaf 241
  for (( column = 0; column <= WIDTH; column++ ))
  do
    line+="_"
  done
  tput cup $((TOP - 1)) $LEFT
  echo $line
  tput cup $BOTTOM $LEFT
  echo $line

  for (( row = 0; row <= HEIGHT; row++ ))
  do
    tput cup $((TOP + row)) $((LEFT - 1))
    echo "|"
    tput cup $((TOP + row)) $((RIGHT + 1))
    echo "|"
  done

  tput cup $((BOTTOM + 2)) $LEFT
  echo "Press 'h' or 'l' to start playing"
}

function clearBall {
  tput cup $ballY $ballX
  echo " "
}

function drawBall {
  tput setaf ${ballColors[$currentColor]}
  tput cup $ballY $ballX
  echo $ballChar

  currentColor=$(($currentColor + 1))
  if [ $currentColor -gt 4 ]
  then
    currentColor=0
  fi
}

function resetBall {
  clearBall
  ballY=$((BOTTOM - 1))
  ballX=$((plateX + plateW / 2))
  ballDY=-1
  ballDY=-1
  drawPlate
  drawBall
}

function move {
  (sleep $DELAY && kill -ALRM $$) &

  if [ $state != 'playing' ]
  then
    return
  fi

  clearBall
  ballY=$((ballY + ballDY))
  ballX=$((ballX + ballDX))

  if [ $ballX -gt $RIGHT ] || [ $ballX -lt $LEFT ]
  then
    ballDX=$((-ballDX))
    ballX=$((ballX + ballDX + ballDX))
  fi

  if [ $ballY -lt $TOP ]
  then
    ballDY=$((-ballDY))
    ballY=$((ballY + ballDY + ballDY))
  fi

  if [ $ballY -gt $((BOTTOM - 1)) ]
  then
    if [ $ballX -le $((plateX + plateW)) ] && [ $ballX -ge $plateX ]
    then
      ballX=$((plateX + plateW / 2))
      ballDY=$((-ballDY))
      ballY=$((ballY + ballDY + ballDY))
      drawPlate
    else
      resetBall
      drawBorder
      state='stop'
      lifes=$((lifes - 1))
    fi
  fi

  index=1$ballY\0$ballX
  if [ ${briks[$index]} ] && [ ${briks[$index]} == 1 ]
  then
    tput cup $ballY $ballX
    drawBall
    clearBall
    ballDY=$((-ballDY))
    ballY=$((ballY))
    briks[$index]=0
  fi

  drawBall
  tput setaf 7
  tput cup $((BOTTOM + 2)) $LEFT
  if [ $lifes -gt 0 ]
  then
    echo "Lifes: " $lifes "                       "
  else
    echo "Game over =(((                           "
    exitGame
  fi
}

function calcPlateS {
  plateS=" +"
  for (( i = 0; i < $((plateW - 2)); i++ ))
  do
    plateS+="-"
  done
  plateS+="+ "
}

function drawPlate {
  tput setaf 2
  tput cup $((BOTTOM - 1)) $((plateX - 1))
  echo $plateS
  if [ $plateX == $LEFT ]
  then
    tput setaf 241
    tput cup $((BOTTOM - 1)) $((plateX - 1))
    echo "|"
  fi
}

function exitGame {
  echo "Goodbye!"
  trap exit ALRM
  tput cnorm
  IFS="$OLD_IFS"
  tput cvvis
  stty echo
  exit 0
}

function startGame {
  if [ $lifes -ge 0 ]
  then
    state='playing'
  else
    state='gameOver'
  fi
}

trap move ALRM

calcPlateS
drawBricks
drawBorder
drawBall
drawPlate
resetBall
move

while :
do
  read -s -n 1 key
  case "$key" in
    h)
      if [ $state == 'stop' ]
      then
        ballDX=-1
        startGame
      else
        if [ $plateX -gt $LEFT ]
        then
          plateX=$((plateX - 1))
          drawPlate
          drawBall
        fi
      fi
	;;
    l)
      if [ $state == 'stop' ]
      then
        ballDX=1
        startGame
      else
        if [ $plateX -lt $((RIGHT - $plateW)) ]
        then
          plateX=$((plateX + 1))
          drawPlate
          drawBall
        fi
      fi
	;;
    q)
      exitGame
	;;
  esac
done
	;;
	5)
	TITLE="About"
	    BACKTITLE="$BACKTITLE / About"
	    dialog \
	    --title "$TITLE" \
	    --backtitle "$BACKTITLE" \
	    --msgbox "Games provided by:\n\nMartin 'BruXy' Bruchanov\nfound at: URL: http://bruxy.regnet.cz\n&\nSteve_Parker,\nShell Scripting: Expert Recipes for Linux,Bash and more." 13 40
		esac
		;;
	3) ##PMPlayer 0.0.1
	while [[ 1 ]]
	do
	HEIGHT=13
	WIDTH=30
	CHOICE_HEIGHT=6
	TITLE="PMPlayer 0.0.1"
	BACKTITLE="PMP v.0.0.13 by Kali_Yuga / Extras / PMPlayer 0.0.1"
	MENU="♫__Welcome to PMPlayer!__♫"
	OPTIONS=(1 "→ Next"
		 2 "← Previous"
		 3 "►❚❚ Play/Pause"
		 4 "◼ Stop"
		 5 "Currently Playing"
		 6 "Library")

	CHOICE=$(dialog --clear \
			--backtitle "$BACKTITLE" \
			--title "$TITLE" \
			--menu "$MENU" \
			$HEIGHT $WIDTH $CHOICE_HEIGHT \
			"${OPTIONS[@]}" \
			2>&1 >/dev/tty)
			if [ "$?" -eq 0 ]; then
			    case $CHOICE in
			    1)
			    xmms2 next
			    ;;
			    2)
			    xmms2 prev
			    ;;
			    3)
			    xmms2 toggle
			    ;;
			    4)
			    xmms2 stop
			    ;;
			    5)
			    xmms2 current > /tmp/space.txt
			    dialog --backtitle "$BACKTITLE / Currently Playing" \
				   --title "PMPlayer - Currently Playing" \
				   --textbox /tmp/space.txt 5 95
			    ;;
			    6)
			    while [[ 1 ]]
			    do
			    clear
			    HEIGHT=15
			    WIDTH=30
			    CHOICE_HEIGHT=6
			    BACKTITLE="PMP v.0.0.13 by Kali_Yuga / Extras / PMPlayer 0.0.1 / Library"
			    TITLE="Library"
			    MENU="Please choose one of the following Options:"

			    OPTIONS=(1 "Library"
				    2 "Add Music"
				    3 "Shuffle Library"
				    4 "Jump to Track"
				    5 "Empty Library"
				    6 "Install Xmms2")

			    CHOICE=$(dialog --clear \
					    --backtitle "$BACKTITLE" \
					    --title "$TITLE" \
					    --menu "$MENU" \
			    $HEIGHT $WIDTH $CHOICE_HEIGHT \
			    "${OPTIONS[@]}" \
			    2>&1 >/dev/tty)
			    if [ "$?" -eq 0 ]; then ##PMPlayer Library Okay
			      case $CHOICE in
				  1) ##Library
				  printf "TIP - Use Page up & Page Down or the arrow keys to scroll:\n\n" > /tmp/space.txt
				  xmms2 list >> /tmp/space.txt
				  dialog --backtitle "$BACKTITLE / Library" \
					 --title "Library" \
					 --textbox /tmp/space.txt 25 120
				  ;;
				  2) ##Add Music
				  FILE=$(dialog --title "$TITLE" \
						--backtitle "$BACKTITLE / Add Music" \
						--stdout \
						--title "Add a Music folder:" \
						--fselect $HOME/  8 60) ;
				  if [ "$?" -eq 0 ]; then ##YES Fselect Add Music
				  xmms2 add $FILE
				  elif [ "$?" -eq 1 ]; then ##NO Fselect Add Music
				  dialog --title "$TITLE" \
					 --backtitle "$BACKTITLE" \
					 --infobox "cancelled...." 3 16
				    sleep 1.2
				    clear
				  fi
				  ;;
				  3) ##Shuffle Library
				  xmms2 playlist shuffle
				  ;;
				  4) ##Jump to Track
				  TRACK=$(dialog --clear \
						 --title "Play Track" \
						 --backtitle "$BACKTITLE / Jump to Track" \
						 --stdout \
						 --inputbox "Track Number:" 7 16)
				  if [ "$?" -eq 0 ]; then ##YES Fselect Track Number
				  xmms2 jump $TRACK
				  elif [ "$?" -eq 1 ]; then ##NO Fselect Track Number
				  clear
				  fi
				  ;;
				  5) ##Empty Library
				  xmms2 clear
				  ;;
				  6) ##Install Xmms2
				  dialog \
				  --clear \
				  --title "Xmms2" \
				  --backtitle "$BACKTITLE / Install Xmms2" \
				  --yesno "Do you want to download & install the Xmms2 player?" 7 25 ;
				  if [ "$?" -eq 0 ]; then
				  sudo apt-get install xmms2
				  elif [ "$?" -eq 1 ]; then
				  dialog \
				  --infobox "cancelled..." 3 15
				  sleep 1.2
				  fi
				  ;;
			      esac
			    elif [ "$?" -eq 1 ]; then ##PMPlayer Library Cancel
			      break
			    fi
			    done
			    ;;
			    esac
			elif [ "$?" -eq 1 ]; then
			break
			fi
	done
	;;
	4)
	clear
	bc -l
	;;
	5)
	while [[ 1 ]]
	do
	HEIGHT=10
	WIDTH=15
	CHOICE_HEIGHT=2
	BACKTITLE="PMP v.0.0.13 by Kali_Yuga / Extras / Time & Date"
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
           if [ "$?" -eq 0 ]; then ##Okay Time & Date
		case $CHOICE in
		    1)
		    dialog --clear \
			   --title 'PMP Time' \
			   --backtitle "$BACKTITLE / Time" \
			   --timebox '' \
		    0 0
		    clear
		    ;;
		    2)
		    dialog --clear \
			   --title "PMP Calendar" \
			   --backtitle "$BACKTITLE / Calendar" \
			   --calendar '' \
		    0 0
		    clear
		    ;;
		esac
           elif [ "$?" -eq 1 ]; then ##Cancel Time & Date
           break
           fi
	done
	;;
	esac
elif [ "$?" -eq 1 ]; then ##Cancel Extras
		clear
	break
	fi ##END Extras
        done
	;;
	7)
	BACKTITLE="$BACKTITLE / Shutdown"
	 dialog --title "Shutdown" \
	 --backtitle "$BACKTITLE" \
	 --yesno "Do you want to turn off your Computer?" 6 35
	 if [ "$?" -eq 0 ]; then
	 clear
	 sudo shutdown -h now
	 elif [ "$?" -eq 1 ]; then
	 dialog --title "Cancel" --backtitle "$BACKTITLE / Shutdown" --infobox "cancelled..." 3 15
	 sleep 2
	 clear
	 fi
	;;
	8)
	TITLE="About"
	BACKTITLE="PMP v.0.0.13  by Kali_Yuga / About"
	dialog --clear \
	       --title "$TITLE" \
	       --backtitle "$BACKTITLE" \
	       --msgbox "PMP\nPersonal Maintain Program\nver.0.0.13\n\nwritten by Kali_Yuga\n2017-2018\npoorly programmed. :D\n---------------------------\nAll Debian!.\nOnly runs with Debian Systems, like Debian, Ubuntu or Mint.\n\nMade for beginners that switched from Windows\nto Linux.\n\nEasy Update & Maintain your System on the Terminal\nwithout having to know commands\nso this is basically just a Bash script for learning and it is not professional made! Mainly use it myself\nso it works for me.\nNo warranty whatsoever!" 24 80
	clear
        ;;
        9) ##EXIT
        dialog --title "Exit" \
	       --backtitle "$BACKTITLE / Exit" \
	       --infobox "Goodbye!" 3 20
	       sleep 1.2;
	       clear
	       exit 0;
        ;;
esac
	elif [ "$?" -eq 1 ]; then ##MAIN MENU IF USER PRESSED CANCEL
	  dialog --title "Exit" \
		 --backtitle "$BACKTITLE / Exit" \
		 --infobox "Goodbye!" 3 20
		 sleep 1.2;
		 clear
		 exit 0;
	fi
elif [ "$?" -eq 1 ]; then ##NO Dialog installed
    clear
    printf "Sorry... You need to have Dialog installed to run this!\n"
    PS3='Select Options:'
    options=("Install Dialog"
	     "Exit")
	    select opt in "${options[@]}"
	    do
	    case $opt in
	    ("Install Dialog")
	    sudo apt-get update && sudo apt-get install dialog
	    break
	    ;;
	    ("Exit")
	    printf "==============================\n";
	    printf "|         Good Bye           |\n"
	    printf "==============================\n";
	    exit
	    esac
	    done
fi
done
