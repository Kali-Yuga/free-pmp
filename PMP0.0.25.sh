#!/bin/bash
while [[ 1 ]]
do
dpkg -s dialog &> /dev/null; #Check's if Dialog is installed
if [ "$?" -eq 0 ]; then #Dialog Installed
clear;
HEIGHT=17
WIDTH=45
CHOICE_HEIGHT=8
BACKTITLE="PMP v.0.0.25"
TITLE="Personal Maintain Program"
MENU="Select one of the following Options:"

OPTIONS=(1 "Computer Maintenance"
         2 "System Monitor"
         3 "Kill Wine"
         4 "Software Center"
         5 "Extras"
         6 "Shut Down"
         7 "About"
         8 "Exit") ##Main Menu

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
	  clear;
	  HEIGHT=17
	  WIDTH=45
	  CHOICE_HEIGHT=10
	  BACKTITLE="PMP v.0.0.25 / Computer Maintenance"
	  TITLE="Computer Maintenance"
	  MENU="Select one of the following Options:"

	  OPTIONS=(1 "Update"
		   2 "Auto-Remove"
		   3 "Clean"
		   4 "Update Boot-Loader"
		   5 "Kernel Remover"
		   6 "Search & Install Software"
		   7 "Remove Software"
		   8 "Nvidia Driver Manager"
		   9 "Run Command"
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
		  TITLE="PMP - 0.0.25"
		  dialog \
		  --title "$TITLE" \
		  --backtitle "$BACKTITLE / Upgrade" \
		  --yesno "do you want to Upgrade your System?" 6 35;
		      if [ "$?" -eq 0 ]; then ##YESNO Question Update
		  clear;
		  printf "==========================================\n| Updating System                        |\n==========================================\n";
		  sudo apt-get update && sudo apt-get dist-upgrade;
		  printf "\nPress Enter to return to the program.\n";
		  read
		      elif [ "$?" -eq 1 ]; then ##YESNO Question Update
		  dialog \
		  --backtitle "$BACKTITLE / Upgrade" \
		  --infobox "cancelled..." 3 15;
		  sleep 1;
		      fi
		  ;;
		  2) ##Auto-Remove
		  dialog \
		  --title "Auto-Remove" \
		  --backtitle "PMP v.0.0.25 / Computer Maintenance / Auto-Remove" \
		  --yesno "Remove unnecessary files?" 5 31;
		      if [ $? -eq 0 ]; then ##YESNO Question
		  clear
		  printf "==========================================\n| Autoremove                             |\n==========================================\n";
		  sudo apt-get autoremove;
		  printf "\nPress Enter to return to the program.\n";
		  read
		      elif [ $? -eq 1 ]; then ##YESNO Question
		  dialog \
		  --title "Auto-Remove" \
		  --backtitle "PMP v.0.0.25 / Computer Maintenance / Auto-Remove" \
		  --infobox "cancelled..." 3 20;
		  sleep 1;
		      fi
		  ;;
		  3) ##Autoclean
		  clear;
		  printf "==========================================\n| Autoclean                              |\n==========================================\n";
		  printf "'starting sudo'...\n";
		  sudo apt-get autoclean;
		  printf "please wait...\n";
		  printf "Press Enter to return to the program.\n";
		  read
		  ;;
		  4) ##Update Grub-Bootloader
		  dialog \
		  --title "Update-grub" \
		  --backtitle "$BACKTITLE / Update Boot-Loader" \
		  --yesno "Do you want to update the Grub-Bootloader?" 6 31;
		  if [ "$?" -eq 0 ]; then ##YESNO Question Update
		  clear;
		  printf "==========================================\n| Update Grub Boot Loader                |\n==========================================\n";
		  echo "Updating Grub Boot Loader";
		  sleep 0.1;
		  printf "starting sudo...\n";
		  sudo update-grub;
		  printf "Press Enter to return to the program.\n";
		  read
		  elif [ "$?" -eq 1 ]; then ##YESNO Question Update
		   dialog \
		  --title "Auto-Remove" \
		  --backtitle "$BACKTITLE / Update Boot-Loader" \
		  --infobox "cancelled..." 3 20;
		  sleep 1;
		  fi
		  ;;
		  5) ##Kernel-Remover
		  while [[ 1 ]]
		  do
		  HEIGHT=15
		  WIDTH=45
		  CHOICE_HEIGHT=7
		  BACKTITLE="PMP v.0.0.25 / Computer Maintenance / Kernel Remover"
		  TITLE="Kernel Remover 0.0.6"
		  MENU="Please choose one of the following Options:"
		  OPTIONS=(1 "Show Current Kernel"
			   2 "Show all Kernel Images"
			   3 "Show removable Kernel Images"
			   4 "Remove Kernel Images"
			   5 "Purge-Old-Kernels"
			   6 "Understanding Package States"
			   7 "Help")
		  CHOICE=$(dialog --clear \
			--backtitle "$BACKTITLE" \
			--title "$TITLE" \
			--menu "$MENU" \
			$HEIGHT $WIDTH $CHOICE_HEIGHT \
			"${OPTIONS[@]}" \
			2>&1 >/dev/tty) ##Kernel Remover Menu
		  if [ "$?" -eq 0 ]; then ##Pressed Okay in Kernel-Remover
		    case $CHOICE in
			1)
			uname -r > '/tmp/space.txt'; ##Kernel Information, current linux Kernel
			  dialog --clear \
			  --backtitle "$BACKTITLE / Kernel Information" \
			  --title "    Linux Kernel" \
			  --textbox /tmp/space.txt 5 30;
			clear;
			;;
			2) ##Show all Kernel Images
			dpkg --list | grep linux-image > /tmp/space.txt;
			dialog --clear \
			--backtitle "$BACKTITLE / All Kernel Images & Configuration files" \
			--title "$TITLE" \
			--textbox /tmp/space.txt 18 70;
			clear;
			;;
			3) ##Show removable Kernel Images
			x=$(dpkg --list | grep -i linux-image | grep ^rc| awk '{ print $2}')
			printf "You have no unused Linux Kernel or config files,\nif field below is empty!:\n-------------------------------------------------------\n$x" > /tmp/space.txt;
			clear;
			dialog --clear \
			--backtitle "$BACKTITLE / Removable Kernel Images & Configuration Files" \
			--title "$TITLE" \
			--textbox /tmp/space.txt 18 70;
			clear;
			;;
			4) ##Remove Kernel Images
			x=$(dpkg --list | grep -i linux-image | grep ^rc| awk '{ print $2}')
			clear;
			    dialog --clear \
			    --backtitle "$BACKTITLE / Remove Kernel Images" \
			    --title "$TITLE" \
			    --msgbox "Listed kernels & config files can be removed.\nYou have no unused Linux Kernel or config files,\nif field below is empty!\n========================================================\n$x" 18 60;
			    dialog --clear \
			    --backtitle "$BACKTITLE / Remove Kernel Images" \
			    --title "$TITLE" \
			    --yesno "Do you want to remove previous shown Kernel Images & Configuration Files?" 6 40;
			if [ "$?" -eq 0 ]; then ##YESNO Remove Kernel Images YES
			    clear;
			    sudo apt-get --purge remove $x
			    dialog --clear \
			    --backtitle "$BACKTITLE / Remove Kernel Images" \
			    --title "$TITLE" \
			    --infobox "All Old Kernel Images & Configuration Files listed as 'rc' have been removed, please wait..." 9 20;
			    sleep 3;
			    clear;
			elif [ "$?" -eq 1 ]; then ##YESNO Remove Kernel Images NO
			    dialog \
				--infobox "cancelled..." 3 15;
				sleep 1.2;
				clear;
			fi
			;;
			5)
			while [[ 1 ]]
			do
			HEIGHT=12
			WIDTH=38
			CHOICE_HEIGHT=4
			BACKTITLE="$BACKTITLE / Purge old Kernels"
			TITLE="Purge Old Kernels"
			MENU="Please choose one of the following Options:"
			OPTIONS=(1 "Show old Kernels"
				 2 "Purge old Kernels"
				 3 "Install purge-old-kernels"
				 4 "Info")
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
			      printf "Make sure your current running Kernel is not on this list!\n----------------------------------------------------------\n" > /tmp/space.txt;
			      dpkg -l linux-{image,headers}-"[0-9]*" | awk '/^ii/{ print $2}' | grep -v -e `uname -r | cut -f1,2 -d"-"` | grep -e '[0-9]' >> /tmp/space.txt;
			      dialog --clear \
				     --backtitle "$BACKTITLE / Show old Kernels" \
				     --title "Show old Kernels" \
				     --textbox /tmp/space.txt 15 65;
			    ;;
			    2)
			    dpkg -s byobu &> /dev/null
			    if [ "$?" -eq 0 ]; then #purge-old-kernels Installed
			      dialog --clear \
				     --backtitle "$BACKTITLE / Remove Kernel Images" \
				     --title "$TITLE" \
				     --yesno "Are you sure you want to purge all Kernel besides the current one in use? " 7 40;
					if [ "$?" -eq 0 ]; then #purge-old-kernel yes
					   clear;
					   sudo purge-old-kernels
					   printf "\nPress Enter to Return to the Program\n"
					   read
					elif [ "$?" -eq 1 ]; then #purge-old-kernel no
					dialog \
					--infobox "cancelled..." 3 15;
					sleep 1.2;
					clear;
					fi
			    elif [ "$?" -eq 1 ]; then #purge-old-kernels not Installed
			    dialog --clear \
				   --title "$TITLE Info" \
				   --backtitle "$BACKTITLE / Purge Old Kernels" \
				   --msgbox "To use this Option,\nyou must first install 'purge-old-kernels'\nfrom the repositories\nor choose Option:\n'Install purge-old-kernels'\nin the menu." 11 31;
			    clear;
			    fi
			    ;;
			    3)
			      while [[ 1 ]]
			      do
			      HEIGHT=12
			      WIDTH=38
			      CHOICE_HEIGHT=2
			      BACKTITLE="$BACKTITLE"
			      TITLE="Install purge-old-kernels"
			      MENU="Please choose one of the following Options:"
			      OPTIONS=(1 "Install purge old Kernels"
				       2 "Remove purge-old-kernels")
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
			       clear;
			       printf "==========================================\n| Install 'purge-old-kernels'            |\n==========================================\n";
			       sudo apt-get install byobu;
			       printf "\nPress Enter to Return to the Program\n";
			       read
			       ;;
			       2)
			       clear;
			       printf "==========================================\n| Remove 'purge-old-kernels'             |\n==========================================\n";
			       sudo apt-get remove --purge byobu && sudo apt-get autoremove;
			       printf "\nPress Enter to Return to the Program\n";
			       read
			       ;;
			      esac
			      elif [ "$?" -eq 1 ]; then ##Cancel Install purge-old-kernels
			      break;
			      fi
			      done
			      ;;
			    4)
			    dialog --clear \
				   --title "Info" \
				   --backtitle "$BACKTITLE / Info" \
				   --msgbox "Only for 16.04!\nattempt this Option only if\n'sudo apt-get autoremove'\nfails to remove old kernel images automatically,\nor if you have manually installed Kernel where autoremove won't work!" 11 45;
				   clear;
			    ;;
			  esac
			elif [ "$?" -eq 1 ]; then ##Cancel in Force Kernel-Remover
			break;
			fi
			done
			;;
			6)
			##Understanding Package States
			dialog --clear \
			--title "$TITLE Info" \
			--backtitle "$BACKTITLE / Understanding Package States" \
			--msgbox "Understanding package states in Ubuntu and Debian Linux\n-------------------------------------------------------\n\nrc: It means package is in remove/deinstall state and only config file exists.\n\n-----\n\nii: It means package is in install state and it is 100% installed on the system" 15 70;
			clear;
			;;
			7) ##Kernel Remover Help
			printf "Kernel Remover Help - TIP!: Use Page Up & Page Down or the arrow keys to Scroll\n-------------------------------------------------------\n\nOption 1\nShow Current Kernel:\n\nDisplays the kernel version you are currently running.\n--------------------\n\nOption 2\nShow all Kernel Images:\n\nDisplays all Kernel Images & Configuration Files\nwith the respective install state displayed on the left as 'ii'\nor 'rc'.\n--------------------\n\nOption 3\nShow removable Kernel Images:\n\nDisplays all Kernel Images & Configuration Files listed as\nnot installed and shown as 'rc' in Option 2,\nand are removable.\n--------------------\n\nOption 4\nRemove Kernel Images:\n\nA Window Displays all Kernel Images & Configuration Files\nthat can be removed.\nA question Window will pop up, if you really want to remove\nthe previous listed kernel images & configuration files.\nIf you answered the question with yes,\nthe script will execute a\n'#apt-get --purge remove' command.\nThat will remove all packages that were found as 'not installed'.\nRoot privileges will be required.\nYou may update your Grub Bootloader after running this,\nso all your boot files are set for your next reboot.\nThis script will not update your boot configuration file!!\n--------------------\n\nOption 5\nPurge-Old-Kernels:\n\nRemoves all Kernel Images besides the one currently in use,\nindependent of their install state.\nUseful to clean up the /boot partition.\nOnly attempt this Option if\n'sudo apt-get autoremove'\nfails to remove old kernels automatically,\nor if you have manually installed Kernel where autoremove won't work!\n--------------------\n\nOption 6\nUnderstanding package states in Ubuntu and Debian Linux:\n\nDisplays a short Information about what package states are.\n--------------------\nNo Warranty whatsoever!" > /tmp/space.txt;
			dialog --clear \
			--backtitle "$BACKTITLE / Removable Kernel Images & Configuration Files" \
			--title "$TITLE" \
			--textbox /tmp/space.txt 25 90
			clear;
			;;
		    esac
		  elif [ "$?" -eq 1 ]; then ##Pressed Cancel in Kernel-Remover
		  break;
		  fi
		    done ## End while loop Kernel remover
		  ;;
		  6) ##Search Repository and Install Software
		  while [[ 1 ]]
		  do
		    clear;
		    HEIGHT=10
		    WIDTH=35
		    CHOICE_HEIGHT=2
		    BACKTITLE="PMP v.0.0.25 / Computer Maintenance / Search & Install Software"
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
			clear;
		  case $CHOICE in
		    1) ##Search Repository
			FILE=$(dialog --clear \
			--title "Search" \
			--stdout \
			--backtitle "$BACKTITLE / Search Repository" \
			--inputbox "Search the Repository for Programs:"  7 40) ;
		  if [ "$?" -eq 0 ]; then
			  printf "TIP! - Use the arrow keys 'up, down, left & right' to scroll,!\n------------------------------\n" > /tmp/space.txt;
			  apt-cache search $FILE >> /tmp/space.txt;
			  dialog --clear \
			  --backtitle "$BACKTITLE / Search Repository" \
			  --title "$TITLE" \
			  --textbox /tmp/space.txt 20 90;
		  elif [ "$?" -eq 1 ]; then
			  dialog \
			  --infobox "cancelled..." 3 15;
			  sleep 1;
		  fi
			;;
		    2) ##Install Software
			INSTL=$(dialog --clear \
			--title "Search" \
			--stdout \
			--backtitle "$BACKTITLE / Install Software" \
			--inputbox "Type in a Software Name to install something:"  7 40) ;
			if [ "$?" -eq 0 ]; then ##inputbox Okay
			    clear;
			    dialog \
			      --title "$TITLE" \
			      --backtitle "$BACKTITLE / Remove Software" \
			      --yesno "Do you really want to install\n$INSTL ?" 7 30 ;
			      if [ "$?" -eq 0 ]; then ##YESNO Install YES
				clear;
				sudo apt-get install $INSTL;
				printf "\nPress Enter to Return to the Program\n";
				read
			      elif [ "$?" -eq 1 ]; then ##YESNO Install NO
				dialog \
			      --infobox "cancelled..." 3 15;
			      sleep 1;
			      fi ##YESNO end 
			elif [ "$?" -eq 1 ]; then ##inputbox cancel
			    dialog \
			      --infobox "cancelled..." 3 15;
			    sleep 1;
			fi ##inputbox end
			;;
		    esac
		  elif [ "$?" -eq 1 ]; then ##inputbox Cancel
			  break;
		  fi
		  done
		  ;;
		  7)
          TITLE="PMP v.0.0.25 - Remove Software"
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
			  clear;
			  sudo apt-get remove --purge $PROGRAM;
			  printf "\nPress Enter to Return to the Program\n";
			  read
			  elif [ "$?" -eq 1 ]; then ##YESNO Remove Software NO
			  dialog \
			  --infobox "cancelled..." 3 15;
			  sleep 1;
			  fi
		  elif [ "$?" -eq 1 ]; then ##inputbox Cancel
		  dialog \
		      --infobox "cancelled..." 3 15;
		  sleep 1;
		  fi
		  ;;
		  8) ## Nvidia Driver Manager
		  while [[ 1 ]]
		  do
		  BACKTITLE="PMP v.0.0.25 / Computer Maintenance / Nvidia Driver Manager"
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
		      --textbox /tmp/space.txt 15 75;
		      ;;
		      2) ##Available Nvidia Driver
		      apt-cache search nvidia | grep -P '^nvidia-[0-9]+\s' > '/tmp/space.txt'
		      dialog --clear \
		      --backtitle "$BACKTITLE / Available Nvidia Driver" \
		      --title "$TITLE" \
		      --textbox /tmp/space.txt 20 75;
		      clear;
		      ;;
		      3) ##Install Nvidia Driver
		      BACKTITLE="$BACKTITLE / Install Nvidia Driver"
		      TITLE="Install Nvidia Driver"
		      dialog --clear \
		      --backtitle "$BACKTITLE" \
		      --title "Attention!" \
		      --msgbox "sudo is required for this!" 5 30;
		      DRVNR=$(dialog \
		      --title "$TITLE" \
		      --backtitle "$BACKTITLE" \
		      --stdout \
		      --inputbox "Type in a version number a.e, nvidia-340:" 7 40 nvidia-) ;
		      if [ "$?" -eq 0 ]; then
			      dialog \
				--title "$TITLE" \
				--backtitle "$BACKTITLE" \
				--yesno "Sure you want to install $DRVNR ?" 6 35; ##YESNO Nvidia driver
			    if [ "$?" -eq 0 ]; then ##YES Nvidia
				sudo apt-get install $DRVNR;
				printf "\nPress Enter to Return to the Program\n";
				read
			    elif [ "$?" -eq 1 ]; then ##NO Nvidia
				dialog \
				--infobox "cancelled..." 3 15;
			    sleep 1;
			    fi
		      elif [ "$?" -eq 1 ]; then
			  dialog \
			  --infobox "cancelled..." 3 15;
			    sleep 1;
		      fi
		      ;;
		      4) ##Remove Nvidia Driver
		      BACKTITLE="$BACKTITLE / Remove Nvidia Driver"
		      TITLE="Remove Nvidia Driver"
		      dialog --clear \
		      --backtitle "$BACKTITLE" \
		      --title "Warning!" \
		      --msgbox "This Option will delete all Nvidia driver installed on the System!.\n\nAdministrative privileges are required!." 10 35;
		      printf "Listing all currently installed Nvidia driver once more:\n\n" > /tmp/space.txt;
		      dpkg -l | grep nvidia >> /tmp/space.txt
		      dialog --clear \
		      --backtitle "$BACKTITLE" \
		      --title "$TITLE" \
		      --textbox /tmp/space.txt 25 80;
		         dialog \
		      --title "$TITLE" \
		      --backtitle "$BACKTITLE" \
		      --yesno "Everything related to nvidia will be removed!\nAre you sure you want to continue?" 8 35;
		      if [ "$?" -eq 0 ]; then ##YES remove Nvidia driver
		      clear;
		      sudo apt-get remove --purge nvidia-*
		      printf "\nPress Enter to return to the program.\n";
		      read
		      elif [ "$?" -eq 1 ]; then ##NO remove Nvidia driver
		      dialog \
		      --infobox "cancelled..." 3 15;
		      sleep 2;
		      fi
		      ;;
		      5) ##Help
		      printf "TIP - Use Page up & Page Down or the arrow keys to scroll.\n\n1.) Show Installed Driver --\n\nWill list any Nvidia drivers installed on your system.\n--------------------\n\n2.) Available Nvidia Driver --\n\nShows Nvidia drivers you can install.\n--------------------\n\n3.) Install Nvidia Driver --\n\nBe careful which driver you choose!.\nThe higher the version number is, the newer is the driver.\nCompatibility is not always working!.\nLook under your available drivers\nand type in the version number you want to install.\nThe driver will be installed from your repository.\n--------------------\n\n4.) Remove all Nvidia Driver --\n\nIf you installed a wrong driver,\nthe computer could start with a black screen\nand nothing would show up anymore.\nIf that happens you can do the following:\nLet your system boot up normally and\njust ignore the black screen for a moment.\nPress 'Ctrl + Alt + F1'.\nThis is how you get into a Terminal called 'tty'.\nOn a regular Linux Desktop, you can usually open a tty 1-6\nwith all keys between F1 - F6 respectively.\n'Ctrl + Alt + F7' will bring you back to your Desktop.\nIt will ask you for your login details.\nIn the upper left corner type in your username\nand press Enter.\nNext, type in your normal login password.\n*You won't see the password you type,\nbut it's beeing registered.\nWhen you are logged in, you have control over your terminal.\nNow you can remove the non working driver with:\n\n          sudo apt-get remove --purge nvidia-*\n-To remove everything from Nvidia.\n\n-Or define the version number a.e:\n          sudo apt-get remove --purge nvidia-340\n\nYou can also follow these steps and open this program\nin your tty!.\nwith ./PMP0.0.25.sh and choose Option 4\n'Remove Nvidia driver'\nto remove any Nvidia drivers you have installed." > /tmp/space.txt;
		      dialog --clear \
			     --title "Nvidia Driver Manager - Help" \
			     --backtitle "$BACKTITLE" \
			     --textbox /tmp/space.txt 20 66;
		      ;;
		      6)
		      while [[ 1 ]]
			do
		      HEIGHT=11
		      WIDTH=35
		      CHOICE_HEIGHT=4
		      BACKTITLE="PMP v.0.0.25 / Computer Maintenance / Nvidia Driver Manager / Nvidia Prime-select"
		      TITLE="PMP - Nvidia Prime-select"
		      MENU="ONLY FOR NVIDIA PRIME/OPTIMUS"
		      OPTIONS=(1 "Select Nvidia GPU"
			       2 "Select Intel GPU"
			       3 "Currently running GPU"
			       4 "Logout")
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
		      clear;
			sudo prime-select nvidia;
			printf "You selected:"
		      prime-select query
		      sleep 2;
		      ;;
		      2) ##select Intel GPU
		     clear;
			sudo prime-select intel;
			printf "You selected:"
		      prime-select query
		      sleep 2;
		      ;;
		      3) ##Currently running
		      prime-select query > '/tmp/space.txt'
			dialog --backtitle "$BACKTITLE / Currently running" \
			--textbox /tmp/space.txt 5 20
		      clear;
              ;;
              4)
              dialog --title "PMP - Logout" \
                     --backtitle "$BACKTITLE / Logout" \
                     --yesno "Do you want to logout of the current Session?" 6 33;
              if [ "$?" -eq 0 ]; then ##Yes Log out
                loginctl session-status > /tmp/space.txt;
                SESSION=$(awk '{print $1; exit}' /tmp/space.txt)
                    dialog --title "$TITLE" \
                           --backtitle "$BACKTITLE" \
                           --pause "Logging out..." 8 30 20;
                            if [ "$?" -eq 0 ]; then
                            loginctl terminate-session $SESSION;
                            elif [ "$?" -eq 1 ]; then
                            dialog --title "Cancel" --backtitle "$BACKTITLE" --infobox "cancelled..." 3 15;
                            sleep 1.5;
                            clear;
                            fi
              elif [ "$?" -eq 1 ]; then ##No Log output
              dialog --infobox "cancelled..." 3 15;
              sleep 2;
              clear;
              fi
              ;;
			esac
		      elif [ "$?" -eq 1 ]; then ##Cancel Nvidia Prime-select
		    clear;
		  break;
		      fi
                done
		      esac ##end Nvidia Driver Manager menu
		  elif [ "$?" -eq 1 ]; then
		  break;
		  fi
		  done
		  ;;
		  9)
            while [[ 1 ]]
			  do
			  COMMAND=$(dialog --clear \
					   --title "Run Command" \
					   --stdout \
					   --backtitle "$BACKTITLE / Run Command" \
					   --inputbox "Enter Command:"  7 40)
			  if [ "$?" -eq 0 ]; then ##Okay Command
			  clear;
			  $COMMAND
			  printf "\nPress Enter to return to the program.\n";
			  read
			  elif [ "$?" -eq 1 ]; then ##Cancel Command
			    break;
			  fi
			  done
		  ;;
		  10) ##Next Page
		  while [[ 1 ]]
		      do
		      clear;
		      HEIGHT=17
		      WIDTH=45
		      CHOICE_HEIGHT=4
		      BACKTITLE="PMP v.0.0.25 / Computer Maintenance"
		      TITLE="Computer Maintenance"
		      MENU="Select one of the following Options:"

		      OPTIONS=(1 "Find Linux Support"
				2 "Set Up Wifi USB Adapter"
				3 "Install a Printer"
				4 "Program Problem detected FIX")

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
                dpkg -s irssi &> /dev/null; #Check's if irssi is installed
                if [ "$?" -eq 0 ]; then ##Irssi Installed
                    while [[ 1 ]]
                        do
                        HEIGHT=13
                        WIDTH=35
                        CHOICE_HEIGHT=3
                        BACKTITLE="PMP v.0.0.25 / Computer Maintenance / Find Linux Support"
                        TITLE="Get Support"
                        MENU="Select one:"
                        OPTIONS=(1 "Connect to Freenode"
                                2 "How to Register"
                                3 "Freenode Channel list")
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
                            --backtitle "$BACKTITLE" \
                            --stdout \
                            --inputbox "Type in your Nickname:" 7 40)
                                if [ "$?" -eq 0 ]; then ##Okay Nickname
                                PW=$(dialog \
                                --title "$TITLE" \
                                --backtitle "$BACKTITLE" \
                                --stdout \
                                --insecure \
                                --passwordbox "freenode.net password:" 7 40)
                                if [ "$?" -eq 0 ]; then ##Okay Password
                                    irssi --connect=$SERVER --password=$PW --port=$PORT --nick=$NICK
                                elif [ "$?" -eq 1 ]; then ##Cancel Password
                                    dialog \
                                    --infobox "cancelled..." 3 15;
                                    sleep 2;
                                    fi ##End freenode Password
                                elif [ "$?" -eq 1 ]; then ##Cancel Nickname
                                    dialog \
                                    --infobox "cancelled..." 3 15;
                                    sleep 2;
                                fi ## end Nickname Freenode
                            ;;
                            2) ##How to Register
                            printf "Leave the password field blank and type:\n\n/msg NickServ REGISTER password youremail@example.com\n\ninto Irssi to register an account on freenode.\nYou need to verify your e-mail address\nbefore you are able to log in.\n\nyou can find more information here:\n'https://freenode.net/kb/answer/registration" > /tmp/space.txt
                            dialog \
                            --title "$TITLE" \
                            --backtitle "$BACKTITLE / How to Register" \
                            --textbox /tmp/space.txt 14 58;
                            clear;
                            ;;
                            3) ##Freenode Channel list
                            printf "TIP! - Use Page up & Page Down or the arrow keys to scroll:\nTo join channels,\nuse: /join #channelname\nHere are some support channels for Linux:\n---------------------------------------------------------------\n##Linux      General Linux support channel.\n#debian      Debian help channel\n#ubuntu      Ubuntu help channel\n#kubuntu     Kubuntu help channel\n#xubuntu     Xubuntu help channel\n#lubuntu     Lubuntu help channel\n#edubuntu    Edubuntu help channel\nFind even more Ubuntu Support Channels near you at:\nhttps://wiki.ubuntu.com/IRC/ChannelList\n---------------------------------------------------------------\n" > /tmp/space.txt;
                            dialog --clear \
                                --title "$TITLE" \
                                --backtitle "$BACKTITLE / Freenode Channel list" \
                                --textbox /tmp/space.txt 20 65;
                            ;;
                            esac
                        elif [ "$?" -eq 1 ]; then ##Cancel Find Support on Freenode
                        break;
                        fi
                        done
                elif [ "$?" -eq 1 ]; then ##Irssi Not Installed
                    clear;
                        dialog \
                        --title "$TITLE" \
                        --backtitle "$BACKTITLE / Find Linux Support" \
                        --yesno "Irssi is not installed.\nDo you want to install Irssi?" 6 33;
                            if [ "$?" -eq 0 ]; then #Yes Install Irssi
                                clear;
                                sudo apt-get install irssi;
                            elif [ "$?" -eq 1 ]; then #No Install Irssi
                            clear;
                            dialog --title "Cancel" --backtitle "$BACKTITLE / Find Linux Support" --infobox "cancelled..." 3 15;
                            sleep 1.2;
                            fi
                fi ##end
			  ;;
			  2) ## Set Up Wifi Usb Adapt-geter
			  while [[ 1 ]] 
                do
                    clear;
                    HEIGHT=18
                    WIDTH=55
                    CHOICE_HEIGHT=10
                    BACKTITLE="PMP v.0.0.25 / Computer Maintenance / PMP Wifi"
                    TITLE="PMP Wifi 0.0.4"
                    MENU="Select one of the following Options:"

                    OPTIONS=(1 "Quick Wifi Installer"
                        2 "Install Driver Utilities"
                        3 "Install Wifi Driver"
                        4 "Show Driver Configuration"
                        5 "Add Driver to Startup"
                        6 "Start Wifi Driver"
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
                    TITLE="PMP Wifi 0.0.4"
                    BACKTITLE="PMP v.0.0.25 / PMP Wifi / Quick WiFi Installer"
                        dialog \
                        --title "$TITLE" \
                        --backtitle "$BACKTITLE" \
                        --msgbox "You need to choose the '.inf ' file in the next step.\n\nExample: '/home/user/wifidriver/driver.inf'\n\nYou can find more Information under 'Help' in the Main Menu." 14 60;
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
                        clear;
                        printf "==========================================\n|1. Quick WiFi Installer 0.0.4           |\n==========================================\n";
                        sudo apt-get install dkms ndiswrapper-utils-1.9 ndiswrapper-common ndisgtk ndiswrapper-dkms gksu ndiswrapper-source;
                        clear;
                        dialog \
                        --title "please wait..." \
                        --backtitle "$BACKTITLE" \
                        --infobox "Installing .inf Driver..." 3 40;
                        sleep 0.5;
                        sudo ndiswrapper -i $FILE
                            dialog \
                            --title "please wait..." \
                            --backtitle "$BACKTITLE" \
                            --infobox "Adding Ndiswrapper to Startup..." 3 40;
                        sleep 0.5;
                        sudo ndiswrapper -ma
                            dialog --title "please wait..." \
                            --backtitle "$BACKTITLE" \
                            --infobox "Modprobing Driver..." 3 40;
                        sleep 0.5;
                        sudo modprobe -v ndiswrapper;
                        clear;
                            dialog \
                            --title "$TITLE" \
                            --backtitle "$BACKTITLE" \
                            --msgbox "Replug* your Wifi Stick and Wait about 20 seconds to test your WiFi Stick.\n\nIs your Wifi still not functioning?\nyou might have installed the wrong .inf driver...\n\nUse 'Option 7. 'Delete Ndiswrapper driver' in PMP WiFi v.0.0.4\nto delete any drivers.\n\nAfter pressing 'OK', the driver status will be displayed." 15 80;
                        clear;
                        printf "The Driver status below must display,\n'driver installed' to work properly!:\n=====================================\n\n" > /tmp/space.txt;
                        sudo ndiswrapper -l >> /tmp/space.txt ##Driver Status
                            dialog \
                            --title "$TITLE" \
                            --backtitle "$BACKTITLE" \
                            --textbox /tmp/space.txt 12 45;
                        clear;
                        elif [ "$?" -eq 1 ]; then ##No Wifi driver
                            dialog \
                        --title "$TITLE" \
                        --backtitle "$BACKTITLE" \
                        --msgbox "You will need an .inf file to install any Wifi Drivers.\n\nRestart the program and give it the right path.\n\nGoodbye." 12 40;
                        fi
                    elif [ "$?" -eq 1 ]; then ##Okay Fselect
                        dialog --infobox "cancelled..." 3 16;
                    fi
                    ;;
                    2) ##Installing Driver Utilities
                    TITLE="PMP Wifi 0.0.4"
                    BACKTITLE="PMP v.0.0.25 / PMP Wifi / Installing Driver Utilities"
                        dialog \
                        --title "$TITLE" \
                        --backtitle "$BACKTITLE" \
                        --yesno "Do you want to install the Ndiswrapper Utility from the Repository?" 7 40;
                    if [ "$?" -eq 0 ]; then
                    clear;
                        printf "==========================================\n|2. Installing Driver Utilities          |\n==========================================\n";
                    sudo apt-get install dkms ndiswrapper-utils-1.9 ndiswrapper-common ndisgtk ndiswrapper-dkms gksu ndiswrapper-source;
                    elif [ "$?" -eq 1 ]; then
                        dialog \
                        --title "$TITLE" \
                        --backtitle "$BACKTITLE" \
                        --infobox "cancelled..." 3 16;
                    sleep 3;
                    clear;
                    fi
                    ;;
                    3) ##Install WiFi Driver
                    TITLE="PMP Wifi 0.0.4"
                    BACKTITLE="PMP v.0.0.25 / PMP Wifi / Install WiFi Driver"
                        dialog \
                        --title "$TITLE" \
                        --backtitle "$BACKTITLE" \
                        --msgbox "Please choose the .inf file in the next step,\nExample: /home/user/wifidriver/driver.inf\n\nYou can find more Information under 'Help' in the PMP WiFi Menu.\n\nINFO: Be sure to get your driver in the right Architecture 32 or 64 bit!" 13 50;
                    FILE=$(dialog \
                        --title "$TITLE" \
                        --backtitle "$BACKTITLE" \
                        --stdout \
                        --title "Please choose the .inf file" \
                        --fselect $HOME/  8 60)
                    if [ "$?" -eq 0 ]; then ##Fselect Install WiFi Driver YES
                        dialog \
                        --title "$TITLE" \
                        --backtitle "$BACKTITLE" \
                        --yesno "Continue Installing this .inf file?\n\n\n$FILE ?" 10 40;
                        if [ "$?" -eq 0 ]; then ##YES .inf driver
                        dialog \
                        --title "$TITLE" \
                        --backtitle "$BACKTITLE" \
                        --pause "starting sudo\nPlease Wait..." 10 30 3;
                        clear;
                        printf "==========================================\n|3. Install a Driver                     |\n==========================================\n";
                        sudo ndiswrapper -i $FILE;
                        let x=5;while [ $x -gt 0 ];do echo "$x";let x=$x-1;sleep 1;done
                        clear;
                        printf "The Driver status shown below\nmust display: 'driver installed'\nto work properly!:\n=====================================\n\n" > /tmp/space.txt;
                        sudo ndiswrapper -l >> /tmp/space.txt ##Driver Status
                        dialog \
                        --title "$TITLE" \
                        --backtitle "$BACKTITLE" \
                        --textbox /tmp/space.txt 11 40;
                        clear;
                        dialog \
                        --title "$TITLE" \
                        --backtitle "$BACKTITLE" \
                        --infobox "please wait..." 3 20;
                    sleep 3;
                        elif [ "$?" -eq 1 ]; then ##NO .inf driver
                        dialog --title "$TITLE" --backtitle "$BACKTITLE" --msgbox "You will need the .inf file to install any Wifi Drivers.\n\nPlease restart the program and give it the right path to the .inf File" 9 40;
                        clear;
                        fi
                    elif [ "$?" -eq 1 ]; then ##Fselect Install WiFi Driver NO
                        dialog \
                        --backtitle "$BACKTITLE" \
                        --infobox "cancelled..." 3 16;
                        sleep 1.2;
                    fi
                    ;;
                    4) ##Driver Configuration
                    x=$(ls -rl /etc/ndiswrapper/*/* > /tmp/space.txt)
                        dialog \
                        --title "Driver Configuration" \
                        --backtitle "PMP v.0.0.25 / PMP Wifi / Driver Configuration" \
                        --textbox /tmp/space.txt 20 100;
                    ;;
                    5) ##Set Ndiswrapper to Startup
                    TITLE="PMP Wifi 0.0.4"
                    BACKTITLE="PMP v.0.0.25 / PMP Wifi / Set Ndiswrapper to Startup"
                        dialog \
                        --title "$TITLE" \
                        --backtitle "$BACKTITLE" \
                        --yesno "Do you want to add the Ndiswrapper Utilitie to the Systemstart?" 6 40;
                    if [ "$?" -eq 0 ]; then
                    clear;
                        printf "==========================================\n|5. Add Ndiswrapper to Systemstart       |\n==========================================\n";
                        printf "starting sudo...\n"
                        sudo ndiswrapper -ma
                        dialog \
                        --backtitle "$BACKTITLE" \
                        --infobox "Done!\nPlease Wait..." 4 21
                        sleep 3;
                        clear
                    elif [ "$?" -eq 1 ]; then
                        dialog --title "$TITLE" --backtitle "$BACKTITLE" --infobox "cancelled..." 3 16;
                        sleep 3;
                    clear;
                    fi
                    ;;
                    6) ##Load Ndiswrapper Module
                    TITLE="PMP Wifi 0.0.4"
                    BACKTITLE="PMP v.0.0.25 / PMP Wifi / Load Ndiswrapper Module"
                        dialog \
                        --title "$TITLE" \
                        --backtitle "$BACKTITLE" \
                        --yesno "Do you want to start the Ndiswrapper Module?" 6 30;
                    if [ "$?" -eq 0 ]; then ##Yes Modprobe
                        clear
                        printf "==========================================\n|6. Load Ndiswrapper Module              |\n==========================================\n";
                        printf "starting sudo...\n";
                        sudo modprobe -v ndiswrapper
                    elif [ "$?" -eq 1 ]; then ##No Modprobe
                        dialog --title "$TITLE" --backtitle "$BACKTITLE" --infobox "cancelled..." 3 16;
                    sleep 3;
                    clear;
                    fi
                    ;;
                    7) ##Remove WiFi driver
                    TITLE="PMP Wifi 0.0.4"
                    BACKTITLE="PMP v.0.0.25 / PMP Wifi / Remove WiFi driver"
                    clear;
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
                        --pause "starting sudo..." 8 35 3;
                        clear;
                        sudo ndiswrapper -r $x;
                        clear;
                        dialog \
                        --title "$TITLE" \
                        --backtitle "$BACKTITLE" \
                        --infobox "$x was removed.\nplease wait..." 4 30;
                    sleep 3;
                        clear;
                    elif [ "$?" -eq 1 ]; then ##No Remove Wifi driver
                        dialog \
                        --backtitle "$BACKTITLE" \
                        --infobox "cancelled..." 3 16;
                        sleep 1.2;
                    fi
                    ;;
                    8) ##Remove Driver Utilities
                    TITLE="PMP Wifi 0.0.4"
                    BACKTITLE="PMP v.0.0.25 / PMP Wifi / Remove Driver Utilities"
                        dialog \
                        --title "$TITLE" \
                        --backtitle "$BACKTITLE" \
                        --yesno "Do you want to remove the Ndiswrapper Utility completely from your system?" 6 50;
                    if [ "$?" -eq 0 ]; then ##YES Remove Ndiswrapper
                        clear;
                    printf "==========================================\n|8. Remove Ndiswrapper                   |\n==========================================\n";
                        sudo apt-get remove --purge ndiswrapper*
                    let x=5;while [ $x -gt 0 ];do echo "$x";let x=$x-1;sleep 1;done
                        dialog  \
                        --title "$TITLE" \
                        --backtitle "$BACKTITLE" \
                        --msgbox "DONE!.\n\nTo clear all configuration files, check /etc/ndiswrapper/ or use Option 7 in the PMP Wifi menu." 10 40;
                        clear;
                    elif [ "$?" -eq 1 ]; then ##NO Remove Ndiswrapper
                        dialog --title "$TITLE" \
                        --backtitle "$BACKTITLE" \
                        --infobox "cancelled...." 3 16;
                    sleep 1.2;
                    clear;
                    fi
                    ;;
                    9) ##HELP PMP WIFI
                    printf "PMP WiFi Help - TIP - You can use the arrow keys to scroll!\n==============================\n|1.Tutorial: GET A DRIVER!!! |\n==============================\n\n============================================================================\nIMPORTANT INFO: The .inf file holds all the necessary driver information!!!.\n============================================================================\n\n1.) Make a New Folder in /Home\n2.) Download a Microsoft Windows® Wifi driver for your Wifi USB Stick to the\n    New Folder we've just created\n3.) Extract the Windows .exe in your new Folder\n4.) There should be an .inf and the .sys File located in your folder!\n\n5.) Remember the path to the .inf file somewhere\nExample: '/home/user/wifidriver/driverexample.inf'\n\nINFO: Be sure to get your Driver in the right Architecture 32bit or 64bit\n\nIf you installed a wrong Driver,\nchoose,\nOption 7) -- Delete Ndiswrapper driver\nto delete any Drivers Installed\n\n==============================\n|2. Options                  |\n==============================\n\n=======================================================\nOption 1) -- Quick WiFi Installer <---recommended if unsure.\nInsert the .inf path of your driver and Press install.\nEverything will be installed and loaded in one rush.\nA Lan connection is required.\nDon't have a driver preinstalled when running this!\n=======================================================\n\n=======================================================\nOption 2) -- Install Driver Utilities\nInstall's the Driver Utility, Ndiswrapper from the repository.\n=======================================================\n\n=======================================================\nOption 3) -- Install Wifi Driver\nIs the Driver Installation Process\nFollow the Tutorial 1 GET A DRIVER\nKeep your .inf File ready!!!\nYou will need to specify the .inf path there\nExample: /home/user/wifidriver/driverexample.inf\n=======================================================\n\n=======================================================\nOption 4) -- Show Driver configuration\nShows you the current Driver Configuration you have Installed\n=======================================================\n\n=======================================================\nOption 5) -- Add Driver to Startup\nSet's Ndiswrapper as a Start-up Program.\nThen your Driver will start automatically\nwhen your system boot's up\n=======================================================\n\n=======================================================\nOption 6) -- Start Driver  \nStarts Ndiswrapper and it's Drivers.\nYou will need to 'replug' your stick and wait about 20 seconds\nafter you loaded the ndiswrapper module.\nDon't worry, It will spit out a notification.\nMake sure your Wifi Stick is inserted\nand Drivers are installed before executing this Option.\n=======================================================\n\n=======================================================\nOption 7) -- Remove Wifi Driver  \nWill Delete installed drivers.\nYou will be promted for a password.\nThe removable driver will be shown in a field.\n=======================================================\n\n=======================================================\nOption 8) -- Remove Driver Utilities\nWill remove Ndistwrapper from your system.\n=======================================================\n\n=======================================================\nOption 9) -- Help\nIs the Section you are currently reading.\n=======================================================\n\n=======================================================\nOption 10) -- About\nAbout PMP.\n=======================================================\n\n=======================================================\nOption 11) -- Exit\nExit's PMP.\n=======================================================\n" > /tmp/space.txt;
                    dialog \
                    --backtitle "$BACKTITLE / HELP" \
                    --title "HELP" \
                    --colors \
                    --textbox /tmp/space.txt 25 80;
                    clear;
                    ;;
                    10) ##About PMP Wifi
                    printf "PMP WiFi 0.0.4\nPersonal Maintain Program\nver. 0.0.25\n\nwritten by Kali_Yuga\n2017-2018\npoorly programmed. :D\n---------------------------\nAll Debian!.\nOnly runs with Debian Systems, like Debian, Ubuntu or Mint.\n\nHelps installing & setting up Ndiswrapper!\n\nMade for beginners that switched from Windows\nto Linux.\n\nEasy Update & Maintain your System on the Terminal\nwithout having to know commands\nthis Bash script is not professional made.!\njust a learning bash script for me.\nNo Warranty whatsoever!." > /tmp/space.txt;
                    TITLE="About"
                    BACKTITLE="PMP v.0.0.25 / PMP Wifi / About"
                        dialog \
                        --title "$TITLE" \
                        --backtitle "$BACKTITLE" \
                        --textbox /tmp/space.txt 25 80;
                    clear;
                    ;;
                    esac
                    elif [ "$?" -eq 1 ]; then ##CANCEL PMP Wifi
                    break;
                fi
              done   
			  ;;
			  3)
			  while [[ 1 ]]
			  do
			  HEIGHT=13
			  WIDTH=35
			  CHOICE_HEIGHT=5
			  BACKTITLE="PMP v.0.0.25 / Computer Maintenance / Install a Printer"
			  TITLE="PMPrinter"
			  MENU="Select one:"
			  OPTIONS=(1 "Install HP Printer"
				   2 "Install Brother Printer"
				   3 "Install Epson Printer"
				   4 "Install Canon Printer"
				   5 "Info")
			  CHOICE=$(dialog --clear \
			      --backtitle "$BACKTITLE" \
			      --title "$TITLE" \
			      --menu "$MENU" \
			      $HEIGHT $WIDTH $CHOICE_HEIGHT \
			      "${OPTIONS[@]}" \
			      2>&1 >/dev/tty)
			  if [ "$?" -eq 0 ]; then ##Okay Install a Printer
			    case $CHOICE in
			      1)
			      dialog --clear \
				     --title "$TITLE" \
				     --backtitle "$BACKTITLE / Install HP Printer" \
				     --yesno "Do you want to install HP driver package HPLIP?" 6 40;
				     if [ "$?" -eq 0 ]; then ##YES Install HPLIP
				      clear
				      printf "==========================================\n| Install HP Printer                     |\n==========================================\n";
				      sudo apt-get install hplip && sudo apt-get install hplip-gui;
				      printf "\nPress Enter to Return to the Program\n";
				      read
				     elif [ "$?" -eq 1 ]; then ##NO Install HPLIP
				     dialog --infobox "cancelled..." 3 15;
				     sleep 2;
				     fi
			      ;;
			      2)
			      dialog --clear \
				     --title "$TITLE" \
				     --backtitle "$BACKTITLE / Install Brother Printer" \
				     --yesno "Open the Product Search Website ?" 5 40
				     if [ "$?" -eq 0 ]; then ##YES Brother Product Search
					xdg-open "http://support.brother.com/g/b/productsearch.aspx?c=us&lang=en"
					 printf "Search your Printer Model on this Website.\nFor OS Family choose Linux.\nFor OS Version select Linux (deb).\nAnd Download 'Driver Install Tool'\nAfter the Download continue the\nInstructions on the Website.\nInfo: Instructions will be shown\n      automatically after the Download" > /tmp/space.txt;
					dialog --clear \
					       --backtitle "$BACKTITLE" \
					       --title "$TITLE" \
					       --textbox /tmp/space.txt 12 50
				     elif [ "$?" -eq 1 ]; then ##NO Brother Product Search
				     dialog --infobox "cancelled..." 3 15;
				     sleep 2;
				     fi
			      ;;
			      3)
			      dialog --clear \
				     --title "$TITLE" \
				     --backtitle "$BACKTITLE / Install Epson Printer" \
				     --yesno "Open the Product Search Website ?" 5 40
				     if [ "$?" -eq 0 ]; then ##YES Epson Product Search
				      xdg-open "http://download.ebz.epson.net/dsc/search/01/search/?OSC=LX";
				     elif [ "$?" -eq 1 ]; then ##NO Epson Product Search
				     dialog --infobox "cancelled..." 3 15;
				     sleep 2;
				     fi
			      ;;
			      4)
			      dialog --clear \
				     --title "$TITLE" \
				     --backtitle "$BACKTITLE / Install Canon Printer" \
				     --yesno "Open the Product Search Website ?" 5 40
				     if [ "$?" -eq 0 ]; then ##YES Canon Product Search
				      xdg-open "https://www.usa.canon.com/internet/portal/us/home/support/";
				     elif [ "$?" -eq 1 ]; then ##NO Canon Product Search
				     dialog --infobox "cancelled..." 3 15;
				     sleep 2;
				     fi
			      ;;
			      5)
			      printf "If you want to install a Driver for your\nPrinter it is recommended to install\nthe '.deb' file from the official Websites.\nClick on one of the Options in the Menu.\nIt will take you to the\nOfficial Download Pages.\nHP Printers can be installed with the\nhplip package from the repositories." > /tmp/space.txt
			      dialog --clear \
				     --backtitle "$BACKTITLE / Info" \
				     --title "$TITLE" \
				     --textbox /tmp/space.txt 12 50;
			      ;;
			    esac
			  elif [ "$?" -eq 1 ]; then ##Cancel Install a Printer
			  break;
			  fi
			  done
			  ;;
			  4) ##Program Problem detected FIX
			  clear;
			  printf "==========================================\n";
			  printf "|   System Program Problem detected FIX  |\n";
			  printf "==========================================\n";
			  sudo rm /var/crash/*
			  sleep 1;
			  clear;
			  ;;
			  esac
		      elif [ "$?" -eq 1 ]; then ##Cancel Computer Maintenance 
		      clear;
		      break;
		      fi
		      done
		      ;;
    esac ## end statement Menu Options Computer Maintenance
	elif [ "$?" -eq 1 ]; then ##CANCEL Computer Maintenance Menu
		break;
	fi
	done ##end Computer Maintenance Menu
	;;
    2) ##System Monitor
	while [[ 1 ]]
	do
	    clear;
	    HEIGHT=17
	    WIDTH=45
	    CHOICE_HEIGHT=10
	    BACKTITLE="PMP v.0.0.25 / System Monitor"
	    TITLE="System Monitor"
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
		    df -h > '/tmp/space.txt';
		    dialog --clear \
		    --backtitle "$BACKTITLE / Disk Space" \
		    --title "$TITLE" \
		    --textbox /tmp/space.txt 20 75;
		    clear;
		    ;;
		    2) ##USB Devices
		    lsusb > '/tmp/space.txt';
		    dialog --clear \
		    --backtitle "$BACKTITLE / Connected USB Devices" \
		    --title "USB Devices" \
		    --textbox /tmp/space.txt 20 85;
		    clear;
		    ;;
		    3) ##PCI
		    printf "TIP! - You can use the arrow keys 'up, down, left & right' to scroll!\n" > /tmp/space.txt;
		    lspci >> '/tmp/space.txt';
		    dialog --clear \
		    --backtitle "$BACKTITLE / PCI & Graphics Card Information" \
		    --title "PCI Devices" \
		    --textbox /tmp/space.txt 20 150;
		    clear;
		    ;;
		    4) ##RAM
		    free -h > '/tmp/space.txt';
		    dialog --clear \
		    --backtitle "$BACKTITLE / RAM Information" \
		    --title "Memory Information" \
		    --textbox /tmp/space.txt 10 84;
		    clear;
		    ;;
		    5) ##process Manager
		    while [[ 1 ]]
		    do
		    clear;
		    HEIGHT=12
		    WIDTH=40
		    CHOICE_HEIGHT=5
		    BACKTITLE="PMP v.0.0.25 / System Monitor / Process Manager"
		    TITLE="PMP - Process Manager 0.0.2"
		    MENU="Select one of the following Options:"

		    OPTIONS=(1 "List Processes by CPU Usage"
			    2 "List Processes by ID"
			    3 "Kill Process by ID"
			    4 "Kill Process by Name"
			    5 "Kill with Mouse cursor")

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
		      dpkg -s htop &> /dev/null; #Check's if htop is installed
		      if [ "$?" -eq 0 ]; then #htop installed
		      clear
		      printf "Hit 'Q' to return to the Program...\n";
		      sleep 2.1
		      clear;
		      htop
		      elif [ "$?" -eq 1 ]; then #htop not installed
                dialog \
                --title "$TITLE" \
                --backtitle "$BACKTITLE" \
                --yesno "Htop is not installed.\nDo you want to install htop?" 6 33;
                    if [ "$?" -eq 0 ]; then #Yes Install htop
                        clear;
                        sudo apt-get install htop;
                    elif [ "$?" -eq 1 ]; then #No Install htop
                        clear;
                        dialog --title "Cancel" --backtitle "$BACKTITLE" --infobox "cancelled..." 3 15;
                        sleep 1.2;
                    fi
		      fi
		      ;;
		      2)
		      printf "TIP! - You can use the arrow keys 'up, down, left & right' to scroll!\n" > /tmp/space.txt;
		      ps -ef >> /tmp/space.txt;
		      dialog --clear \
			    --backtitle "$BACKTITLE / List Processes by ID" \
			    --title "Processes by ID" \
			    --textbox /tmp/space.txt 25 150;
			    clear;
		      ;;
		      3)
		      PID=$(dialog \
			    --title "$TITLE" \
			    --backtitle "$BACKTITLE / Kill Process by ID" \
			    --stdout \
			    --inputbox "Type in a valid PID to kill it:" 7 40)
			    if [ "$?" -eq 0 ]; then
		      kill $PID
		      dialog \
		      --backtitle "$BACKTITLE" \
		      --infobox "Process ID $PID killed" 3 32;
		      sleep 2;
			  elif [ "$?" -eq 1 ]; then
			  clear;
			  fi
		      ;;
		      4)
		      prc=$(dialog \
			    --title "$TITLE" \
			    --backtitle "$BACKTITLE / Kill Process by Name" \
			    --stdout \
			    --inputbox "Type in a Process you want to kill a.e 'firefox':" 7 40)
			    if [ "$?" -eq 0 ]; then
		      dialog --clear \
			    --title "$TITLE" \
			    --backtitle "$BACKTITLE / Kill Process by Name" \
			    --yesno "Do you really want to kill '$prc'?" 5 45;
			    if [ "$?" -eq 0 ]; then
			    killall $prc;
			    elif [ "$?" -eq 1 ]; then
			    dialog --infobox "cancelled..." 3 16;
				sleep 1.2;
			    fi
			    elif [ "$?" -eq 1 ]; then
			    clear;
			    fi
		      ;;
		      5)
		      clear;
		      printf "Cancel Action with right Click!\n"
		      xkill
		      ;;
		    esac
		    elif [ "$?" -eq 1 ]; then
		    break;
		    fi
		    done
		    ;;
		    6)
		    dpkg -s acpi &> /dev/null; #Check's if Acpi is installed
                if [ "$?" -eq 0 ]; then #Acpi installed
                    while [[ 1 ]]
                    do
                    HEIGHT=12
                    WIDTH=40
                    CHOICE_HEIGHT=2
                    TITLE="Battery & Power"
                    BACKTITLE="PMP v.0.0.25 / System Monitor / Battery & Power Info"
                    MENU="Select one:"
                    OPTIONS=(1 "Power Status"
                             2 "Show more Info")
                    CHOICE=$(dialog --clear \
                                    --backtitle "$BACKTITLE" \
                                    --title "$TITLE" \
                                    --menu "$MENU" \
                    $HEIGHT $WIDTH $CHOICE_HEIGHT \
                    "${OPTIONS[@]}" \
                    2>&1 >/dev/tty)
                        if [ "$?" -eq 0 ]; then ##okay Battery & Power Info
                            case $CHOICE in
                            1) #Power Status
                            acpi > '/tmp/space.txt'
                            dialog --clear \
                                   --backtitle "PMP v.0.0.25 / System Monitor / Battery & Power Info / Power Status" \
                                   --title "$TITLE" \
                                   --textbox /tmp/space.txt 5 100;
                            clear;
                            ;;
                            2) #Show more Info
                            acpi -b -a -t > '/tmp/space.txt'
                            dialog --clear \
                                   --backtitle "PMP v.0.0.25 / System Monitor / Battery & Power Info / More Battery Information" \
                                  --title "$TITLE" \
                                  --textbox /tmp/space.txt 8 55;
                            clear;
                            ;;
                            esac
                        elif [ "$?" -eq 1 ]; then ##Cancel Battery & Power Info
                            break;
                            fi
                        done
                    elif [ "$?" -eq 1 ]; then #Acpi not installed
                        BACKTITLE="PMP v.0.0.25 / System Monitor / Battery & Power Info"
                            clear;
                        dialog --title "System Monitor" \
                               --backtitle "$BACKTITLE" \
                               --yesno "Acpi is not installed.\nDo you want to install Acpi?" 6 33;
                            if [ "$?" -eq 0 ]; then #Yes Install Acpi
                                clear;
                                sudo apt-get install acpi;
                            elif [ "$?" -eq 1 ]; then #No Install Acpi
                                dialog --title "Cancel" --backtitle "$BACKTITLE" --infobox "cancelled..." 3 15;
                                sleep 1.2;
                                clear;
                            fi
                fi
		    ;;
		    7) ##System Monitor / CPU INFO 
		    while [[ 1 ]]
		      do
		    HEIGHT=12
		    WIDTH=40
		    CHOICE_HEIGHT=3
		    BACKTITLE="PMP v.0.0.25 / System Monitor / CPU Info"
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
				  --yesno "INFO: Root privileges required!\nDo you want to use sudo?" 7 30;
			      if [ "$?" -eq 0 ]; then ##YES CPU privileges
				clear;
				  sudo lshw -class processor > '/tmp/space.txt'
				  dialog --clear \
				  --backtitle "$BACKTITLE / General CPU Information" \
				  --title "$TITLE" \
				  --textbox /tmp/space.txt 25 75;
			      elif [ "$?" -eq 1 ]; then ##NO CPU privileges
				  dialog \
				  --backtitle "$BACKTITLE" \
				  --infobox "cancelled..." 3 20;
				sleep 1.2;
			      fi
			;;
			2)
			cat /proc/cpuinfo | grep processor | wc -l > '/tmp/space.txt'
			      dialog --clear \
			      --backtitle "$BACKTITLE / Number of CPU Cores" \
			      --title "$TITLE" \
			      --textbox /tmp/space.txt 5 20;
			      clear;
			;;
			3)
			lscpu > '/tmp/space.txt'
			      dialog --clear \
			      --backtitle "$BACKTITLE / Processor Details" \
			      --title "Processor Details" \
			      --textbox /tmp/space.txt 20 49;
			      clear;
			;;
			esac
		    elif [ "$?" -eq 1 ]; then ##Cancel CPU Info
			clear;
		    break;
		    fi
		    done
		    ;;
		    8) ##Network Information
		    while [[ 1 ]]
		    do
		    HEIGHT=12
		    WIDTH=38
		    CHOICE_HEIGHT=3
		    BACKTITLE="PMP v.0.0.25 / System Monitor / Network Information"
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
				  --textbox /tmp/space.txt 20 85;
				clear;
			      ;;
			      2)
				  iwconfig > '/tmp/space.txt'
				  dialog --clear \
				  --backtitle "$BACKTITLE / Connection Information" \
				  --title "$TITLE" \
				  --textbox /tmp/space.txt 20 85;
				clear;
			      ;;
			      3)
				printf "TIP - You can use arrow keys 'up, down, left & right' to scroll!\n" > /tmp/space.txt
				  lspci | egrep -i --color 'network|ethernet' >> '/tmp/space.txt'
				  dialog --clear \
				  --backtitle "$BACKTITLE / Ethernet & Wifi Card Information" \
				  --title "Network & Ethernet info" \
				  --textbox /tmp/space.txt 10 100;
				clear;
			      ;;
			  esac
		      elif [ "$?" -eq 1 ]; then ##cancel Network Information
		      break;
		      fi
		      done
		    ;;
		    9)
		      uname -r > '/tmp/space.txt' ##Kernel Information, current linux Kernel
			  dialog --clear \
			  --backtitle "$BACKTITLE / Kernel Information" \
			  --title "    Linux Kernel" \
			  --textbox /tmp/space.txt 5 30;
		      clear;
		    ;;
		    10)
		    while [[ 1 ]]
		      do
		      clear;
		      HEIGHT=17
		      WIDTH=45
		      CHOICE_HEIGHT=4
		      BACKTITLE="PMP v.0.0.25 / System Monitor"
		      TITLE="System Monitor"
		      MENU="Select one of the following Options:"

		      OPTIONS=(1 "Uptime"
                   2 "CPU Temperature"
			       3 "Distro Information"
			       4 "BIOS / UEFI Information")
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
			  uptime -p > /tmp/space.txt;
			  dialog \
			  --title "Uptime" \
			  --backtitle "$BACKTITLE / Uptime" \
			  --textbox /tmp/space.txt 5 43;
			  ;;
			  2)
			  dpkg -s acpi &> /dev/null; #Check's if Acpi is installed
                if [ "$?" -eq 0 ]; then #Acpi installed
                acpi -t > /tmp/space.txt;
                dialog --title "CPU Temperature" \
                       --backtitle "PMP v.0.0.25 / System Monitor / CPU Temperature" \
                       --textbox /tmp/space.txt 5 43;
                elif [ "$?" -eq 1 ]; then #Acpi not installed
              BACKTITLE="PMP v.0.0.25 / System Monitor / CPU Temperature"
                clear;
                dialog --title "System Monitor 0.0.4" \
                       --backtitle "$BACKTITLE" \
                       --yesno "Acpi is not installed.\nDo you want to install Acpi?" 6 33;
                    if [ "$?" -eq 0 ]; then #Yes Install Acpi
                        clear;
                        sudo apt-get install acpi;
                    elif [ "$?" -eq 1 ]; then #No Install Acpi
                        dialog --title "Cancel" --backtitle "$BACKTITLE" --infobox "cancelled..." 3 15;
                        sleep 1.2;
                        clear;
                    fi
                fi
			  ;;
			  3)
			  uname -romi > /tmp/space.txt
			  lsb_release -a >> /tmp/space.txt;
			  dialog \
			  --title "Distro Information" \
			  --backtitle "$BACKTITLE / Distribution Details" \
			  --textbox /tmp/space.txt 10 55;
			  ;;
			  4)
			  clear;
			  sudo dmidecode -t bios > /tmp/space.txt;
			  dialog \
			  --title "BIOS / UEFI Info" \
			  --backtitle "$BACKTITLE / BIOS / UEFI Information" \
			  --textbox /tmp/space.txt 17 65;
			  ;;
			esac
		      elif [ "$?" -eq 1 ]; then ## Cancel System Monitor
		      break;
		      fi
		      done
		    ;;
		    esac
		elif [ "$?" -eq 1 ]; then ##Cancel System Monitor
		break;
		fi
	done
        ;;
	3)
        BACKTITLE="PMP v.0.0.25 / Kill Wine"
	    dialog \
		--title "Wine Killer" \
		--backtitle "$BACKTITLE" \
		--yesno "Do you want to kill all Wine processes?" 6 31;
	if [ "$?" -eq 0 ]; then
	    wineserver -k; killall -9 wine wineserver; for i in `ps ax|egrep "*\.exe"|grep -v 'egrep'|awk '{print $1 }'`;do kill -9 $i;done
	    dialog --infobox "All Wine Processes killed..." 3 32;
	    sleep 2;
	  clear;
	elif [ "$?" -eq 1 ]; then
	    dialog --backtitle "$BACKTITLE" --infobox "cancelled..." 3 16;
	    sleep 2;
	fi
	;;
	4)
	while [[ 1 ]]
	do
	HEIGHT=15
    WIDTH=25
    CHOICE_HEIGHT=8
    BACKTITLE="PMP v.0.0.25 / Software Center"
    TITLE="Software Center"
    MENU="Select one:"
    OPTIONS=(1 "Accessories"
             2 "Accessibility"
             3 "Education"
             4 "Office"
             5 "Internet"
             6 "Multimedia"
             7 "Graphics"
             8 "Games")
    CHOICE=$(dialog --clear \
			        --backtitle "$BACKTITLE" \
			        --title "$TITLE" \
			        --menu "$MENU" \
			      $HEIGHT $WIDTH $CHOICE_HEIGHT \
			      "${OPTIONS[@]}" \
			      2>&1 >/dev/tty)
	if [ "$?" -eq 0 ]; then ##Okay in Software Center Menu
        case $CHOICE in
            1)
                while [[ 1 ]]
                do
                HEIGHT=17
                WIDTH=50
                CHOICE_HEIGHT=10
                BACKTITLE="PMP v.0.0.25 / Software Center / Accessories"
                TITLE="Accessories"
                MENU="Select one:"
                OPTIONS=(1 "Archive Manager - Gnome Archive Manager"
                         2 "Ark - KDE Archive Manager"
                         3 "Bluewho - Bluetooth Notifier"
                         4 "GnomeCalculator - Calculator"
                         5 "Diodon - GTK+ Clipboard Manager"
                         6 "Docky - Desktop Dock"
                         7 "Emacs - Text Editor"
                         8 "GnomeDiskUtility - Manage Disk Drives"
                         9 "Gourmet - Recipe Organizer"
                         10 "Next Page ->")
                CHOICE=$(dialog --clear \
			        --backtitle "$BACKTITLE" \
			        --title "$TITLE" \
			        --menu "$MENU" \
                $HEIGHT $WIDTH $CHOICE_HEIGHT \
                "${OPTIONS[@]}" \
                2>&1 >/dev/tty)
                if [ "$?" -eq 0 ]; then ##Okay in Accessories
                    case $CHOICE in
                        1)
                            dialog --clear \
                                   --title "File Roller" \
                                   --backtitle "$BACKTITLE" \
                                   --msgbox "File Roller is a graphical interface to archiving utilities such as tar and zip.\nIt supports most common operations\nsuch as creating, modifing and extracting files\nfrom an archive.\nYou can also view the contents of an archive\nand open files contained in the archive." 11 58;clear
                            dialog --title "Install" \
                                   --backtitle "$BACKTITLE" \
                                   --yesno "Do you want to install Gnome Archive Manager File-Roller?" 6 33;
                            if [ "$?" -eq 0 ]; then ##Okay File Roller
                                clear;
                                printf "==========================================\n| Install Software                       |\n==========================================\n";
                                sudo apt-get install file-roller;
                                printf "\nPress Enter to return to the Program\n";read
                            elif [ "$?" -eq 1 ]; then ##Cancel File Roller
                             clear;
                            fi
                        ;;
                        2)
                            dialog --clear \
                                   --title "Ark" \
                                   --backtitle "$BACKTITLE" \
                                   --msgbox "Ark is a program for managing various compressed file formats within KDE.\nArchives can be viewed, extracted, created and modified with Ark.\nThe program can handle various formats such as tar, gzip, bzip2, zip, rar \nwhen the appropriate libraries or command-line programs are installed" 12 58;clear
                            dialog --title "Install" \
                                   --backtitle "$BACKTITLE" \
                                   --yesno "Do you want to install Ark Archive Manager?" 6 33;
                            if [ "$?" -eq 0 ]; then ##Okay Ark
                                clear;
                                printf "==========================================\n| Install Software                       |\n==========================================\n";
                                sudo apt-get install ark;
                                printf "\nPress Enter to return to the Program\n";read
                            elif [ "$?" -eq 1 ]; then ##Cancel Ark
                                clear;
                            fi
                        ;;
                        3)
                            dialog --clear \
                                   --title "Bluewho" \
                                   --backtitle "$BACKTITLE" \
                                   --msgbox "BlueWho is a GTK utility to inform and notify you\nwhen a new  bluetooth device is discovered.\nDetection can be requested by the user or automatically continuous until is stopped.\nA visible and audible notification  can be fired\nwhenever a new device is detected.\nEach device found will be saved on the list\nas well its name, MAC address, last seen date and time.\nFor each device a list of available Bluetooth services can be requested." 15 58;clear
                            dialog --title "Install" \
                                   --backtitle "$BACKTITLE" \
                                   --yesno "Do you want to install BlueWho Bluetooth Notifier?" 6 33;
                            if [ "$?" -eq 0 ]; then ##Okay Bluewho
                                clear;
                                printf "==========================================\n| Install Software                       |\n==========================================\n";
                                sudo apt-get install bluewho;
                                printf "\nPress Enter to return to the Program\n";read
                            elif [ "$?" -eq 1 ]; then ##Cancel Bluewho
                                clear;
                            fi
                        ;;
                        4)
                            dialog --clear \
                                   --title "gnome-calculator" \
                                   --backtitle "$BACKTITLE" \
                                   --msgbox "Gnome Calculator is the official calculator\nof the GNOME desktop environment." 6 58;clear
                            dialog --title "Install" \
                                   --backtitle "$BACKTITLE" \
                                   --yesno "Do you want to install Gnome Calculator?" 6 33;
                            if [ "$?" -eq 0 ]; then ##Okay gnome-calculator
                                clear;
                                printf "==========================================\n| Install Software                       |  \n==========================================\n";
                                sudo apt-get install gnome-calculator;
                                printf "\nPress Enter to return to the Program\n";read
                            elif [ "$?" -eq 1 ]; then ##Cancel gnome-calculator
                             clear;
                            fi
                        ;;
                        5)
                            dialog --clear \
                                   --title "Diodon" \
                                   --backtitle "$BACKTITLE" \
                                   --msgbox "Diodon is a lightweight clipboard manager for Linux written in Vala\nwhich aims to be the best integrated clipboard manager for the Gnome/GTK+desktop.\nDiodon features include Ubuntu indicator, clipboard sync\nprimary selection and Ctrl+C / Ctrl+V clipboard\nand an option to set the clipboard size." 12 58;clear
                            dialog --title "Install" \
                                   --backtitle "$BACKTITLE" \
                                   --yesno "Do you want to install Diodon Clipboard Manager?" 6 33;
                            if [ "$?" -eq 0 ]; then ##Okay Diodon
                                clear;
                                printf "==========================================\n| Install Software                       |\n==========================================\n";
                                sudo apt-get install diodon;
                                printf "\nPress Enter to return to the Program\n";read
                            elif [ "$?" -eq 1 ]; then ##Cancel Diodon
                             clear;
                            fi
                        ;;
                        6)
                            dialog --clear \
                                   --title "Docky" \
                                   --backtitle "$BACKTITLE" \
                                   --msgbox "Docky - a full fledged dock application\nthat makes opening common applications and managing windows easier and quicker.\nDocky is fully integrated into the GNOME Desktop\nand features a no non-sense approach to configuration and usage.\nIt just works." 11 58;clear
                            dialog --title "Install" \
                                   --backtitle "$BACKTITLE" \
                                   --yesno "Do you want to install Docky?" 5 33;
                            if [ "$?" -eq 0 ]; then ##Okay Docky
                                clear;
                                printf "==========================================\n| Install Software                       |\n==========================================\n";
                                sudo apt-get install docky;
                                printf "\nPress Enter to return to the Program\n";read
                            elif [ "$?" -eq 1 ]; then ##Cancel Docky
                             clear;
                            fi
                        ;;
                        7)
                            dialog --clear \
                                   --title "Emacs" \
                                   --backtitle "$BACKTITLE" \
                                   --msgbox "Emacs is a Text-Editor created by Richard Stallman at MIT.\nA popular version is called GNU Emacs. The user functionality of GNU Emacs encompasses everything other editors do, and it is easily extensible\nsince its editing commands are written in Lisp." 10 58;clear
                            dialog --title "Install" \
                                   --backtitle "$BACKTITLE" \
                                   --yesno "Do you want to install Emacs?" 5 33;
                            if [ "$?" -eq 0 ]; then ##Okay Emacs
                                clear;
                                printf "==========================================\n| Install Software                       |\n==========================================\n";
                                sudo apt-get install emacs;
                                printf "\nPress Enter to return to the Program\n";read
                            elif [ "$?" -eq 1 ]; then ##Cancel Emacs
                             clear;
                            fi
                        ;;
                        8)
                            dialog --clear \
                                   --title "Gnome Disk Utility" \
                                   --backtitle "$BACKTITLE" \
                                   --msgbox "the GNOME Disks application 'Disks'\nprovides a way to inspect, format, partition and configure disks and block devices." 7 58;clear
                            dialog --title "Install" \
                                   --backtitle "$BACKTITLE" \
                                   --yesno "Do you want to install Gnome Disk Utility?" 6 33;
                            if [ "$?" -eq 0 ]; then ##Okay Gnome Disk Utility
                                clear;
                                printf "==========================================\n| Install Software                       |\n==========================================\n";
                                sudo apt-get install gnome-disk-utility;
                                printf "\nPress Enter to return to the Program\n";read
                            elif [ "$?" -eq 1 ]; then ##Cancel Gnome Disk Utility
                             clear;
                            fi
                        ;;
                        9)
                            dialog --clear \
                                   --title "Gourmet Recipe Manager" \
                                   --backtitle "$BACKTITLE" \
                                   --msgbox "Gourmet Recipe Manager is a Gtk-based recipe organizer\nand shopping list generator\nintended for the GNOME desktop environment\nthough it does not need all the GNOME libraries.\nGourmet can importMealmaster *tm files \nand can export recipes in a number of formats,\nincluding text, RTF and web pages.\nGourmet also can calculate nutritional information for recipes." 13 58;clear
                            dialog --title "Install" \
                                   --backtitle "$BACKTITLE" \
                                   --yesno "Do you want to install Gourmet Recipe Manager?" 6 33;
                            if [ "$?" -eq 0 ]; then ##Okay Gourmet Recipe Manager
                                clear;
                                printf "==========================================\n| Install Software                       |\n==========================================\n";
                                sudo apt-get install gourmet;
                                printf "\nPress Enter to return to the Program\n";read
                            elif [ "$?" -eq 1 ]; then ##Cancel Gourmet Recipe Manager
                             clear;
                            fi
                        ;;
                        10)
                            while [[ 1 ]]
                            do
                            HEIGHT=17
                            WIDTH=50
                            CHOICE_HEIGHT=10
                            BACKTITLE="PMP v.0.0.25 / Software Center / Accessories"
                            TITLE="Accessories"
                            MENU="Select one:"
                            OPTIONS=(1 "GVim - Text Editor"
                                     2 "GnomeTranslate - Translator"
                                     3 "Leafpad - Text Editor"
                                     4 "Mousepad - Text Editor"
                                     5 "Putty - Telnet Client"
                                     6 "Redshift - Colour Adjustment"
                                     7 "SimpleBackup - Backup Tool"
                                     8 "UPNP - Router Control"
                                     9 "Vile - Text Editor"
                                     10 "Next Page ->")
                            CHOICE=$(dialog --clear \
                                            --backtitle "$BACKTITLE" \
                                            --title "$TITLE" \
                                            --menu "$MENU" \
                            $HEIGHT $WIDTH $CHOICE_HEIGHT \
                            "${OPTIONS[@]}" \
                            2>&1 >/dev/tty)
                            if [ "$?" -eq 0 ]; then ##Okay in Accessories Page 2
                                case $CHOICE in
                                    1)
                                        dialog --clear \
                                               --title "GVim" \
                                               --backtitle "$BACKTITLE" \
                                               --msgbox "GVim or Gnome-Vim is an almost compatible version of the UNIX editor Vi" 6 58;clear
                                        dialog --title "Install" \
                                               --backtitle "$BACKTITLE" \
                                               --yesno "Do you want to install GVim?" 5 33;
                                        if [ "$?" -eq 0 ]; then ##Okay GVim
                                            clear;
                                            printf "==========================================\n| Install Software                       |\n==========================================\n";
                                            sudo apt-get install vim-gnome;
                                            printf "\nPress Enter to return to the Program\n";read
                                        elif [ "$?" -eq 1 ]; then ##Cancel GVim
                                            clear;
                                        fi
                                    ;;
                                    2)
                                        dialog --clear \
                                               --title "GnomeTranslate" \
                                               --backtitle "$BACKTITLE" \
                                               --msgbox "GNOME Translate is a GNOME interface to libtranslate.\nIt can translate a text or web page between several natural languages,\nand it can automatically detect the source language\nas you type." 9 58;clear
                                        dialog --title "Install" \
                                               --backtitle "$BACKTITLE" \
                                               --yesno "Do you want to install Gnome Translate?" 6 33;
                                        if [ "$?" -eq 0 ]; then ##Okay GnomeTranslate
                                            clear;
                                            printf "==========================================\n| Install Software                       |\n==========================================\n";
                                            sudo apt-get install gnome-translate;
                                            printf "\nPress Enter to return to the Program\n";read
                                        elif [ "$?" -eq 1 ]; then ##Cancel GnomeTranslate
                                            clear;
                                        fi
                                    ;;
                                    3)
                                        dialog --clear \
                                               --title "Leafpad" \
                                               --backtitle "$BACKTITLE" \
                                               --msgbox "Leafpad is a simple GTK+ based text editor.\nThe user interface is similar to Windows(tm) notepad.\nIt aims to be lighter than GEdit and KWrite and to be as useful as them.\n" 8 58;clear
                                        dialog --title "Install" \
                                               --backtitle "$BACKTITLE" \
                                               --yesno "Do you want to install Leafpad?" 6 33;
                                        if [ "$?" -eq 0 ]; then ##Okay Leafpad
                                            clear;
                                            printf "==========================================\n| Install Software                       |\n==========================================\n";
                                            sudo apt-get leafpad;
                                            printf "\nPress Enter to return to the Program\n";read
                                        elif [ "$?" -eq 1 ]; then ##Cancel Leafpad
                                            clear;
                                        fi
                                    ;;
                                    4)
                                        dialog --clear \
                                               --title "Mousepad" \
                                               --backtitle "$BACKTITLE" \
                                               --msgbox "Mousepad is a simple text editor for Xfce" 5 58;clear
                                        dialog --title "Install" \
                                               --backtitle "$BACKTITLE" \
                                               --yesno "Do you want to install Mousepad?" 6 33;
                                        if [ "$?" -eq 0 ]; then ##Okay Mousepad
                                            clear;
                                            printf "==========================================\n| Install Software                       |\n==========================================\n";
                                            sudo apt-get mousepad;
                                            printf "\nPress Enter to return to the Program\n";read
                                        elif [ "$?" -eq 1 ]; then ##Cancel Mousepad
                                            clear;
                                        fi
                                    ;;
                                    5)
                                        dialog --clear \
                                               --title "Putty" \
                                               --backtitle "$BACKTITLE" \
                                               --msgbox "putty is a graphical SSH, Telnet and Rlogin client for X.\nIt is a direct port of the Windows SSH client of the same name." 8 58;clear
                                        dialog --title "Install" \
                                               --backtitle "$BACKTITLE" \
                                               --yesno "Do you want to install Putty Telnet Client?" 6 33;
                                        if [ "$?" -eq 0 ]; then ##Okay Putty
                                            clear;
                                            printf "==========================================\n| Install Software                       |\n==========================================\n";
                                            sudo apt-get putty;
                                            printf "\nPress Enter to return to the Program\n";read
                                        elif [ "$?" -eq 1 ]; then ##Cancel Putty
                                            clear;
                                        fi
                                    ;;
                                    6)
                                        dialog --clear \
                                               --title "Redshift" \
                                               --backtitle "$BACKTITLE" \
                                               --msgbox "Redshift adjusts the color temperature of your screen\naccording to your surroundings.\nThis may help your eyes hurt less\nif you are working in front of the screen at night." 8 58;clear
                                        dialog --title "Install" \
                                               --backtitle "$BACKTITLE" \
                                               --yesno "Do you want to install redshift?" 6 33;
                                        if [ "$?" -eq 0 ]; then ##Okay Redshift
                                            clear;
                                            printf "==========================================\n| Install Software                       |\n==========================================\n";
                                            sudo apt-get install redshift redshift-gtk;
                                            printf "\nPress Enter to return to the Program\n";read
                                        elif [ "$?" -eq 1 ]; then ##Cancel Redshift
                                            clear;
                                        fi
                                    ;;
                                    7)
                                        dialog --clear \
                                               --title "SimpleBackup" \
                                               --backtitle "$BACKTITLE" \
                                               --msgbox "Simple Backup Suite graphical user interface GUI written in GTK+. This Package installs the GTK+ GUI of Simple Backup Suite including a status indicator placed in panel when running backups" 8 58;clear
                                        dialog --title "Install" \
                                               --backtitle "$BACKTITLE" \
                                               --yesno "Do you want to install SimpleBackup Backup Tool?" 6 33;
                                        if [ "$?" -eq 0 ]; then ##Okay SimpleBackup
                                            clear;
                                            printf "==========================================\n| Install Software                       |\n==========================================\n";
                                            sudo apt-get install simplebackup;
                                            printf "\nPress Enter to return to the Program\n";read
                                        elif [ "$?" -eq 1 ]; then ##Cancel SimpleBackup
                                            clear;
                                        fi
                                    ;;
                                    8)
                                        dialog --clear \
                                               --title "UPNP-Router-Control" \
                                               --backtitle "$BACKTITLE" \
                                               --msgbox "UPNP-Router-Control allow to see some params of the IGD compliant routers\nlike the download speed\nand manage port forwarding trough UPnP protocol." 8 58;clear
                                        dialog --title "Install" \
                                               --backtitle "$BACKTITLE" \
                                               --yesno "Do you want to install UPNP Router Control?" 6 33;
                                        if [ "$?" -eq 0 ]; then ##Okay UPNP-Router-Control
                                            clear;
                                            printf "==========================================\n| Install Software                       |\n==========================================\n";
                                            sudo apt-get install upnp-router-control;
                                            printf "\nPress Enter to return to the Program\n";read
                                        elif [ "$?" -eq 1 ]; then ##Cancel UPNP-Router-Control
                                            clear;
                                        fi
                                    ;;
                                    9)
                                        dialog --clear \
                                               --title "vile" \
                                               --backtitle "$BACKTITLE" \
                                               --msgbox "VI Like Emacs is a vi work-alike Text Editor" 5 58;clear
                                        dialog --title "Install" \
                                               --backtitle "$BACKTITLE" \
                                               --yesno "Do you want to install Vile Text Editor?" 6 33;
                                        if [ "$?" -eq 0 ]; then ##Okay vile
                                            clear;
                                            printf "==========================================\n| Install Software                       |\n==========================================\n";
                                            sudo apt-get install vile;
                                            printf "\nPress Enter to return to the Program\n";read
                                        elif [ "$?" -eq 1 ]; then ##Cancel vile
                                            clear;
                                        fi
                                    ;;
                                    10)
                                    while [[ 1 ]]
                                    do
                                    HEIGHT=17
                                    WIDTH=50
                                    CHOICE_HEIGHT=4
                                    BACKTITLE="PMP v.0.0.25 / Software Center / Accessories"
                                    TITLE="Accessories"
                                    MENU="Select one:"
                                    OPTIONS=(1 "Virtual Box - Virtual System"
                                             2 "Wine - Run Windows Applications"
                                             3 "Xterm - Terminal Emulator"
                                             4 "Back to Main Menu")
                                    CHOICE=$(dialog --clear \
                                                    --backtitle "$BACKTITLE" \
                                                    --title "$TITLE" \
                                                    --menu "$MENU" \
                                    $HEIGHT $WIDTH $CHOICE_HEIGHT \
                                    "${OPTIONS[@]}" \
                                    2>&1 >/dev/tty)
                                    if [ "$?" -eq 0 ]; then ##Okay in Accessories Page 3
                                        case $CHOICE in
                                            1)
                                                dialog --clear \
                                                       --title "Virtualbox" \
                                                       --backtitle "$BACKTITLE" \
                                                       --msgbox "VirtualBox - virtualization solution\nis a free and open-source hypervisor\nfor computers developed by Oracle Corporation." 7 58;clear
                                                dialog --title "Install" \
                                                       --backtitle "$BACKTITLE" \
                                                       --yesno "Do you want to install Virtualbox?" 6 33;
                                                if [ "$?" -eq 0 ]; then ##Okay Virtualbox
                                                    clear;
                                                    printf "==========================================\n| Install Software                       |\n==========================================\n";
                                                    sudo apt-get install virtualbox;
                                                    printf "\nPress Enter to return to the Program\n";read
                                                elif [ "$?" -eq 1 ]; then ##Cancel Virtualbox
                                                    clear;
                                                fi  
                                            ;;
                                            2)
                                                dialog --clear \
                                                       --title "Wine" \
                                                       --backtitle "$BACKTITLE" \
                                                       --msgbox "Wine - runs Windows programs on Unix" 5 58;clear
                                                dialog --title "Install" \
                                                       --backtitle "$BACKTITLE" \
                                                       --yesno "Do you want to install Wine?" 5 33;
                                                if [ "$?" -eq 0 ]; then ##Okay Wine
                                                    clear;
                                                    printf "==========================================\n| Install Software                       |\n==========================================\n";
                                                    sudo apt-get install wine;
                                                    printf "\nPress Enter to return to the Program\n";read
                                                elif [ "$?" -eq 1 ]; then ##Cancel Wine
                                                    clear;
                                                fi  
                                            ;;
                                            3)
                                                dialog --clear \
                                                       --title "XTerm" \
                                                       --backtitle "$BACKTITLE" \
                                                       --msgbox "The xterm program is a terminal emulator for the X Window System.\nIt provides DEC VT102/VT220\nand  selected features from higher-level terminals\nsuch as VT320/VT420/VT520 'VTxxx'.\nIt  also  provides Tektronix 4014 emulation\nfor programs that cannot use the window system directly." 12 58;clear
                                                dialog --title "Install" \
                                                       --backtitle "$BACKTITLE" \
                                                       --yesno "Do you want to install Xterm Terminal Emulator?" 6 33;
                                                if [ "$?" -eq 0 ]; then ##Okay XTerm
                                                    clear;
                                                    printf "==========================================\n| Install Software                       |\n==========================================\n";
                                                    sudo apt-get install xterm;
                                                    printf "\nPress Enter to return to the Program\n";read
                                                elif [ "$?" -eq 1 ]; then ##Cancel XTerm
                                                    clear;
                                                fi  
                                            ;;
                                            4)
                                                break 3;
                                            ;;
                                        esac
                                    elif [ "$?" -eq 1 ]; then ##Cancel in Accessories Page 3
                                        break;
                                    fi
                                    done 
                                    ;;
                                esac
                            elif [ "$?" -eq 1 ]; then ##Cancel in Accessories Page 2
                                break;
                            fi
                            done 
                        ;;
                    esac
                    elif [ "$?" -eq 1 ]; then ##Cancel in Accessories
                    break;
                    fi
                    done 
            ;;
            2)
                while [[ 1 ]]
                do
                HEIGHT=17
                WIDTH=50
                CHOICE_HEIGHT=6
                BACKTITLE="PMP v.0.0.25 / Software Center / Accessibility"
                TITLE="Accessibility"
                MENU="Select one:"
                OPTIONS=(1 "Orca - Screen Reader"
                         2 "Onboard - On-screen Keyboard"
                         3 "XZoom - Screen Magnifier"
                         4 "Simon - Speech Recognition"
                         5 "Eviacam - Cam based Mouse Emulator"
                         6 "Florence - Virtual Keyboard")
                CHOICE=$(dialog --clear \
			        --backtitle "$BACKTITLE" \
			        --title "$TITLE" \
			        --menu "$MENU" \
			      $HEIGHT $WIDTH $CHOICE_HEIGHT \
			      "${OPTIONS[@]}" \
			      2>&1 >/dev/tty)
                    if [ "$?" -eq 0 ]; then ##Okay in Accessibility
                        case $CHOICE in
                            1)
                                dialog --clear \
                                       --title "Orca" \
                                       --backtitle "$BACKTITLE" \
                                       --msgbox "Orca is a screen reader for people with visual impairments,\nit provides alternative access to the desktop\nby using speech synthesis and braille." 8 58;clear
                                dialog --title "Install" \
                                       --backtitle "$BACKTITLE" \
                                       --yesno "Do you want to install Orca Screen Reader?" 6 33;
                                if [ "$?" -eq 0 ]; then ##Okay Orca
                                    clear;
                                    printf "==========================================\n| Install Software                       |\n==========================================\n";
                                    sudo apt-get install gnome-orca;
                                    printf "\nPress Enter to return to the Program\n";read
                                elif [ "$?" -eq 1 ]; then ##Cancel Orca
                                    clear;
                                fi  
                            ;;
                            2)
                                dialog --clear \
                                       --title "Onboard" \
                                       --backtitle "$BACKTITLE" \
                                       --msgbox "Onboard is an on-screen keyboard\nthat can be useful for tablet PC users,\nas well as for mobility impaired people.\nOnboard supports macros, easy layout creation and word suggestion." 9 58;clear
                                dialog --title "Install" \
                                       --backtitle "$BACKTITLE" \
                                       --yesno "Do you want to install Onboard On-screen Keyboard?" 6 33;
                                if [ "$?" -eq 0 ]; then ##Okay Onboard
                                    clear;
                                    printf "==========================================\n| Install Software                       |\n==========================================\n";
                                    sudo apt-get install onboard;
                                    printf "\nPress Enter to return to the Program\n";read
                                elif [ "$?" -eq 1 ]; then ##Cancel Onboard
                                    clear;
                                fi  
                            ;;
                            3)
                                dialog --clear \
                                       --title "XZoom" \
                                       --backtitle "$BACKTITLE" \
                                       --msgbox "XZoom - magnify part of the screen, with fast updates\nXzoom displays in its window a magnified area of the X11 display.\nThe user can interactively change the zoomed area,\nthe  window  size, magnification\noptionally different magnification for X and Y axes or rotate or mirror the image." 11 58;clear
                                dialog --title "Install" \
                                       --backtitle "$BACKTITLE" \
                                       --yesno "Do you want to install XZoom Screen Magnifier?" 6 33;
                                if [ "$?" -eq 0 ]; then ##Okay XZoom
                                    clear;
                                    printf "==========================================\n| Install Software                       |\n==========================================\n";
                                    sudo apt-get install xzoom;
                                    printf "\nPress Enter to return to the Program\n";read
                                elif [ "$?" -eq 1 ]; then ##Cancel XZoom
                                    clear;
                                fi  
                            ;;
                            4)
                                dialog --clear \
                                       --title "Simon" \
                                       --backtitle "$BACKTITLE" \
                                       --msgbox "Simon is the main front end for the Simon open source speech recognition solution.\nIt is a Simond client and provides a graphical user interface\nfor managing the speech model and the commands.\nMoreover, Simon can execute all sorts of commands\nbased on the input it receives from the server:\nSimond." 12 58;clear
                                dialog --title "Install" \
                                       --backtitle "$BACKTITLE" \
                                       --yesno "Do you want to install Simon Speech Recognition Solution?" 6 33;
                                if [ "$?" -eq 0 ]; then ##Okay Simon
                                    clear;
                                    printf "==========================================\n| Install Software                       |\n==========================================\n";
                                    sudo apt-get install simon;
                                    printf "\nPress Enter to return to the Program\n";read
                                elif [ "$?" -eq 1 ]; then ##Cancel Simon
                                    clear;
                                fi  
                            ;;
                            5)
                                dialog --clear \
                                       --title "EviaCam" \
                                       --backtitle "$BACKTITLE" \
                                       --msgbox "Enable Viacam (eViacam) is a mouse replacement software that moves the pointer as you move your head. It works on standard PC equipped with a webcam. No additional hardware is required. It's completely free, open source and easy to use!" 9 58;clear
                                dialog --title "Install" \
                                       --backtitle "$BACKTITLE" \
                                       --yesno "Do you want to install Eviacam Mouse Replacement Software?" 6 33;
                                if [ "$?" -eq 0 ]; then ##Okay EviaCam
                                    clear;
                                    printf "==========================================\n| Install Software                       |\n==========================================\n";
                                    sudo apt-get install eviacam;
                                    printf "\nPress Enter to return to the Program\n";read
                                elif [ "$?" -eq 1 ]; then ##Cancel EviaCam
                                    clear;
                                fi 
                            ;;
                            6)
                                dialog --clear \
                                       --title "Florence" \
                                       --backtitle "$BACKTITLE" \
                                       --msgbox "Florence is an extensible scalable virtual keyboard for GNOME.\nYou need it if you can’t use a real hardware keyboard,\nfor example because of injury, handicap, your keyboard is broken or because you use a tablet PC,\nbut you must be able to use a pointing device\n'as a mouse, a trackball, or a touchscreen'\nIf you can’t use a pointing device,\nthere is gok, which can be used with just simple switches." 14 58;clear
                                dialog --title "Install" \
                                       --backtitle "$BACKTITLE" \
                                       --yesno "Do you want to install Florence Virtual Keyboard?" 6 33;
                                if [ "$?" -eq 0 ]; then ##Okay Florence
                                    clear;
                                    printf "==========================================\n| Install Software                       |\n==========================================\n";
                                    sudo apt-get install florence;
                                    printf "\nPress Enter to return to the Program\n";read
                                elif [ "$?" -eq 1 ]; then ##Cancel Florence
                                    clear;
                                fi  
                            ;;
                        esac
                    elif [ "$?" -eq 1 ]; then ##Cancel in Accessibility
                    break;
                    fi
                done
            ;;
            3)
                while [[ 1 ]]
                do
                HEIGHT=17
                WIDTH=50
                CHOICE_HEIGHT=10
                BACKTITLE="PMP v.0.0.25 / Software Center / Education"
                TITLE="Education"
                MENU="Select one:"
                OPTIONS=(1 "Achilles - Evolution Simulator"
                         2 "Amide - Medical Imaging Software"
                         3 "Artikulate - Pronunciation Trainer"
                         4 "Aweather - Weather Program"
                         5 "Biogenesis - Simulates Organisms"
                         6 "Controlaula - Control Classroom PC's"
                         7 "Electric - Electrical CAD System"
                         8 "Freediams - Drug Prescription Manager"
                         9 "Genius - General Purpose Calculator"
                         10 "Next Page ->")
                CHOICE=$(dialog --clear \
			        --backtitle "$BACKTITLE" \
			        --title "$TITLE" \
			        --menu "$MENU" \
			      $HEIGHT $WIDTH $CHOICE_HEIGHT \
			      "${OPTIONS[@]}" \
			      2>&1 >/dev/tty)
                    if [ "$?" -eq 0 ]; then ##Okay in Education Page 1
                        case $CHOICE in
                            1)
                                dialog --clear \
                                       --title "Achilles" \
                                       --backtitle "$BACKTITLE" \
                                       --msgbox "Achilles is an evolution simulation based on Larry Yaeger's PolyWorld.\nIt uses Hebbian neural networks,\nand an extremely simplified physical model\nthat allows virtual organisms to interact freely\nin a simulated environment." 10 58;clear
                                dialog --title "Install" \
                                       --backtitle "$BACKTITLE" \
                                       --yesno "Do you want to install Achilles Evolution Simulator?" 6 33;
                                if [ "$?" -eq 0 ]; then ##Okay Achilles
                                    clear;
                                    printf "==========================================\n| Install Software                       |\n==========================================\n";
                                    sudo apt-get install achilles;
                                    printf "\nPress Enter to return to the Program\n";read
                                elif [ "$?" -eq 1 ]; then ##Cancel Achilles
                                    clear;
                                fi 
                            ;;
                            2)
                                dialog --clear \
                                       --title "Amide" \
                                       --backtitle "$BACKTITLE" \
                                       --msgbox "AMIDE is a competely free tool for viewing, analyzing,\nand registering volumetric medical imaging data sets.\nIt's been written on top of GTK+,\nand runs on any system that supports this toolkit:\nLinux, Windows, Mac OS X, etc.." 9 58;clear
                                dialog --title "Install" \
                                       --backtitle "$BACKTITLE" \
                                       --yesno "Do you want to install Amide Medical Imaging Software?" 6 33;
                                if [ "$?" -eq 0 ]; then ##Okay Amide
                                    clear;
                                    printf "==========================================\n| Install Software                       |\n==========================================\n";
                                    sudo apt-get install amide;
                                    printf "\nPress Enter to return to the Program\n";read
                                elif [ "$?" -eq 1 ]; then ##Cancel Amide
                                    clear;
                                fi 
                            ;;
                            3)
                                dialog --clear \
                                       --title "Artikulate" \
                                       --backtitle "$BACKTITLE" \
                                       --msgbox "Artikulate is a pronunciation trainer\nthat helps improving and perfecting a learner's pronunciation skills for a foreign language.\nIt provides courses with native speaker\nrecordings for several training languages.\nThe learner downloads those courses,\nselects a category of phrases to train,\nthen starts with recording her/his own voice when speaking the phrases\nand comparing the results to the native speaker's recordings by listening to both.\nBy adjusting and repeating the own pronunciation,\nthe learner can improve his/her skill." 17 58;clear
                                dialog --title "Install" \
                                       --backtitle "$BACKTITLE" \
                                       --yesno "Do you want to install Artikulate?" 6 33;
                                if [ "$?" -eq 0 ]; then ##Okay Artikulate
                                    clear;
                                    printf "==========================================\n| Install Software                       |\n==========================================\n";
                                    sudo apt-get install artikulate;
                                    printf "\nPress Enter to return to the Program\n";read
                                elif [ "$?" -eq 1 ]; then ##Cancel Artikulate
                                    clear;
                                fi 
                            ;;
                            4)
                                dialog --clear \
                                       --title "AWeather" \
                                       --backtitle "$BACKTITLE" \
                                       --msgbox "AWeather is a advanced weather reporting program\nwhich is designed to be used by weather enthusiasts.\nAWeather is not another weather dockapp that simply displays a pre-computed forecast.\nIt is designed to be an easy to use program\nthat integrates a variety of weather data in simple unified interface" 11 58;clear
                                dialog --title "Install" \
                                       --backtitle "$BACKTITLE" \
                                       --yesno "Do you want to install AWeather Weather Reporting?" 6 33;
                                if [ "$?" -eq 0 ]; then ##Okay AWeather
                                    clear;
                                    printf "==========================================\n| Install Software                       |\n==========================================\n";
                                    sudo apt-get install aweather;
                                    printf "\nPress Enter to return to the Program\n";read
                                elif [ "$?" -eq 1 ]; then ##Cancel AWeather
                                    clear;
                                fi 
                            ;;
                            5)
                                dialog --clear \
                                       --title "Biogenesis" \
                                       --backtitle "$BACKTITLE" \
                                       --msgbox "Biogenesis, an artificial life program focused on evolution" 6 58;clear
                                dialog --title "Install" \
                                       --backtitle "$BACKTITLE" \
                                       --yesno "Do you want to install Biogenesis?" 6 33;
                                if [ "$?" -eq 0 ]; then ##Okay Biogenesis
                                    clear;
                                    printf "==========================================\n| Install Software                       |\n==========================================\n";
                                    sudo apt-get install biogenesis;
                                    printf "\nPress Enter to return to the Program\n";read
                                elif [ "$?" -eq 1 ]; then ##Cancel Biogenesis
                                    clear;
                                fi 
                            ;;
                            6)
                                dialog --clear \
                                       --title "ControlAura" \
                                       --backtitle "$BACKTITLE" \
                                       --msgbox "ControlAula is an application written to assist with the integration of the computers in a classroom and with their daily use." 7 58;clear
                                dialog --title "Install" \
                                       --backtitle "$BACKTITLE" \
                                       --yesno "Do you want to install ControlAura?" 6 33;
                                if [ "$?" -eq 0 ]; then ##Okay ControlAura
                                    clear;
                                    printf "==========================================\n| Install Software                       |\n==========================================\n";
                                    sudo apt-get install controlaula;
                                    printf "\nPress Enter to return to the Program\n";read
                                elif [ "$?" -eq 1 ]; then ##Cancel ControlAura
                                    clear;
                                fi 
                            ;;
                            7)
                                dialog --clear \
                                       --title "Electric" \
                                       --backtitle "$BACKTITLE" \
                                       --msgbox "Electric is a general purpose system for all electrical design.\nIt currently knows about nMOS, CMOS,  Bipolar, artwork, schematics,\nprinted-circuit boards, and many other technologies.\nIts has a large set of tools \nincluding multiple design-rule checkers\n'both incremental and hierarchical',\nan electrical rules checker,\nover a dozen simulator interfaces,\nmultiple generators 'PLA and pad frame',\nmultiple routers 'stitching, maze, river',\nnetwork comparison, compaction, compensation, a VHDL compiler, and a silicon compiler\nthat places-and-routes standardcells." 19 58;clear
                                dialog --title "Install" \
                                       --backtitle "$BACKTITLE" \
                                       --yesno "Do you want to install Electric?" 6 33;
                                if [ "$?" -eq 0 ]; then ##Okay Electric
                                    clear;
                                    printf "==========================================\n| Install Software                       |\n==========================================\n";
                                    sudo apt-get install electric;
                                    printf "\nPress Enter to return to the Program\n";read
                                elif [ "$?" -eq 1 ]; then ##Cancel Electric
                                    clear;
                                fi
                            ;;
                            8)
                                dialog --clear \
                                       --title "Freediams" \
                                       --backtitle "$BACKTITLE" \
                                       --msgbox "FreeDiams is a pharmaceutical drug prescription\nand interaction manager" 6 58;clear
                                dialog --title "Install" \
                                       --backtitle "$BACKTITLE" \
                                       --yesno "Do you want to install FreeDiams Drug Prescription Manager?" 6 33;
                                if [ "$?" -eq 0 ]; then ##Okay Freediams
                                    clear;
                                    printf "==========================================\n| Install Software                       |\n==========================================\n";
                                    sudo apt-get install freediams;
                                    printf "\nPress Enter to return to the Program\n";read
                                elif [ "$?" -eq 1 ]; then ##Cancel Freediams
                                    clear;
                                fi 
                            ;;
                            9)
                                dialog --clear \
                                       --title "Genius" \
                                       --backtitle "$BACKTITLE" \
                                       --msgbox "Genius is a general purpose calculator program\nsimilar in some aspects to BC, Matlab, Maple or Mathematica.\nIt is useful both as a simple calculator\nand as a research or educational tool.\nThe syntax is very intuitive\nand is designed to mimic how mathematics is usually written.\nGEL is the name of its extension language,\nit stands for Genius Extension Language,\nclever isn't it?\nIn fact, many of the standard genius functions\nare written in GEL itself." 17 58;clear
                                dialog --title "Install" \
                                       --backtitle "$BACKTITLE" \
                                       --yesno "Do you want to install Genius Calculator?" 6 33;
                                if [ "$?" -eq 0 ]; then ##Okay Genius
                                    clear;
                                    printf "==========================================\n| Install Software                       |\n==========================================\n";
                                    sudo apt-get install genius;
                                    printf "\nPress Enter to return to the Program\n";read
                                elif [ "$?" -eq 1 ]; then ##Cancel Genius
                                    clear;
                                fi 
                            ;;
                            10)
                                while [[ 1 ]]
                                do
                                HEIGHT=17
                                WIDTH=50
                                CHOICE_HEIGHT=10
                                BACKTITLE="PMP v.0.0.25 / Software Center / Education"
                                TITLE="Education"
                                MENU="Select one:"
                                OPTIONS=(1 "Glogic - Graphical Circuit Simulator"
                                         2 "GPredict - Satellite Tracker"
                                         3 "Grace - XY Plotting Tool"
                                         4 "Jmol - Molecular Viewer"
                                         5 "Kalzium - Periodic Table"
                                         6 "Kbruch - Fraction Learning Aid"
                                         7 "KDEMarble - Navigation & Maps"
                                         8 "KGeography - Geography Learning"
                                         9 "KHangMan - Hangman Game"
                                         10 "Next Page ->")
                                CHOICE=$(dialog --clear \
                                                --backtitle "$BACKTITLE" \
                                                --title "$TITLE" \
                                                --menu "$MENU" \
                                $HEIGHT $WIDTH $CHOICE_HEIGHT \
                                "${OPTIONS[@]}" \
                                2>&1 >/dev/tty)
                                if [ "$?" -eq 0 ]; then ##Okay in Education Page 2
                                    case $CHOICE in
                                        1)
                                        dialog --clear \
                                               --title "Glogic" \
                                               --backtitle "$BACKTITLE" \
                                               --msgbox "Glogic is a educational graphical logic circuit simulator using Python and GTK+. This application contains simple circuit editor and view simulated circuit with colouring." 8 58;clear
                                        dialog --title "Install" \
                                               --backtitle "$BACKTITLE" \
                                               --yesno "Do you want to install Glogic Circuit Simulator?" 6 33;
                                        if [ "$?" -eq 0 ]; then ##Okay Glogic
                                            clear;
                                            printf "==========================================\n| Install Software                       |\n==========================================\n";
                                            sudo apt-get install glogic;
                                            printf "\nPress Enter to return to the Program\n";read
                                        elif [ "$?" -eq 1 ]; then ##Cancel Glogic
                                            clear;
                                        fi 
                                        ;;
                                        2)
                                        dialog --clear \
                                               --title "Gpredict" \
                                               --backtitle "$BACKTITLE" \
                                               --msgbox "GNOME Predict is a real time satellite tracking program for GNOME,\nbased on the tracking engine of John Magliacane's\nexcellent satellitetracker Predict." 8 58;clear
                                        dialog --title "Install" \
                                               --backtitle "$BACKTITLE" \
                                               --yesno "Do you want to install Gpredict Satellite Tracker?" 6 33;
                                        if [ "$?" -eq 0 ]; then ##Okay Gpredict
                                            clear;
                                            printf "==========================================\n| Install Software                       |\n==========================================\n";
                                            sudo apt-get install gpredict;
                                            printf "\nPress Enter to return to the Program\n";read
                                        elif [ "$?" -eq 1 ]; then ##Cancel Gpredict 
                                            clear;
                                        fi
                                        ;;
                                        3)
                                        dialog --clear \
                                               --title "Grace" \
                                               --backtitle "$BACKTITLE" \
                                               --msgbox "Grace is a WYSIWYG tool to make two-dimensional plots of scientific data." 6 58;clear
                                        dialog --title "Install" \
                                               --backtitle "$BACKTITLE" \
                                               --yesno "Do you want to install Grace XY Plotting Tool?" 6 33;
                                        if [ "$?" -eq 0 ]; then ##Okay Grace
                                            clear;
                                            printf "==========================================\n| Install Software                       |\n==========================================\n";
                                            sudo apt-get install grace;
                                            printf "\nPress Enter to return to the Program\n";read
                                        elif [ "$?" -eq 1 ]; then ##Cancel Grace
                                            clear;
                                        fi
                                        ;;
                                        4)
                                        dialog --clear \
                                               --title "Jmol" \
                                               --backtitle "$BACKTITLE" \
                                               --msgbox "jmol is a program that is able to view 3D chemical information\nlike molecular structures, vibrations of bonds or animations." 8 58;clear
                                        dialog --title "Install" \
                                               --backtitle "$BACKTITLE" \
                                               --yesno "Do you want to install Jmol Molecular Viewer?" 6 33;
                                        if [ "$?" -eq 0 ]; then ##Okay Jmol
                                            clear;
                                            printf "==========================================\n| Install Software                       |\n==========================================\n";
                                            sudo apt-get install jmol;
                                            printf "\nPress Enter to return to the Program\n";read
                                        elif [ "$?" -eq 1 ]; then ##Cancel Jmol
                                            clear;
                                        fi
                                        ;;
                                        5)
                                        dialog --clear \
                                               --title "Kalzium" \
                                               --backtitle "$BACKTITLE" \
                                               --msgbox "Kalzium is a program which shows you the Periodic System of the Elements\n'PSE'. You can use Kalzium to search for information about the elements\nr to learn facts about the PSE.\nKalzium provides you with all kinds of information about the PSE.\nYou can look up lots of information about the elements\nand also use visualisations to show them." 13 58;clear
                                        dialog --title "Install" \
                                               --backtitle "$BACKTITLE" \
                                               --yesno "Do you want to install Kalzium Periodic Table?" 6 33;
                                        if [ "$?" -eq 0 ]; then ##Okay Kalzium
                                            clear;
                                            printf "==========================================\n| Install Software                       |\n==========================================\n";
                                            sudo apt-get install kalzium;
                                            printf "\nPress Enter to return to the Program\n";read
                                        elif [ "$?" -eq 1 ]; then ##Cancel Kalzium
                                            clear;
                                        fi
                                        ;;
                                        6)
                                        dialog --clear \
                                               --title "KBruch" \
                                               --backtitle "$BACKTITLE" \
                                               --msgbox "KBruch is a small program to practice calculating with fractions.\nDifferent exercises are provided for this purpose.\nThe program checks user's input and gives feedback." 8 58;clear
                                        dialog --title "Install" \
                                               --backtitle "$BACKTITLE" \
                                               --yesno "Do you want to install KBruch Fraction Learning Aid?" 6 33;
                                        if [ "$?" -eq 0 ]; then ##Okay KBruch
                                            clear;
                                            printf "==========================================\n| Install Software                       |\n==========================================\n";
                                            sudo apt-get install kbruch;
                                            printf "\nPress Enter to return to the Program\n";read
                                        elif [ "$?" -eq 1 ]; then ##Cancel KBruch
                                            clear;
                                        fi
                                        ;;
                                        7)
                                        dialog --clear \
                                               --title "KDEMarble" \
                                               --backtitle "$BACKTITLE" \
                                               --msgbox "Marble is a Virtual Globe and World Atlas\nthat you can use to learn more about the Earth." 6 58;clear
                                        dialog --title "Install" \
                                               --backtitle "$BACKTITLE" \
                                               --yesno "Do you want to install KDEMarble Navigation & Maps?" 6 33;
                                        if [ "$?" -eq 0 ]; then ##Okay KDEMarble
                                            clear;
                                            printf "==========================================\n| Install Software                       |\n==========================================\n";
                                            sudo apt-get install marble;
                                            printf "\nPress Enter to return to the Program\n";read
                                        elif [ "$?" -eq 1 ]; then ##Cancel KDEMarble
                                            clear;
                                        fi
                                        ;;
                                        8)
                                        dialog --clear \
                                               --title "Kgeography" \
                                               --backtitle "$BACKTITLE" \
                                               --msgbox "KGeography is a geography learning tool,\nwhich allows you to learn about the political divisions\nof some countries 'divisions, capitals of those divisions\nand their associated flags if there are some'." 10 58;clear
                                        dialog --title "Install" \
                                               --backtitle "$BACKTITLE" \
                                               --yesno "Do you want to install KGeography?" 6 33;
                                        if [ "$?" -eq 0 ]; then ##Okay Kgeography
                                            clear;
                                            printf "==========================================\n| Install Software                       |\n==========================================\n";
                                            sudo apt-get install kgeography;
                                            printf "\nPress Enter to return to the Program\n";read
                                        elif [ "$?" -eq 1 ]; then ##Cancel Kgeography
                                            clear;
                                        fi
                                        ;;
                                        9)
                                        dialog --clear \
                                               --title "KHangMan" \
                                               --backtitle "$BACKTITLE" \
                                               --msgbox "KHangMan is a game based on the well known hangman game.\nIt is aimed for children 6 and above.\nIt has several levels of difficulty:\nA lot of categories like Animals\n'animals words' and Easy, Medium and Hard.\nA word is picked at random\nand the letters are hidden.\nYou must guess the word by trying one letter after another.\nEach time you guess a wrong letter,\npart of a picture of a hangman is drawn.\nYou must guess the word before getting hanged!\nYou have 10 tries." 18 58;clear
                                        dialog --title "Install" \
                                               --backtitle "$BACKTITLE" \
                                               --yesno "Do you want to install KHangMan?" 6 33;
                                        if [ "$?" -eq 0 ]; then ##Okay KHangMan
                                            clear;
                                            printf "==========================================\n| Install Software                       |\n==========================================\n";
                                            sudo apt-get install khangman;
                                            printf "\nPress Enter to return to the Program\n";read
                                        elif [ "$?" -eq 1 ]; then ##Cancel KHangMan
                                            clear;
                                        fi
                                        ;;
                                        10)
                                        while [[ 1 ]]
                                        do
                                        HEIGHT=17
                                        WIDTH=50
                                        CHOICE_HEIGHT=10
                                        BACKTITLE="PMP v.0.0.25 / Software Center / Education"
                                        TITLE="Education"
                                        MENU="Select one:"
                                        OPTIONS=(1 "Kiten - Japanese Study Aid"
                                                 2 "KStars - Desktop Planetarium"
                                                 3 "KTurtle - Learn Programming"
                                                 4 "Kwordquiz - Flashcard Program"
                                                 5 "Maxima - Algebra System"
                                                 6 "Openteacher - Personal Tutor"
                                                 7 "GElemental - Periodic Table"
                                                 8 "Planets - Planet Gravity Simulator"
                                                 9 "PYlang - Practice Languages"
                                                 10 "Next Page ->")
                                        CHOICE=$(dialog --clear \
                                                        --backtitle "$BACKTITLE" \
                                                        --title "$TITLE" \
                                                        --menu "$MENU" \
                                        $HEIGHT $WIDTH $CHOICE_HEIGHT \
                                        "${OPTIONS[@]}" \
                                        2>&1 >/dev/tty)
                                        if [ "$?" -eq 0 ]; then ##Okay in Education Page 3
                                            case $CHOICE in
                                            1)
                                                dialog --clear \
                                                       --title "Kiten" \
                                                       --backtitle "$BACKTITLE" \
                                                       --msgbox "Kiten is a Japanese reference/study tool." 5 58;clear
                                                dialog --title "Install" \
                                                       --backtitle "$BACKTITLE" \
                                                       --yesno "Do you want to install Kiten Study Aid?" 6 33;
                                            if [ "$?" -eq 0 ]; then ##Okay Kiten
                                                clear;
                                                printf "==========================================\n| Install Software                       |\n==========================================\n";
                                                sudo apt-get install kiten;
                                                printf "\nPress Enter to return to the Program\n";read
                                            elif [ "$?" -eq 1 ]; then ##Cancel Kiten
                                                clear;
                                            fi
                                            ;;
                                            2)
                                                dialog --clear \
                                                       --title "KStars" \
                                                       --backtitle "$BACKTITLE" \
                                                       --msgbox "KStars is a desktop planetarium for KDE,\ndepicting an accurate graphical simulation of the night sky,\nfrom any location on Earth, atany date and time.\nThe display includes 130,000 stars, 13,000 deep-sky objects,\nall 8 planets, the Sun and Moon,\nand thousands of  comets  and asteroids.\nIt  includes tools for astronomical calculations and can control telescopes and cameras." 14 58;clear
                                                dialog --title "Install" \
                                                       --backtitle "$BACKTITLE" \
                                                       --yesno "Do you want to install KStars Planetarium?" 6 33;
                                            if [ "$?" -eq 0 ]; then ##Okay KStars
                                                clear;
                                                printf "==========================================\n| Install Software                       |\n==========================================\n";
                                                sudo apt-get install kstars;
                                                printf "\nPress Enter to return to the Program\n";read
                                            elif [ "$?" -eq 1 ]; then ##Cancel KStars
                                                clear;
                                            fi
                                            ;;
                                            3)
                                                dialog --clear \
                                                       --title "KTurte" \
                                                       --backtitle "$BACKTITLE" \
                                                       --msgbox "KTurtle is an educational programming environment\nthat aims to make learning how to program as easily as possible.\nTo achieve this\nKTurtle makes all programming tools available from the user interface.\nThe programming language used is TurtleScript which allows its commands to be translated." 12 58;clear
                                                dialog --title "Install" \
                                                       --backtitle "$BACKTITLE" \
                                                       --yesno "Do you want to install KTurtle?" 6 33;
                                            if [ "$?" -eq 0 ]; then ##Okay KTurte
                                                clear;
                                                printf "==========================================\n| Install Software                       |\n==========================================\n";
                                                sudo apt-get install kturtle;
                                                printf "\nPress Enter to return to the Program\n";read
                                            elif [ "$?" -eq 1 ]; then ##Cancel KTurte
                                                clear;
                                            fi
                                            ;;
                                            4)
                                                dialog --clear \
                                                       --title "KWordquiz" \
                                                       --backtitle "$BACKTITLE" \
                                                       --msgbox "KWordQuiz is a general purpose flash card program.\nIt can be used for vocabulary learning and many other subjects." 7 58;clear
                                                dialog --title "Install" \
                                                       --backtitle "$BACKTITLE" \
                                                       --yesno "Do you want to install Kwordquiz?" 6 33;
                                            if [ "$?" -eq 0 ]; then ##Okay KWordquiz
                                                clear;
                                                printf "==========================================\n| Install Software                       |\n==========================================\n";
                                                sudo apt-get install kwordquiz;
                                                printf "\nPress Enter to return to the Program\n";read
                                            elif [ "$?" -eq 1 ]; then ##Cancel KWordquiz
                                                clear;
                                            fi
                                            ;;
                                            5)
                                                dialog --clear \
                                                       --title "Maxima" \
                                                       --backtitle "$BACKTITLE" \
                                                       --msgbox "Maxima is a version of the MIT-developed MACSYMA\nsystem,\nmodified to run under Common Lisp.\nIt is an interactive expert system and programming environment\nfor symbolic and numerical mathematical manipulation.\nWritten in Lisp,\nit allows differentiation, integration,\nsolution of linear or polynomial equations,\nfactoring of polynomials,\nexpansion of functions in Laurent or Taylor series,\ncomputation of Poisson series,\nmatrix and tensor manipulations,\nand two-and three-dimensional graphics.\nProcedures may be written using an ALGOL-like syntax,\nand both Lisp-like functions\nand pattern matching facilities are provided.\nFiles containing Maxima objects\nmay be read from and written to disk files.\nPre-written Maxima commands\nmay be read from a file and executed,\nallowing batch-mode use." 26 58;clear
                                                dialog --title "Install" \
                                                       --backtitle "$BACKTITLE" \
                                                       --yesno "Do you want to install Maxima Algebra System?" 6 33;
                                            if [ "$?" -eq 0 ]; then ##Okay Maxima
                                                clear;
                                                printf "==========================================\n| Install Software                       |\n==========================================\n";
                                                sudo apt-get install maxima;
                                                printf "\nPress Enter to return to the Program\n";read
                                            elif [ "$?" -eq 1 ]; then ##Cancel Maxima
                                                clear;
                                            fi
                                            ;;
                                            6)
                                                dialog --clear \
                                                       --title "Openteacher" \
                                                       --backtitle "$BACKTITLE" \
                                                       --msgbox "OpenTeacher helps you to learn a foreign language. Just enter somewords in your native or foreign language, and OpenTeacher tests you." 7 58;clear
                                                dialog --title "Install" \
                                                       --backtitle "$BACKTITLE" \
                                                       --yesno "Do you want to install Openteacher?" 6 33;
                                            if [ "$?" -eq 0 ]; then ##Okay Openteacher
                                                clear;
                                                printf "==========================================\n| Install Software                       |\n==========================================\n";
                                                sudo apt-get install openteacher;
                                                printf "\nPress Enter to return to the Program\n";read
                                            elif [ "$?" -eq 1 ]; then ##Cancel Openteacher
                                                clear;
                                            fi
                                            ;;
                                            7)
                                                dialog --clear \
                                                       --title "GElemental" \
                                                       --backtitle "$BACKTITLE" \
                                                       --msgbox "gElemental is a periodic table viewer that provides\ndetailed information on the chemical elements.\nIt is a port of GPeriodic to C++ and gtkmm,\nand it offers an improved UI, an updated and corrected data set,\na better data format, a list view, and easier coloration." 11 58;clear
                                                dialog --title "Install" \
                                                       --backtitle "$BACKTITLE" \
                                                       --yesno "Do you want to install GElemental Periodic Table?" 6 33;
                                            if [ "$?" -eq 0 ]; then ##Okay GElemental
                                                clear;
                                                printf "==========================================\n| Install Software                       |\n==========================================\n";
                                                sudo apt-get install gelemental;
                                                printf "\nPress Enter to return to the Program\n";read
                                            elif [ "$?" -eq 1 ]; then ##Cancel GElemental
                                                clear;
                                            fi
                                            ;;
                                            8)
                                                dialog --clear \
                                                       --title "Planets" \
                                                       --backtitle "$BACKTITLE" \
                                                       --msgbox "Planets is a simple interactive program\nfor playing with simulations\nof planetary systems.\nIt is great  teaching  tool for understanding\nhow gravitation works on a planetary level.\nThe user interface is aimed at being simple enough\nfor a fairly young kid can get some joy of it.\nThere's also a special kid-mode\naimed at very young children which grabs the focus\nand converts key banging into lots of random planets." 14 58;clear
                                                dialog --title "Install" \
                                                       --backtitle "$BACKTITLE" \
                                                       --yesno "Do you want to install Planets?" 6 33;
                                            if [ "$?" -eq 0 ]; then ##Okay Planets
                                                clear;
                                                printf "==========================================\n| Install Software                       |\n==========================================\n";
                                                sudo apt-get install planets;
                                                printf "\nPress Enter to return to the Program\n";read
                                            elif [ "$?" -eq 1 ]; then ##Cancel Planets
                                                clear;
                                            fi
                                            ;;
                                            9)
                                                dialog --clear \
                                                       --title "PYlang" \
                                                       --backtitle "$BACKTITLE" \
                                                       --msgbox "PYLang is a Linux application for checking language by random sentences,\nwhere you must compose the right sentence." 7 58;clear
                                                dialog --title "Install" \
                                                       --backtitle "$BACKTITLE" \
                                                       --yesno "Do you want to install Pylang?" 6 33;
                                            if [ "$?" -eq 0 ]; then ##Okay PYlang
                                                clear;
                                                printf "==========================================\n| Install Software                       |\n==========================================\n";
                                                sudo apt-get install pylang;
                                                printf "\nPress Enter to return to the Program\n";read
                                            elif [ "$?" -eq 1 ]; then ##Cancel PYlang
                                                clear;
                                            fi
                                            ;;
                                            10)
                                            while [[ 1 ]]
                                            do
                                            HEIGHT=17
                                            WIDTH=50
                                            CHOICE_HEIGHT=7
                                            BACKTITLE="PMP v.0.0.25 / Software Center / Education"
                                            TITLE="Education"
                                            MENU="Select one:"
                                            OPTIONS=(1 "Scratch - Easy Programming Enviroment"
                                                     2 "Stellarium - Planetarium"
                                                     3 "TuxMath - Math Game For Kids"
                                                     4 "TuxPaint - Paint Program For Kids"
                                                     5 "TuxType - Typing Tutor For Kids"
                                                     6 "UDAV - Data Plotting Tool"
                                                     7 "Back to Main Menu")
                                            CHOICE=$(dialog --clear \
                                                            --backtitle "$BACKTITLE" \
                                                            --title "$TITLE" \
                                                            --menu "$MENU" \
                                            $HEIGHT $WIDTH $CHOICE_HEIGHT \
                                            "${OPTIONS[@]}" \
                                            2>&1 >/dev/tty)
                                            if [ "$?" -eq 0 ]; then ##Okay in Education Page 4
                                                case $CHOICE in
                                                    1)
                                                    dialog --clear \
                                                           --title "Scratch" \
                                                           --backtitle "$BACKTITLE" \
                                                           --msgbox "Scratch is an easy, interactive,\ncollaborative programming environment\ndesigned for creation of interactive\nstories, animations, games, music, and art\n-- and sharing these on the web.\nScratch is designed to help young people\n'ages 8 and up'\ndevelop 21st century learning skills.\nAs they create Scratch projects,\nyoung people learn important mathematical\nand computational ideas,\nwhile also gaining a deeper understanding\nof the process of design. " 17 58;clear
                                                    dialog --title "Install" \
                                                           --backtitle "$BACKTITLE" \
                                                           --yesno "Do you want to install Scratch?" 6 33;
                                                    if [ "$?" -eq 0 ]; then ##Okay Scratch
                                                        clear;
                                                        printf "==========================================\n| Install Software                       |\n==========================================\n";
                                                        sudo apt-get install scratch;
                                                        printf "\nPress Enter to return to the Program\n";read
                                                    elif [ "$?" -eq 1 ]; then ##Cancel Scratch
                                                    clear;
                                                    fi
                                                    ;;
                                                    2)
                                                    dialog --clear \
                                                           --title "Stellarium" \
                                                           --backtitle "$BACKTITLE" \
                                                           --msgbox "Stellarium is a free GPL software\nwhich renders realistic skies\nin real time with OpenGL.\nIt is available for Linux/Unix, Windows and MacOSX.\nWith Stellarium,\nyou really see what you can see with your eyes,\nbinoculars\nor a small telescope." 12 58;clear
                                                    dialog --title "Install" \
                                                           --backtitle "$BACKTITLE" \
                                                           --yesno "Do you want to install Stellarium?" 6 33;
                                                    if [ "$?" -eq 0 ]; then ##Okay Stellarium
                                                        clear;
                                                        printf "==========================================\n| Install Software                       |\n==========================================\n";
                                                        sudo apt-get install stellarium;
                                                        printf "\nPress Enter to return to the Program\n";read
                                                    elif [ "$?" -eq 1 ]; then ##Cancel Stellarium
                                                    clear;
                                                    fi
                                                    ;;
                                                    3)
                                                    dialog --clear \
                                                           --title "TuxMath" \
                                                           --backtitle "$BACKTITLE" \
                                                           --msgbox "Tux, of Math Command 'TuxMath, for short'\nis an educational arcade game\nstarring Tux, the Linux mascot!\nBased on the classic arcade game Missile Command,\nTux must defend his cities.\nIn this case, though,\nhe must do it by solving math problems." 11 58;clear
                                                    dialog --title "Install" \
                                                           --backtitle "$BACKTITLE" \
                                                           --yesno "Do you want to install Tuxmath?" 6 33;
                                                    if [ "$?" -eq 0 ]; then ##Okay TuxMath
                                                        clear;
                                                        printf "==========================================\n| Install Software                       |\n==========================================\n";
                                                        sudo apt-get install tuxmath;
                                                        printf "\nPress Enter to return to the Program\n";read
                                                    elif [ "$?" -eq 1 ]; then ##Cancel TuxMath
                                                    clear;
                                                    fi
                                                    ;;
                                                    4)
                                                    dialog --clear \
                                                           --title "TuxPaint" \
                                                           --backtitle "$BACKTITLE" \
                                                           --msgbox "Tux Paint is a drawing program for young children.\nIt is meant to be easy and fun to use.\nIt provides a simple interface\nand fixed canvas size,\nand provides access to previous images\nusing a thumbnail browser 'i.e.,\nno access to the underlying filesystem'.\nUnlike popular drawing programs like 'The GIMP,'\nit has a very limited toolset.\nHowever, it  provides a much simpler interface,\nand has entertaining,\nchild-oriented additions such as sound effects." 16 58;clear
                                                    dialog --title "Install" \
                                                           --backtitle "$BACKTITLE" \
                                                           --yesno "Do you want to install TuxPaint?" 6 33;
                                                    if [ "$?" -eq 0 ]; then ##Okay TuxPaint
                                                        clear;
                                                        printf "==========================================\n| Install Software                       |\n==========================================\n";
                                                        sudo apt-get install tuxpaint;
                                                        printf "\nPress Enter to return to the Program\n";read
                                                    elif [ "$?" -eq 1 ]; then ##Cancel TuxPaint
                                                    clear;
                                                    fi
                                                    ;;
                                                    5)
                                                    dialog --clear \
                                                           --title "TuxType" \
                                                           --backtitle "$BACKTITLE" \
                                                           --msgbox "TuxTyping is an educational typing tutorial game\nstarring Tux, the Linux Penguin.\nThe player guides Tux to eat fish\nwhich are falling from the top of the screen.\nEach fish has a letter written on it.\nWhen the player presses the corresponding key,\nTux will position himself to  eat the fish.\nThe game is intended for children learning to type,\nthough it does have higher difficulty levels\nwhich even experienced typers may find challenging." 14 58;clear
                                                    dialog --title "Install" \
                                                           --backtitle "$BACKTITLE" \
                                                           --yesno "Do you want to install TuxType Typing Tudor?" 6 33;
                                                    if [ "$?" -eq 0 ]; then ##Okay TuxType
                                                        clear;
                                                        printf "==========================================\n| Install Software                       |\n==========================================\n";
                                                        sudo apt-get install tuxtype;
                                                        printf "\nPress Enter to return to the Program\n";read
                                                    elif [ "$?" -eq 1 ]; then ##Cancel TuxType
                                                    clear;
                                                    fi
                                                    ;;
                                                    6)
                                                    dialog --clear \
                                                           --title "UDAV" \
                                                           --backtitle "$BACKTITLE" \
                                                           --msgbox "UDAV reads MGL scripts from scriptfile\nto produce plots of specified functions or data.\nThe program will create a GUI window\nwhich show the script result\nand allow to edit the script itself." 9 58;clear
                                                    dialog --title "Install" \
                                                           --backtitle "$BACKTITLE" \
                                                           --yesno "Do you want to install UDAV Data Plotting Tool?" 6 33;
                                                    if [ "$?" -eq 0 ]; then ##Okay UDAV
                                                        clear;
                                                        printf "==========================================\n| Install Software                       |\n==========================================\n";
                                                        sudo apt-get install udav;
                                                        printf "\nPress Enter to return to the Program\n";read
                                                    elif [ "$?" -eq 1 ]; then ##Cancel UDAV
                                                    clear;
                                                    fi
                                                    ;;
                                                    7)
                                                        break 4;
                                                    ;;
                                                    esac
                                            elif [ "$?" -eq 1 ]; then ##Cancel in Education Page 4
                                                break;
                                            fi
                                            done 
                                            ;;
                                            esac
                                        elif [ "$?" -eq 1 ]; then ##Cancel in Education Page 3
                                            break;
                                        fi
                                        done
                                        ;;
                                        esac
                                elif [ "$?" -eq 1 ]; then ##Cancel in Education Page 2
                                    break;
                                fi
                            done
                            ;;
                        esac
                    elif [ "$?" -eq 1 ]; then ##Cancel in Education Page 1
                    break;
                    fi
                done
            ;;
            4)
                while [[ 1 ]]
                do
                HEIGHT=17
                WIDTH=50
                CHOICE_HEIGHT=10
                BACKTITLE="PMP v.0.0.25 / Software Center / Office"
                TITLE="Office"
                MENU="Select one:"
                OPTIONS=(1 "Abiword - Word Processor"
                         2 "AGTL - Geocaching Tool"
                         3 "Gnome Calendar - Calendar App"
                         4 "GLabels - Label Creator"
                         5 "GNUCash - Finance Accounting"
                         6 "LibreOffice - Office Suite"
                         7 "LibreOffice Calc - Speadsheets"
                         8 "LibreOffice Draw - Graphics Editor "
                         9 "LibreOffice Impress - Presentations"
                         10 "Next Page ->")
                CHOICE=$(dialog --clear \
			        --backtitle "$BACKTITLE" \
			        --title "$TITLE" \
			        --menu "$MENU" \
			      $HEIGHT $WIDTH $CHOICE_HEIGHT \
			      "${OPTIONS[@]}" \
			      2>&1 >/dev/tty)
                    if [ "$?" -eq 0 ]; then ##Okay in Office Page 1
                        case $CHOICE in
                            1)
                                dialog --clear \
                                       --title "Abiword" \
                                       --backtitle "$BACKTITLE" \
                                       --msgbox "AbiWord is a full-featured, efficient word processing\napplication suitable for a wide range of word processing tasks,\nand extensible with a variety of plugins.\nIt integrates with enchant to provide spell-checking." 9 58;clear
                                dialog --title "Install" \
                                       --backtitle "$BACKTITLE" \
                                       --yesno "Do you want to install Abiword Word Processor?" 6 33;
                                if [ "$?" -eq 0 ]; then ##Okay Abiword
                                    clear;
                                    printf "==========================================\n| Install Software                       |\n==========================================\n";
                                    sudo apt-get install abiword;
                                    printf "\nPress Enter to return to the Program\n";read
                                elif [ "$?" -eq 1 ]; then ##Cancel Abiword
                                    clear;
                                fi
                            ;;
                            2)
                                dialog --clear \
                                       --title "AGTL" \
                                       --backtitle "$BACKTITLE" \
                                       --msgbox "Agtl is used while geocaching to circumvent the need\nto have paper and pencils at hand." 6 58;clear
                                dialog --title "Install" \
                                       --backtitle "$BACKTITLE" \
                                       --yesno "Do you want to install AGTL Geocaching Tool?" 6 33;
                                if [ "$?" -eq 0 ]; then ##Okay AGTL
                                    clear;
                                    printf "==========================================\n| Install Software                       |\n==========================================\n";
                                    sudo apt-get install agtl;
                                    printf "\nPress Enter to return to the Program\n";read
                                elif [ "$?" -eq 1 ]; then ##Cancel AGTL
                                    clear;
                                fi
                            ;;
                            3)
                                dialog --clear \
                                       --title "Gnome Calendar" \
                                       --backtitle "$BACKTITLE" \
                                       --msgbox "GNOME Calendar is a simple and beautiful calendar\napplication designed to perfectly fit\nthe GNOME desktop.\nBy reusing the components\nwhich the GNOME desktop is build on,\nCalendar nicely integrates with the GNOME ecosystem. " 10 58;clear
                                dialog --title "Install" \
                                       --backtitle "$BACKTITLE" \
                                       --yesno "Do you want to install Gnome Calendar?" 6 33;
                                if [ "$?" -eq 0 ]; then ##Okay Gnome Calendar
                                    clear;
                                    printf "==========================================\n| Install Software                       |\n==========================================\n";
                                    sudo apt-get install gnome-calendar;
                                    printf "\nPress Enter to return to the Program\n";read
                                elif [ "$?" -eq 1 ]; then ##Cancel Gnome Calendar
                                    clear;
                                fi
                            ;;
                            4)
                                dialog --clear \
                                       --title "GLabels" \
                                       --backtitle "$BACKTITLE" \
                                       --msgbox "glabels-3 is a lightweight program\nfor creating labels and business cards\nfor the GNOME desktop environment.\nIt is designed to work with various\nlaser/ink-jet peel-off label\nand business card sheets\nthat you'll find at most office supply stores.\nglabels-3 is pre-configured with templates for many\nof these products.\nIt also provides an interactive template designer\nfor creating new templates\naccording to user specifications." 16 58;clear
                                dialog --title "Install" \
                                       --backtitle "$BACKTITLE" \
                                       --yesno "Do you want to install GLabels Label Creator?" 6 33;
                                if [ "$?" -eq 0 ]; then ##Okay GLabels
                                    clear;
                                    printf "==========================================\n| Install Software                       |\n==========================================\n";
                                    sudo apt-get install glabels;
                                    printf "\nPress Enter to return to the Program\n";read
                                elif [ "$?" -eq 1 ]; then ##Cancel GLabels
                                    clear;
                                fi
                            ;;
                            5)
                                dialog --clear \
                                       --title "GNUCash" \
                                       --backtitle "$BACKTITLE" \
                                       --msgbox "GnuCash is a personal accounting package\nthat allows you to record and track income,\nexpenses,  assets, and investments.\nIt supports reconciliation,\nhas substantial reporting capabilities,\nand is extensible using guile.\nIt can import QIF data from Quicken TM*\nand many  other  commercial  accounting packages.\nIt uses GTK+ and GNOME\nto provide an attractive user interface,\nand has extensive online help." 15 58;clear
                                dialog --title "Install" \
                                       --backtitle "$BACKTITLE" \
                                       --yesno "Do you want to install GNUCash Finance Accounting?" 6 33;
                                if [ "$?" -eq 0 ]; then ##Okay GNUCash
                                    clear;
                                    printf "==========================================\n| Install Software                       |\n==========================================\n";
                                    sudo apt-get install gnucash;
                                    printf "\nPress Enter to return to the Program\n";read
                                elif [ "$?" -eq 1 ]; then ##Cancel GNUCash
                                    clear;
                                fi
                            ;;
                            6)
                                dialog --clear \
                                       --title "LibreOffice" \
                                       --backtitle "$BACKTITLE" \
                                       --msgbox "LibreOffice is a multi-platform\noffice productivity suite.\nIt was derived from OpenOffice.org 3.3 Beta\non September 28,2010." 8 58;clear
                                dialog --title "Install" \
                                       --backtitle "$BACKTITLE" \
                                       --yesno "Do you want to install LibreOffice Office Suite?" 6 33;
                                if [ "$?" -eq 0 ]; then ##Okay LibreOffice
                                    clear;
                                    printf "==========================================\n| Install Software                       |\n==========================================\n";
                                    sudo apt-get install libreoffice;
                                    printf "\nPress Enter to return to the Program\n";read
                                elif [ "$?" -eq 1 ]; then ##Cancel LibreOffice
                                    clear;
                                fi
                            ;;
                            7)
                                dialog --clear \
                                       --title "LibreOffice Calc" \
                                       --backtitle "$BACKTITLE" \
                                       --msgbox "LibreOffice Calc is the spreadsheet component\nof the LibreOffice software package." 6 58;clear
                                dialog --title "Install" \
                                       --backtitle "$BACKTITLE" \
                                       --yesno "Do you want to install LibreOffice Calc Speadsheets?" 6 33;
                                if [ "$?" -eq 0 ]; then ##Okay LibreOffice Calc
                                    clear;
                                    printf "==========================================\n| Install Software                       |\n==========================================\n";
                                    sudo apt-get install libreoffice-calc;
                                    printf "\nPress Enter to return to the Program\n";read
                                elif [ "$?" -eq 1 ]; then ##Cancel LibreOffice Calc
                                    clear;
                                fi
                            ;;
                            8)
                                dialog --clear \
                                       --title "LibreOffice Draw" \
                                       --backtitle "$BACKTITLE" \
                                       --msgbox "LibreOffice Draw is an online diagramming\nand charting office tool.\nDraw is an excellent application\nfor producing a quick sketch, a complex plan,\ntechnical drawings, general posters,\nand much more.\nYou can use the picture gallery\nto access built-in clip art,\nand can create your own art\nand add it to the gallery.\nDraw can import graphics in popular formats,\nincluding BMP, GIF, JPEG, PNG, TIFF, and WMF.\nIt also allow you to export files to Flash\n'.swf' format." 18 58;clear
                                dialog --title "Install" \
                                       --backtitle "$BACKTITLE" \
                                       --yesno "Do you want to install LibreOffice Draw?" 6 33;
                                if [ "$?" -eq 0 ]; then ##Okay LibreOffice Draw
                                    clear;
                                    printf "==========================================\n| Install Software                       |\n==========================================\n";
                                    sudo apt-get install libreoffice-draw;
                                    printf "\nPress Enter to return to the Program\n";read
                                elif [ "$?" -eq 1 ]; then ##Cancel LibreOffice Draw
                                    clear;
                                fi
                            ;;
                            9)
                                dialog --clear \
                                       --title "LibreOffice Impress" \
                                       --backtitle "$BACKTITLE" \
                                       --msgbox "LibreOffice Impress is an online office tool\nfor creating professional multimedia presentations.\nYour presentations can be enhanced\nwith 2D and 3D clip art, special effects, transition styles, animations, and advanced drawing tools.\nYou can open Microsoft PowerPoint files,\nand save your work in PowerPoint format \n'.pptx, .pps'." 12 58;clear
                                dialog --title "Install" \
                                       --backtitle "$BACKTITLE" \
                                       --yesno "Do you want to install LibreOffice Impress?" 6 33;
                                if [ "$?" -eq 0 ]; then ##Okay LibreOffice Impress
                                    clear;
                                    printf "==========================================\n| Install Software                       |\n==========================================\n";
                                    sudo apt-get install libreoffice-impress;
                                    printf "\nPress Enter to return to the Program\n";read
                                elif [ "$?" -eq 1 ]; then ##Cancel LibreOffice Impress
                                    clear;
                                fi
                            ;;
                            10)
                            while [[ 1 ]]
                            do
                            HEIGHT=17
                            WIDTH=50
                            CHOICE_HEIGHT=6
                            BACKTITLE="PMP v.0.0.25 / Software Center / Office"
                            TITLE="Internet"
                            MENU="Select one:"
                            OPTIONS=(1 "LibreOffice Math - Equation Editor"
                                     2 "LibreOffice Writer - Word Processor"
                                     3 "Okular - Document Viewer"
                                     4 "OpenMolar - Dental Practice Manager"
                                     5 "Tellico - A Collection Manager"
                                     6 "Back to Main Menu")
                            CHOICE=$(dialog --clear \
                                            --backtitle "$BACKTITLE" \
                                            --title "$TITLE" \
                                            --menu "$MENU" \
                            $HEIGHT $WIDTH $CHOICE_HEIGHT \
                            "${OPTIONS[@]}" \
                            2>&1 >/dev/tty)
                            if [ "$?" -eq 0 ]; then ##Okay in Office Page 2
                                case $CHOICE in
                                    1)
                                    dialog --clear \
                                           --title "Libreoffice Math" \
                                           --backtitle "$BACKTITLE" \
                                           --msgbox "Math is LibreOffice’s component for writing\nmathematical and chemical equations.\nIt is most commonly used\nas an equation editor for text documents,\nbut it can also be used\nwith other types of documents or stand-alone.\nWhen used inside Writer,\nthe equation is treated as an object\ninside the text document." 13 58;clear
                                    dialog --title "Install" \
                                           --backtitle "$BACKTITLE" \
                                           --yesno "Do you want to install Libreoffice Math?" 6 33;
                                    if [ "$?" -eq 0 ]; then ##Okay Libreoffice Math
                                        clear;
                                        printf "==========================================\n| Install Software                       |\n==========================================\n";
                                        sudo apt-get install libreoffice-math;
                                        printf "\nPress Enter to return to the Program\n";read
                                    elif [ "$?" -eq 1 ]; then ##Cancel Libreoffice Math
                                        clear;
                                    fi
                                    ;;
                                    2)
                                    dialog --clear \
                                           --title "LibreOffice Writer" \
                                           --backtitle "$BACKTITLE" \
                                           --msgbox "LibreOffice Writer has all the features you need\nfrom a modern, full-featured word processing\nand desktop publishing tool.\nIt's simple enough for a quick memo,\nbut powerful enough to create complete books\nwith contents, diagrams, indexes, and more.\nYou're free to concentrate on your message,\nwhile Writer makes it look great." 12 58;clear
                                    dialog --title "Install" \
                                           --backtitle "$BACKTITLE" \
                                           --yesno "Do you want to install LibreOffice Writer?" 6 33;
                                    if [ "$?" -eq 0 ]; then ##Okay LibreOffice Writer
                                        clear;
                                        printf "==========================================\n| Install Software                       |\n==========================================\n";
                                        sudo apt-get install libreoffice-writer;
                                    printf "\nPress Enter to return to the Program\n";read
                                    elif [ "$?" -eq 1 ]; then ##Cancel LibreOffice Writer
                                        clear;
                                    fi
                                    ;;
                                    3)
                                    dialog --clear \
                                           --title "Okular" \
                                           --backtitle "$BACKTITLE" \
                                           --msgbox "Okular is aimed to show documents in different formats." 5 58;clear
                                    dialog --title "Install" \
                                           --backtitle "$BACKTITLE" \
                                           --yesno "Do you want to install Okular?" 6 33;
                                    if [ "$?" -eq 0 ]; then ##Okay Okular 
                                        clear;
                                        printf "==========================================\n| Install Software                       |\n==========================================\n";
                                        sudo apt-get install okular;
                                        printf "\nPress Enter to return to the Program\n";read
                                    elif [ "$?" -eq 1 ]; then ##Cancel Okular
                                        clear;
                                    fi
                                    ;;
                                    4)
                                    dialog --clear \
                                           --title "OpenMolar" \
                                           --backtitle "$BACKTITLE" \
                                           --msgbox "Openmolar is a dental practice management software." 5 58;clear
                                    dialog --title "Install" \
                                           --backtitle "$BACKTITLE" \
                                           --yesno "Do you want to install Okay OpenMolar?" 6 33;
                                    if [ "$?" -eq 0 ]; then ##Okay OpenMolar
                                        clear;
                                        printf "==========================================\n| Install Software                       |      \n==========================================\n";
                                        sudo apt-get install openmolar;
                                        printf "\nPress Enter to return to the Program\n";read
                                    elif [ "$?" -eq 1 ]; then ##Cancel OpenMolar
                                        clear;
                                    fi 
                                    ;;
                                    5)
                                    dialog --clear \
                                           --title "Tellico" \
                                           --backtitle "$BACKTITLE" \
                                           --msgbox "Tellico - is a collection manager for KDE" 5 58;clear
                                    dialog --title "Install" \
                                           --backtitle "$BACKTITLE" \
                                           --yesno "Do you want to install Tellico?" 6 33;
                                    if [ "$?" -eq 0 ]; then ##Okay Tellico
                                        clear;
                                        printf "==========================================\n| Install Software                       |\n==========================================\n";
                                        sudo apt-get install tellico;
                                        printf "\nPress Enter to return to the Program\n";read
                                    elif [ "$?" -eq 1 ]; then ##Cancel Tellico
                                        clear;
                                    fi
                                    ;;
                                    6)
                                        break 2;
                                    ;;
                                esac
                            elif [ "$?" -eq 1 ]; then ##Cancel in Office Page 2
                                break;
                            fi
                            done
                            ;;
                        esac
                    elif [ "$?" -eq 1 ]; then ##Cancel in Office Page 1
                    break;
                    fi
                done
            ;;
            5)
                while [[ 1 ]]
                do
                HEIGHT=17
                WIDTH=50
                CHOICE_HEIGHT=4
                BACKTITLE="PMP v.0.0.25 / Software Center / Internet"
                TITLE="Internet"
                MENU="Select one:"
                OPTIONS=(1 "Web Browser"
                         2 "File Sharing"
                         3 "Mail"
                         4 "Chat")
                CHOICE=$(dialog --clear \
			        --backtitle "$BACKTITLE" \
			        --title "$TITLE" \
			        --menu "$MENU" \
			      $HEIGHT $WIDTH $CHOICE_HEIGHT \
			      "${OPTIONS[@]}" \
			      2>&1 >/dev/tty)
                    if [ "$?" -eq 0 ]; then ##Okay in Internet Page
                        case $CHOICE in
                            1)
                            while [[ 1 ]]
                            do
                            HEIGHT=17
                            WIDTH=50
                            CHOICE_HEIGHT=5
                            BACKTITLE="PMP v.0.0.25 / Software Center / Internet / Web Browser"
                            TITLE="Web Browser"
                            MENU="Select one:"
                            OPTIONS=(1 "Firefox"
                                     2 "Chromium"
                                     3 "Gnome Epiphany"
                                     4 "QupZilla"
                                     5 "Tor Browser")
                            CHOICE=$(dialog --clear \
                                            --backtitle "$BACKTITLE" \
                                            --title "$TITLE" \
                                            --menu "$MENU" \
                            $HEIGHT $WIDTH $CHOICE_HEIGHT \
                            "${OPTIONS[@]}" \
                            2>&1 >/dev/tty)
                            if [ "$?" -eq 0 ]; then ##Okay in Web Browser
                                case $CHOICE in
                                    1)
                                    dialog --title "Install" \
                                           --backtitle "$BACKTITLE" \
                                           --yesno "Do you want to install Firefox Web Browser?" 6 33;
                                    if [ "$?" -eq 0 ]; then ##Okay Firefox
                                        clear;
                                        printf "==========================================\n| Install Software                       |\n==========================================\n";
                                        sudo apt-get install firefox;
                                        printf "\nPress Enter to return to the Program\n";read
                                    elif [ "$?" -eq 1 ]; then ##Cancel Firefox
                                        clear;
                                    fi
                                    ;;
                                    2)
                                    dialog --title "Install" \
                                           --backtitle "$BACKTITLE" \
                                           --yesno "Do you want to install Chromium Web Browser?" 6 33;
                                    if [ "$?" -eq 0 ]; then ##Okay Chromium
                                        clear;
                                        printf "==========================================\n| Install Software                       |\n==========================================\n";
                                        sudo apt-get install chromium-browser;
                                        printf "\nPress Enter to return to the Program\n";read
                                    elif [ "$?" -eq 1 ]; then ##Cancel Chromium
                                        clear;
                                    fi
                                    ;;
                                    3)
                                    dialog --title "Install" \
                                           --backtitle "$BACKTITLE" \
                                           --yesno "Do you want to install Epiphany Web Browser?" 6 33;
                                    if [ "$?" -eq 0 ]; then ##Okay Epiphany
                                        clear;
                                        printf "==========================================\n| Install Software                       |\n==========================================\n";
                                        sudo apt-get install epiphany-browser;
                                        printf "\nPress Enter to return to the Program\n";read
                                    elif [ "$?" -eq 1 ]; then ##Cancel Epiphany
                                        clear;
                                    fi
                                    ;;
                                    4)
                                    dialog --title "Install" \
                                           --backtitle "$BACKTITLE" \
                                           --yesno "Do you want to install Qupzilla Web Browser?" 6 33;
                                    if [ "$?" -eq 0 ]; then ##Okay Qupzilla
                                        clear;
                                        printf "==========================================\n| Install Software                       |\n==========================================\n";
                                        sudo apt-get install qupzilla;
                                        printf "\nPress Enter to return to the Program\n";read
                                    elif [ "$?" -eq 1 ]; then ##Cancel Qupzilla
                                        clear;
                                    fi
                                    ;;
                                    5)
                                    dialog --title "Install" \
                                           --backtitle "$BACKTITLE" \
                                           --yesno "Do you want to install Tor Web Browser?" 6 33;
                                    if [ "$?" -eq 0 ]; then ##Okay Tor
                                        clear;
                                        printf "==========================================\n| Install Software                       |\n==========================================\n";
                                        sudo apt-get install tor;
                                        printf "\nPress Enter to return to the Program\n";read
                                    elif [ "$?" -eq 1 ]; then ##Cancel Tor
                                        clear;
                                    fi
                                    ;;
                                esac
                            elif [ "$?" -eq 1 ]; then ##Cancel in Web Browser
                                break;
                            fi
                            done
                            ;;
                            2)
                            while [[ 1 ]]
                            do
                            HEIGHT=17
                            WIDTH=50
                            CHOICE_HEIGHT=5
                            BACKTITLE="PMP v.0.0.25 / Software Center / Internet / File Sharing"
                            TITLE="File Sharing"
                            MENU="Select one:"
                            OPTIONS=(1 "BitTorrent - BitTorrent Client"
                                     2 "FileZilla - FTP Client "
                                     3 "GnuNet - peer-to-peer Framework"
                                     4 "Qbittorrent - BitTorrent Client"
                                     5 "Transmission - Bittorrent Client")
                            CHOICE=$(dialog --clear \
                                            --backtitle "$BACKTITLE" \
                                            --title "$TITLE" \
                                            --menu "$MENU" \
                            $HEIGHT $WIDTH $CHOICE_HEIGHT \
                            "${OPTIONS[@]}" \
                            2>&1 >/dev/tty)
                            if [ "$?" -eq 0 ]; then ##Okay in File Sharing
                                case $CHOICE in
                                1)
                                dialog --title "Install" \
                                       --backtitle "$BACKTITLE" \
                                       --yesno "Do you want to install Bittorrent?" 6 33;
                                if [ "$?" -eq 0 ]; then ##Okay Bittorrent
                                    clear;
                                    printf "==========================================\n| Install Software                       |\n==========================================\n";
                                    sudo apt-get install bittorrent bittorrent-gui;
                                    printf "\nPress Enter to return to the Program\n";read
                                elif [ "$?" -eq 1 ]; then ##Cancel Bittorrent
                                    clear;
                                fi
                                ;;
                                2)
                                dialog --title "Install" \
                                       --backtitle "$BACKTITLE" \
                                       --yesno "Do you want to install FileZilla FTP Client?" 6 33;
                                if [ "$?" -eq 0 ]; then ##Okay FileZilla
                                    clear;
                                    printf "==========================================\n| Install Software                       |\n==========================================\n";
                                    sudo apt-get install filezilla;
                                    printf "\nPress Enter to return to the Program\n";read
                                elif [ "$?" -eq 1 ]; then ##Cancel FileZilla
                                    clear;
                                fi
                                ;;
                                3)
                                dialog --title "Install" \
                                       --backtitle "$BACKTITLE" \
                                       --yesno "Do you want to install Gnunet?" 6 33;
                                if [ "$?" -eq 0 ]; then ##Okay Gnunet
                                    clear;
                                    printf "==========================================\n| Install Software                       |\n==========================================\n";
                                    sudo apt-get install gnunet;
                                    printf "\nPress Enter to return to the Program\n";read
                                elif [ "$?" -eq 1 ]; then ##Cancel Gnunet
                                    clear;
                                fi
                                ;;
                                4)
                                dialog --title "Install" \
                                       --backtitle "$BACKTITLE" \
                                       --yesno "Do you want to install Qbittorrent?" 6 33;
                                if [ "$?" -eq 0 ]; then ##Okay Qbittorrent
                                    clear;
                                    printf "==========================================\n| Install Software                       |\n==========================================\n";
                                    sudo apt-get install qbittorrent;
                                    printf "\nPress Enter to return to the Program\n";read
                                elif [ "$?" -eq 1 ]; then ##Cancel Qbittorrent
                                    clear;
                                fi
                                ;;
                                5)
                                dialog --title "Install" \
                                       --backtitle "$BACKTITLE" \
                                       --yesno "Do you want to install Transmission?" 6 33;
                                if [ "$?" -eq 0 ]; then ##Okay Transmission
                                    clear;
                                    printf "==========================================\n| Install Software                       |\n==========================================\n";
                                    sudo apt-get install transmission;
                                    printf "\nPress Enter to return to the Program\n";read
                                elif [ "$?" -eq 1 ]; then ##Cancel Transmission
                                    clear;
                                fi
                                ;;
                                esac
                            elif [ "$?" -eq 1 ]; then ##Cancel File Sharing
                                break;
                            fi
                            done
                            ;;
                            3)
                            while [[ 1 ]]
                            do
                            HEIGHT=17
                            WIDTH=50
                            CHOICE_HEIGHT=2
                            BACKTITLE="PMP v.0.0.25 / Software Center / Internet / Mail"
                            TITLE="Multimedia"
                            MENU="Select one:"
                            OPTIONS=(1 "Tunderbird"
                                     2 "KMail - Email Client")
                            CHOICE=$(dialog --clear \
                                            --backtitle "$BACKTITLE" \
                                            --title "$TITLE" \
                                            --menu "$MENU" \
                            $HEIGHT $WIDTH $CHOICE_HEIGHT \
                            "${OPTIONS[@]}" \
                            2>&1 >/dev/tty)
                            if [ "$?" -eq 0 ]; then ##Okay in Mail
                                case $CHOICE in
                                1)
                                dialog --title "Install" \
                                       --backtitle "$BACKTITLE" \
                                       --yesno "Do you want to install Thunderbird?" 6 33;
                                if [ "$?" -eq 0 ]; then ##Okay Thunderbird
                                    clear;
                                    printf "==========================================\n| Install Software                       |\n==========================================\n";
                                    sudo apt-get install thunderbird;
                                    printf "\nPress Enter to return to the Program\n";read
                                elif [ "$?" -eq 1 ]; then ##Cancel Thunderbird
                                    clear;
                                fi
                                ;;
                                2)
                                dialog --title "Install" \
                                       --backtitle "$BACKTITLE" \
                                       --yesno "Do you want to install Thunderbird?" 6 33;
                                if [ "$?" -eq 0 ]; then ##Okay Kmail
                                    clear;
                                    printf "==========================================\n| Install Software                       |\n==========================================\n";
                                    sudo apt-get install kmail;
                                    printf "\nPress Enter to return to the Program\n";read
                                elif [ "$?" -eq 1 ]; then ##Cancel Kmail
                                    clear;
                                fi
                                ;;
                                esac
                            elif [ "$?" -eq 1 ]; then ##Cancel in Mail
                                break;
                            fi
                            done
                            ;;
                            4)
                             while [[ 1 ]]
                            do
                            HEIGHT=17
                            WIDTH=50
                            CHOICE_HEIGHT=3
                            BACKTITLE="PMP v.0.0.25 / Software Center / Internet / Chat"
                            TITLE="Multimedia"
                            MENU="Select one:"
                            OPTIONS=(1 "Empathy - Instant Messaging"
                                     2 "Pidgin - Instant Messaging"
                                     3 "Quassel - IRC Client")
                            CHOICE=$(dialog --clear \
                                            --backtitle "$BACKTITLE" \
                                            --title "$TITLE" \
                                            --menu "$MENU" \
                            $HEIGHT $WIDTH $CHOICE_HEIGHT \
                            "${OPTIONS[@]}" \
                            2>&1 >/dev/tty)
                            if [ "$?" -eq 0 ]; then ##Okay in Chat
                                case $CHOICE in
                                    1)
                                    dialog --title "Install" \
                                           --backtitle "$BACKTITLE" \
                                           --yesno "Do you want to install Empathy Instant Messaging?" 6 33;
                                    if [ "$?" -eq 0 ]; then ##Okay Empathy
                                        clear;
                                        printf "==========================================\n| Install Software                       |\n==========================================\n";
                                        sudo apt-get install empathy;
                                        printf "\nPress Enter to return to the Program\n";read
                                    elif [ "$?" -eq 1 ]; then ##Cancel Empathy
                                        clear;
                                    fi
                                    ;;
                                    2)
                                    dialog --title "Install" \
                                           --backtitle "$BACKTITLE" \
                                           --yesno "Do you want to install Pidgin Instant Messaging?" 6 33;
                                    if [ "$?" -eq 0 ]; then ##Okay Pidgin
                                        clear;
                                        printf "==========================================\n| Install Software                       |\n==========================================\n";
                                        sudo apt-get install pidgin;
                                        printf "\nPress Enter to return to the Program\n";read
                                    elif [ "$?" -eq 1 ]; then ##Cancel Pidgin
                                        clear;
                                    fi
                                    ;;
                                    3)
                                    dialog --title "Install" \
                                           --backtitle "$BACKTITLE" \
                                           --yesno "Do you want to install Quassel IRC Client?" 6 33;
                                    if [ "$?" -eq 0 ]; then ##Okay Quassel
                                        clear;
                                        printf "==========================================\n| Install Software                       |\n==========================================\n";
                                        sudo apt-get install quassel;
                                        printf "\nPress Enter to return to the Program\n";read
                                    elif [ "$?" -eq 1 ]; then ##Cancel Quassel
                                        clear;
                                    fi
                                    ;;
                                esac
                            elif [ "$?" -eq 1 ]; then ##Cancel in Chat
                                break;
                            fi
                            done   
                            ;;
                        esac
                    elif [ "$?" -eq 1 ]; then ##Cancel in Internet Page
                        break;
                    fi
                done
            ;;
            6)
                while [[ 1 ]]
                do
                HEIGHT=17
                WIDTH=50
                CHOICE_HEIGHT=10
                BACKTITLE="PMP v.0.0.25 / Software Center / Multimedia"
                TITLE="Multimedia"
                MENU="Select one:"
                OPTIONS=(1 "Ardour - Audio Workstation"
                         2 "Audacious - Music Player"
                         3 "Audacity - Record Audio Files"
                         4 "Banshee - Multimedia App"
                         5 "Brasero - CD/DVD Burner"
                         6 "Buzztrax - Music Composer"
                         7 "Cheese - Take Photos"
                         8 "Devede - CD/DVD Burner"
                         9 "Entagged - Audiofile tagger"
                         10 "Next Page ->")
                CHOICE=$(dialog --clear \
			        --backtitle "$BACKTITLE" \
			        --title "$TITLE" \
			        --menu "$MENU" \
			      $HEIGHT $WIDTH $CHOICE_HEIGHT \
			      "${OPTIONS[@]}" \
			      2>&1 >/dev/tty)
                    if [ "$?" -eq 0 ]; then ##Okay in Multimedia Page 1
                        case $CHOICE in
                            1)
                            dialog --clear \
                                   --title "Ardour" \
                                   --backtitle "$BACKTITLE" \
                                   --msgbox "Ardour is a multichannel hard disk recorder 'HDR'\nand digital audio workstation 'DAW'.\nIt is capable of simultaneous recording\n24 or more channels of 32 bit audio at 48kHz.\nArdour is intended to function\nas a 'professional' HDR system,\nreplacing dedicated hardware solutions\nsuch as the Mackie HDR,\nthe Tascam 2424 and more" 13 58;clear
                            dialog --title "Install" \
                                   --backtitle "$BACKTITLE" \
                                   --yesno "Do you want to install Ardour Audio Workstation?" 6 33;
                            if [ "$?" -eq 0 ]; then ##Okay Ardour
                                clear;
                                printf "==========================================\n| Install Software                       |\n==========================================\n";
                                sudo apt-get install ardour;
                                printf "\nPress Enter to return to the Program\n";read
                            elif [ "$?" -eq 1 ]; then ##Cancel Ardour
                                clear;
                            fi
                            ;;
                            2)
                            dialog --clear \
                                   --title "Audacious" \
                                   --backtitle "$BACKTITLE" \
                                   --msgbox "Audacious is a free advanced audio player for Linux\nand many other UNIX-compatible systems.\nIt focuses on low resource usage,\nhigh  audio quality,\nand  support  for  a  wide  range  of  audio  formats.\nIt was originally based on Beep Media Player,\nwhich was in turn based on XMMS." 11 58;clear
                            dialog --title "Install" \
                                   --backtitle "$BACKTITLE" \
                                   --yesno "Do you want to install Audacious Music Player?" 6 33;
                            if [ "$?" -eq 0 ]; then ##Okay Audacious
                                clear;
                                printf "==========================================\n| Install Software                       |\n==========================================\n";
                                sudo apt-get install audacious;
                                printf "\nPress Enter to return to the Program\n";read
                            elif [ "$?" -eq 1 ]; then ##Cancel Audacious
                                clear;
                            fi
                            ;;
                            3)
                            dialog --clear \
                                   --title "Audacity" \
                                   --backtitle "$BACKTITLE" \
                                   --msgbox "Audacity is a Graphical cross-platform audio editor" 5 58;clear
                            dialog --title "Install" \
                                   --backtitle "$BACKTITLE" \
                                   --yesno "Do you want to install Audacious Music Player?" 6 33;
                            if [ "$?" -eq 0 ]; then ##Okay Audacity
                                clear;
                                printf "==========================================\n| Install Software                       |\n==========================================\n";
                                sudo apt-get install audacity;
                                printf "\nPress Enter to return to the Program\n";read
                            elif [ "$?" -eq 1 ]; then ##Cancel Audacity
                                clear;
                            fi
                            ;;
                            4)
                            dialog --clear \
                                   --title "Banshee" \
                                   --backtitle "$BACKTITLE" \
                                   --msgbox "Banshee is an media management and playback application\nfor the GNOME desktop,\nallowing users to import audio from CDs,\nsearch their library,\ncreate playlists of selections of their library,\nsync music to/from iPods\nand other media devices,\nplay and manage video files\nand burn selections to a CD." 14 58;clear
                            dialog --title "Install" \
                                   --backtitle "$BACKTITLE" \
                                   --yesno "Do you want to install Banshee Multimedia App?" 6 33;
                            if [ "$?" -eq 0 ]; then ##Okay Banshee
                                clear;
                                printf "==========================================\n| Install Software                       |\n==========================================\n";
                                sudo apt-get install banshee;
                                printf "\nPress Enter to return to the Program\n";read
                            elif [ "$?" -eq 1 ]; then ##Cancel Banshee
                                clear;
                            fi
                            ;;
                            5)
                            dialog --clear \
                                   --title "Brasero" \
                                   --backtitle "$BACKTITLE" \
                                   --msgbox "Brasero is a disc burning application.\nIt is designed to be simple and easy to use.\nIt allows to create data CD/DVD,\naudio CD, to copy CD/DVD\nand to burn images.\nIt has some nices features,\nsuch as a song, image and video previewer.\nIt can also search for files\nand display a playlist and its contents." 13 58;clear
                            dialog --title "Install" \
                                   --backtitle "$BACKTITLE" \
                                   --yesno "Do you want to install Brasero CD/DVD Burner?" 6 33;
                            if [ "$?" -eq 0 ]; then ##Okay Brasero 
                                clear;
                                printf "==========================================\n| Install Software                       |\n==========================================\n";
                                sudo apt-get install brasero;
                                printf "\nPress Enter to return to the Program\n";read
                            elif [ "$?" -eq 1 ]; then ##Cancel Brasero
                                clear;
                            fi
                            ;;
                            6)
                            dialog --clear \
                                   --title "Buzztrax" \
                                   --backtitle "$BACKTITLE" \
                                   --msgbox "Buzztrax aims to be a music studio that allows\none to compose songs using only a computer\nwith a soundcard.\nIf you’ve used tracker programs like FastTracker,\nImpulse Tracker, or the original AMIGA SoundTracker,\nthat will give you an idea\nof how one can sequence music in Buzztrax." 11 58;clear
                            dialog --title "Install" \
                                   --backtitle "$BACKTITLE" \
                                   --yesno "Do you want to install Buzztrax Music Composer?" 6 33;
                            if [ "$?" -eq 0 ]; then ##Okay Buzztrax 
                                clear;
                                printf "==========================================\n| Install Software                       |\n==========================================\n";
                                sudo apt-get install buzztrax;
                                printf "\nPress Enter to return to the Program\n";read
                            elif [ "$?" -eq 1 ]; then ##Cancel Buzztrax
                                clear;
                            fi
                            ;;
                            7)
                            dialog --clear \
                                   --title "Cheese" \
                                   --backtitle "$BACKTITLE" \
                                   --msgbox "Cheese is a tool to take pictures\nand videos from your webcam" 6 58;clear
                            dialog --title "Install" \
                                   --backtitle "$BACKTITLE" \
                                   --yesno "Do you want to install Cheese?" 6 33;
                            if [ "$?" -eq 0 ]; then ##Okay Cheese 
                                clear;
                                printf "==========================================\n| Install Software                       |\n==========================================\n";
                                sudo apt-get install cheese;
                                printf "\nPress Enter to return to the Program\n";read
                            elif [ "$?" -eq 1 ]; then ##Cancel Cheese
                                clear;
                            fi
                            ;;
                            8)
                            dialog --clear \
                                   --title "Devede" \
                                   --backtitle "$BACKTITLE" \
                                   --msgbox "DeVeDe allows users to create Video DVDs,\nsuitable for home players,\nfrom any number of video files,\nin any of the formats supported by Mplayer.\nIt also allows user to create subtitles\nand even animated menus." 10 58;clear
                            dialog --title "Install" \
                                   --backtitle "$BACKTITLE" \
                                   --yesno "Do you want to install Devede CD/DVD Burner?" 6 33;
                            if [ "$?" -eq 0 ]; then ##Okay Devede
                                clear;
                                printf "==========================================\n| Install Software                       |\n==========================================\n";
                                sudo apt-get install devede;
                                printf "\nPress Enter to return to the Program\n";read
                            elif [ "$?" -eq 1 ]; then ##Cancel Devede
                                clear;
                            fi
                            ;;
                            9)
                            dialog --clear \
                                   --title "Entagged" \
                                   --backtitle "$BACKTITLE" \
                                   --msgbox "Entagged is a Java Audio File Tagger\nfor 'mp3, ogg, wma, etc'" 6 58;clear
                            dialog --title "Install" \
                                   --backtitle "$BACKTITLE" \
                                   --yesno "Do you want to install Entagged?" 6 33;
                            if [ "$?" -eq 0 ]; then ##Okay Entagged
                                clear;
                                printf "==========================================\n| Install Software                       |\n==========================================\n";
                                sudo apt-get install entagged;
                                printf "\nPress Enter to return to the Program\n";read
                            elif [ "$?" -eq 1 ]; then ##Cancel Entagged
                                clear;
                            fi
                            ;;
                            10)
                            while [[ 1 ]]
                            do
                            HEIGHT=17
                            WIDTH=50
                            CHOICE_HEIGHT=10
                            BACKTITLE="PMP v.0.0.25 / Software Center / Multimedia"
                            TITLE="Multimedia"
                            MENU="Select one:"
                            OPTIONS=(1 "Gnome-Alsamixer - ALSA Sound Mixer"
                                     2 "Mplayer - Movie Player"
                                     3 "Guvcview - GTK+ UVC Viewer"
                                     4 "Gxmms2 - GTK2-based Xmms2 Client"
                                     5 "Handbrake - Transcodes DVD/Blueray"
                                     6 "ISO Master - Read Write Modify ISO's"
                                     7 "K3b - Disc Writing Program"
                                     8 "Kazam - Capt-geture Screencasts"
                                     9 "Kdenlive - Video Editor"
                                     10 "Next Page ->")
                            CHOICE=$(dialog --clear \
                                            --backtitle "$BACKTITLE" \
                                            --title "$TITLE" \
                                            --menu "$MENU" \
                            $HEIGHT $WIDTH $CHOICE_HEIGHT \
                            "${OPTIONS[@]}" \
                            2>&1 >/dev/tty)
                                if [ "$?" -eq 0 ]; then ##Okay in Multimedia Page 2
                                    case $CHOICE in
                                        1)
                                        dialog --clear \
                                               --title "Gnome-Alsamixer" \
                                               --backtitle "$BACKTITLE" \
                                               --msgbox "gnome-alsamixer is a volume control program\nfor gnome and ALSA." 6 58;clear
                                        dialog --title "Install" \
                                               --backtitle "$BACKTITLE" \
                                               --yesno "Do you want to install Entagged?" 6 33;
                                        if [ "$?" -eq 0 ]; then ##Okay Gnome-Alsamixer
                                            clear;
                                            printf "==========================================\n| Install Software                       |\n==========================================\n";
                                            sudo apt-get install gnome-alsamixer;
                                            printf "\nPress Enter to return to the Program\n";read
                                        elif [ "$?" -eq 1 ]; then ##Cancel Gnome-Alsamixer
                                            clear;
                                        fi
                                        ;;
                                        2)
                                        dialog --clear \
                                               --title "Mplayer" \
                                               --backtitle "$BACKTITLE" \
                                               --msgbox "mplayer is a movie player for Linux\n'runs on many other platforms\nand CPU architectures.\nIt plays most MPEG/VOB, AVI, ASF/WMA/WMV,\nRM, QT/MOV/MP4, Ogg/OGM, MKV, VIVO,\nFLI, NuppelVideo, yuv4mpeg,\nFILM and RoQ files,\nsupported by many native and binary codecs.\nYou can watch VCD, SVCD, DVD, Blu-ray,\n3ivx, DivX 3/4/5, WMV\nand even H.264 movies, too." 15 58;clear
                                        dialog --title "Install" \
                                               --backtitle "$BACKTITLE" \
                                               --yesno "Do you want to install Mplayer Movie Player?" 6 33;
                                        if [ "$?" -eq 0 ]; then ##Okay Mplayer
                                            clear;
                                            printf "==========================================\n| Install Software                       |\n==========================================\n";
                                            sudo apt-get install mplayer;
                                            printf "\nPress Enter to return to the Program\n";read
                                        elif [ "$?" -eq 1 ]; then ##Cancel Mplayer
                                            clear;
                                        fi
                                        ;;
                                        3)
                                        dialog --clear \
                                               --title "Guvcview" \
                                               --backtitle "$BACKTITLE" \
                                               --msgbox "Guvcview is a simple GTK+ interface\nfor capt-geturing and viewing video\nfrom devices supported by the Linux UVC  driver.\nIt fully supports video4linux2\nso it should work with any driver\nthat supports this API,\nincluding the gspca driver." 11 58;clear
                                        dialog --title "Install" \
                                               --backtitle "$BACKTITLE" \
                                               --yesno "Do you want to install Guvcview GTK+ UVC Viewer?" 6 33;
                                        if [ "$?" -eq 0 ]; then ##Okay Guvcview 
                                            clear;
                                            printf "==========================================\n| Install Software                       |\n==========================================\n";
                                            sudo apt-get install guvcview;
                                            printf "\nPress Enter to return to the Program\n";read
                                        elif [ "$?" -eq 1 ]; then ##Cancel Guvcview
                                            clear;
                                        fi
                                        ;;
                                        4)
                                        dialog --clear \
                                               --title "Gxmms2" \
                                               --backtitle "$BACKTITLE" \
                                               --msgbox "Gxmms2  is a GTK2-based XMMS2 client, written in C.\nIts main window is small and simple.\nIt includes a playlist editor with a medialib search and an artist browser\nand a file information dialog." 9 58;clear
                                        dialog --title "Install" \
                                               --backtitle "$BACKTITLE" \
                                               --yesno "Do you want to install Gxmms2?" 6 33;
                                        if [ "$?" -eq 0 ]; then ##Okay Gxmms2
                                            clear;
                                            printf "==========================================\n| Install Software                       |\n==========================================\n";
                                            sudo apt-get install gxmms2;
                                            printf "\nPress Enter to return to the Program\n";read
                                        elif [ "$?" -eq 1 ]; then ##Cancel Gxmms2
                                            clear;
                                        fi
                                        ;;
                                        5)
                                        dialog --clear \
                                               --title "Handbrake" \
                                               --backtitle "$BACKTITLE" \
                                               --msgbox "Handbrake versatile DVD ripper and video transcoder\nhandbrake [OPTION...] - Transcode media formats" 6 58;clear
                                        dialog --title "Install" \
                                               --backtitle "$BACKTITLE" \
                                               --yesno "Do you want to install Handbrake?" 6 33;
                                        if [ "$?" -eq 0 ]; then ##Okay Handbrake
                                            clear;
                                            printf "==========================================\n| Install Software                       |\n==========================================\n";
                                            sudo apt-get install handbrake;
                                            printf "\nPress Enter to return to the Program\n";read
                                        elif [ "$?" -eq 1 ]; then ##Cancel Handbrake
                                            clear;
                                        fi
                                        ;;
                                        6)
                                        dialog --clear \
                                               --title "IsoMaster" \
                                               --backtitle "$BACKTITLE" \
                                               --msgbox "ISO Master is an open-source, easy to use,\ngraphical CD image editor for Linux and BSD.\nBasically you can use this program to extract files\nfrom an ISO, add files to an ISO,\nand create bootable ISOs - all in a graphical\nuser interface.\nISO Master can open ISO, NRG,\nand some MDF files\nbut can only save as ISO." 13 58;clear
                                        dialog --title "Install" \
                                               --backtitle "$BACKTITLE" \
                                               --yesno "Do you want to install IsoMaster?" 6 33;
                                        if [ "$?" -eq 0 ]; then ##Okay IsoMaster
                                            clear;
                                            printf "==========================================\n| Install Software                       |\n==========================================\n";
                                            sudo apt-get install isomaster;
                                            printf "\nPress Enter to return to the Program\n";read
                                        elif [ "$?" -eq 1 ]; then ##Cancel IsoMaster
                                            clear;
                                        fi
                                        ;;
                                        7)
                                        dialog --clear \
                                               --title "K3b" \
                                               --backtitle "$BACKTITLE" \
                                               --msgbox "K3b is a CD burning program that has two aims:\nusability and as many features\nas possible." 7 58;clear
                                        dialog --title "Install" \
                                               --backtitle "$BACKTITLE" \
                                               --yesno "Do you want to install K3b Disc Writing Program?" 6 33;
                                        if [ "$?" -eq 0 ]; then ##Okay K3b
                                            clear;
                                            printf "==========================================\n| Install Software                       |\n==========================================\n";
                                            sudo apt-get install k3b;
                                            printf "\nPress Enter to return to the Program\n";read
                                        elif [ "$?" -eq 1 ]; then ##Cancel K3b
                                            clear;
                                        fi
                                        ;;
                                        8)
                                        dialog --clear \
                                               --title "Kazam" \
                                               --backtitle "$BACKTITLE" \
                                               --msgbox "Kazam provides a well designed and easy to use\ninterface for capt-geturing screencasts\nand  screenshots.\nIt can record desktop video\nand multiple audio streams simultaneously\nwith control over audio levels and\nthe screen region being capt-getured." 11 58;clear
                                        dialog --title "Install" \
                                               --backtitle "$BACKTITLE" \
                                               --yesno "Do you want to install Kazam?" 5 33;
                                        if [ "$?" -eq 0 ]; then ##Okay Kazam
                                            clear;
                                            printf "==========================================\n| Install Software                       |\n==========================================\n";
                                            sudo apt-get install kazam;
                                            printf "\nPress Enter to return to the Program\n";read
                                        elif [ "$?" -eq 1 ]; then ##Cancel Kazam
                                            clear;
                                        fi
                                        ;;
                                        9)
                                        dialog --clear \
                                               --title "Kdenlive" \
                                               --backtitle "$BACKTITLE" \
                                               --msgbox "Kdenlive is an open source non-linear\nvideo editor which supports a large number of formats\nfor editing, including DV,\nAVCHD 'experimental support'\nand HDV.\nKdenlive relies on  several other open source projects,\nsuch as FFmpeg and MLT video framework." 12 58;clear
                                        dialog --title "Install" \
                                               --backtitle "$BACKTITLE" \
                                               --yesno "Do you want to install Kdenlive?" 6 33;
                                        if [ "$?" -eq 0 ]; then ##Okay Kdenlive
                                            clear;
                                            printf "==========================================\n| Install Software                       |\n==========================================\n";
                                            sudo apt-get install kdenlive;
                                            printf "\nPress Enter to return to the Program\n";read
                                        elif [ "$?" -eq 1 ]; then ##Cancel Kdenlive
                                            clear;
                                        fi
                                        ;;
                                        10)
                                        while [[ 1 ]]
                                        do
                                        HEIGHT=17
                                        WIDTH=50
                                        CHOICE_HEIGHT=10
                                        BACKTITLE="PMP v.0.0.25 / Software Center / Multimedia"
                                        TITLE="Multimedia"
                                        MENU="Select one:"
                                        OPTIONS=(1 "Kodi - Media Player"
                                                 2 "LMMS - Music Production"
                                                 3 "Mplayer - Media Player"
                                                 4 "OpenShot - Video Editor"
                                                 5 "Pitivi - Video Editor"
                                                 6 "PavuControl - Adjust Volume"
                                                 7 "RecordMyDesktop - Screencast"
                                                 8 "Rythmbox - Music Player"
                                                 9 "SMPlayer - Media Player"
                                                 10 "Next Page ->")
                                        CHOICE=$(dialog --clear \
                                                        --backtitle "$BACKTITLE" \
                                                        --title "$TITLE" \
                                                        --menu "$MENU" \
                                        $HEIGHT $WIDTH $CHOICE_HEIGHT \
                                        "${OPTIONS[@]}" \
                                        2>&1 >/dev/tty)
                                        if [ "$?" -eq 0 ]; then ##Okay in Multimedia Page 3
                                            case $CHOICE in
                                                1)
                                                dialog --clear \
                                                       --title "Kodi" \
                                                       --backtitle "$BACKTITLE" \
                                                       --msgbox "Kodi is a free media player\nthat is designed to look great on your big screen TV\nbut is just as home on a small screen." 7 58;clear
                                                dialog --title "Install" \
                                                       --backtitle "$BACKTITLE" \
                                                       --yesno "Do you want to install Kodi Media Player?" 6 33;
                                                if [ "$?" -eq 0 ]; then ##Okay Kodi
                                                    clear;
                                                    printf "==========================================\n| Install Software                       |\n==========================================\n";
                                                    sudo apt-get install kodi;
                                                    printf "\nPress Enter to return to the Program\n";read
                                                elif [ "$?" -eq 1 ]; then ##Cancel Kodi
                                                    clear;
                                                fi
                                                ;;
                                                2)
                                                dialog --clear \
                                                       --title "LMMS" \
                                                       --backtitle "$BACKTITLE" \
                                                       --msgbox "LMMS is a free cross-platform alternative\nto commercial programs like FL Studio®,\nwhich allow you to produce music with your computer.\nThis includes the creation of melodies and beats,\nthe synthesis and mixing of sounds,\nand arranging of samples.\nYou can have fun with  your MIDI-keyboard\nand much more\nall in a user-friendly and modern interface.\nLMMS features components such as a Song Editor,\na Beat+Bassline Editor, a Piano Roll, an FX Mixer\nas well as many powerful instruments\nand effects." 17 58;clear
                                                dialog --title "Install" \
                                                       --backtitle "$BACKTITLE" \
                                                       --yesno "Do you want to install LMMS Music Production?" 6 33;
                                                if [ "$?" -eq 0 ]; then ##Okay LMMS
                                                    clear;
                                                    printf "==========================================\n| Install Software                       |\n==========================================\n";
                                                    sudo apt-get install lmms;
                                                    printf "\nPress Enter to return to the Program\n";read
                                                elif [ "$?" -eq 1 ]; then ##Cancel LMMS
                                                    clear;
                                                fi
                                                ;;
                                                3)
                                                dialog --clear \
                                                       --title "Mplayer" \
                                                       --backtitle "$BACKTITLE" \
                                                       --msgbox "mplayer is a movie player for Linux\n'runs on many other platforms and CPU architectures'\nIt plays most MPEG/VOB,AVI,\nASF/WMA/WMV, RM, QT/MOV/MP4, Ogg/OGM,\nMKV, VIVO, FLI, NuppelVideo,\nyuv4mpeg, FILM\nand RoQ files,\nsupported by many native and binary codecs.\nYou can watch VCD, SVCD,\nDVD, Blu-ray, 3ivx,\nDivX 3/4/5,WMV\nand even H.264 movies, too." 16 58;clear
                                                dialog --title "Install" \
                                                       --backtitle "$BACKTITLE" \
                                                       --yesno "Do you want to install Mplayer Media Player?" 6 33;
                                                if [ "$?" -eq 0 ]; then ##Okay Mplayer
                                                    clear;
                                                    printf "==========================================\n| Install Software                       |\n==========================================\n";
                                                    sudo apt-get install mplayer;
                                                    printf "\nPress Enter to return to the Program\n";read
                                                elif [ "$?" -eq 1 ]; then ##Cancel Mplayer
                                                    clear;
                                                fi
                                                ;;
                                                4)
                                                dialog --clear \
                                                       --title "OpenShot" \
                                                       --backtitle "$BACKTITLE" \
                                                       --msgbox "OpenShot can create stunning videos,\nfilms, and animations\nwith an easy-to-use interface\nand rich set of features." 8 58;clear
                                                dialog --title "Install" \
                                                       --backtitle "$BACKTITLE" \
                                                       --yesno "Do you want to install OpenShot Video Editor?" 6 33;
                                                if [ "$?" -eq 0 ]; then ##Okay OpenShot
                                                    clear;
                                                    printf "==========================================\n| Install Software                       |\n==========================================\n";
                                                    sudo apt-get install openshot;
                                                    printf "\nPress Enter to return to the Program\n";read
                                                elif [ "$?" -eq 1 ]; then ##Cancel OpenShot
                                                    clear;
                                                fi
                                                ;;
                                                5)
                                                dialog --clear \
                                                       --title "Pitivi" \
                                                       --backtitle "$BACKTITLE" \
                                                       --msgbox "pitivi is a free, intuitive and featureful\nmovie editor for the Linux desktop." 6 58;clear
                                                dialog --title "Install" \
                                                       --backtitle "$BACKTITLE" \
                                                       --yesno "Do you want to install Pitivi Video Editor?" 6 33;
                                                if [ "$?" -eq 0 ]; then ##Okay Pitivi
                                                    clear;
                                                    printf "==========================================\n| Install Software                       |\n==========================================\n";
                                                    sudo apt-get install pitivi;
                                                    printf "\nPress Enter to return to the Program\n";read
                                                elif [ "$?" -eq 1 ]; then ##Cancel Pitivi
                                                    clear;
                                                fi
                                                ;;
                                                6)
                                                dialog --clear \
                                                       --title "PavuControl" \
                                                       --backtitle "$BACKTITLE" \
                                                       --msgbox "A simple volume control tool 'mixer'\nfor the PulseAudio sound server.\nIn contrast to classic mixer tools\nthis one allows you to control both\nthe volume of hardware devices\nand of each playback stream separately.\nIt also allows you to redirect a playback stream\nto another output device\nwithout interrupting playback." 13 58;clear
                                                dialog --title "Install" \
                                                       --backtitle "$BACKTITLE" \
                                                       --yesno "Do you want to install PavuControl?" 6 33;
                                                if [ "$?" -eq 0 ]; then ##Okay PavuControl
                                                    clear;
                                                    printf "==========================================\n| Install Software                       |\n==========================================\n";
                                                    sudo apt-get install pavucontrol;
                                                    printf "\nPress Enter to return to the Program\n";read
                                                elif [ "$?" -eq 1 ]; then ##Cancel PavuControl
                                                    clear;
                                                fi
                                                ;;
                                                7)
                                                dialog --clear \
                                                       --title "RecordMyDesktop" \
                                                       --backtitle "$BACKTITLE" \
                                                       --msgbox "recordMyDesktop is a free and open source\ndesktop screencasting software application \nwritten for Linux." 7 58;clear
                                                dialog --title "Install" \
                                                       --backtitle "$BACKTITLE" \
                                                       --yesno "Do you want to install RecordMyDesktop?" 6 33;
                                                if [ "$?" -eq 0 ]; then ##Okay RecordMyDesktop
                                                    clear;
                                                    printf "==========================================\n| Install Software                       |\n==========================================\n";
                                                    sudo apt-get install recordmydesktop gtk-recordmydesktop;
                                                    printf "\nPress Enter to return to the Program\n";read
                                                elif [ "$?" -eq 1 ]; then ##Cancel RecordMyDesktop
                                                    clear;
                                                fi
                                                ;;
                                                8)
                                                dialog --clear \
                                                       --title "Rythmbox" \
                                                       --backtitle "$BACKTITLE" \
                                                       --msgbox "Rhythmbox is a very easy to use music playing\nand management program\nwhich supports a wide range of audio formats\n'including mp3 and ogg'.\nOriginally inspired by Apple's iTunes,\nthe current version also supports Internet Radio\nand Last.fm integration,\niPod syncing and generic portable audio player support.\nAudio CD playback, ripping and encoding,\nmusic sharing, and Podcasts." 15 58;clear
                                                dialog --title "Install" \
                                                       --backtitle "$BACKTITLE" \
                                                       --yesno "Do you want to install Rythmbox Music Player?" 6 33;
                                                if [ "$?" -eq 0 ]; then ##Okay Rythmbox
                                                    clear;
                                                    printf "==========================================\n| Install Software                       |\n==========================================\n";
                                                    sudo apt-get install rythmbox;
                                                    printf "\nPress Enter to return to the Program\n";read
                                                elif [ "$?" -eq 1 ]; then ##Cancel Rythmbox
                                                    clear;
                                                fi
                                                ;;
                                                9)
                                                dialog --clear \
                                                       --title "SMPlayer" \
                                                       --backtitle "$BACKTITLE" \
                                                       --msgbox "SMPlayer is a GUI media player based on Qt 4,\nusing mplayer as its backend." 6 58;clear
                                                dialog --title "Install" \
                                                       --backtitle "$BACKTITLE" \
                                                       --yesno "Do you want to install SMPlayer Media Player?" 6 33;
                                                if [ "$?" -eq 0 ]; then ##Okay SMPlayer
                                                    clear;
                                                    printf "==========================================\n| Install Software                       |\n==========================================\n";
                                                    sudo apt-get install smplayer;
                                                    printf "\nPress Enter to return to the Program\n";read
                                                elif [ "$?" -eq 1 ]; then ##Cancel SMPlayer
                                                    clear;
                                                fi
                                                ;;
                                                10)
                                                while [[ 1 ]]
                                                do
                                                HEIGHT=17
                                                WIDTH=50
                                                CHOICE_HEIGHT=6
                                                BACKTITLE="PMP v.0.0.25 / Software Center / Multimedia"
                                                TITLE="Multimedia"
                                                MENU="Select one:"
                                                OPTIONS=(1 "Subtitleeditor - GTK Subtitle Editor"
                                                         2 "Tomahawk - Multi Source Music Player"
                                                         3 "VLC - Media Player"
                                                         4 "Xine - Video Player"
                                                         5 "Yoshimi - Real Time Synthesizer"
                                                         6 "Back to Main Menu")
                                                CHOICE=$(dialog --clear \
                                                                --backtitle "$BACKTITLE" \
                                                                --title "$TITLE" \
                                                                --menu "$MENU" \
                                                $HEIGHT $WIDTH $CHOICE_HEIGHT \
                                                "${OPTIONS[@]}" \
                                                2>&1 >/dev/tty)
                                                if [ "$?" -eq 0 ]; then ##Okay in Multimedia Page 4
                                                    case $CHOICE in
                                                        1)
                                                        dialog --clear \
                                                               --title "SubtitleEditor" \
                                                               --backtitle "$BACKTITLE" \
                                                               --msgbox "subtitleeditor is a GTK+2 tool to edit subtitles.\nIt can be used to create new subtitles\nor as a tool to transform, edit, correct\nand refine existing subtitles." 8 58;clear
                                                        dialog --title "Install" \
                                                               --backtitle "$BACKTITLE" \
                                                               --yesno "Do you want to install SubtitleEditor?" 6 33;
                                                        if [ "$?" -eq 0 ]; then ##Okay SubtitleEditor
                                                            clear;
                                                            printf "==========================================\n| Install Software                       |\n==========================================\n";
                                                            sudo apt-get install subtitleeditor;
                                                            printf "\nPress Enter to return to the Program\n";read
                                                        elif [ "$?" -eq 1 ]; then ##Cancel SubtitleEditor
                                                            clear;
                                                        fi
                                                        ;;
                                                        2)
                                                        dialog --clear \
                                                               --title "Tomahawk" \
                                                               --backtitle "$BACKTITLE" \
                                                               --msgbox "Tomahawk is a free multi-source and cross-platform music player.\nAn application that can play not only your local files,\nbut also stream from services\nlike Spotify, Beats, SoundCloud, Google Music,\nYouTube and many others.\nYou can even connect with your friends'\nTomahawks, share your musical gems or listen\nalong with them.\nLet the music play!" 15 58;clear
                                                        dialog --title "Install" \
                                                               --backtitle "$BACKTITLE" \
                                                               --yesno "Do you want to install Tomahawk?" 6 33;
                                                        if [ "$?" -eq 0 ]; then ##Okay Tomahawk
                                                            clear;
                                                            printf "==========================================\n| Install Software                       |\n==========================================\n";
                                                            sudo apt-get install tomahawk;
                                                            printf "\nPress Enter to return to the Program\n";read
                                                        elif [ "$?" -eq 1 ]; then ##Cancel Tomahawk
                                                            clear;
                                                        fi
                                                        ;;
                                                        3)
                                                        dialog --clear \
                                                               --title "VLC" \
                                                               --backtitle "$BACKTITLE" \
                                                               --msgbox "VLC is a free and open source cross-platform multimedia player\nand framework that plays most multimedia files\nas well as DVDs, Audio CDs, VCDs,\nand various streaming protocols." 9 58;clear
                                                        dialog --title "Install" \
                                                               --backtitle "$BACKTITLE" \
                                                               --yesno "Do you want to install VLC Media Player?" 6 33;
                                                        if [ "$?" -eq 0 ]; then ##Okay VLC
                                                            clear;
                                                            printf "==========================================\n| Install Software                       |\n==========================================\n";
                                                            sudo apt-get install vlc;
                                                            printf "\nPress Enter to return to the Program\n";read
                                                        elif [ "$?" -eq 1 ]; then ##Cancel VLC
                                                            clear;
                                                        fi
                                                        ;;
                                                        4)
                                                        dialog --clear \
                                                               --title "Xine" \
                                                               --backtitle "$BACKTITLE" \
                                                               --msgbox "xine plays MPEG system 'audio  and  video' streams,\nmpeg elementary streams e.g. .mp3 or .mpv files,\nmpeg transport streams, ogg files, avi files,\nasf files, quicktime files,\n'S'VCDs and DVDs and many more." 9 58;clear
                                                        dialog --title "Install" \
                                                               --backtitle "$BACKTITLE" \
                                                               --yesno "Do you want to install Xine Video Player?" 6 33;
                                                        if [ "$?" -eq 0 ]; then ##Okay Xine
                                                            clear;
                                                            printf "==========================================\n| Install Software                       |\n==========================================\n";
                                                            sudo apt-get install xine;
                                                            printf "\nPress Enter to return to the Program\n";read
                                                        elif [ "$?" -eq 1 ]; then ##Cancel Xine
                                                            clear;
                                                        fi
                                                        ;;
                                                        5)
                                                        dialog --clear \
                                                               --title "Yoshimi" \
                                                               --backtitle "$BACKTITLE" \
                                                               --msgbox "Yoshimi is a polyphonic multi-part sound synthesiser\nutilising three distinct 'engines'\nthat can be used separately or together.\nThese can also be stacked into 'kits',\ntypically for percussion.\nIt fully supports both JACK and ALSA\nfor MIDI input and audio output.\nYoshimi can be run in a graphical interface,\na command line interface,\nor with control from both.\nA number of controls can also be accessed\nvia MIDI.\nThe CLI has its own Readline parser\nand built-in help system\naccessed by entering the commands\n'?' or 'help'." 20 58;clear
                                                        dialog --title "Install" \
                                                               --backtitle "$BACKTITLE" \
                                                               --yesno "Do you want to install Yoshimi?" 6 33;
                                                        if [ "$?" -eq 0 ]; then ##Okay Yoshimi
                                                            clear;
                                                            printf "==========================================\n| Install Software                       |\n==========================================\n";
                                                            sudo apt-get install yoshimi;
                                                            printf "\nPress Enter to return to the Program\n";read
                                                        elif [ "$?" -eq 1 ]; then ##Cancel Yoshimi
                                                            clear;
                                                        fi
                                                        ;;
                                                        6)
                                                            break 4;
                                                        ;;
                                                    esac
                                                elif [ "$?" -eq 1 ]; then ##Cancel Multimedia Page 4
                                                    break;
                                                fi
                                                done
                                                ;;
                                            esac
                                        elif [ "$?" -eq 1 ]; then ##Cancel Multimedia Page 3
                                            break;
                                        fi
                                        done
                                        ;;
                                    esac
                                elif [ "$?" -eq 1 ]; then ##Cancel in Multimedia Page 2
                                    break;
                                fi
                            done
                            ;;
                        esac
                    elif [ "$?" -eq 1 ]; then ##Cancel Multimedia Page 1
                        break;
                    fi
                done
            ;;
            7)
                while [[ 1 ]]
                do
                HEIGHT=17
                WIDTH=50
                CHOICE_HEIGHT=6
                BACKTITLE="PMP v.0.0.25 / Software Center / Graphics"
                TITLE="Graphics"
                MENU="Select one:"
                OPTIONS=(1 "3D"
                         2 "Drawing"
                         3 "Painting & Editing"
                         4 "Photography"
                         5 "Scanning"
                         6 "Viewers")
                CHOICE=$(dialog --clear \
			        --backtitle "$BACKTITLE" \
			        --title "$TITLE" \
			        --menu "$MENU" \
			      $HEIGHT $WIDTH $CHOICE_HEIGHT \
			      "${OPTIONS[@]}" \
			      2>&1 >/dev/tty)
                    if [ "$?" -eq 0 ]; then ##Okay in Graphics
                        case $CHOICE in
                            1)
                            while [[ 1 ]]
                            do
                            HEIGHT=17
                            WIDTH=50
                            CHOICE_HEIGHT=2
                            BACKTITLE="PMP v.0.0.25 / Software Center / Graphics / 3D"
                            TITLE="3D"
                            MENU="Select one:"
                            OPTIONS=(1 "Aqsis - 3D Rendering Solution"
                                     2 "Blender - 3D Modelling & Animation")
                            CHOICE=$(dialog --clear \
                                            --backtitle "$BACKTITLE" \
                                            --title "$TITLE" \
                                            --menu "$MENU" \
                            $HEIGHT $WIDTH $CHOICE_HEIGHT \
                            "${OPTIONS[@]}" \
                            2>&1 >/dev/tty)
                            if [ "$?" -eq 0 ]; then ##Okay in 3D
                                case $CHOICE in
                                    1)
                                    dialog --clear \
                                           --title "Aqsis" \
                                           --backtitle "$BACKTITLE" \
                                           --msgbox "aqsis - renderer from Aqsis Renderer,\na 3D rendering solution\nadhering to the RenderMan® standard" 7 58;clear
                                    dialog --title "Install" \
                                           --backtitle "$BACKTITLE" \
                                           --yesno "Do you want to install Aqsis?" 5 33;
                                    if [ "$?" -eq 0 ]; then ##Okay Aqsis
                                        clear;
                                        printf "==========================================\n| Install Software                       |\n==========================================\n";
                                        sudo apt-get install aqsis;
                                        printf "\nPress Enter to return to the Program\n";read
                                    elif [ "$?" -eq 1 ]; then ##Cancel Aqsis
                                        clear;
                                    fi
                                    ;;
                                    2)
                                    dialog --clear \
                                           --title "Blender" \
                                           --backtitle "$BACKTITLE" \
                                           --msgbox "Blender is a 3D modelling and rendering package.\nIt is the in-house software of a high quality\nanimation studio,\nBlender has proven to be an extremely fast\nand versatile design instrument.\nThe software has a personal touch,\noffering a unique approach\nto the world of Three Dimensions.\nUse Blender to create TV commercials,\nto make technical visualizations,\nbusiness graphics, to do some morphing,\nor design user interfaces.\nYou can easy build and manage complex environments.\nThe renderer is versatile\nand extremely fast.\nAll basic animation principles\n'curves & keys' are well implemented." 21 58;clear
                                    dialog --title "Install" \
                                           --backtitle "$BACKTITLE" \
                                           --yesno "Do you want to install Blender?" 6 33;
                                    if [ "$?" -eq 0 ]; then ##Okay Blender
                                     clear;
                                     printf "==========================================\n| Install Software                       |\n==========================================\n";
                                     sudo apt-get install blender;
                                     printf "\nPress Enter to return to the Program\n";read
                                    elif [ "$?" -eq 1 ]; then ##Cancel Blender
                                                            clear;
                                    fi
                                    ;;
                                esac
                            elif [ "$?" -eq 1 ]; then ##Cancel in 3D
                                break;
                            fi
                            done
                            ;;
                            2)
                            while [[ 1 ]]
                            do
                            HEIGHT=17
                            WIDTH=50
                            CHOICE_HEIGHT=1
                            BACKTITLE="PMP v.0.0.25 / Software Center / Graphics / Drawing"
                            TITLE="Games"
                            MENU="Select one:"
                            OPTIONS=(1 "Libre Office Draw")
                            CHOICE=$(dialog --clear \
                                            --backtitle "$BACKTITLE" \
                                            --title "$TITLE" \
                                            --menu "$MENU" \
                            $HEIGHT $WIDTH $CHOICE_HEIGHT \
                            "${OPTIONS[@]}" \
                            2>&1 >/dev/tty)
                            if [ "$?" -eq 0 ]; then ##Okay in Drawing
                                case $CHOICE in
                                    1)
                                    dialog --clear \
                                           --title "Libre Office Draw" \
                                           --backtitle "$BACKTITLE" \
                                           --msgbox "Draw lets you produce anything\nfrom a quick sketch to a complex plan,\nand gives you the means\nto communicate with graphics and diagrams.\nWith a maximum page size of 300cm by 300cm,\nDraw is a an excellent package for producing\ntechnical drawings, brochures, posters\nand many other documents.\nDraw lets you manipulate\ngraphical objects, group them, crop them,\nuse objects in 3D and much more." 15 58;clear
                                    dialog --title "Install" \
                                           --backtitle "$BACKTITLE" \
                                           --yesno "Do you want to install Libre Office Draw?" 6 33;
                                    if [ "$?" -eq 0 ]; then ##Okay Libre Office Draw
                                        printf "==========================================\n| Install Software                       |\n==========================================\n";
                                        clear;
                                        sudo apt-get install libreoffice-draw;
                                        printf "\nPress Enter to return to the Program\n";read
                                    elif [ "$?" -eq 1 ]; then ##Cancel Libre Office Draw
                                        clear;
                                    fi
                                    ;;
                                esac
                            elif [ "$?" -eq 1 ]; then ##Cancel in Drawing
                                break;
                            fi
                            done
                            ;;
                            3)
                            while [[ 1 ]]
                            do
                            HEIGHT=17
                            WIDTH=50
                            CHOICE_HEIGHT=2
                            BACKTITLE="PMP v.0.0.25 / Software Center / Graphics / Painting & Editing"
                            TITLE="Panting & Editing"
                            MENU="Select one:"
                            OPTIONS=(1 "Gimp - Image Editor"
                                     2 "KolourPaint - Paint Program")
                            CHOICE=$(dialog --clear \
                                            --backtitle "$BACKTITLE" \
                                            --title "$TITLE" \
                                            --menu "$MENU" \
                            $HEIGHT $WIDTH $CHOICE_HEIGHT \
                            "${OPTIONS[@]}" \
                            2>&1 >/dev/tty)
                            if [ "$?" -eq 0 ]; then ##Okay in Painting & Editing
                                case $CHOICE in
                                    1)
                                    dialog --clear \
                                           --title "Gimp" \
                                           --backtitle "$BACKTITLE" \
                                           --msgbox "GIMP is the GNU Image Manipulation Program.\nIt is used to edit and manipulate images.\nIt can load and save a variety of image formats\nand can be used to convert between formats.\nGIMP can also be used as a paint program.\nIt features a set of drawing and painting tools\nsuch as airbrush, clone, pencil,\nand paint brush." 12 58;clear
                                    dialog --title "Install" \
                                           --backtitle "$BACKTITLE" \
                                           --yesno "Do you want to install Gimp Image Editor?" 6 33;
                                    if [ "$?" -eq 0 ]; then ##Okay Gimp
                                        clear;
                                        printf "==========================================\n| Install Software                       |\n==========================================\n";
                                        sudo apt-get install gimp;
                                        printf "\nPress Enter to return to the Program\n";read
                                    elif [ "$?" -eq 1 ]; then ##Cancel Gimp
                                        clear;
                                    fi
                                    ;;
                                    2)
                                    dialog --clear \
                                           --title "KolourPaint" \
                                           --backtitle "$BACKTITLE" \
                                           --msgbox "KolourPaint is a simple painting program\nto quickly create raster images.\nIt is useful as a touch-up tool \nand simple image editing tasks." 8 58;clear
                                    dialog --title "Install" \
                                           --backtitle "$BACKTITLE" \
                                           --yesno "Do you want to install KolourPaint?" 6 33;
                                    if [ "$?" -eq 0 ]; then ##Okay KolourPaint
                                        clear;
                                        printf "==========================================\n| Install Software                       |\n==========================================\n";
                                        sudo apt-get install kolourpaint4;
                                        printf "\nPress Enter to return to the Program\n";read
                                    elif [ "$?" -eq 1 ]; then ##Cancel KolourPaint
                                        clear;
                                    fi
                                    ;;
                                esac
                            elif [ "$?" -eq 1 ]; then ##Cancel in Painting & Editing
                                break;
                            fi
                            done
                            ;;
                            4)
                            while [[ 1 ]]
                            do
                            HEIGHT=17
                            WIDTH=50
                            CHOICE_HEIGHT=2
                            BACKTITLE="PMP v.0.0.25 / Software Center / Graphics / Photography"
                            TITLE="Photography"
                            MENU="Select one:"
                            OPTIONS=(1 "Gwenview - Image Viewer"
                                     2 "Shotwell - Photo Manager")
                            CHOICE=$(dialog --clear \
                                            --backtitle "$BACKTITLE" \
                                            --title "$TITLE" \
                                            --menu "$MENU" \
                            $HEIGHT $WIDTH $CHOICE_HEIGHT \
                            "${OPTIONS[@]}" \
                            2>&1 >/dev/tty)
                            if [ "$?" -eq 0 ]; then ##Okay in Photography
                                case $CHOICE in
                                    1)
                                    dialog --clear \
                                           --title "Gwenview" \
                                           --backtitle "$BACKTITLE" \
                                           --msgbox "Gwenview is an image viewer for KDE.\nIt features a folder tree window\nand a file list window\nto provide easy navigation of your file hierarchy.\nGwenview uses docked windows,\nso you can alter its layout any way you wish.\nYou can also browse your images in full-screen mode,\nor embedded within Konqueror\nusing the Gwenview Image Browser View and Kpart." 13 58;clear
                                    dialog --title "Install" \
                                           --backtitle "$BACKTITLE" \
                                           --yesno "Do you want to install Gwenview Image Viewer?" 6 33;
                                    if [ "$?" -eq 0 ]; then ##Okay Gwenview
                                        clear;
                                        printf "==========================================\n| Install Software                       |\n==========================================\n";
                                        sudo apt-get install gwenview;
                                        printf "\nPress Enter to return to the Program\n";read
                                    elif [ "$?" -eq 1 ]; then ##Cancel Gwenview
                                        clear;
                                    fi
                                    ;;
                                    2)
                                    dialog --clear \
                                           --title "Shotwell" \
                                           --backtitle "$BACKTITLE" \
                                           --msgbox "Shotwell is a digital photo organizer\ndesigned for the GNOME desktop environment.\nIt allows you to import  photos\nfrom disk or camera,\norganize them in various ways,\nview them in full-window\nor fullscreen mode,\nand export them to share with others." 12 58;clear
                                    dialog --title "Install" \
                                           --backtitle "$BACKTITLE" \
                                           --yesno "Do you want to install Shotwell Photo Manager?" 6 33;
                                    if [ "$?" -eq 0 ]; then ##Okay Shotwell
                                        clear;
                                        printf "==========================================\n| Install Software                       |\n==========================================\n";
                                        sudo apt-get install shotwell;
                                        printf "\nPress Enter to return to the Program\n";read
                                    elif [ "$?" -eq 1 ]; then ##Cancel Shotwell
                                        clear;
                                    fi
                                    ;;
                                esac
                            elif [ "$?" -eq 1 ]; then ##Cancel in Photography
                                break;
                            fi
                            done
                            ;;
                            5)
                            while [[ 1 ]]
                            do
                            HEIGHT=17
                            WIDTH=50
                            CHOICE_HEIGHT=1
                            BACKTITLE="PMP v.0.0.25 / Software Center / Graphics / Scanning"
                            TITLE="Scanning"
                            MENU="Select one:"
                            OPTIONS=(1 "SimpleScan - Scan Utility")
                            CHOICE=$(dialog --clear \
                                            --backtitle "$BACKTITLE" \
                                            --title "$TITLE" \
                                            --menu "$MENU" \
                            $HEIGHT $WIDTH $CHOICE_HEIGHT \
                            "${OPTIONS[@]}" \
                            2>&1 >/dev/tty)
                            if [ "$?" -eq 0 ]; then ##Okay in Scanning
                                case $CHOICE in
                                    1)
                                    dialog --clear \
                                           --title "SimpleScan" \
                                           --backtitle "$BACKTITLE" \
                                           --msgbox "Simple Scan is an easy-to-use application,\ndesigned to let users connect their scanner\nand quickly have the  image/document\nin an appropriate format." 8 58;clear
                                    dialog --title "Install" \
                                           --backtitle "$BACKTITLE" \
                                           --yesno "Do you want to install SimpleScan Utility?" 6 33;
                                    if [ "$?" -eq 0 ]; then ##Okay SimpleScan
                                        clear;
                                        printf "==========================================\n| Install Software                       |\n==========================================\n";
                                        sudo apt-get install simple-scan;
                                        printf "\nPress Enter to return to the Program\n";read
                                    elif [ "$?" -eq 1 ]; then ##Cancel SimpleScan
                                        clear;
                                    fi
                                    ;;
                                esac
                            elif [ "$?" -eq 1 ]; then ##Cancel in Scanning
                                break;
                            fi
                            done
                            ;;
                            6)
                            while [[ 1 ]]
                            do
                            HEIGHT=17
                            WIDTH=50
                            CHOICE_HEIGHT=3
                            BACKTITLE="PMP v.0.0.25 / Software Center / Graphics / Viewers"
                            TITLE="Viewers"
                            MENU="Select one:"
                            OPTIONS=(1 "Aeskulap - Medical Image Viewer"
                                     2 "Gthumb - Image Viewer"
                                     3 "Gwenview - Image Viewer")
                            CHOICE=$(dialog --clear \
                                            --backtitle "$BACKTITLE" \
                                            --title "$TITLE" \
                                            --menu "$MENU" \
                            $HEIGHT $WIDTH $CHOICE_HEIGHT \
                            "${OPTIONS[@]}" \
                            2>&1 >/dev/tty)
                            if [ "$?" -eq 0 ]; then ##Okay in Viewers
                                case $CHOICE in
                                    1)
                                    dialog --clear \
                                           --title "Aeskulap" \
                                           --backtitle "$BACKTITLE" \
                                           --msgbox "aeskulap is able to load a series of special images\nstored in the DICOM format for review.\nAdditionally it is able to query and fetch\nDICOM images from archive nodes\n'also called PACS' over the network.\nAeskulap tries to  achieve a full open source replacement for commercially available DICOM viewers." 11 58;clear
                                    dialog --title "Install" \
                                           --backtitle "$BACKTITLE" \
                                           --yesno "Do you want to install Aeskulap?" 6 33;
                                    if [ "$?" -eq 0 ]; then ##Okay Aeskulap
                                        clear;
                                        printf "==========================================\n| Install Software                       |\n==========================================\n";
                                        sudo apt-get install aeskulap;
                                        printf "\nPress Enter to return to the Program\n";read
                                    elif [ "$?" -eq 1 ]; then ##Cancel Aeskulap
                                        clear;
                                    fi
                                    ;;
                                    2)
                                    dialog --clear \
                                           --title "Gthumb" \
                                           --backtitle "$BACKTITLE" \
                                           --msgbox "With gThumb you can browse your\nhard disk viewing thumbnails of image files.\nIt also lets you view single files\n'including GIF animations',\nadd comments to images, organize images in catalogs,\nprint images, view slideshows,\nset your desktop background,\nand more." 12 58;clear
                                    dialog --title "Install" \
                                           --backtitle "$BACKTITLE" \
                                           --yesno "Do you want to install Gthumb Image Viewer?" 6 33;
                                    if [ "$?" -eq 0 ]; then ##Okay Gthumb
                                        clear;
                                        printf "==========================================\n| Install Software                       |\n==========================================\n";
                                        sudo apt-get install gthumb;
                                        printf "\nPress Enter to return to the Program\n";read
                                    elif [ "$?" -eq 1 ]; then ##Cancel Gthumb
                                        clear;
                                    fi
                                    ;;
                                    3)
                                    dialog --clear \
                                           --title "Gwenview" \
                                           --backtitle "$BACKTITLE" \
                                           --msgbox "Gwenview is an image viewer for KDE.\nIt features a folder tree window\nand a file list window\nto provide easy navigation of your file hierarchy.\nGwenview uses docked windows,\nso you can alter its layout any way you wish.\nYou can also browse your images in full-screen mode,\nor embedded within Konqueror\nusing the Gwenview Image Browser View and Kpart." 13 58;clear
                                    dialog --title "Install" \
                                           --backtitle "$BACKTITLE" \
                                           --yesno "Do you want to install Gwenview Image Viewer?" 6 33;
                                    if [ "$?" -eq 0 ]; then ##Okay Gwenview
                                        clear;
                                        printf "==========================================\n| Install Software                       |\n==========================================\n";
                                        sudo apt-get install gwenview;
                                        printf "\nPress Enter to return to the Program\n";read
                                    elif [ "$?" -eq 1 ]; then ##Cancel Gwenview
                                        clear;
                                    fi
                                    ;;
                                esac
                            elif [ "$?" -eq 1 ]; then ##Cancel in Viewers
                                break;
                            fi
                            done
                            ;;
                        esac
                    elif [ "$?" -eq 1 ]; then ##Cancel in Graphics
                        break;
                    fi
                done
            ;;
            8)
                while [[ 1 ]]
                do
                HEIGHT=17
                WIDTH=50
                CHOICE_HEIGHT=7
                BACKTITLE="PMP v.0.0.25 / Software Center / Games"
                TITLE="Games"
                MENU="Select one:"
                OPTIONS=(1 "Arcarde"
                         2 "Board Games"
                         3 "Card Games"
                         4 "Puzzles"
                         5 "Role Playing"
                         6 "Simulation"
                         7 "Sports")
                CHOICE=$(dialog --clear \
			        --backtitle "$BACKTITLE" \
			        --title "$TITLE" \
			        --menu "$MENU" \
			      $HEIGHT $WIDTH $CHOICE_HEIGHT \
			      "${OPTIONS[@]}" \
			      2>&1 >/dev/tty)
                    if [ "$?" -eq 0 ]; then ##Okay in Games
                        case $CHOICE in
                            1)
                            while [[ 1 ]]
                            do
                            HEIGHT=17
                            WIDTH=50
                            CHOICE_HEIGHT=9
                            BACKTITLE="PMP v.0.0.25 / Software Center / Games / Arcarde"
                            TITLE="Arcarde"
                            MENU="Select one:"
                            OPTIONS=(1 "Bloboats - Arcarde Boat Racing Game"
                                     2 "Extremetuxracer - 3D Racing Game"
                                     3 "FretsonFire - Rock Your Keyboard"
                                     4 "Frozenbubble - Pop Out Bubbles"
                                     5 "Funguloids - Collect Mushrooms"
                                     6 "Neverball - 3D Floor Tilting Game"
                                     7 "Neverputt - 3D Mini Golf Game"
                                     8 "SuperTux - 2D Platform Game"
                                     9 "Supertuxkart - 3D Kart Racing")
                            CHOICE=$(dialog --clear \
                                            --backtitle "$BACKTITLE" \
                                            --title "$TITLE" \
                                            --menu "$MENU" \
                            $HEIGHT $WIDTH $CHOICE_HEIGHT \
                            "${OPTIONS[@]}" \
                            2>&1 >/dev/tty)
                            if [ "$?" -eq 0 ]; then ##Okay in Arcade
                                case $CHOICE in
                                    1)
                                    dialog --clear \
                                           --title "Bloboats" \
                                           --backtitle "$BACKTITLE" \
                                           --msgbox "Bloboats is a boat game in the spirit of Elasto Mania or X-Moto,\nintroducing a handful of elements\nfrom Super Mario Bros -like games." 8 58;clear
                                    dialog --title "Install" \
                                           --backtitle "$BACKTITLE" \
                                           --yesno "Do you want to install Bloboats?" 6 33;
                                    if [ "$?" -eq 0 ]; then ##Okay Bloboats
                                        clear;
                                        printf "==========================================\n| Install Software                       |\n==========================================\n";
                                        sudo apt-get install bloboats;
                                        printf "\nPress Enter to return to the Program\n";read
                                    elif [ "$?" -eq 1 ]; then ##Cancel Bloboats
                                        clear;
                                    fi
                                    ;;
                                    2)
                                    dialog --clear \
                                           --title "Extremetuxracer" \
                                           --backtitle "$BACKTITLE" \
                                           --msgbox "Extreme Tux Racer is a simple OpenGL racing game\nfeaturing Tux, the Linux mascot.\nThe goal of the game is to\nslide down a snow-and ice-covered mountain\nas quickly as possible while collecting fishes \nand avoiding the trees and rocks\nthat will slow you down." 11 58;clear
                                    dialog --title "Install" \
                                           --backtitle "$BACKTITLE" \
                                           --yesno "Do you want to install Extremetuxracer?" 6 33;
                                    if [ "$?" -eq 0 ]; then ##Okay Extremetuxracer
                                        clear;
                                        printf "==========================================\n| Install Software                       |\n==========================================\n";
                                        sudo apt-get install extremetuxracer;
                                        printf "\nPress Enter to return to the Program\n";read
                                    elif [ "$?" -eq 1 ]; then ##Cancel Extremetuxracer
                                        clear;
                                    fi
                                    ;;
                                    3)
                                    dialog --clear \
                                           --title "FretsonFire" \
                                           --backtitle "$BACKTITLE" \
                                           --msgbox "Frets on Fire is a game of musical skill\nand fast fingers. The aim of the game is\nto play guitar with the keyboard\nas accurately as possible." 8 58;clear
                                    dialog --title "Install" \
                                           --backtitle "$BACKTITLE" \
                                           --yesno "Do you want to install FretsonFire?" 6 33;
                                    if [ "$?" -eq 0 ]; then ##Okay FretsonFire
                                        clear;
                                        printf "==========================================\n| Install Software                       |\n==========================================\n";
                                        sudo apt-get install fretsonfire;
                                        printf "\nPress Enter to return to the Program\n";read
                                    elif [ "$?" -eq 1 ]; then ##Cancel FretsonFire
                                        clear;
                                    fi
                                    ;;
                                    4)
                                    dialog --clear \
                                           --title "Frozenbubble" \
                                           --backtitle "$BACKTITLE" \
                                           --msgbox "The Frozen-Bubble game is a free software implementation\nof a popular arcade/reflex game.\nThe game mainly consists of firing\nrandomly chosen bubbles across the board.\nIf the shoot ends up having a clump\nof at least 3 bubbles of the same color, they all pop.\nIf some bubbles were sticked\nonly on the popping clump, they fall.\nIn 1-player mode,\nthe goal is to pop all the bubbles on the board\nas quickly as possible.\nIn 2-players or network mode,\nyou have to get your opponent to die before you." 18 58;clear
                                    dialog --title "Install" \
                                           --backtitle "$BACKTITLE" \
                                           --yesno "Do you want to install Frozenbubble?" 6 33;
                                    if [ "$?" -eq 0 ]; then ##Okay Frozenbubble
                                        clear;
                                        printf "==========================================\n| Install Software                       |\n==========================================\n";
                                        sudo apt-get install frozen-bubble;
                                        printf "\nPress Enter to return to the Program\n";read
                                    elif [ "$?" -eq 1 ]; then ##Cancel Frozenbubble
                                        clear;
                                    fi
                                    ;;
                                    5)
                                    dialog --clear \
                                           --title "Funguloids" \
                                           --backtitle "$BACKTITLE" \
                                           --msgbox "Funguloids - Those Funny Funguloids!" 5 58;clear
                                    dialog --title "Install" \
                                           --backtitle "$BACKTITLE" \
                                           --yesno "Do you want to install Funguloids?" 6 33;
                                    if [ "$?" -eq 0 ]; then ##Okay Funguloids
                                        clear;
                                        printf "==========================================\n| Install Software                       |\n==========================================\n";
                                        sudo apt-get install funguloids;
                                        printf "\nPress Enter to return to the Program\n";read
                                    elif [ "$?" -eq 1 ]; then ##Cancel Funguloids
                                        clear;
                                    fi
                                    ;;
                                    6)
                                    dialog --clear \
                                           --title "Neverball" \
                                           --backtitle "$BACKTITLE" \
                                           --msgbox "In the grand tradition of Marble Madness\nand Super Monkey Ball,\nNeverball has you guide a rolling ball through dangerous territory.\nBalance on narrow bridges,\nnavigate mazes, ride moving platforms,\nand dodge pushers and shovers\nto get to the goal.\nRace against the clock to collect coins\nto earn extra balls." 14 58;clear
                                    dialog --title "Install" \
                                           --backtitle "$BACKTITLE" \
                                           --yesno "Do you want to install Neverball?" 6 33;
                                    if [ "$?" -eq 0 ]; then ##Okay Neverball
                                        clear;
                                        printf "==========================================\n| Install Software                       |\n==========================================\n";
                                        sudo apt-get install neverball;
                                        printf "\nPress Enter to return to the Program\n";read
                                    elif [ "$?" -eq 1 ]; then ##Cancel Neverball
                                        clear;
                                    fi
                                    ;;
                                    7)
                                    dialog --clear \
                                           --title "Neverputt" \
                                           --backtitle "$BACKTITLE" \
                                           --msgbox "Based on the physics and graphics of Neverball,\nNeverputt is a hot-seat\nmulti-player miniature golf game\nfor 1 to 4 players.\nThe available courses take advantage of all\nthe elements that challenge Neverball players,\nincluding moving platforms\nand barriers, teleporters, ramps,and drop-offs.\nA simple putting interface\nand golf scoring system have been added." 14 58;clear
                                    dialog --title "Install" \
                                           --backtitle "$BACKTITLE" \
                                           --yesno "Do you want to install Neverputt?" 6 33;
                                    if [ "$?" -eq 0 ]; then ##Okay Neverputt
                                        clear;
                                        printf "==========================================\n| Install Software                       |\n==========================================\n";
                                        sudo apt-get install neverputt;
                                        printf "\nPress Enter to return to the Program\n";read
                                    elif [ "$?" -eq 1 ]; then ##Cancel Neverputt
                                        clear;
                                    fi
                                    ;;
                                    8)
                                    dialog --clear \
                                           --title "SuperTux" \
                                           --backtitle "$BACKTITLE" \
                                           --msgbox "Supertux is a classic 2D jump'n run sidescroller game\nin a similar style like the original SuperMario games." 6 58;clear
                                    dialog --title "Install" \
                                           --backtitle "$BACKTITLE" \
                                           --yesno "Do you want to install SuperTux?" 6 33;
                                    if [ "$?" -eq 0 ]; then ##Okay SuperTux
                                        clear;
                                        printf "==========================================\n| Install Software                       |\n==========================================\n";
                                        sudo apt-get install supertux;
                                        printf "\nPress Enter to return to the Program\n";read
                                    elif [ "$?" -eq 1 ]; then ##Cancel SuperTux
                                        clear;
                                    fi
                                    ;;
                                    9)
                                    dialog --clear \
                                           --title "Supertuxkart" \
                                           --backtitle "$BACKTITLE" \
                                           --msgbox "A Kart Game Featuring Tux and Friends." 5 58;clear
                                    dialog --title "Install" \
                                           --backtitle "$BACKTITLE" \
                                           --yesno "Do you want to install Supertuxkart?" 6 33;
                                    if [ "$?" -eq 0 ]; then ##Okay Supertuxkart
                                        clear;
                                        printf "==========================================\n| Install Software                       |\n==========================================\n";
                                        sudo apt-get install supertuxkart;
                                        printf "\nPress Enter to return to the Program\n";read
                                    elif [ "$?" -eq 1 ]; then ##Cancel Supertuxkart
                                        clear;
                                    fi
                                    ;;
                                esac
                            elif [ "$?" -eq 1 ]; then ##Cancel in Arcade
                                break;
                            fi
                            done 
                            ;;
                            2)
                            while [[ 1 ]]
                            do
                            HEIGHT=17
                            WIDTH=50
                            CHOICE_HEIGHT=8
                            BACKTITLE="PMP v.0.0.25 / Software Center / Board Games"
                            TITLE="Board Games"
                            MENU="Select one:"
                            OPTIONS=(1 "3D Chess - Chess Game"
                                     2 "Gnomechess - Chess Game"
                                     3 "DreamChess - Chess Game"
                                     4 "Jester - Similar to Othello"
                                     5 "Mahjongg - Disassemble Tiles"
                                     6 "Open Yahtzee - Dice Game"
                                     7 "Pentobi - Board Game Blokus"
                                     8 "PyChess - Chess Game")
                            CHOICE=$(dialog --clear \
                                            --backtitle "$BACKTITLE" \
                                            --title "$TITLE" \
                                            --menu "$MENU" \
                            $HEIGHT $WIDTH $CHOICE_HEIGHT \
                            "${OPTIONS[@]}" \
                            2>&1 >/dev/tty)
                            if [ "$?" -eq 0 ]; then ##Okay in Board Games
                                case $CHOICE in
                                    1)
                                    dialog --clear \
                                           --title "3D Chess" \
                                           --backtitle "$BACKTITLE" \
                                           --msgbox "3Dchess - Play chess across 3 boards!" 5 58;clear
                                    dialog --title "Install" \
                                           --backtitle "$BACKTITLE" \
                                           --yesno "Do you want to install 3D Chess?" 6 33;
                                    if [ "$?" -eq 0 ]; then ##Okay 3D Chess
                                        clear;
                                        printf "==========================================\n| Install Software                       |\n==========================================\n";
                                        sudo apt-get install 3dchess;
                                        printf "\nPress Enter to return to the Program\n";read
                                    elif [ "$?" -eq 1 ]; then ##Cancel 3D Chess
                                        clear;
                                    fi
                                    ;;
                                    2)
                                    dialog --clear \
                                           --title "Gnomechess" \
                                           --backtitle "$BACKTITLE" \
                                           --msgbox "Gnome-chess — A 3D chess application" 5 58;clear
                                    dialog --title "Install" \
                                           --backtitle "$BACKTITLE" \
                                           --yesno "Do you want to install Gnomechess?" 6 33;
                                    if [ "$?" -eq 0 ]; then ##Okay Gnomechess
                                        clear;
                                        printf "==========================================\n| Install Software                       |\n==========================================\n";
                                        sudo apt-get install gnome-chess;
                                        printf "\nPress Enter to return to the Program\n";read
                                    elif [ "$?" -eq 1 ]; then ##Cancel Gnomechess
                                        clear;
                                    fi
                                    ;;
                                    3)
                                    dialog --clear \
                                           --title "DreamChess" \
                                           --backtitle "$BACKTITLE" \
                                           --msgbox "Dreamchess - 3D chess game" 5 58;clear
                                    dialog --title "Install" \
                                           --backtitle "$BACKTITLE" \
                                           --yesno "Do you want to install DreamChess?" 6 33;
                                    if [ "$?" -eq 0 ]; then ##Okay DreamChess
                                        clear;
                                        printf "==========================================\n| Install Software                       |\n==========================================\n";
                                        sudo apt-get install dreamchess;
                                        printf "\nPress Enter to return to the Program\n";read
                                    elif [ "$?" -eq 1 ]; then ##Cancel DreamChess
                                        clear;
                                    fi
                                    ;;
                                    4)
                                    dialog --clear \
                                           --title "Jester" \
                                           --backtitle "$BACKTITLE" \
                                           --msgbox "Board game similar to Othello" 5 58;clear
                                    dialog --title "Install" \
                                           --backtitle "$BACKTITLE" \
                                           --yesno "Do you want to install Jester?" 6 33;
                                    if [ "$?" -eq 0 ]; then ##Okay Jester
                                        clear;
                                        printf "==========================================\n| Install Software                       |\n==========================================\n";
                                        sudo apt-get install jester;
                                        printf "\nPress Enter to return to the Program\n";read
                                    elif [ "$?" -eq 1 ]; then ##Cancel Jester
                                        clear;
                                    fi
                                    ;;
                                    5)
                                    dialog --clear \
                                           --title "Mahjongg" \
                                           --backtitle "$BACKTITLE" \
                                           --msgbox "GNOME Mahjongg, or Mahjongg for short,\nis a solitaire 'one player' version\nof the classic Eastern tile game, Mahjongg." 7 58;clear
                                    dialog --title "Install" \
                                           --backtitle "$BACKTITLE" \
                                           --yesno "Do you want to install Mahjongg?" 6 33;
                                    if [ "$?" -eq 0 ]; then ##Okay Mahjongg
                                        clear;
                                        printf "==========================================\n| Install Software                       |\n==========================================\n";
                                        sudo apt-get install mahjongg;
                                        printf "\nPress Enter to return to the Program\n";read
                                    elif [ "$?" -eq 1 ]; then ##Cancel Mahjongg
                                        clear;
                                    fi
                                    ;;
                                    6)
                                    dialog --clear \
                                           --title "Open Yahtzee" \
                                           --backtitle "$BACKTITLE" \
                                           --msgbox "Classic dice game of Yahtzee" 5 58;clear
                                    dialog --title "Install" \
                                           --backtitle "$BACKTITLE" \
                                           --yesno "Do you want to install Yahtzee?" 6 33;
                                    if [ "$?" -eq 0 ]; then ##Okay Open Yahtzee
                                        clear;
                                        printf "==========================================\n| Install Software                       |\n==========================================\n";
                                        sudo apt-get install openyahtzee;
                                        printf "\nPress Enter to return to the Program\n";read
                                    elif [ "$?" -eq 1 ]; then ##Cancel Open Yahtzee
                                        clear;
                                    fi
                                    ;;
                                    7)
                                    dialog --clear \
                                           --title "Pentobi" \
                                           --backtitle "$BACKTITLE" \
                                           --msgbox "Clone of the strategy board game Blokus" 5 58;clear
                                    dialog --title "Install" \
                                           --backtitle "$BACKTITLE" \
                                           --yesno "Do you want to install Pentobi?" 6 33;
                                    if [ "$?" -eq 0 ]; then ##Okay Pentobi
                                        clear;
                                        printf "==========================================\n| Install Software                       |\n==========================================\n";
                                        sudo apt-get install pentobi;
                                        printf "\nPress Enter to return to the Program\n";read
                                    elif [ "$?" -eq 1 ]; then ##Cancel Pentobi
                                        clear;
                                    fi
                                    ;;
                                    8)
                                    dialog --clear \
                                           --title "PyChess" \
                                           --backtitle "$BACKTITLE" \
                                           --msgbox "PyChess is a gtk chess client,\noriginally developed for GNOME,\nbut running well under all other linux desktops." 7 58;clear
                                    dialog --title "Install" \
                                           --backtitle "$BACKTITLE" \
                                           --yesno "Do you want to install PyChess?" 6 33;
                                    if [ "$?" -eq 0 ]; then ##Okay PyChess
                                        clear;
                                        printf "==========================================\n| Install Software                       |\n==========================================\n";
                                        sudo apt-get install pychess;
                                        printf "\nPress Enter to return to the Program\n";read
                                    elif [ "$?" -eq 1 ]; then ##Cancel PyChess
                                        clear;
                                    fi
                                    ;;
                                esac
                            elif [ "$?" -eq 1 ]; then ##Cancel in Board Games
                                break;
                            fi
                            done 
                            ;;
                            3)
                            while [[ 1 ]]
                            do
                            HEIGHT=17
                            WIDTH=50
                            CHOICE_HEIGHT=3
                            BACKTITLE="PMP v.0.0.25 / Software Center / Games / Card Games"
                            TITLE="Card Games"
                            MENU="Select one:"
                            OPTIONS=(1 "Aisleriot - Solitaire"
                                     2 "GnomeHearts - Hearts Game"
                                     3 "Pokerth - Texas Hold'em Game")
                            CHOICE=$(dialog --clear \
                                            --backtitle "$BACKTITLE" \
                                            --title "$TITLE" \
                                            --menu "$MENU" \
                            $HEIGHT $WIDTH $CHOICE_HEIGHT \
                            "${OPTIONS[@]}" \
                            2>&1 >/dev/tty)
                            if [ "$?" -eq 0 ]; then ##Okay in Card Games
                                case $CHOICE in
                                    1)
                                    dialog --clear \
                                           --title "Aisleriot" \
                                           --backtitle "$BACKTITLE" \
                                           --msgbox "AisleRiot also known as Solitaire or sol is a collection of card games which are easy to play with the aid of a mouse." 7 58;clear
                                    dialog --title "Install" \
                                           --backtitle "$BACKTITLE" \
                                           --yesno "Do you want to install Aisleriot Solitaire?" 6 33;
                                    if [ "$?" -eq 0 ]; then ##Okay Aisleriot
                                        clear;
                                        printf "==========================================\n| Install Software                       |\n==========================================\n";
                                        sudo apt-get install aisleriot;
                                        printf "\nPress Enter to return to the Program\n";read
                                    elif [ "$?" -eq 1 ]; then ##Cancels Aisleriot
                                        clear;
                                    fi
                                    ;;
                                    2)
                                    dialog --clear \
                                           --title "GnomeHearts" \
                                           --backtitle "$BACKTITLE" \
                                           --msgbox "Gnome hearts is an implementation\nof the classic card game for the GNOME desktop,\nfeaturing configurable rulesets\nand editable computer opponents\nto satisfy widely diverging playing styles." 9 58;clear
                                    dialog --title "Install" \
                                           --backtitle "$BACKTITLE" \
                                           --yesno "Do you want to install GnomeHearts Hearts Game?" 6 33;
                                    if [ "$?" -eq 0 ]; then ##Okay GnomeHearts
                                        clear;
                                        printf "==========================================\n| Install Software                       |\n==========================================\n";
                                        sudo apt-get install gnome-hearts;
                                        printf "\nPress Enter to return to the Program\n";read
                                    elif [ "$?" -eq 1 ]; then ##Cancel GnomeHearts
                                        clear;
                                    fi
                                    ;;
                                    3)
                                    dialog --clear \
                                           --title "Pokerth" \
                                           --backtitle "$BACKTITLE" \
                                           --msgbox "pokerth is a free implementation\nof the famous Texas hold'em card game\nwhich is often played in casinos." 7 58;clear
                                    dialog --title "Install" \
                                           --backtitle "$BACKTITLE" \
                                           --yesno "Do you want to install Pokerth Texas Hold'em?" 6 33;
                                    if [ "$?" -eq 0 ]; then ##Okay Pokerth
                                        clear;
                                        printf "==========================================\n| Install Software                       |\n==========================================\n";
                                        sudo apt-get install pokerth;
                                        printf "\nPress Enter to return to the Program\n";read
                                    elif [ "$?" -eq 1 ]; then ##Cancel Pokerth
                                        clear;
                                    fi
                                    ;;
                                esac
                            elif [ "$?" -eq 1 ]; then ##Cancel in Card Games
                                break;
                            fi
                            done 
                            ;;
                            4)
                            while [[ 1 ]]
                            do
                            HEIGHT=17
                            WIDTH=50
                            CHOICE_HEIGHT=9
                            BACKTITLE="PMP v.0.0.25 / Software Center / Games / Puzzles"
                            TITLE="Puzzles"
                            MENU="Select one:"
                            OPTIONS=(1 "Amoebax - Puyo Puyo Style Puzzle"
                                     2 "BrainParty - 36 Puzzle Games"
                                     3 "FiveOrMore - Align Colored Balls"
                                     4 "FourInARow - Four In A Row Game"
                                     5 "Gbrainy - Brain Teaser Game"
                                     6 "Ksudoku - Sudoku Puzzle Game"
                                     7 "GnomeMines - Mine Game"
                                     8 "GnomeSudoku - Sudoku Puzzle Game"
                                     9 "Pybik - Rubic's Cube Game")
                            CHOICE=$(dialog --clear \
                                            --backtitle "$BACKTITLE" \
                                            --title "$TITLE" \
                                            --menu "$MENU" \
                            $HEIGHT $WIDTH $CHOICE_HEIGHT \
                            "${OPTIONS[@]}" \
                            2>&1 >/dev/tty)
                            if [ "$?" -eq 0 ]; then ##Okay in Puzzles
                                case $CHOICE in
                                    1)
                                    dialog --clear \
                                           --title "Amoebax" \
                                           --backtitle "$BACKTITLE" \
                                           --msgbox "Puyo Puyo-style puzzle game for up to two players" 5 58;clear
                                    dialog --title "Install" \
                                           --backtitle "$BACKTITLE" \
                                           --yesno "Do you want to install Amoebax?" 6 33;
                                    if [ "$?" -eq 0 ]; then ##Okay Amoebax
                                        clear;
                                        printf "==========================================\n| Install Software                       |\n==========================================\n";
                                        sudo apt-get install amoebax;
                                        printf "\nPress Enter to return to the Program\n";read
                                    elif [ "$?" -eq 1 ]; then ##Cancel Amoebax
                                        clear;
                                    fi
                                    ;;
                                    2)
                                    dialog --clear \
                                           --title "BrainParty" \
                                           --backtitle "$BACKTITLE" \
                                           --msgbox "36 puzzle games for all the family" 5 58;clear
                                    dialog --title "Install" \
                                           --backtitle "$BACKTITLE" \
                                           --yesno "Do you want to install BrainParty?" 6 33;
                                    if [ "$?" -eq 0 ]; then ##Okay BrainParty
                                        clear;
                                        printf "==========================================\n| Install Software                       |\n==========================================\n";
                                        sudo apt-get install brainparty;
                                        printf "\nPress Enter to return to the Program\n";read
                                    elif [ "$?" -eq 1 ]; then ##Cancel BrainParty
                                        clear;
                                    fi
                                    ;;
                                    3)
                                    dialog --clear \
                                           --title "FiveOrMore" \
                                           --backtitle "$BACKTITLE" \
                                           --msgbox "five-or-more is the GNOME port\nof the once popular Windows game called Colour Lines.\nThe game's objective is to align as often as possible\nfive or more objects of the same colour\nand shape causing them to disappear." 9 58;clear
                                    dialog --title "Install" \
                                           --backtitle "$BACKTITLE" \
                                           --yesno "Do you want to install FiveOrMore?" 6 33;
                                    if [ "$?" -eq 0 ]; then ##Okay FiveOrMore
                                        printf "==========================================\n| Install Software                       |\n==========================================\n";
                                        clear;
                                        sudo apt-get install five-or-more;
                                        printf "\nPress Enter to return to the Program\n";read
                                    elif [ "$?" -eq 1 ]; then ##Cancel FiveOrMore
                                        clear;
                                    fi
                                    ;;
                                    4)
                                    dialog --clear \
                                           --title "FourInARow" \
                                           --backtitle "$BACKTITLE" \
                                           --msgbox "The object of the game is to build\na line of four of your marbles\nwhile trying to stop your opponent\n'human or computer' building a line of his or her own.\nA line can be horizontal, vertical or diagonal." 9 58;clear
                                    dialog --title "Install" \
                                           --backtitle "$BACKTITLE" \
                                           --yesno "Do you want to install FourInARow?" 6 33;
                                    if [ "$?" -eq 0 ]; then ##Okay FourInARow
                                        clear;
                                        printf "==========================================\n| Install Software                       |\n==========================================\n";
                                        sudo apt-get install four-in-a-row;
                                        printf "\nPress Enter to return to the Program\n";read
                                    elif [ "$?" -eq 1 ]; then ##Cancel FourInARow
                                        clear;
                                    fi
                                    ;;
                                    5)
                                    dialog --clear \
                                           --title "Gbrainy" \
                                           --backtitle "$BACKTITLE" \
                                           --msgbox "gbrainy features different game types like\nlogic puzzles, mental calculation games,\nmemory  trainers and verbal analogies\ndesigned to test different cognitive skills." 8 58;clear
                                    dialog --title "Install" \
                                           --backtitle "$BACKTITLE" \
                                           --yesno "Do you want to install Gbrainy?" 6 33;
                                    if [ "$?" -eq 0 ]; then ##Okay Gbrainy
                                        clear;
                                        printf "==========================================\n| Install Software                       |\n==========================================\n";
                                        sudo apt-get install gbrainy;
                                        printf "\nPress Enter to return to the Program\n";read
                                    elif [ "$?" -eq 1 ]; then ##Cancel Gbrainy
                                        clear;
                                    fi
                                    ;;
                                    6)
                                    dialog --clear \
                                           --title "Ksudoku" \
                                           --backtitle "$BACKTITLE" \
                                           --msgbox "KSudoku is a Sudoku game and solver,\nsupporting a range of 2D and 3D Sudoku variants.\nIn addition to playing Sudoku,\nit can print Sudoku puzzle sheets\nand find the solution to any Sudoku puzzle." 9 58;clear
                                    dialog --title "Install" \
                                           --backtitle "$BACKTITLE" \
                                           --yesno "Do you want to install Ksudoku?" 6 33;
                                    if [ "$?" -eq 0 ]; then ##Okay Ksudoku
                                        clear;
                                        printf "==========================================\n| Install Software                       |\n==========================================\n";
                                        sudo apt-get install ksudoku;
                                        printf "\nPress Enter to return to the Program\n";read
                                    elif [ "$?" -eq 1 ]; then ##Cancel Ksudoku
                                        clear;
                                    fi
                                    ;;
                                    7)
                                    dialog --clear \
                                           --title "GnomeMines" \
                                           --backtitle "$BACKTITLE" \
                                           --msgbox "popular minesweeper puzzle game for GNOME" 5 58;clear
                                    dialog --title "Install" \
                                           --backtitle "$BACKTITLE" \
                                           --yesno "Do you want to install GnomeMines?" 6 33;
                                    if [ "$?" -eq 0 ]; then ##Okay GnomeMines
                                        clear;
                                        printf "==========================================\n| Install Software                       |\n==========================================\n";
                                        sudo apt-get install gnome-mines;
                                        printf "\nPress Enter to return to the Program\n";read
                                    elif [ "$?" -eq 1 ]; then ##Cancel GnomeMines
                                        clear;
                                    fi
                                    ;;
                                    8)
                                    dialog --clear \
                                           --title "GnomeSudoku" \
                                           --backtitle "$BACKTITLE" \
                                           --msgbox "gnome-sudoku a simple player for the sudoku number logic puzzle.\nGNOME Sudoku generates unique,\nsymmetrical puzzles\nand rates their difficulty." 9 58;clear
                                    dialog --title "Install" \
                                           --backtitle "$BACKTITLE" \
                                           --yesno "Do you want to install GnomeSudoku?" 6 33;
                                    if [ "$?" -eq 0 ]; then ##Okay GnomeSudoku
                                        clear;
                                        printf "==========================================\n| Install Software                       |\n==========================================\n";
                                        sudo apt-get install gnome-sudoku;
                                        printf "\nPress Enter to return to the Program\n";read
                                    elif [ "$?" -eq 1 ]; then ##Cancel GnomeSudoku
                                        clear;
                                    fi
                                    ;;
                                    9)
                                    dialog --clear \
                                           --title "Pybik" \
                                           --backtitle "$BACKTITLE" \
                                           --msgbox "Pybik is an interactive, graphical,\nsingle player puzzle about the cube\ninvented by Erno Rubik.\nBesides the cube the program can handle towersand bricks 'non cubic puzzles'.\nPybik also has solvers, pretty patterns\nand a collection of various moves.\nThe cube can be manipulated\nwith the mouse or keyboard.\nYou can change the colors or images\non the faces of the cube." 15 58;clear
                                    dialog --title "Install" \
                                           --backtitle "$BACKTITLE" \
                                           --yesno "Do you want to install Pybik?" 5 33;
                                    if [ "$?" -eq 0 ]; then ##Okay Pybik
                                        clear;
                                        printf "==========================================\n| Install Software                       |\n==========================================\n";
                                        sudo apt-get install pybik;
                                        printf "\nPress Enter to return to the Program\n";read
                                    elif [ "$?" -eq 1 ]; then ##Cancel Pybik
                                        clear;
                                    fi
                                    ;;
                                esac
                            elif [ "$?" -eq 1 ]; then ##Cancel in Puzzels
                                break;
                            fi
                            done 
                            ;;
                            5)
                            while [[ 1 ]]
                            do
                            HEIGHT=17
                            WIDTH=50
                            CHOICE_HEIGHT=2
                            BACKTITLE="PMP v.0.0.25 / Software Center / Games / Role Playing"
                            TITLE="Role Playing"
                            MENU="Select one:"
                            OPTIONS=(1 "Flare - 2D Action Role-Playing Game"
                                     2 "PQ - Role Playing Game")
                            CHOICE=$(dialog --clear \
                                            --backtitle "$BACKTITLE" \
                                            --title "$TITLE" \
                                            --menu "$MENU" \
                            $HEIGHT $WIDTH $CHOICE_HEIGHT \
                            "${OPTIONS[@]}" \
                            2>&1 >/dev/tty)
                            if [ "$?" -eq 0 ]; then ##Okay in Software Center Menu
                                case $CHOICE in
                                    1)
                                    dialog --clear \
                                           --title "Flare" \
                                           --backtitle "$BACKTITLE" \
                                           --msgbox "Flare is a Diablo like RPG game." 5 58;clear
                                    dialog --title "Install" \
                                           --backtitle "$BACKTITLE" \
                                           --yesno "Do you want to install Flare?" 5 33;
                                    if [ "$?" -eq 0 ]; then ##Okay Flare
                                        clear;
                                        printf "==========================================\n| Install Software                       |\n==========================================\n";
                                        sudo apt-get install flare-game;
                                        printf "\nPress Enter to return to the Program\n";read
                                    elif [ "$?" -eq 1 ]; then ##Cancel Flare
                                        clear;
                                    fi
                                    ;;
                                    2)
                                    dialog --clear \
                                           --title "PQ" \
                                           --backtitle "$BACKTITLE" \
                                           --msgbox "Progress Quest is a 'fire and forget'\ncomputer role-playing game,\nwhere you create a fantasy character\nand watch it advance." 8 58;clear
                                    dialog --title "Install" \
                                           --backtitle "$BACKTITLE" \
                                           --yesno "Do you want to install PQ?" 5 33;
                                    if [ "$?" -eq 0 ]; then ##Okay PQ
                                        clear;
                                        printf "==========================================\n| Install Software                       |\n==========================================\n";
                                        sudo apt-get install pq;
                                        printf "\nPress Enter to return to the Program\n";read
                                    elif [ "$?" -eq 1 ]; then ##Cancel PQ
                                        clear;
                                    fi
                                    ;;
                                esac
                            elif [ "$?" -eq 1 ]; then ##
                                break;
                            fi
                            done 
                            ;;
                            6)
                            while [[ 1 ]]
                            do
                            HEIGHT=17
                            WIDTH=50
                            CHOICE_HEIGHT=4
                            BACKTITLE="PMP v.0.0.25 / Software Center / Games / Simulation"
                            TITLE="Simulation"
                            MENU="Select one:"
                            OPTIONS=(1 "Achilles - Evolution Simulator"
                                     2 "EndlessSky - 2D Space exploration Game"
                                     3 "Foobillardplus - 3D Billiard Game"
                                     4 "LinCityNG - City Simulation Game")
                            CHOICE=$(dialog --clear \
                                            --backtitle "$BACKTITLE" \
                                            --title "$TITLE" \
                                        --menu "$MENU" \
                            $HEIGHT $WIDTH $CHOICE_HEIGHT \
                            "${OPTIONS[@]}" \
                            2>&1 >/dev/tty)
                            if [ "$?" -eq 0 ]; then ##Okay in Simulation
                                case $CHOICE in
                                    1)
                                    dialog --clear \
                                           --title "Achilles" \
                                           --backtitle "$BACKTITLE" \
                                           --msgbox "OpenGL simulation of artificial life and evolution." 5 58;clear
                                    dialog --title "Install" \
                                           --backtitle "$BACKTITLE" \
                                           --yesno "Do you want to install Achilles?" 6 33;
                                    if [ "$?" -eq 0 ]; then ##Okay Achilles
                                        clear;
                                        printf "==========================================\n| Install Software                       |\n==========================================\n";
                                        sudo apt-get install achilles;
                                        printf "\nPress Enter to return to the Program\n";read
                                    elif [ "$?" -eq 1 ]; then ##Cancel Achilles
                                        clear;
                                    fi
                                    ;;
                                    2)
                                    dialog --clear \
                                           --title "EndlessSky" \
                                           --backtitle "$BACKTITLE" \
                                           --msgbox "Endless Sky is a space exploration and combat game\ncombining action and role playing elements.\nExplore other star systems. Earn money by trading,\ncarrying passengers, or completing missions.\nUse your earnings to buy a better ship\nor to upgrade  the  weapons and engines\non your current one.\nBlow up pirates. Take sides in a civil war.\nOr leave human space behind\nand hope to find some friendly aliens\nwhose culture is more civilized\nthan your own." 16 58;clear
                                    dialog --title "Install" \
                                           --backtitle "$BACKTITLE" \
                                           --yesno "Do you want to install EndlessSky?" 6 33;
                                    if [ "$?" -eq 0 ]; then ##Okay EndlessSky
                                        clear;
                                        printf "==========================================\n| Install Software                       |\n==========================================\n";
                                        sudo apt-get install endless-sky;
                                        printf "\nPress Enter to return to the Program\n";read
                                    elif [ "$?" -eq 1 ]; then ##Cancel EndlessSky
                                        clear;
                                    fi
                                    ;;
                                    3)
                                    dialog --clear \
                                           --title "Foobillardplus" \
                                           --backtitle "$BACKTITLE" \
                                           --msgbox "FooBillard is an OpenGL billard game for Linux.\nFooBillard is still under development,\nbut the main physics are implemented.\nIf you are a billard-pro\nand you're missing some physics,\nplease contact the author." 10 58;clear
                                    dialog --title "Install" \
                                           --backtitle "$BACKTITLE" \
                                           --yesno "Do you want to install Foobillardplus?" 6 33;
                                    if [ "$?" -eq 0 ]; then ##Okay Foobillardplus
                                        clear;
                                        printf "==========================================\n| Install Software                       |\n==========================================\n";
                                        sudo apt-get install foobillardplus;
                                        printf "\nPress Enter to return to the Program\n";read
                                    elif [ "$?" -eq 1 ]; then ##Cancel Foobillardplus
                                        clear;
                                    fi
                                    ;;
                                    4)
                                    dialog --clear \
                                           --title "LinCityNG" \
                                           --backtitle "$BACKTITLE" \
                                           --msgbox "Lincity is a city/country simulation game\nYou are required to build and maintain a city.\nYou must feed, house, provide jobs and goods\nfor your residents.\nYou can build a sustainable economy\nwith the help of renewable energy and recycling,\nor you can go for broke\nand build rockets to escape from\na pollution ridden and resource starved planet,\nit's up to you.\nDue to the finite  resources available\nin any one place,\nthis is not a game that you can leave for\nlong periods of time." 18 58;clear
                                    dialog --title "Install" \
                                           --backtitle "$BACKTITLE" \
                                           --yesno "Do you want to install LinCityNG?" 6 33;
                                    if [ "$?" -eq 0 ]; then ##Okay LinCityNG
                                        clear;
                                        printf "==========================================\n| Install Software                       |\n==========================================\n";
                                        sudo apt-get install lincity-ng;
                                        printf "\nPress Enter to return to the Program\n";read
                                    elif [ "$?" -eq 1 ]; then ##Cancel LinCityNG
                                        clear;
                                    fi
                                    ;;
                                esac
                            elif [ "$?" -eq 1 ]; then ##Cancel in Simulation
                                break;
                            fi
                            done 
                            ;;
                            7)
                            while [[ 1 ]]
                            do
                            HEIGHT=17
                            WIDTH=50
                            CHOICE_HEIGHT=4
                            BACKTITLE="PMP v.0.0.25 / Software Center / Games / Sports"
                            TITLE="Sports"
                            MENU="Select one:"
                            OPTIONS=(1 "ETW - Arcade Style Soccer Game"
                                     2 "Tennix - 2D Tennis Game"
                                     3 "TuxFootball - 2D Soccer Game"
                                     4 "TuxPuck - Air Hockey Game")
                            CHOICE=$(dialog --clear \
                                            --backtitle "$BACKTITLE" \
                                            --title "$TITLE" \
                                            --menu "$MENU" \
                            $HEIGHT $WIDTH $CHOICE_HEIGHT \
                            "${OPTIONS[@]}" \
                            2>&1 >/dev/tty)
                            if [ "$?" -eq 0 ]; then ##Okay in Sports
                                case $CHOICE in
                                    1)
                                    dialog --clear \
                                           --title "ETW" \
                                           --backtitle "$BACKTITLE" \
                                           --msgbox "ETW is an arcade-style soccer game." 5 58;clear
                                    dialog --title "Install" \
                                           --backtitle "$BACKTITLE" \
                                           --yesno "Do you want to install ETW?" 5 33;
                                    if [ "$?" -eq 0 ]; then ##Okay ETW
                                        clear;
                                        printf "==========================================\n| Install Software                       |\n==========================================\n";
                                        sudo apt-get install etw;
                                        printf "\nPress Enter to return to the Program\n";read
                                    elif [ "$?" -eq 1 ]; then ##Cancel ETW
                                        clear;
                                    fi
                                    ;;
                                    2)
                                    dialog --clear \
                                           --title "Tennix" \
                                           --backtitle "$BACKTITLE" \
                                           --msgbox "Tennix is a top-view 2D tennis game.\nIt features a two-player game mode\nand a single-player mode against the computer.\nThis is the SDL port of a DOS game\nwritten in 2003. " 9 58;clear
                                    dialog --title "Install" \
                                           --backtitle "$BACKTITLE" \
                                           --yesno "Do you want to install Tennix?" 6 33;
                                    if [ "$?" -eq 0 ]; then ##Okay Tennix
                                        clear;
                                        printf "==========================================\n| Install Software                       |\n==========================================\n";
                                        sudo apt-get install tennix;
                                        printf "\nPress Enter to return to the Program\n";read
                                    elif [ "$?" -eq 1 ]; then ##Cancel Tennix
                                        clear;
                                    fi
                                    ;;
                                    3)
                                    dialog --clear \
                                           --title "TuxFootball" \
                                           --backtitle "$BACKTITLE" \
                                           --msgbox "Tux Football brings old style gameplay\nfrom DOS times back to the desktop\nwith up to date  graphics!\nIts gameplay is similar to old classics\nsuch as Amco's Kick Off\nand Sensible Software's Sensible Soccer." 10 58;clear
                                    dialog --title "Install" \
                                           --backtitle "$BACKTITLE" \
                                           --yesno "Do you want to install Tuxfootball?" 6 33;
                                    if [ "$?" -eq 0 ]; then ##Okay TuxFootball
                                        clear;
                                        printf "==========================================\n| Install Software                       |\n==========================================\n";
                                        sudo apt-get install tuxfootball;
                                        printf "\nPress Enter to return to the Program\n";read
                                    elif [ "$?" -eq 1 ]; then ##Cancel TuxFootball
                                        clear;
                                    fi
                                    ;;
                                    4)
                                    dialog --clear \
                                           --title "TuxPuck" \
                                           --backtitle "$BACKTITLE" \
                                           --msgbox "Anyone remember 'Shufflepuck Cafe'\nfor the Amiga/AtariST?   I do.\nTuxPuck is a shufflepuck game written in C using SDL.\nThe player moves a pad around a board\nand tries to shoot down the puck\nthrough the opponents defense." 10 58;clear
                                    dialog --title "Install" \
                                           --backtitle "$BACKTITLE" \
                                           --yesno "Do you want to install TuxPuck?" 6 33;
                                    if [ "$?" -eq 0 ]; then ##Okay TuxPuck
                                        clear;
                                        printf "==========================================\n| Install Software                       |\n==========================================\n";
                                        sudo apt-get install tuxpuck;
                                        printf "\nPress Enter to return to the Program\n";read
                                    elif [ "$?" -eq 1 ]; then ##Cancel TuxPuck
                                        clear;
                                    fi
                                    ;;
                                esac
                            elif [ "$?" -eq 1 ]; then ##Cancel in Sports
                                break;
                            fi
                            done 
                            ;;
                        esac
                    elif [ "$?" -eq 1 ]; then ##Cancel in Games
                    break;
                    fi
                done
            ;;
        esac
    elif [ "$?" -eq 1 ]; then ##Cancel in Software Center Menu
        break;
    fi
    done
	;;
	5)
	while [[ 1 ]]
	      do
	      HEIGHT=12
	      WIDTH=24
	      CHOICE_HEIGHT=5
	      BACKTITLE="PMP v.0.0.25 / Extras"
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
		      WIDTH=27
		      CHOICE_HEIGHT=6
		      BACKTITLE="PMP v.0.0.25 / Extras / Tools"
		      TITLE="Tools"
		      MENU="Select one:"
		      OPTIONS=(1 "Display Resolution"
                   2 "Checksum"
			       3 "Screen Recording"
			       4 "Screensaver"
			       5 "Themes"
			       6 "MapSCII")
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
		 while [[ 1 ]]
		    do
		HEIGHT=16
		WIDTH=35
		CHOICE_HEIGHT=9
		BACKTITLE="PMP v.0.0.25 / Extras / Tools / Display Resolution"
		TITLE="Display Configuration"
		MENU="Select one:"
		OPTIONS=(1 "Current Display Resolution"
			 2 "Set Custom Resolution"
			 3 "3:2 aspect ratio"
			 4 "4:3 aspect ratio"
			 5 "5:3 aspect ratio"
			 6 "5:4 aspect ratio"
			 7 "16:9 aspect ratio"
			 8 "16:10 aspect ratio"
			 9 "17:9 aspect ratio")
		CHOICE=$(dialog --clear \
			      --backtitle "$BACKTITLE" \
			      --title "$TITLE" \
			      --menu "$MENU" \
		$HEIGHT $WIDTH $CHOICE_HEIGHT \
		"${OPTIONS[@]}" \
		2>&1 >/dev/tty)
		if [ "$?" -eq 0 ]; then ##Okay Change Display Resolution
		  case $CHOICE in
		1)
		xrandr | fgrep '*' > '/tmp/space.txt'
		dialog --clear \
		--backtitle "$BACKTITLE / Current Display Resolution" \
		--textbox /tmp/space.txt 5 30
		clear;
		;;
		2)
		RES=$(dialog --clear \
			     --title "$TITLE" \
			     --stdout \
			     --backtitle "$BACKTITLE / Set Custom Resolution" \
			     --inputbox "Enter Screen Resolution a.e 800x600:"  7 40)
		if [ "$?" -eq 0 ]; then ##Okay Custom Resolution
		  xrandr -s $RES
		elif [ "$?" -eq 1 ]; then ##Cancel Custom Resolution
		dialog --infobox "cancelled..." 3 15
		sleep 2;
		fi
		;;
		3)
		while [[ 1 ]]
		do
		HEIGHT=15
		WIDTH=35
		CHOICE_HEIGHT=5
		BACKTITLE="PMP v.0.0.25 / Extras / Tools / Display Resolution"
		TITLE="Display Configuration"
		MENU="Select one:"
		OPTIONS=(1 "720x480"
			 2 "1152x768"
			 3 "1280x854"
			 4 "1440x960"
			 5 "2880x1920")
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
		    clear;
		    xrandr -s 720x480;
		    sleep 2;
		    ;;
		    2)
		    clear;
		    xrandr -s 1152x768;
		    sleep 2;
		    ;;
		    3)
		    clear;
		    xrandr -s 1280x854;
		    sleep 2;
		    ;;
		    4)
		    clear;
		    xrandr -s 1440x960;
		    sleep 2;
		    ;;
		    5)
		    clear;
		    xrandr -s 2880x1920;
		    sleep 2;
		  ;;
		esac
		elif [ "$?" -eq 1 ]; then
		break;
		fi
		done
		;;
		4)
		while [[ 1 ]]
		do
		HEIGHT=15
		WIDTH=35
		CHOICE_HEIGHT=8
		BACKTITLE="PMP v.0.0.25 / Extras / Tools / Display Resolution"
		TITLE="Display Configuration"
		MENU="Select one:"
		OPTIONS=(1 "320x240"
			 2 "640x480"
			 3 "800x600"
			 4 "1024x768"
			 5 "1152x864"
			 6 "1280x960"
			 7 "1400x1050"
			 8 "1600x1200"
			 9 "2048x1536"
			 10 "3200x2400"
			 11 "4000x3000"
			 12 "6400x4800")
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
		    clear;
		    xrandr -s 320x240;
		    sleep 2;
		    ;;
		    2)
		    clear;
		    xrandr -s 640x480;
		    sleep 2;
		    ;;
		    3)
		    clear;
		    xrandr -s 800x600;
		    sleep 2;
		    ;;
		    4)
		    clear;
		    xrandr -s 1024x768;
		    sleep 2;
		    ;;
		    5)
		    clear;
		    xrandr -s 1152x864;
		    sleep 2;
		    ;;
		    6)
		    clear;
		    xrandr -s 1280x960;
		    sleep 2;
		    ;;
		    7)
		    clear;
		    xrandr -s 1400x1050;
		    sleep 2;
		    ;;
		    8)
		    clear;
		    xrandr -s 1600x1200;
		    sleep 2;
		    ;;
		    9)
		    clear;
		    xrandr -s 2048x1536;
		    sleep 2;
		    ;;
		    10)
		    clear;
		    xrandr -s 3200x2400;
		    sleep 2;
		    ;;
		    11)
		    clear;
		    xrandr -s 4000x3000;
		    sleep 2;
		    ;;
		    12)
		    clear;
		    xrandr -s 6400x4800;
		    sleep 2;
		    ;;
		    esac
		  elif [ "$?" -eq 1 ]; then
		    break;
		  fi
		  done
		  ;;
		  5)
		  while [[ 1 ]]
		    do
		  HEIGHT=15
		  WIDTH=35
		  CHOICE_HEIGHT=2
		  BACKTITLE="PMP v.0.0.25 / Extras / Tools / Display Resolution"
		  TITLE="Display Configuration"
		  MENU="Select one:"
		  OPTIONS=(1 "800x480"
			   2 "1280x768")
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
			 clear;
			 xrandr -s 800x480;
			 sleep 2;
			 ;;
			 2)
			 clear;
			 xrandr -s 1280x768;
			 sleep 2;
			 ;;
		 esac
		  elif [ "$?" -eq 1 ]; then
		break;
		fi
		done
		;;
		6)
		while [[ 1 ]]
		do
		HEIGHT=15
		WIDTH=35
		CHOICE_HEIGHT=3
		BACKTITLE="PMP v.0.0.25 / Extras / Tools / Display Resolution"
		TITLE="Display Configuration"
		MENU="Select one:"
		OPTIONS=(1 "1280x1024"
			 2 "2560x2048"
			 3 "5120x4096")
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
		    clear;
		    xrandr -s 1280x1024;
		    sleep 2;
		    ;;
		    2)
		    clear;
		    xrandr -s 2560x2048;
		    sleep 2;
		    ;;
		    3)
		    clear;
		    xrandr -s 5120x4096;
		    sleep 2;
		    ;;
		    esac
		    elif [ "$?" -eq 1 ]; then
		    break;
		    fi
		    done
		    ;;
		    7)
		    while [[ 1 ]]
		    do
		    HEIGHT=15
		    WIDTH=35
		    CHOICE_HEIGHT=5
		    BACKTITLE="PMP v.0.0.25 / Extras / Tools / Display Resolution"
		    TITLE="Display Configuration"
		    MENU="Select one:"
		    OPTIONS=(1 "852x480"
			     2 "1280x720"
			     3 "1365x768"
			     4 "1600x900"
			     5 "1920x1080")
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
		    clear;
		    xrandr -s 852x480;
		    sleep 2;
		    ;;
		    2)
		    clear;
		    xrandr -s 1280x720;
		    sleep 2;
		    ;;
		    3)
		    clear;
		    xrandr -s 1365x768;
		    sleep 2;
		    ;;
		    4)
		    clear;
		    xrandr -s 1600x900;
		    sleep 2;
		    ;;
		    5)
		    clear;
		    xrandr -s 1920x1080;
		    sleep 2;
		    ;;
		    esac
		    elif [ "$?" -eq 1 ]; then
		      break;
		    fi
		    done
		    ;;
		    8)
		    while [[ 1 ]]
		    do
		    HEIGHT=15
		    WIDTH=35
		    CHOICE_HEIGHT=8
		    BACKTITLE="PMP v.0.0.25 / Extras / Tools / Display Resolution"
		    TITLE="Display Configuration"
		    MENU="Select one:"
		    OPTIONS=(1 "320x200"
			     2 "640x400"
			     3 "1280x800"
			     4 "1440x900"
			     5 "1680x1050"
			     6 "1920x1200"
			     7 "2560x1600"
			     8 "3840x2400"
			     9 "7680x4800")
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
			    clear;
			    xrandr -s 320x200;
			    sleep 2;
			    ;;
			    2)
			    clear;
			    xrandr -s 640x400;
			    sleep 2;
			    ;;
			    3)
			    clear;
			    xrandr -s 1280x800;
			    sleep 2;
			    ;;
			    4)
			    clear;
			    xrandr -s 1440x900;
			    sleep 2;
			    ;;
			    5)
			    clear;
			    xrandr -s 1680x1050;
			    sleep 2;
			    ;;
			    6)
			    clear;
			    xrandr -s 1920x1200;
			    sleep 2;
			    ;;
			    7)
			    clear;
			    xrandr -s 2560x1600;
			    sleep 2;
			    ;;
			    8)
			    clear;
			    xrandr -s 3840x2400;
			    sleep 2;
			    ;;
			    9)
			    clear;
			    xrandr -s 7680x4800;
			    sleep 2;
			    ;;
			    esac
			    elif [ "$?" -eq 1 ]; then
			    break;
			      fi
			    done
			    ;;
			    9)
			    while [[ 1 ]]
			    do
			    HEIGHT=15
			    WIDTH=35
			    CHOICE_HEIGHT=1
			    BACKTITLE="PMP v.0.0.25 / Extras / Tools / Display Resolution"
			    TITLE="Display Configuration"
			    MENU="Select one:"
			    OPTIONS=(1 "2048x1080")
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
				  clear;
				  xrandr -s 2048x1080;
				  sleep 2;
				  ;;
			    esac
			    elif [ "$?" -eq 1 ]; then
			      break;
			    fi
			    done
		      ;;
		esac
		elif [ "$?" -eq 1 ]; then ##Cancel Change Display Resolution
		break;
		fi
		done
		;;
		2)
		while [[ 1 ]] ##Checksum
		      do
		      HEIGHT=10
		      WIDTH=20
		      CHOICE_HEIGHT=3
		      BACKTITLE="PMP v.0.0.25 / Extras / Tools / Checksum"
		      TITLE="Checksum"
		      MENU="Select one:"
		      OPTIONS=(1 "Md5Sum"
                       2 "Sha1Sum"
                       3 "Sha256Sum")
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
			    --fselect $HOME/  12 50)
			    if [ "$?" -eq 0 ]; then ##Okay Fselect Md5sum Check
                md5sum $FILE > '/tmp/space.txt'
			     dialog --backtitle "$BACKTITLE / Md5Sum Check" \
			    --title "Md5Sum" \
			    --textbox /tmp/space.txt 5 199;
			    elif [ "$?" -eq 1 ]; then ##Cancel Fselect Md5sum Check
				clear;
			    fi
		      ;;
		      2)
		      FILE=$(dialog --clear \
			    --backtitle "$BACKTITLE / Sha1 Check" \
			    --title "Sha1" \
			    --stdout \
			    --fselect $HOME/  12 50)
			    if [ "$?" -eq 0 ]; then ##Okay Fselect Sha1 Check
                sha1sum $FILE > '/tmp/space.txt'
			     dialog --backtitle "$BACKTITLE / Sha1 Check" \
			    --title "Sha1" \
			    --textbox /tmp/space.txt 5 199;
			    elif [ "$?" -eq 1 ]; then ##Cancel Fselect Sha1 Check
				clear;
			    fi
		      ;;
		      3)
		      FILE=$(dialog --clear \
			    --backtitle "$BACKTITLE / Sha256 Check" \
			    --title "Sha256" \
			    --stdout \
			    --fselect $HOME/  12 50)
			    if [ "$?" -eq 0 ]; then ##Okay Fselect Sha256 Check
                sha256sum $FILE > '/tmp/space.txt'
			     dialog --backtitle "$BACKTITLE / Sha256 Check" \
			    --title "Sha256" \
			    --textbox /tmp/space.txt 5 199;
			    elif [ "$?" -eq 1 ]; then ##Cancel Fselect Sha256 Check
				clear;
			    fi
		      ;;
		      esac
		      elif [ "$?" -eq 1 ]; then ##Cancel Checksum
                break;
		      fi
		      done ## End Checksum
		;;
		3)
        while [[ 1 ]]
        do
        dpkg -s ffmpeg &> /dev/null; #Check's if ffmpeg is installed
        if [ "$?" -eq 0 ]; then #ffmpeg installed
            HEIGHT=8
            WIDTH=30
            CHOICE_HEIGHT=1
            BACKTITLE="PMP v.0.0.25 / Extras / Tools / Screen Recording"
            TITLE="Screen Recording 0.0.1"
            MENU="Select one:"
            OPTIONS=(1 "New Screen Recording")
            CHOICE=$(dialog --clear \
                    --backtitle "$BACKTITLE" \
                    --title "$TITLE" \
                    --menu "$MENU" \
                $HEIGHT $WIDTH $CHOICE_HEIGHT \
                "${OPTIONS[@]}" \
                2>&1 >/dev/tty)
                if [ "$?" -eq 0 ]; then ##Okay Screen recording
                    case $CHOICE in
                    1)
                    while [[ 1 ]]
                    do
                    REC=$(dialog \
                    --title "$TITLE" \
                    --backtitle "$BACKTITLE / New Screen Recording" \
                    --stdout \
                    --inputbox "Save recording as: example, out.mkv" 7 40) ;
                    if [ "$?" -eq 0 ]; then ##Okay New Screen recording
                        DESTINATION=$(dialog --title "$TITLE" \
                                    --backtitle "$BACKTITLE" \
                                    --stdout \
                                    --title "Save Recording in:" \
                                    --fselect $HOME/  8 60) ;
                            if [ "$?" -eq 0 ]; then ##Okay New Screen recording
                                dialog --clear \
                                    --title "$TITLE Info" \
                                    --backtitle "$BACKTITLE" \
                                    --yesno "Save:\n'$REC'\nin:\n'$DESTINATION'?" 8 45;
                                        if [ "$?" -eq 0 ]; then ##YES New Screen recording
                                        dialog --clear \
                                                --title "$TITLE" \
                                                --backtitle "$BACKTITLE" \
                                                --msgbox "Press OK to start the recording.\nTo stop the recording press 'Q'" 6 40;
                                        dialog --title "$TITLE" \
                                            --backtitle "$BACKTITLE" \
                                            --pause "Recording starts in:" 8 30 5;
                                        if [ "$?" -eq 0 ]; then ##Okay Starting Countdown
                                        ## DEFAULT_OUTPUT=$(pacmd list-sinks | grep -A1 "* index" | grep -oP "<\K[^ >]+")  ## Trying to get the default Audio output to work in ffmpeg ?
                                        xrandr | fgrep '*' > '/tmp/space.txt';
                                        SCREENSIZE=$(cat /tmp/space.txt | awk '{print $1}');
                                        ffmpeg -y -f x11grab -r 25 -s $SCREENSIZE -i $DISPLAY $DESTINATION$REC;
                                        dialog --title "Info" \
                                            --backtitle "$BACKTITLE" \
                                            --infobox "Recording was stopped!" 3 26;
                                            sleep 3;
                                                break 1;
                                        elif [ "$?" -eq 1 ]; then ##Cancel Screen Recording
                                            dialog --title "Cancel" --backtitle "$BACKTITLE" --infobox "cancelled..." 3 15;
                                            sleep 2;
                                            clear;
                                            break 1;
                                        fi
                                        elif [ "$?" -eq 1 ]; then ##NO New Screen recording
                                        clear;
                                        fi
                            elif [ "$?" -eq 1 ]; then ##Okay New Screen recording
                            clear;
                            fi
                    elif [ "$?" -eq 1 ]; then ##Cancel New Screen recording
                        break;
                    fi
                    done
                    ;;
                    esac
                elif [ "$?" -eq 1 ]; then # Cancel Screen Recording
                    break;
                fi
        elif [ "$?" -eq 1 ]; then #ffmpeg not installed
            clear;
            dialog \
            --title "Screen Recording" \
            --backtitle "$BACKTITLE / Screen Recording" \
            --yesno "FFmpeg is not installed.\nDo you want to install FFmpeg?" 6 35;
                if [ "$?" -eq 0 ]; then #Yes Install ffmpeg
                    clear;
                    sudo apt-get install ffmpeg;
                elif [ "$?" -eq 1 ]; then #No Install ffmpeg
                clear;
                dialog --title "Cancel" --backtitle "$BACKTITLE" --infobox "cancelled..." 3 15;
                sleep 1.2;
                break;
                fi
        fi
        done
		;;
		4)
		      while [[ 1 ]]
		      do
			HEIGHT=12
			WIDTH=29
			CHOICE_HEIGHT=3
			BACKTITLE="PMP v.0.0.25 / Extras / Tools / Screensaver"
			TITLE="CLI Screensaver"
			MENU="Select one:"
			OPTIONS=(1 "Pipes"
				2 "Rain"
				3 "Matrix")
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
3)
#!/bin/bash
echo -e "\033[2J\033[?25l"; R=`tput lines` C=`tput cols`;: $[R--] ; while true 
do ( e=echo\ -e s=sleep j=$[RANDOM%C] d=$[RANDOM%R];for i in `eval $e {1..$R}`;
do c=`printf '\\\\0%o' $[RANDOM%57+33]` ### http://bruxy.regnet.cz/web/linux ###
$e "\033[$[i-1];${j}H\033[32m$c\033[$i;${j}H\033[37m"$c; $s 0.1;if [ $i -ge $d ]
then $e "\033[$[i-d];${j}H ";fi;done;for i in `eval $e {$[i-d]..$R}`; #[mat!rix]
do echo -e "\033[$i;${j}f ";$s 0.1;done)& sleep 0.05;done #(c) 2011 -- [ BruXy ]
;;
			esac
		      elif [ "$?" -eq 1 ]; then ##Cancel screensaver
			break;
		      fi
		    done
		      ;;
		      5)
              while [[ 1 ]]
                do
                HEIGHT=14
                WIDTH=28
                CHOICE_HEIGHT=7
                BACKTITLE="PMP v.0.0.25 / Extras / Tools / Themes"
                TITLE="Themes"
                MENU="Select one:"
                OPTIONS=(1 "Default"
                        2 "Dark"
                        3 "Red"
                        4 "Green"
                        5 "Yellow"
                        6 "Cyan"
                        7 "Magenta")
                CHOICE=$(dialog --clear \
                                --backtitle "$BACKTITLE" \
                                --title "$TITLE" \
                                --menu "$MENU" \
                $HEIGHT $WIDTH $CHOICE_HEIGHT \
                "${OPTIONS[@]}" \
                2>&1 >/dev/tty)
                if [ "$?" -eq 0 ]; then ##Okay
                case $CHOICE in
                1)
                rm -r ~/.dialogrc
                ;;
                2)
                dialog --create-rc ~/.dialogrc;cd ~/;
                echo "use_shadow = OFF
                screen_color = (WHITE,BLACK,ON)
                button_active_color = (WHITE,BLUE,ON)
                title_color = (BLUE,WHITE,ON)
                button_label_active_color = (WHITE,BLUE,ON)
                tag_key_selected_color = (WHITE,BLUE,ON)" > .dialogrc
                ;;
                3)
                cd ~/;dialog --create-rc ~/.dialogrc;
                echo "use_shadow = ON
                screen_color = (WHITE,RED,ON)
                button_active_color = (WHITE,BLUE,ON)
                title_color = (BLUE,WHITE,ON)
                button_label_active_color = (YELLOW,BLUE,ON)
                tag_key_selected_color = (WHITE,RED,ON)" > .dialogrc
                ;;
                4)
                cd ~/;dialog --create-rc ~/.dialogrc;
                echo "use_shadow = ON
                screen_color = (WHITE,GREEN,ON)
                button_active_color = (WHITE,BLUE,ON)
                title_color = (BLUE,WHITE,ON)
                button_label_active_color = (YELLOW,BLUE,ON)
                tag_key_selected_color = (WHITE,GREEN,ON)" > .dialogrc
                ;;
                5)
                cd ~/;dialog --create-rc ~/.dialogrc;
                echo "use_shadow = ON
                screen_color = (WHITE,YELLOW,ON)
                button_active_color = (WHITE,BLUE,ON)
                title_color = (BLUE,WHITE,ON)
                button_label_active_color = (YELLOW,BLUE,ON)
                tag_key_selected_color = (WHITE,YELLOW,ON)" > .dialogrc
                ;;
                6)
                cd ~/;dialog --create-rc ~/.dialogrc;
                echo "use_shadow = ON
                screen_color = (WHITE,CYAN,ON)
                button_active_color = (WHITE,BLUE,ON)
                title_color = (BLUE,WHITE,ON)
                button_label_active_color = (YELLOW,BLUE,ON)
                tag_key_selected_color = (WHITE,CYAN,ON)" > .dialogrc
                ;;
                7)
                cd ~/;dialog --create-rc ~/.dialogrc;
                echo "use_shadow = ON
                screen_color = (WHITE,MAGENTA,ON)
                button_active_color = (WHITE,BLUE,ON)
                title_color = (BLUE,WHITE,ON)
                button_label_active_color = (YELLOW,BLUE,ON)
                tag_key_selected_color = (WHITE,MAGENTA,ON)" > .dialogrc
                ;;
                esac
                elif [ "$?" -eq 1 ]; then ##Cancel 
                break;
                fi
                done
                ;;
                6)
                clear;
                telnet mapscii.me ##MapSCII
                ;;
                esac
                elif [ "$?" -eq 1 ]; then ##Cancel Tools
                    break;
                fi
                done
            ;;
	      2)
	      HEIGHT=13
	      WIDTH=29
	      CHOICE_HEIGHT=6
	      BACKTITLE="$BACKTITLE / Games"
	      TITLE="Games"
	      MENU="Select one:"
	      OPTIONS=(1 "HOUSENKA"
		       2 "TetriBash"
		       3 "BashInvaders!"
		       4 "Snake"
		       5 "Arkanoid"
		       6 "About")
	      CHOICE=$(dialog --clear \
                --backtitle "$BACKTITLE" \
                --title "$TITLE" \
                --menu "$MENU" \
                $HEIGHT $WIDTH $CHOICE_HEIGHT \
                "${OPTIONS[@]}" \
                2>&1 >/dev/tty)
                clear;
                if [ "$?" -eq 0 ]; then ##OK Games
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
#!/bin/bash
#-----------------------------------------------------------------------------
# A tetromino stacking game written entirely in BASH script! =D
#
# Because I can...
# 
#-----------------------------------------------------------------------------
# Version 0.1 Beta:
#	- The game is functional
#	- Todo:
#		- Overtime bonus to score after all 10 lines of level 10 are cleared
#		- Highscores
#=============================================================================

#=============================================================================
#-----------------------------------------------------------------------------
# [ Global Variables ]
#-----------------------------------------------------------------------------
#=============================================================================
dialog  \
--title "TetriBash" \
--backtitle "$BACKTITLE / TetriBash" \
--msgbox "Controls are:\n'K' - Select menu item.\n'Q' - quit or back.\n'WASD' - menu nav and block movement.\n'J' and 'L' - rotate piece." 9 42
declare -r TETRIBASHTITLE="TetriBASH"
declare -ri TETRIBASHVERSION=0
declare -ri TETRIBASHSUBVERS=1
declare -r TETRIBASHRELEASE="Beta"
declare -r TETRIBASHDATE="2010 - 2012"
declare -r TETRIBASHINFO="A tetromino stacking game written entirely in"
declare -r TETRIBASHINFO2="BASH script! =D"
declare -r TETRIBASHINFO3="Because I can..."

declare -i TETRIBASHSTATE=0	# Indicates the current game state
declare -i TETRIBASHDEBUG=0	# Value of 1 enables debug mode

declare TIMESTART="0.0" 	# Start time of a frame
declare TIMEEND="0.0"		# End time of a frame
declare DELTATIME="0.0"		# Time elapsed for the frame
declare ACCUMULATOR="0.0"	# Primary gameplay accumulator

declare -ri TERMULT=2	# and chaos		# Multiplier to determin tetromino block width in characters (Do not change!)
declare -ri TERMWIDTH=$(tput cols)		# Character width of the terminal
declare -ri TERMHEIGHT=$(tput lines)	# Character height of the terminal

declare -ri GAMEWIDTH=34											# Width of the game area
declare -ri GAMEOFFSETX=$((($TERMWIDTH / 2) - ($GAMEWIDTH / 2)))	# X offset of the game area
declare -ri GAMEOFFSETY=2											# Y offset of the game area

declare -ri GAMEBLOCKSIZE=4											# Width and height of the game block array
declare -ri GAMEBLOCKAREA=$(($GAMEBLOCKSIZE * $GAMEBLOCKSIZE))		# Size of the game block array

declare -i GAMESCORE=0			# Game score
declare -i GAMESCOREMULTDEF=33	# Score Multiplier Default
declare -i GAMESCOREMULT=33		# Score Multiplier
declare -i GAMESCOREMULTINC=100	# Score Multiplier increase per level
declare -i GAMELEVEL=0			# Game level
declare -i GAMELINES=0			# Number of lines cleared
declare -i GAMELINESPERLEVEL=10	# Number of lines that need to be cleared to advance in level
declare -i GAMELEVELLINES=0		# Number of lines cleared this level	
declare -i GAMEFAILUREMAX=10	# NUmber of blocks to place after failure before showing Game Over message
declare -i GAMEFAILURECOUNT=0	# Number of blocks placed on top of eachother
declare -i GAMEFAILURE=0		# Indicates a game is determined to be lost
declare -i GAMECURRENT=0		# Current active block ID
declare -i GAMECURRENTROT=0		# Current active block rotation
declare -i GAMENEXT=0			# The next block ID
declare -i GAMERUNNING=0		# Indicates the game is running

declare -a GAMECURRENTARRAY		# Current active block array
declare -a GAMENEXTARRAY		# Next block array
declare -a GAMEBLOCKBUFFER		# Current active block rotation buffer

declare -i GAMECLEARINPROGRESS=0	# Indicates a line clear is in progress
declare -i GAMEOVERINPROGRESS=0		# Indicates game over is in progress
declare -i GAMELINESTOCLEAR=0		# Number of lines that need clearing
declare -a GAMELINESBUFFER			# Lists of lines that need clearing
declare -i GAMECLEARANIMFRAMES=3	# Number of frames of clearing animation
declare -r GAMECLEARCHAR=":"

declare -i GAMEBLOCKX=0			# X position of active game block relative to terminal
declare -i GAMEBLOCKY=0			# Y position of active game block relative to terminal		
declare -i GAMEBLOCKAPX=0		# X position of active game block relative to the play area
declare -i GAMEBLOCKAPY=0		# Y position of active game block relative to the play area

declare GAMEINTERVAL="0.5"		# Fall rate in seconds
declare GAMECLEARINTERVAL="0.2"	# Clear rate in seconds
declare GAMEOVERINTERVAL="5.0"	# Game Over message interval in seconds

declare -i FRAMEUPDATED=0		# Indicates drawing has been done in the current frame

declare -ri TBASHW=10									# Width of the play area in blocks
declare -ri TBASHH=20									# Height of the play area in blocks
declare -ri TBASHSIZE=$(($TBASHW * $TBASHH))			# Size of the play area array
declare -ri TBASHAREAOFFSETX=$GAMEOFFSETX				# X offset of play area including border
declare -ri TBASHAREAOFFSETY=$GAMEOFFSETY				# Y offset of play area including border
declare -ri TBASHAREAW=$((($TBASHW * $TERMULT) + 2))	# Width of play area including border
declare -ri TBASHAREAH=$(($TBASHH + 2))					# Height of play area including border
declare -ri TBASHOFFSETX=$(($TBASHAREAOFFSETX + 1))		# X offset of play area
declare -ri TBASHOFFSETY=$(($TBASHAREAOFFSETY + 1))		# Y offset of play area

declare -ri TBASHGAMEOVEROFFSETX=$(($TBASHAREAOFFSETX + 2))
declare -ri TBASHGAMEOVEROFFSETY=$(($TBASHAREAOFFSETY + ($TBASHAREAH / 2) - 2))
declare -ri TBASHGAMEOVERWIDTH=$(($TBASHAREAW - 4))
declare -ri TBASHGAMEOVERHEIGHT=3

declare -ri TBASHSCOREW=10
declare -ri TBASHSCOREH=3
declare -ri TBASHSCOREOFFSETX=$(($TBASHAREAW + 2 + $GAMEOFFSETX))
declare -ri TBASHSCOREOFFSETY=$GAMEOFFSETY
declare -ri TBASHSCOREVALUEX=$(($TBASHSCOREOFFSETX + 1))
declare -ri TBASHSCOREVALUEY=$(($TBASHSCOREOFFSETY + 1))

declare -ri TBASHLEVELW=10
declare -ri TBASHLEVELH=3
declare -ri TBASHLEVELOFFSETX=$(($TBASHAREAW + 2 + $GAMEOFFSETX))
declare -ri TBASHLEVELOFFSETY=$(($GAMEOFFSETY + 1 + $TBASHSCOREH))
declare -ri TBASHLEVELVALUEX=$(($TBASHLEVELOFFSETX + 1))
declare -ri TBASHLEVELVALUEY=$(($TBASHLEVELOFFSETY + 1))

declare -ri TBASHLINESW=10
declare -ri TBASHLINESH=3
declare -ri TBASHLINESOFFSETX=$(($TBASHAREAW + 2 + $GAMEOFFSETX))
declare -ri TBASHLINESOFFSETY=$(($GAMEOFFSETY + 1 + $TBASHSCOREH + 1 + $TBASHLEVELH))
declare -ri TBASHLINESVALUEX=$(($TBASHLINESOFFSETX + 1))
declare -ri TBASHLINESVALUEY=$(($TBASHLINESOFFSETY + 1))

declare -ri TBASHNEXTW=10
declare -ri TBASHNEXTH=6
declare -ri TBASHNEXTOFFSETX=$(($TBASHAREAW + 2 + $GAMEOFFSETX))
declare -ri TBASHNEXTOFFSETY=$(($GAMEOFFSETY + $TBASHAREAH - $TBASHNEXTH))
declare -ri TBASHNEXTVALUEX=$(($TBASHNEXTOFFSETX + 1))
declare -ri TBASHNEXTVALUEY=$(($TBASHNEXTOFFSETY + 1))

declare -ri MAINTITLEW=49
declare -ri MAINTITLEH=5
declare -ri MAINTITLEX=$((($TERMWIDTH / 2) - ($MAINTITLEW / 2)))
declare -ri MAINTITLEY=1
declare -r MAINTITLELINE1="\e[0;31m  ______      __       _ ____  ___   _____ __  __\e[0m"
declare -r MAINTITLELINE2="\e[1;31m /_  __/___  / /______(_) __ )/   | / ___// / / /\e[0m"
declare -r MAINTITLELINE3="\e[0;33m  / /  / _ \\/ __/ ___/ / __  / /| | \\__ \\/ /_/ / \e[0m"
declare -r MAINTITLELINE4="\e[1;33m / /  /  __/ /_/ /  / / /_/ / ___ |___/ / __  /  \e[0m"
declare -r MAINTITLELINE5="\e[1;37m/_/   \\___/\\__/_/  /_/_____/_/  |_/____/_/ /_/   \e[0m"

declare -ri TBASHABOUTW=49
declare -ri TBASHABOUTH=7
declare -ri TBASHABOUTX=$((($TERMWIDTH / 2) - ($TBASHABOUTW / 2)))
declare -ri TBASHABOUTY=$(($MAINTITLEH + 5))

declare -ri MAINMENUW=15
declare -ri MAINMENUH=4
declare -ri MAINMENUX=$((($TERMWIDTH / 2) - ($MAINMENUW / 2)))
declare -ri MAINMENUY=$(($MAINTITLEH + $MAINTITLEY + 3))
declare -ri MAINMENUITEMCOUNT=4
declare -a MAINMENUITEMS
MAINMENUITEMS[0]="New Game\e[0m"
MAINMENUITEMS[1]="High Scores\e[0m"
MAINMENUITEMS[2]="About\e[0m"
MAINMENUITEMS[3]="Exit\e[0m"
declare -a MAINMENUITEMY
MAINMENUITEMY[0]=$MAINMENUY
MAINMENUITEMY[1]=$(($MAINMENUY + 2))
MAINMENUITEMY[2]=$(($MAINMENUY + 4))
MAINMENUITEMY[3]=$(($MAINMENUY + 6))
declare -i MAINMENUSELECTION=0
declare -r MAINMENUITEMNOTSEL="    \e[0;33m"
declare -r MAINMENUITEMSELECT="\e[1;37m??> \e[1;33m"

declare -ri MENUBOTTOMDECORX=$MAINTITLEX
declare -ri MENUBOTTOMDECORY=$(($TERMHEIGHT - 5))

declare -r SCREENINFOSTRING=$(printf "%s %d.%d %s" "$TETRIBASHTITLE" $TETRIBASHVERSION $TETRIBASHSUBVERS "$TETRIBASHRELEASE")
declare -ri SCREENINFOSTRINGX=$((($TERMWIDTH / 2) - (${#SCREENINFOSTRING} / 2)))
declare -ri SCREENINFOSTRINGY=$(($TERMHEIGHT - 1))

declare -r BH="?"
declare -r BV="?"
declare -r BTL="?"
declare -r BTR="?"
declare -r BBL="?"
declare -r BBR="?"

declare -r BLK1="\e[43m\e[1;33m[]"
declare -r BLK2="\e[42m\e[1;32m()"
declare -r BLK3="\e[46m\e[1;36m::"
declare -r BLK4="\e[41m\e[1;31m[]"
declare -r BLK5="\e[44m\e[1;34m{}"
declare -r BLK6="\e[47m\e[1;37m++"
declare -r BLK7="\e[45m\e[1;35m<>"

declare -a TBASHARRAY

#================================== Block 1 ==================================
declare -a BLK1ARRAY=(0 0 0 0 1 1 1 0 0 1 0 0 0 0 0 0)
declare -a BLK1ARRAYR2=(0 1 0 0 1 1 0 0 0 1 0 0 0 0 0 0)
declare -a BLK1ARRAYR3=(0 1 0 0 1 1 1 0 0 0 0 0 0 0 0 0)
declare -a BLK1ARRAYR4=(0 1 0 0 0 1 1 0 0 1 0 0 0 0 0 0)

#================================== Block 2 ==================================
declare -a BLK2ARRAY=(0 0 0 0 0 2 2 0 0 2 2 0 0 0 0 0)

#================================== Block 3 ==================================
declare -a BLK3ARRAY=(0 0 0 0 3 3 3 3 0 0 0 0 0 0 0 0)
declare -a BLK3ARRAYR2=(0 0 3 0 0 0 3 0 0 0 3 0 0 0 3 0)
declare -a BLK3ARRAYR3=(0 3 0 0 0 3 0 0 0 3 0 0 0 3 0 0)

#================================== Block 4 ==================================
declare -a BLK4ARRAY=(0 0 0 0 4 4 0 0 0 4 4 0 0 0 0 0)
declare -a BLK4ARRAYR2=(0 4 0 0 4 4 0 0 4 0 0 0 0 0 0 0)

#================================== Block 5 ==================================
declare -a BLK5ARRAY=(0 0 0 0 0 5 5 0 5 5 0 0 0 0 0 0)
declare -a BLK5ARRAYR2=(5 0 0 0 5 5 0 0 0 5 0 0 0 0 0 0)

#================================== Block 6 ==================================
declare -a BLK6ARRAY=(0 0 0 0 6 6 6 0 0 0 6 0 0 0 0 0)
declare -a BLK6ARRAYR2=(0 6 0 0 0 6 0 0 6 6 0 0 0 0 0 0)
declare -a BLK6ARRAYR3=(6 0 0 0 6 6 6 0 0 0 0 0 0 0 0 0)
declare -a BLK6ARRAYR4=(0 6 6 0 0 6 0 0 0 6 0 0 0 0 0 0)

#================================== Block 7 ==================================
declare -a BLK7ARRAY=(0 0 0 0 7 7 7 0 7 0 0 0 0 0 0 0)
declare -a BLK7ARRAYR2=(7 7 0 0 0 7 0 0 0 7 0 0 0 0 0 0)
declare -a BLK7ARRAYR3=(0 0 7 0 7 7 7 0 0 0 0 0 0 0 0 0)
declare -a BLK7ARRAYR4=(0 7 0 0 0 7 0 0 0 7 7 0 0 0 0 0)

#=============================================================================
#-----------------------------------------------------------------------------
# [ Function Declarations ]
#-----------------------------------------------------------------------------
#=============================================================================
function ZeroTetriBashArray()
{
	for((i=0; i<TBASHSIZE; i++)); do
	{
		TBASHARRAY[$i]=0
	}
	done
}

function GameOverClearTetriBashArray()
{
	for((i=0; i<TBASHSIZE; i++)); do
	{
		TBASHARRAY[$i]=8
	}
	done
}

function ZeroBlockBuffer()
{
	for((i=0; i<GAMEBLOCKAREA; i++)); do
	{
		GAMEBLOCKBUFFER[$i]=0
	}
	done
}

function ZeroLinesBuffer()
{
	for((i=0; i<TBASHH; i++)); do
	{
		GAMELINESBUFFER[$i]=0
	}
	done
}

function DrawBorder()
{
	if [ -z "$1" ] || [ -z "$2" ] || [ -z "$3" ] || [ -z "$4" ]; then
	{
		return 1
	}
	fi

	local BWIDTH=$(($3 - 2))
	local BHEIGHT=$(($4 - 2))
	local BVERTVPOS=$(($2 + 1))
	local BVERTHPOS=$1

	printf "\e[%d;%dH${BTL}" $2 $1

	for((i=0; i<BWIDTH; i++)); do
	{
		printf "${BH}"
	}
	done

	printf "${BTR}"

	for((i=0; i<BHEIGHT; i++)); do
	{
		printf "\e[%d;%dH${BV}" $BVERTVPOS $BVERTHPOS
		BVERTVPOS=$(($BVERTVPOS + 1))
	}
	done

	BVERTVPOS=$(($2 + 1))
	BVERTHPOS=$(($1 + $3 - 1))

	for((i=0; i<BHEIGHT; i++)); do
	{
		printf "\e[%d;%dH${BV}" $BVERTVPOS $BVERTHPOS
		BVERTVPOS=$(($BVERTVPOS + 1))
	}
	done

	printf "\e[%d;%dH${BBL}" $(($2 + $4 - 1)) $1
	
	for((i=0; i<BWIDTH; i++)); do
	{
		printf "${BH}"
	}
	done

	printf "${BBR}"

	return 0
}

function DrawTetriBashArray()
{
	local BLAPOS=0

	for((i=0; i<TBASHH; i++)); do
	{
		for((j=0; j<TBASHW; j++)); do
		{
			BLAPOS=$((($i * $TBASHW) + $j))
			
			case ${TBASHARRAY[$BLAPOS]} in
				1) printf "\e[%d;%dH${BLK1}\e[0m" $(($TBASHOFFSETY + $i)) $(($TBASHOFFSETX + ($j * 2)));;
				2) printf "\e[%d;%dH${BLK2}\e[0m" $(($TBASHOFFSETY + $i)) $(($TBASHOFFSETX + ($j * 2)));;
				3) printf "\e[%d;%dH${BLK3}\e[0m" $(($TBASHOFFSETY + $i)) $(($TBASHOFFSETX + ($j * 2)));;
				4) printf "\e[%d;%dH${BLK4}\e[0m" $(($TBASHOFFSETY + $i)) $(($TBASHOFFSETX + ($j * 2)));;
				5) printf "\e[%d;%dH${BLK5}\e[0m" $(($TBASHOFFSETY + $i)) $(($TBASHOFFSETX + ($j * 2)));;
				6) printf "\e[%d;%dH${BLK6}\e[0m" $(($TBASHOFFSETY + $i)) $(($TBASHOFFSETX + ($j * 2)));;
				7) printf "\e[%d;%dH${BLK7}\e[0m" $(($TBASHOFFSETY + $i)) $(($TBASHOFFSETX + ($j * 2)));;
				8) printf "\e[%d;%dH::\e[0m" $(($TBASHOFFSETY + $i)) $(($TBASHOFFSETX + ($j * 2)));;
			esac
		}
		done
	}
	done

	FRAMEUPDATED=1
}

function DrawTetriBashArrayEx()
{
	local BLAPOS=0

	for((i=0; i<TBASHH; i++)); do
	{
		for((j=0; j<TBASHW; j++)); do
		{
			BLAPOS=$((($i * $TBASHW) + $j))
			
			case ${TBASHARRAY[$BLAPOS]} in
				0) printf "\e[%d;%dH  \e[0m" $(($TBASHOFFSETY + $i)) $(($TBASHOFFSETX + ($j * 2)));;
				1) printf "\e[%d;%dH${BLK1}\e[0m" $(($TBASHOFFSETY + $i)) $(($TBASHOFFSETX + ($j * 2)));;
				2) printf "\e[%d;%dH${BLK2}\e[0m" $(($TBASHOFFSETY + $i)) $(($TBASHOFFSETX + ($j * 2)));;
				3) printf "\e[%d;%dH${BLK3}\e[0m" $(($TBASHOFFSETY + $i)) $(($TBASHOFFSETX + ($j * 2)));;
				4) printf "\e[%d;%dH${BLK4}\e[0m" $(($TBASHOFFSETY + $i)) $(($TBASHOFFSETX + ($j * 2)));;
				5) printf "\e[%d;%dH${BLK5}\e[0m" $(($TBASHOFFSETY + $i)) $(($TBASHOFFSETX + ($j * 2)));;
				6) printf "\e[%d;%dH${BLK6}\e[0m" $(($TBASHOFFSETY + $i)) $(($TBASHOFFSETX + ($j * 2)));;
				7) printf "\e[%d;%dH${BLK7}\e[0m" $(($TBASHOFFSETY + $i)) $(($TBASHOFFSETX + ($j * 2)));;
			esac
		}
		done
	}
	done

	FRAMEUPDATED=1
}

function HUDDrawArea()
{
	DrawBorder $TBASHAREAOFFSETX $TBASHAREAOFFSETY $TBASHAREAW $TBASHAREAH
	FRAMEUPDATED=1
}

function HUDDrawGameOver()
{
	DrawBorder $TBASHGAMEOVEROFFSETX $TBASHGAMEOVEROFFSETY $TBASHGAMEOVERWIDTH $TBASHGAMEOVERHEIGHT
	printf "\e[%d;%dH\e[1;31m   Game Over!   \e[0m" $(($TBASHGAMEOVEROFFSETY + 1)) $(($TBASHGAMEOVEROFFSETX + 1))
	FRAMEUPDATED=1
}

function HUDDrawScore()
{
	DrawBorder $TBASHSCOREOFFSETX $TBASHSCOREOFFSETY $TBASHSCOREW $TBASHSCOREH
	printf "\e[%d;%dH\e[1;33mScore\e[0m" $(($TBASHSCOREOFFSETY + 0)) $(($TBASHSCOREOFFSETX + 2))
	FRAMEUPDATED=1
}

function HUDDrawLevel()
{
	DrawBorder $TBASHLEVELOFFSETX $TBASHLEVELOFFSETY $TBASHLEVELW $TBASHLEVELH
	printf "\e[%d;%dH\e[1;33mLevel\e[0m" $(($TBASHLEVELOFFSETY + 0)) $(($TBASHLEVELOFFSETX + 2))
	FRAMEUPDATED=1
}

function HUDDrawLines()
{
	DrawBorder $TBASHLINESOFFSETX $TBASHLINESOFFSETY $TBASHLINESW $TBASHLINESH
	printf "\e[%d;%dH\e[1;33mLines\e[0m" $(($TBASHLINESOFFSETY + 0)) $(($TBASHLINESOFFSETX + 2))
	FRAMEUPDATED=1
}

function HUDDrawNext()
{
	DrawBorder $TBASHNEXTOFFSETX $TBASHNEXTOFFSETY $TBASHNEXTW $TBASHNEXTH
	printf "\e[%d;%dH\e[1;33mNext\e[0m" $(($TBASHNEXTOFFSETY + 0)) $(($TBASHNEXTOFFSETX + 2))
	FRAMEUPDATED=1
}

function HUDUpdateScore()
{
	printf "\e[%d;%dH\e[1;36m%d\e[0m" $TBASHSCOREVALUEY $TBASHSCOREVALUEX $GAMESCORE
	FRAMEUPDATED=1
}

function HUDUpdateLevel()
{
	printf "\e[%d;%dH\e[1;36m%d\e[0m" $TBASHLEVELVALUEY $TBASHLEVELVALUEX $GAMELEVEL
	FRAMEUPDATED=1
}

function HUDUpdateLines()
{
	printf "\e[%d;%dH\e[1;36m%d\e[0m" $TBASHLINESVALUEY $TBASHLINESVALUEX $GAMELINES
	FRAMEUPDATED=1
}

function HUDUpdateNext()
{
	local BLAPOS=0;
	local VY=$TBASHNEXTVALUEY;

	case $GAMENEXT in
		0) GAMENEXTARRAY=("${BLK1ARRAY[@]}");;
		1) GAMENEXTARRAY=("${BLK2ARRAY[@]}");;
		2) GAMENEXTARRAY=("${BLK3ARRAY[@]}");;
		3) GAMENEXTARRAY=("${BLK4ARRAY[@]}");;
		4) GAMENEXTARRAY=("${BLK5ARRAY[@]}");;
		5) GAMENEXTARRAY=("${BLK6ARRAY[@]}");;
		6) GAMENEXTARRAY=("${BLK7ARRAY[@]}");;
	esac

	printf "\e[%d;%dH" $TBASHNEXTVALUEY $TBASHNEXTVALUEX

	for((i=0; i<GAMEBLOCKSIZE; i++)); do
	{
		for((j=0; j<GAMEBLOCKSIZE; j++)); do
		{
			BLAPOS=$((($i * $GAMEBLOCKSIZE) + $j))
			
			case ${GAMENEXTARRAY[$BLAPOS]} in
				0) printf "\e[0m  ";;
				1) printf "${BLK1}";;
				2) printf "${BLK2}";;
				3) printf "${BLK3}";;
				4) printf "${BLK4}";;
				5) printf "${BLK5}";;
				6) printf "${BLK6}";;
				7) printf "${BLK7}";;
				*) printf "\e[0m  ";;
			esac
		}
		done
		
		VY=$(($VY + 1))
		printf "\e[%d;%dH" $VY $TBASHNEXTVALUEX
	}
	done

	FRAMEUPDATED=1
}

function DrawTetriBashHUD()
{
	HUDDrawArea
	HUDDrawScore
	HUDDrawLevel
	HUDDrawLines
	HUDDrawNext

	HUDUpdateScore
	HUDUpdateLevel
	HUDUpdateLines
	HUDUpdateNext

	FRAMEUPDATED=1
}

function FillArrayDemoBlocks()
{
	TBASHARRAY[15]=1
	TBASHARRAY[16]=1
	TBASHARRAY[17]=1
	TBASHARRAY[26]=1
	TBASHARRAY[21]=2
	TBASHARRAY[22]=2
	TBASHARRAY[31]=2
	TBASHARRAY[32]=2
	TBASHARRAY[38]=3
	TBASHARRAY[48]=3
	TBASHARRAY[58]=3
	TBASHARRAY[68]=3
	TBASHARRAY[51]=4
	TBASHARRAY[52]=4
	TBASHARRAY[62]=4
	TBASHARRAY[63]=4
	TBASHARRAY[75]=5
	TBASHARRAY[76]=5
	TBASHARRAY[84]=5
	TBASHARRAY[85]=5
	TBASHARRAY[103]=6
	TBASHARRAY[113]=6
	TBASHARRAY[114]=6
	TBASHARRAY[115]=6
	TBASHARRAY[138]=7
	TBASHARRAY[146]=7
	TBASHARRAY[147]=7
	TBASHARRAY[148]=7
}

function DrawTetriBashTitle()
{
	printf "\e[%d;%dH${MAINTITLELINE1}" $MAINTITLEY $MAINTITLEX
	printf "\e[%d;%dH${MAINTITLELINE2}" $(($MAINTITLEY + 1)) $MAINTITLEX
	printf "\e[%d;%dH${MAINTITLELINE3}" $(($MAINTITLEY + 2)) $MAINTITLEX
	printf "\e[%d;%dH${MAINTITLELINE4}" $(($MAINTITLEY + 3)) $MAINTITLEX
	printf "\e[%d;%dH${MAINTITLELINE5}" $(($MAINTITLEY + 4)) $MAINTITLEX
	FRAMEUPDATED=1
}

function DrawTetriBashMenuDecor()
{
	printf "\e[%d;%dH \e[0m" $MENUBOTTOMDECORY $MENUBOTTOMDECORX
	printf "\e[%d;%dH \e[0m" $(($MENUBOTTOMDECORY + 1)) $MENUBOTTOMDECORX
	printf "\e[%d;%dH \e[0m" $(($MENUBOTTOMDECORY + 2)) $MENUBOTTOMDECORX
	printf "\e[%d;%dH \e[0m" $(($MENUBOTTOMDECORY + 3)) $MENUBOTTOMDECORX
	FRAMEUPDATED=1
}

function DrawTetriBashVersionString()
{
	printf "\e[%d;%dH%s\e[0m" $SCREENINFOSTRINGY $SCREENINFOSTRINGX "$SCREENINFOSTRING"
	FRAMEUPDATED=1
}

function DrawTetriBashMainMenu()
{
	for((i=0; i<MAINMENUITEMCOUNT; i++)); do
	{
		if [ $i -eq $MAINMENUSELECTION ]; then
		{
			printf "\e[%d;%dH${MAINMENUITEMSELECT}${MAINMENUITEMS[$i]}" ${MAINMENUITEMY[$i]} $MAINMENUX
		}
		else
		{
			printf "\e[%d;%dH${MAINMENUITEMNOTSEL}${MAINMENUITEMS[$i]}" ${MAINMENUITEMY[$i]} $MAINMENUX
		}
		fi
	}
	done
	
	FRAMEUPDATED=1
}

function SetMainMenuSelection()
{
	if [ -z "$1" ]; then
	{
		return 1
	}
	fi
	
	if [ $1 -lt 0 ] || [ $1 -ge $MAINMENUITEMCOUNT ]; then
	{
		return 1
	}
	fi

	if [ $1 -eq $MAINMENUSELECTION ]; then
	{
		return 0
	}
	fi
	
	printf "\e[%d;%dH${MAINMENUITEMNOTSEL}${MAINMENUITEMS[$MAINMENUSELECTION]}" ${MAINMENUITEMY[$MAINMENUSELECTION]} $MAINMENUX
	MAINMENUSELECTION=$1
	printf "\e[%d;%dH${MAINMENUITEMSELECT}${MAINMENUITEMS[$MAINMENUSELECTION]}" ${MAINMENUITEMY[$MAINMENUSELECTION]} $MAINMENUX
	FRAMEUPDATED=1

	return 0
}

function ChangeMainMenuSelectionUp()
{
	local NEXTITEM=$MAINMENUSELECTION
	
	if [ $NEXTITEM -eq 0 ]; then
	{
		NEXTITEM=$(($MAINMENUITEMCOUNT - 1))
	}
	else
	{
		NEXTITEM=$(($NEXTITEM - 1))
	}
	fi
	
	SetMainMenuSelection $NEXTITEM
}

function ChangeMainMenuSelectionDown()
{
	local NEXTITEM=$MAINMENUSELECTION
	
	if [ $NEXTITEM -eq $(($MAINMENUITEMCOUNT - 1)) ]; then
	{
		NEXTITEM=0
	}
	else
	{
		NEXTITEM=$(($NEXTITEM + 1))
	}
	fi
	
	SetMainMenuSelection $NEXTITEM
}

function GameSetCurrentBlock()
{
	case $GAMECURRENT in
		0) GAMECURRENTARRAY=("${BLK1ARRAY[@]}");;
		1) GAMECURRENTARRAY=("${BLK2ARRAY[@]}");;
		2) GAMECURRENTARRAY=("${BLK3ARRAY[@]}");;
		3) GAMECURRENTARRAY=("${BLK4ARRAY[@]}");;
		4) GAMECURRENTARRAY=("${BLK5ARRAY[@]}");;
		5) GAMECURRENTARRAY=("${BLK6ARRAY[@]}");;
		6) GAMECURRENTARRAY=("${BLK7ARRAY[@]}");;
	esac

	GAMEBLOCKX=$(($TBASHOFFSETX + ($GAMEBLOCKSIZE * 2) - 2))
	GAMEBLOCKY=$TBASHOFFSETY
	GAMEBLOCKAPX=3
	GAMEBLOCKAPY=0
}

function GameDrawCurrentBlock()
{
	local BLAPOS=0

	for((i=0; i<GAMEBLOCKSIZE; i++)); do
	{
		for((j=0; j<GAMEBLOCKSIZE; j++)); do
		{
			BLAPOS=$((($i * $GAMEBLOCKSIZE) + $j))
			
			case ${GAMECURRENTARRAY[$BLAPOS]} in
				1) printf "\e[%d;%dH${BLK1}\e[0m\e[1;1H" $(($GAMEBLOCKY + $i)) $(($GAMEBLOCKX + ($j * 2)));;
				2) printf "\e[%d;%dH${BLK2}\e[0m\e[1;1H" $(($GAMEBLOCKY + $i)) $(($GAMEBLOCKX + ($j * 2)));;
				3) printf "\e[%d;%dH${BLK3}\e[0m\e[1;1H" $(($GAMEBLOCKY + $i)) $(($GAMEBLOCKX + ($j * 2)));;
				4) printf "\e[%d;%dH${BLK4}\e[0m\e[1;1H" $(($GAMEBLOCKY + $i)) $(($GAMEBLOCKX + ($j * 2)));;
				5) printf "\e[%d;%dH${BLK5}\e[0m\e[1;1H" $(($GAMEBLOCKY + $i)) $(($GAMEBLOCKX + ($j * 2)));;
				6) printf "\e[%d;%dH${BLK6}\e[0m\e[1;1H" $(($GAMEBLOCKY + $i)) $(($GAMEBLOCKX + ($j * 2)));;
				7) printf "\e[%d;%dH${BLK7}\e[0m\e[1;1H" $(($GAMEBLOCKY + $i)) $(($GAMEBLOCKX + ($j * 2)));;
			esac
		}
		done
	}
	done

	FRAMEUPDATED=1
}

function GameClearCurrentBlock()
{
	local BLAPOS=0

	for((i=0; i<GAMEBLOCKSIZE; i++)); do
	{
		for((j=0; j<GAMEBLOCKSIZE; j++)); do
		{
			BLAPOS=$((($i * $GAMEBLOCKSIZE) + $j))
			
			case ${GAMECURRENTARRAY[$BLAPOS]} in
				1) printf "\e[%d;%dH\e[0m  \e[1;1H" $(($GAMEBLOCKY + $i)) $(($GAMEBLOCKX + ($j * 2)));;
				2) printf "\e[%d;%dH\e[0m  \e[1;1H" $(($GAMEBLOCKY + $i)) $(($GAMEBLOCKX + ($j * 2)));;
				3) printf "\e[%d;%dH\e[0m  \e[1;1H" $(($GAMEBLOCKY + $i)) $(($GAMEBLOCKX + ($j * 2)));;
				4) printf "\e[%d;%dH\e[0m  \e[1;1H" $(($GAMEBLOCKY + $i)) $(($GAMEBLOCKX + ($j * 2)));;
				5) printf "\e[%d;%dH\e[0m  \e[1;1H" $(($GAMEBLOCKY + $i)) $(($GAMEBLOCKX + ($j * 2)));;
				6) printf "\e[%d;%dH\e[0m  \e[1;1H" $(($GAMEBLOCKY + $i)) $(($GAMEBLOCKX + ($j * 2)));;
				7) printf "\e[%d;%dH\e[0m  \e[1;1H" $(($GAMEBLOCKY + $i)) $(($GAMEBLOCKX + ($j * 2)));;
			esac
		}
		done
	}
	done

	FRAMEUPDATED=1
}

function GameGenerateBlock()
{
	GAMECURRENTROT=0
	GAMECURRENT=$GAMENEXT
	GAMENEXT=$(($RANDOM % 7))
	GameSetCurrentBlock
	GameDrawCurrentBlock
	HUDUpdateNext
}

function GameCommitBlock()
{
	local BLAPOS=0
	local BLKX=0
	local BLKY=0

	for((i=0; i<GAMEBLOCKSIZE; i++)); do
	{
		for((j=0; j<GAMEBLOCKSIZE; j++)); do
		{
			BLAPOS=$((($i * $GAMEBLOCKSIZE) + $j))			
			BLKX=$(($j + $GAMEBLOCKAPX))			
			BLKY=$(($i + $GAMEBLOCKAPY))			

			if [ $BLKX -lt 0 ] || [ $BLKX -gt $(($TBASHW - 1)) ]; then
			{
				continue
			}
			fi
			
			if [ $BLKY -gt $(($TBASHH - 1)) ]; then
			{
				continue	
			}
			fi

			if [ ${GAMECURRENTARRAY[$BLAPOS]} -gt 0 ]; then
			{
				if [ ${TBASHARRAY[$((($BLKY * $TBASHW) + $BLKX))]} -gt 0 ]; then
				{
					GAMEFAILURE=1
				}
				fi

				TBASHARRAY[$((($BLKY * $TBASHW) + $BLKX))]=${GAMECURRENTARRAY[$BLAPOS]}
			}
			fi
		}
		done
	}
	done
	
	if [ $GAMEFAILURE -eq 0 ]; then
	{
		GAMESCORE=$(($GAMESCORE + 1))
		HUDUpdateScore
	}
	fi
}

function GameEraseLine()
{
	local BLAPOS=0
	local YPOSSTART=0

	if [ -z "$1" ]; then
	{
		return 0
	}
	fi

	YPOSSTART=$1

	if [ $1 -gt $(($TBASHH - 1)) ]; then
	{
		return 0
	}
	fi

	for((k=YPOSSTART; k>0; k--)); do
	{
		for((j=0; j<TBASHW; j++)); do
		{
			BLAPOS=$((($k * $TBASHW) + $j))
			TBASHARRAY[$BLAPOS]=${TBASHARRAY[$(($BLAPOS - $TBASHW))]}
		}
		done
	}
	done

	return 1
}

function GameClearLines()
{
	local BLAPOS=0

	for((i=0; i<GAMELINESTOCLEAR; i++)); do
	{
		GameEraseLine ${GAMELINESBUFFER[$i]}
	}
	done

	DrawTetriBashArrayEx
	GAMESCORE=$(($GAMESCORE + (($GAMELINESTOCLEAR * ($GAMELEVEL + 1)) * ($GAMESCOREMULT * ($GAMELEVEL + 1)))))
	GAMELINES=$(($GAMELINES + $GAMELINESTOCLEAR))
	GAMELEVELLINES=$(($GAMELEVELLINES + $GAMELINESTOCLEAR))	
	if [ $GAMELEVELLINES -ge $GAMELINESPERLEVEL ] && [ $GAMELEVEL -lt 10 ]; then
	{
		GAMELEVELLINES=$(($GAMELEVELLINES - $GAMELINESPERLEVEL))
		GAMELEVEL=$(($GAMELEVEL + 1))
		GAMESCOREMULT=$(($GAMESCOREMULTDEF + ($GAMELEVEL * $GAMESCOREMULTINC)))
		GAMEINTERVAL=$(echo "$GAMEINTERVAL - 0.03" | bc)
		HUDUpdateLevel
	}
	fi
	HUDUpdateScore
	HUDUpdateLines
}

function GameDetectLines()
{
	local BLAPOS=0
	local BLKCOUNT=0
	local LINECLEARS=0

	ZeroLinesBuffer	
	
	for((i=0; i<TBASHH; i++)); do
	{
		BLKCOUNT=0
		for((j=0; j<TBASHW; j++)); do
		{
			BLAPOS=$((($i * $TBASHW) + $j))
			
			if [ ${TBASHARRAY[$BLAPOS]} -gt 0 ]; then
			{
				BLKCOUNT=$(($BLKCOUNT + 1))
			}
			fi
		}
		done
		
		if [ $BLKCOUNT -eq $TBASHW ]; then
		{
			GAMELINESBUFFER[$LINECLEARS]=$i
			LINECLEARS=$(($LINECLEARS + 1))
		}
		fi
	}
	done

	if [ $LINECLEARS -gt 0 ]; then
	{
		GAMELINESTOCLEAR=$LINECLEARS
		GAMECLEARINPROGRESS=1
		ACCUMULATOR="0.0"
		GameDrawLineClear
		return 1
	}
	fi

	return 0
}

function GameDrawLineClear()
{
	local BLAPOS=0

	for((i=0; i<GAMELINESTOCLEAR; i++)); do
	{
		for((j=0; j<TBASHW; j++)); do
		{
			BLAPOS=$(((${GAMELINESBUFFER[$i]} * $TBASHW) + $j))
			printf "\e[%d;%dH${GAMECLEARCHAR}${GAMECLEARCHAR}\e[0m" $(($TBASHOFFSETY + ${GAMELINESBUFFER[$i]})) $(($TBASHOFFSETX + ($j * 2)))
		}
		done
	}
	done
	
	FRAMEUPDATED=1
}

function GameCheckMoveLeft()
{
	local BLAPOS=0
	local BLKX=0
	local BLKY=0

	for((i=0; i<GAMEBLOCKSIZE; i++)); do
	{
		for((j=0; j<GAMEBLOCKSIZE; j++)); do
		{
			BLAPOS=$((($i * $GAMEBLOCKSIZE) + $j))			
			BLKX=$(($j + $GAMEBLOCKAPX))			
			BLKY=$(($i + $GAMEBLOCKAPY))			

			if [ $BLKX -lt 0 ] || [ $BLKX -gt $(($TBASHW - 1)) ]; then
			{
				continue
			}
			fi

			if [ ${GAMECURRENTARRAY[$BLAPOS]} -gt 0 ]; then
			{
				
				if [ $(($BLKX - 1)) -lt 0 ]; then
				{
					return 0
				}
				fi

				if [ ${TBASHARRAY[$((($BLKY * $TBASHW) + $BLKX - 1))]} -gt 0 ]; then
				{
					return 0
				}
				fi
			}
			fi
		}
		done
	}
	done

	return 1
}

function GameCheckMoveRight()
{
	local BLAPOS=0
	local BLKX=0
	local BLKY=0

	for((i=0; i<GAMEBLOCKSIZE; i++)); do
	{
		for((j=0; j<GAMEBLOCKSIZE; j++)); do
		{
			BLAPOS=$((($i * $GAMEBLOCKSIZE) + $j))			
			BLKX=$(($j + $GAMEBLOCKAPX))			
			BLKY=$(($i + $GAMEBLOCKAPY))			

			if [ $BLKX -lt 0 ] || [ $BLKX -gt $(($TBASHW - 1)) ]; then
			{
				continue
			}
			fi

			if [ ${GAMECURRENTARRAY[$BLAPOS]} -gt 0 ]; then
			{
				
				if [ $(($BLKX + 1)) -gt $(($TBASHW - 1)) ]; then
				{
					return 0
				}
				fi
				
				if [ ${TBASHARRAY[$((($BLKY * $TBASHW) + $BLKX + 1))]} -gt 0 ]; then
				{
					return 0
				}
				fi
			}
			fi
		}
		done
	}
	done

	return 1
}

function GameCheckMoveDown()
{
	local BLAPOS=0
	local BLKX=0
	local BLKY=0

	for((i=0; i<GAMEBLOCKSIZE; i++)); do
	{
		for((j=0; j<GAMEBLOCKSIZE; j++)); do
		{
			BLAPOS=$((($i * $GAMEBLOCKSIZE) + $j))			
			BLKX=$(($j + $GAMEBLOCKAPX))			
			BLKY=$(($i + $GAMEBLOCKAPY))			

			if [ $BLKX -lt 0 ] || [ $BLKX -gt $(($TBASHW - 1)) ]; then
			{
				continue
			}
			fi

			if [ ${GAMECURRENTARRAY[$BLAPOS]} -gt 0 ]; then
			{	
				if [ $(($BLAPOS + $GAMEBLOCKSIZE)) -lt $GAMEBLOCKAREA ]; then
				{
					if [ ${GAMECURRENTARRAY[$(($BLAPOS + $GAMEBLOCKSIZE))]} -gt 0 ]; then
					{
						continue
					}
					fi
				}
				fi

				if [ $(($BLKY + 1)) -gt $(($TBASHH - 1)) ]; then
				{
					return 0
				}
				fi

				if [ ${TBASHARRAY[$((($BLKY * $TBASHW) + $BLKX + $TBASHW))]} -gt 0 ]; then
				{
					return 0
				}
				fi
			}
			fi
		}
		done
	}
	done

	return 1
}

function GameMoveBlockLeft()
{
	GameCheckMoveLeft
	if [ $? -eq 1 ]; then
	{
		GameClearCurrentBlock
		GAMEBLOCKAPX=$(($GAMEBLOCKAPX - 1))
		GAMEBLOCKX=$(($GAMEBLOCKX - 2))
		GameDrawCurrentBlock
	}
	fi
}

function GameMoveBlockRight()
{
	GameCheckMoveRight
	if [ $? -eq 1 ]; then
	{
		GameClearCurrentBlock
		GAMEBLOCKAPX=$(($GAMEBLOCKAPX + 1))
		GAMEBLOCKX=$(($GAMEBLOCKX + 2))
		GameDrawCurrentBlock
	}
	fi
}

function GameMoveBlockDown()
{
	if [ ! -z "$1" ]; then
	{
		if [ $1 -eq 1 ]; then
		{
			if [ $GAMEFAILURE -eq 0 ]; then
			{
				ACCUMULATOR="0.0"
			}
			else
			{
				return
			}
			fi
		}
		fi
	}
	fi

	GameCheckMoveDown
	if [ $? -eq 1 ]; then
	{
		GameClearCurrentBlock
		GAMEBLOCKAPY=$(($GAMEBLOCKAPY + 1))
		GAMEBLOCKY=$(($GAMEBLOCKY + 1))
		GameDrawCurrentBlock
	}
	else
	{
		GameCommitBlock
		GameDetectLines
		if [ $? -eq 0 ]; then
		{
			GameGenerateBlock
		}
		fi
	}
	fi
}

function GameCheckRotate()
{
	local NEWROT=0
	local BLAPOS=0
	local BLKX=0
	local BLKY=0
	
	if [ -z "$1" ]; then
	{
		return 0
	}
	fi
	
	if [ $1 -eq 0 ]; then
	{
		if [ $GAMECURRENTROT -eq 0 ]; then
		{
			NEWROT=3
		}
		else
		{
			NEWROT=$(($GAMECURRENTROT - 1))
		}
		fi
	}
	else
	{
		if [ $GAMECURRENTROT -eq 3 ]; then
		{
			NEWROT=0
		}
		else
		{
			NEWROT=$(($GAMECURRENTROT + 1))
		}
		fi
	}
	fi

	ZeroBlockBuffer

	if [ $GAMECURRENT -eq 0 ]; then
	{
		case $NEWROT in
			0) GAMEBLOCKBUFFER=("${BLK1ARRAY[@]}");;
			1) GAMEBLOCKBUFFER=("${BLK1ARRAYR2[@]}");;
			2) GAMEBLOCKBUFFER=("${BLK1ARRAYR3[@]}");;
			3) GAMEBLOCKBUFFER=("${BLK1ARRAYR4[@]}");;
		esac
	}
	elif [ $GAMECURRENT -eq 1 ]; then
	{
		GAMEBLOCKBUFFER=("${BLK2ARRAY[@]}")
		return 1
	}
	elif [ $GAMECURRENT -eq 2 ]; then
	{
		case $NEWROT in
			0) GAMEBLOCKBUFFER=("${BLK3ARRAY[@]}");;
			1) GAMEBLOCKBUFFER=("${BLK3ARRAYR2[@]}");;
			2) GAMEBLOCKBUFFER=("${BLK3ARRAY[@]}");;
			3) GAMEBLOCKBUFFER=("${BLK3ARRAYR3[@]}");;
		esac
	}
	elif [ $GAMECURRENT -eq 3 ]; then
	{
		case $NEWROT in
			0) GAMEBLOCKBUFFER=("${BLK4ARRAY[@]}");;
			1) GAMEBLOCKBUFFER=("${BLK4ARRAYR2[@]}");;
			2) GAMEBLOCKBUFFER=("${BLK4ARRAY[@]}");;
			3) GAMEBLOCKBUFFER=("${BLK4ARRAYR2[@]}");;
		esac
	}
	elif [ $GAMECURRENT -eq 4 ]; then
	{
		case $NEWROT in
			0) GAMEBLOCKBUFFER=("${BLK5ARRAY[@]}");;
			1) GAMEBLOCKBUFFER=("${BLK5ARRAYR2[@]}");;
			2) GAMEBLOCKBUFFER=("${BLK5ARRAY[@]}");;
			3) GAMEBLOCKBUFFER=("${BLK5ARRAYR2[@]}");;
		esac
	}
	elif [ $GAMECURRENT -eq 5 ]; then
	{
		case $NEWROT in
			0) GAMEBLOCKBUFFER=("${BLK6ARRAY[@]}");;
			1) GAMEBLOCKBUFFER=("${BLK6ARRAYR2[@]}");;
			2) GAMEBLOCKBUFFER=("${BLK6ARRAYR3[@]}");;
			3) GAMEBLOCKBUFFER=("${BLK6ARRAYR4[@]}");;
		esac
	}
	elif [ $GAMECURRENT -eq 6 ]; then
	{
		case $NEWROT in
			0) GAMEBLOCKBUFFER=("${BLK7ARRAY[@]}");;
			1) GAMEBLOCKBUFFER=("${BLK7ARRAYR2[@]}");;
			2) GAMEBLOCKBUFFER=("${BLK7ARRAYR3[@]}");;
			3) GAMEBLOCKBUFFER=("${BLK7ARRAYR4[@]}");;
		esac
	}
	fi

	for((i=0; i<GAMEBLOCKSIZE; i++)); do
	{
		for((j=0; j<GAMEBLOCKSIZE; j++)); do
		{
			BLAPOS=$((($i * $GAMEBLOCKSIZE) + $j))			
			BLKX=$(($j + $GAMEBLOCKAPX))			
			BLKY=$(($i + $GAMEBLOCKAPY))

			if [ ${GAMEBLOCKBUFFER[$BLAPOS]} -gt 0 ]; then
			{	
				if [ $BLKY -gt $(($TBASHH - 1)) ] || [ $BLKX -gt $(($TBASHW - 1)) ] || [ $BLKX -lt 0 ]; then
				{
					return 0
				}
				fi

				if [ ${TBASHARRAY[$((($BLKY * $TBASHW) + $BLKX))]} -gt 0 ]; then
				{
					return 0
				}
				fi
			}
			fi
		}
		done
	}
	done
	
	GAMECURRENTROT=$NEWROT
	return 1
}

function GameRotateBlockLeft()
{
	GameCheckRotate 0
	if [ $? -eq 1 ]; then
	{
		GameClearCurrentBlock
		GAMECURRENTARRAY=("${GAMEBLOCKBUFFER[@]}")
		GameDrawCurrentBlock
	}
	fi
}

function GameRotateBlockRight()
{
	GameCheckRotate 1
	if [ $? -eq 1 ]; then
	{
		GameClearCurrentBlock
		GAMECURRENTARRAY=("${GAMEBLOCKBUFFER[@]}")
		GameDrawCurrentBlock
	}
	fi
}

function InitGame()
{
	GAMESCORE=0
	GAMELEVEL=0
	GAMELINES=0
	GAMEFAILURE=0
	GAMEFAILURECOUNT=0
	GAMEOVERINPROGRESS=0
	GAMECLEARINPROGRESS=0
	GAMELINESTOCLEAR=0
	GAMESCOREMULT=$(($GAMESCOREMULTDEF + ($GAMELEVEL * $GAMESCOREMULTINC)))
	GAMECURRENT=$(($RANDOM % 7))
	GAMENEXT=$(($RANDOM % 7))
	GAMEINTERVAL="0.5"
	ACCUMULATOR="0.0"
	
	ZeroTetriBashArray
	DrawTetriBashArray
	GameSetCurrentBlock
	GameDrawCurrentBlock
}

function SetGameStateMenu()
{
	TETRIBASHSTATE=1
	GAMERUNNING=0
	clear
	DrawTetriBashTitle
	DrawTetriBashMainMenu
	DrawTetriBashMenuDecor
	DrawTetriBashVersionString
}

function SetGameStatePlay()
{
	clear
	TETRIBASHSTATE=2
	GAMERUNNING=1
	InitGame
	DrawTetriBashHUD
}

function SetGameStateAbout()
{
	clear
	TETRIBASHSTATE=3
	GAMERUNNING=0
	DrawTetriBashTitle
	DrawTetriBashVersionString
	DrawBorder $TBASHABOUTX $TBASHABOUTY $TBASHABOUTW $TBASHABOUTH
	printf "\e[%d;%dH\e[1;32m${TETRIBASHINFO}\e[0m" $(($TBASHABOUTY + 1)) $(($TBASHABOUTX + 1))
	printf "\e[%d;%dH\e[1;32m${TETRIBASHINFO2}\e[0m" $(($TBASHABOUTY + 2)) $(($TBASHABOUTX + 1))
	printf "\e[%d;%dH\e[1;32m${TETRIBASHINFO3}\e[0m" $(($TBASHABOUTY + 4)) $(($TBASHABOUTX + 1))
}

function SetGameStatePause()
{
	clear
	TETRIBASHSTATE=4
	GAMERUNNING=0
}

function SetGameStateExit()
{
	clear
	TETRIBASHSTATE=0
	GAMERUNNING=0
}

function ExecuteMainMenuSelection()
{
	case $MAINMENUSELECTION in
		0) SetGameStatePlay;;
		2) SetGameStateAbout;;
		3) SetGameStateExit;;
	esac
}


#=============================================================================
#-----------------------------------------------------------------------------
# [ TetriBASH Script ]
#-----------------------------------------------------------------------------
#=============================================================================
# Clear Screen
clear
stty -echo -icanon time 0 min 0

SetGameStateMenu

# Game Loop
while true; do
{
	TIMESTART=$(date +%s.%N)	

	KEY=$(dd bs=1 count=1 2> /dev/null; echo ".")
	KEY=${KEY%.}
	if [ $TETRIBASHSTATE -eq 1 ]; then
	{
		case $KEY in
			q) SetGameStateExit;;
			w) ChangeMainMenuSelectionUp;;
			a) ChangeMainMenuSelectionUp;;
			s) ChangeMainMenuSelectionDown;;
			d) ChangeMainMenuSelectionDown;;
			k) ExecuteMainMenuSelection;;
			# ?) printf "$KEY" ;;
		esac
	}
	elif [ $TETRIBASHSTATE -eq 2 ]; then
	{
		if [ $GAMERUNNING -eq 1 ]; then
		{
			if [ $GAMECLEARINPROGRESS -eq 1 ]; then
			{
				case $KEY in
					q) SetGameStateMenu;;
				esac

				if [[ $(echo "if (${ACCUMULATOR} > ${GAMECLEARINTERVAL}) 1" | bc) -eq 1 ]]; then
				{
					GameClearLines
					GAMECLEARINPROGRESS=0
					GAMELINESTOCLEAR=0
					GameGenerateBlock
				}
				fi
			}
			elif [ $GAMEOVERINPROGRESS -eq 1 ]; then
			{
				case $KEY in
					q) SetGameStateMenu;;
				esac

				if [[ $(echo "if (${ACCUMULATOR} > ${GAMEOVERINTERVAL}) 1" | bc) -eq 1 ]]; then
				{
					SetGameStateMenu
				}
				fi
			}
			else
			{
				case $KEY in
					q) SetGameStateMenu;;
					w) DrawTetriBashArray;;
					a) GameMoveBlockLeft;;
					s) GameMoveBlockDown 1;;
					d) GameMoveBlockRight;;
					j) GameRotateBlockLeft;;
					l) GameRotateBlockRight;;
					# ?) printf "%d\n" "'$KEY" ;;
				esac

				if [[ $(echo "if (${ACCUMULATOR} > ${GAMEINTERVAL}) 1" | bc) -eq 1 ]]; then
				{
					GameMoveBlockDown
					if [ $GAMEFAILURE -eq 1 ]; then
					{
						GAMEFAILURECOUNT=$(($GAMEFAILURECOUNT + 1))
						if [ $GAMEFAILURECOUNT -eq $GAMEFAILUREMAX ]; then
						{
							GAMEOVERINPROGRESS=1
							ACCUMULATOR="0.0"
							GameOverClearTetriBashArray
							DrawTetriBashArray
							HUDDrawGameOver
						}
						fi
						GAMEINTERVAL=$(echo "$GAMEINTERVAL - 0.05" | bc)
					}
					fi
					ACCUMULATOR=$(echo "$ACCUMULATOR - $GAMEINTERVAL" | bc)
				}
				fi
			}
			fi
		}
		fi
	}
	elif [ $TETRIBASHSTATE -eq 3 ]; then
	{
		case $KEY in
			q) SetGameStateMenu;;
		esac
	}
	elif [ $TETRIBASHSTATE -eq 4 ]; then
	{
		case $KEY in
			q) SetGameStateExit ;;
			w) DrawTetriBashArray ;;
			a) DrawBorder 4 2 10 10 ;;
			s) DrawTetriBashHUD ;;
			d) DrawTetriBashTitle;;
			?) printf "%d\n" "'$KEY" ;;
		esac
	}
	else
	{
		break
	}
	fi

	if [ $FRAMEUPDATED -eq 1 ]; then
	{
		if [ $TETRIBASHDEBUG -eq 1 ]; then
		{	
			if [ $TETRIBASHSTATE -eq 2 ]; then
			{	
				printf "\e[1;2H\e[1;32mDebug:BlkPos(%d,%d) BlkTerm(%d,%d) Delta(%2.3g) Accu(%2.3g) LC(%d)      \e[0m" $GAMEBLOCKAPX $GAMEBLOCKAPY $GAMEBLOCKX $GAMEBLOCKY $DELTATIME $ACCUMULATOR $GAMECLEARINPROGRESS
			}
			fi
 		}
		fi
		printf "\e[1;1H"
		FRAMEUPDATED=0
	}
	fi

	TIMEEND=$(date +%s.%N)
	DELTATIME=$(echo "$TIMEEND - $TIMESTART" | bc)
	if [ $TETRIBASHSTATE -eq 2 ] && [ $GAMERUNNING -eq 1 ]; then
	{
		ACCUMULATOR=$(echo "$ACCUMULATOR + $DELTATIME" | bc)
	}
	fi
}
done

# Clean Up
printf "\e[0m"
clear
stty sane
break;
	;;
	3)
if [[ $1 != "" ]]
then
cat << END
BashInvaders!
by Vidar 'koala_man' Holen
www.vidarholen.net

Originally an entry in the #linux.no 1KiB compo (thus the ugly source)
This is a pre-trim version with colors and proper tmp files. All bash. 
Released under the GNU General Public License.

Control your ship with J and L, shoot with K. 
Quit with Q or sigint.

Requires mktemp and sleep with fractions. 

END
exit 0
fi
dialog  \
--title "BashInvaders!" \
--backtitle "$BACKTITLE / BashInvaders!" \
--msgbox "Controls are 'J' 'K' 'L'" 5 28
tput civis

cd /tmp
e=echo
c=clear
r=return
E="$e -ne "
A=$E\\033[
m() { $A$2\;$1\H
}
f() { $A\1\;3$2\m
}

trap z=SigInt SIGINT
 g() {
 $e ${K[$(($2*8+$1))]}
}
 s() {
 K[$(($2*8+$1))]=$3
}
 u() {
 [ $T = 0 ] && $r 0
 m $S $((--T))
 $E `f 3`"."
 x=$((S-Y))
 y=$((T-Z))
 [ $((y%3)) = 0 -a $((x%6)) -lt 4 ] || $r 0
 : $((y/=3)) $((x/=6))
 [ "`g $x $y`" = 1 -a $x -le $o -a $x -ge $n -a $y -le $q -a $y -ge 0 ] || $r 0
 [ $Q = 1 ] && z="You win!"
 s $x $y 0 
 : $((Q--))
 T=0
 $r 1
}
 a() {
 w n +
 w o - 
 h 
}
 w() {
 d=0
 for (( I=0; I<=q; I++ )) {
  [ `g $(($1)) $I` = 1 ] && D=1
 }
 [ $D = 0 ] && : $(($1$2=1)) 
}
 h() {
for (( I=q; I>=0; I--)) {
for (( J=n; J<=o; J++)) {
   [ `g $J $I` = 1 ] && q=$I &&  $r
  }
 }
 }
 
 j() { 
 while read -n 1 S >/dev/null 2>&1
do
$e $S > $M
done
}

G=`mktemp`
L=`mktemp`
M=`mktemp`
N=`mktemp`
X=40
n=0
o=7
q=2
T=0
Y=2
Z=2
U=2
W=0
for (( Q=0; Q<24; Q++)) { 
 K[$Q]=1
}

j 0<&0 &
B=$!

until [ "$z" ]
do
 : $((W++)) 
 if [ -f $M ] 
 then
  i=$(<$M)
  rm $M
  case "$i" in
   q) z="Quit" ;;
   j) X=$(($X-3)) ;;
   l) X=$(($X+3)) ;;
   k) [ $T = 0 ] && S=$((X+1)) && T=22 
   ;;
  esac
 fi
 rm $N  
 exec > $N
for (( J=0; J<=q; J++)) { 
  for (( I=n; I<=o; I++)) { 
   [ `g $I $J` = 1 ] && m $((I*6+Y)) $((J*3+Z)) && $e `f 4`/00\\
  }
 }
 m $X 23
 $e `f 2`"/|\\"
 [ $T != 0 ] && u  
 a
 m 0 0
 exec > `tty`
$c
cat $N
sleep .1
[ $((W%2)) = 0 ] && : $((Y+=U)) && if [ $((Y+n*6)) -lt 2 -o $((Y+o*6)) -gt 75 ] 
then 
: $((U=-U))  $((Z+=2))
[ $((Z+q*3)) -le 20 ] || z="You lose!"
fi
done

$c
$e $z
rm $G $L $M $N $F &> /dev/null
kill $B
sleep 4
	;;
	4)
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
      exit 0;
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
	5)
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
	6)
	TITLE="About"
	    BACKTITLE="$BACKTITLE / About"
	    dialog \
	    --title "$TITLE" \
	    --backtitle "$BACKTITLE" \
	    --msgbox "Games provided by:\n\nMartin 'BruXy' Bruchanov\nfound at: URL: http://bruxy.regnet.cz\n\nBashInvaders!\nby Vidar 'koala_man'Holen\nwww.vidarholen.net\n\nTetriBash\nwritten by SynaGl0w\n&\nSteve_Parker,\nShell Scripting: Expert Recipes for Linux,Bash and more." 20 40;
	    ;;
	    esac
	elif [ "$?" -eq 1 ]; then ##Cancel Games
	  break;
	fi
	;;
	3) ##PMPlayer 0.0.3
	dpkg -s xmms2 &> /dev/null; #Check's if Xmms2 is installed
	if [ "$?" -eq 0 ]; then #Xmms2 installed
	while [[ 1 ]]
	do
	HEIGHT=14
	WIDTH=30
	CHOICE_HEIGHT=7
	TITLE="PMPlayer 0.0.3"
	BACKTITLE="PMP v.0.0.25 / Extras / PMPlayer 0.0.3"
	MENU="♫__Welcome to PMPlayer!__♫"
	OPTIONS=(1 "→ Next"
		 2 "← Previous"
		 3 "►❚❚ Play/Pause"
		 4 "◼ Stop"
		 5 "Currently Playing"
		 6 "Library"
		 7 "Radio")

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
			    xmms2 next;
			    ;;
			    2)
			    xmms2 prev;
			    ;;
			    3)
			    xmms2 toggle;
			    ;;
			    4)
			    xmms2 stop;
			    ;;
			    5)
			    xmms2 current > /tmp/space.txt
			    dialog --backtitle "$BACKTITLE / Currently Playing" \
				   --title "PMPlayer - Currently Playing" \
				   --textbox /tmp/space.txt 5 95;
			    ;;
			    6)
			    while [[ 1 ]]
			    do
			    clear;
			    HEIGHT=14
			    WIDTH=30
			    CHOICE_HEIGHT=5
			    BACKTITLE="PMP v.0.0.25 / Extras / PMPlayer 0.0.3 / Library"
			    TITLE="Library"
			    MENU="Please choose one of the following Options:"

			    OPTIONS=(1 "Playlist"
				    2 "Add Music"
				    3 "Shuffle Playlist"
				    4 "Jump to Track"
				    5 "Empty Playlist")

			    CHOICE=$(dialog --clear \
					    --backtitle "$BACKTITLE" \
					    --title "$TITLE" \
					    --menu "$MENU" \
			    $HEIGHT $WIDTH $CHOICE_HEIGHT \
			    "${OPTIONS[@]}" \
			    2>&1 >/dev/tty)
			    if [ "$?" -eq 0 ]; then ##PMPlayer Playlist Okay
			      case $CHOICE in
				  1) ##Library
				  printf "TIP - Use Page up & Page Down or the arrow keys to scroll:\n\n" > /tmp/space.txt;
				  xmms2 list >> /tmp/space.txt;
				  dialog --backtitle "$BACKTITLE / Playlist" \
					 --title "Playlist" \
					 --textbox /tmp/space.txt 25 120
				  ;;
				  2) ##Add Music
				  FILE=$(dialog --title "$TITLE" \
						--backtitle "$BACKTITLE / Add Music" \
						--stdout \
						--title "Add a Music folder:" \
						--fselect $HOME/  8 60) ;
				  if [ "$?" -eq 0 ]; then ##YES Fselect Add Music
				  xmms2 add $FILE;
				  elif [ "$?" -eq 1 ]; then ##NO Fselect Add Music
				  dialog --title "$TITLE" \
					 --backtitle "$BACKTITLE" \
					 --infobox "cancelled...." 3 16;
				    sleep 1.2;
				    clear;
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
				  xmms2 jump $TRACK;
				  elif [ "$?" -eq 1 ]; then ##NO Fselect Track Number
				  clear;
				  fi
				  ;;
				  5) ##Empty Library
				  xmms2 clear;
				  ;;
			      esac
			    elif [ "$?" -eq 1 ]; then ##PMPlayer Library Cancel
			      break;
			    fi
			    done
			    ;;
			    7)
                dpkg -s mplayer &> /dev/null; #Check's if Mplayer is installed
                if [ "$?" -eq 0 ]; then #Mplayer Installed
                while [[ 1 ]]
                do
                HEIGHT=13
                WIDTH=30
                CHOICE_HEIGHT=6
                BACKTITLE="PMP v.0.0.25 / Extras / PMPlayer 0.0.3 / Radio"
                TITLE="Radio - Channel List"
                MENU="Select one:"
                OPTIONS=(1 "Pop"
                        2 "Hip Hop"
                        3 "Electro/Dance"
                        4 "Rock"
                        5 "Country"
                        6 "News")
                CHOICE=$(dialog --clear \
                                --backtitle "$BACKTITLE" \
                                --title "$TITLE" \
                                --menu "$MENU" \
                $HEIGHT $WIDTH $CHOICE_HEIGHT \
                "${OPTIONS[@]}" \
                2>&1 >/dev/tty)
                    if [ "$?" -eq 0 ]; then ##Ok Channel List
                    case $CHOICE in
                    1)
                    while [[ 1 ]]
                    do
                    HEIGHT=17
                    WIDTH=50
                    CHOICE_HEIGHT=7
                    BACKTITLE="PMP v.0.0.25 / Extras / PMPlayer 0.0.3 / Radio / Pop"
                    TITLE="Pop"
                    MENU="Select one:"
                    OPTIONS=(1 "Hot 97.7 FM - NV"
                            2 "WHTZ 100.3 FM New York City, NY"
                            3 "KIIS 102.7 FM Los Angeles, CA"
                            4 "KXOL-FM - Mega 96.3 Los Angeles, CA"
                            5 ".113FM Pop2K USA"
                            6 "181.fm - The Mix"
                            7 "181.fm - Power 181 'Top 40'")
                    CHOICE=$(dialog --clear \
                                    --backtitle "$BACKTITLE" \
                                    --title "$TITLE" \
                                    --menu "$MENU" \
                    $HEIGHT $WIDTH $CHOICE_HEIGHT \
                    "${OPTIONS[@]}" \
                    2>&1 >/dev/tty)
                    if [ "$?" -eq 0 ]; then ##Okay in Pop
                        case $CHOICE in
                        1)
                        clear;
                        mplayer http://janus.cdnstream.com:5353/; #Hot 97.7 FM - NV
                        ;;
                        2)
                        clear
                        mplayer http://c5icy.prod.playlists.ihrhls.com/1469_icy; #WHTZ 100.3 FM New York City, NY
                        ;;
                        3)
                        clear;
                        mplayer http://c2icy.prod.playlists.ihrhls.com/185_icy; #KIIS 102.7 FM Los Angeles, CA
                        ;;
                        4)
                        clear;
                        mplayer http://65.19.131.178/sbsystems-kxolfmaac-ib-64; #KXOL-FM - Mega 96.3 Los Angeles, CA
                        ;;
                        5)
                        clear;
                        mplayer http://113fm-edge1.cdnstream.com/1737_128 #.113FM Pop2K USA
                        ;;
                        6)
                        clear;
                        mplayer http://relay2.181.fm:8032 #181.fm - The Mix
                        ;;
                        7)
                        clear;
                        mplayer http://relay1.181.fm:8128/ #181.fm - Power 181 Top 40
                        ;;
                        esac
                    elif [ "$?" -eq 1 ]; then ##Cancel in Pop
                    break;
                        clear;
                    fi
                    done
                    ;;
                    2)
                    while [[ 1 ]]
                    do
                    HEIGHT=17
                    WIDTH=50
                    CHOICE_HEIGHT=7
                    BACKTITLE="PMP v.0.0.25 / Extras / PMPlayer 0.0.3 / Radio / Hip Hop"
                    TITLE="Hip Hop"
                    MENU="Select one:"
                    OPTIONS=(1 "KVEG 97.5 FM Las Vegas"
                    2 "WPWX 92.3 FM Chicago"
                    3 "WHTA 107.9 FM Atlanta, GA"
                    4 "Dope Beats Radio, NY"
                    5 "Kiss FM - Live Berlin"
                    6 "WPYO 95.3 FM Orlando, FL"
                    7 "181.fm - The Beat")
                    CHOICE=$(dialog --clear \
                                    --backtitle "$BACKTITLE" \
                                    --title "$TITLE" \
                                    --menu "$MENU" \
                    $HEIGHT $WIDTH $CHOICE_HEIGHT \
                    "${OPTIONS[@]}" \
                    2>&1 >/dev/tty)
                    if [ "$?" -eq 0 ]; then ##Okay in Hip Hop
                        case $CHOICE in
                        1)
                        clear;
                        mplayer http://18513.live.streamtheworld.com/KVEGFMAAC.aac; #KVEG 97.5 FM Las Vegas
                        ;;
                        2)
                        clear;
                        mplayer http://17553.live.streamtheworld.com/WPWXFMAAC.aac; #WPWX 92.3 FM Chicago
                        ;;
                        3)
                        clear;
                        mplayer http://18073.live.streamtheworld.com/WHTAFMAAC.aac; #WHTA 107.9 FM Atlanta, GA
                        ;;
                        4)
                        clear;
                        mplayer http://radio.citrus3.com:8304/stream.mp3; #Dope Beats Radio, NY
                        ;;
                        5)
                        clear;
                        mplayer http://stream.kissfm.de/kissfm/mp3-128/internetradio/; #Kiss FM - Live Berlin
                        ;;
                        6)
                        clear;
                        mplayer http://oom-cmg.streamguys1.com/orl953/orl953-sgplayer-aac; #WPYO 95.3 FM Orlando, FL
                        ;;
                        7)
                        clear;
                        mplayer http://relay5.181.fm:8054/; #181.fm - The Beat
                        ;;
                        esac
                    elif [ "$?" -eq 1 ]; then ##Cancel in Hip Hop
                    break;
                        clear;
                    fi
                    done
                    ;;
                    3)
                    while [[ 1 ]]
                    do
                    HEIGHT=17
                    WIDTH=50
                    CHOICE_HEIGHT=8
                    BACKTITLE="PMP v.0.0.25 / Extras / PMPlayer 0.0.3 / Radio / Electro/Dance"
                    TITLE="Electro/Dance"
                    MENU="Select one:"
                    OPTIONS=(1 "TechouseFM - Techouse "
                            2 "DancePopFM"
                            3 "Sunshine Live"
                            4 "Deep Mix Moscow Radio"
                            5 "181.fm - Chilled Out"
                            6 "181.fm - Techno Club"
                            7 "1.FM - Dubstep Forward Radio"
                            8 "Minimal Mix Radio")
                    CHOICE=$(dialog --clear \
                                    --backtitle "$BACKTITLE" \
                                    --title "$TITLE" \
                                    --menu "$MENU" \
                    $HEIGHT $WIDTH $CHOICE_HEIGHT \
                    "${OPTIONS[@]}" \
                    2>&1 >/dev/tty)
                    if [ "$?" -eq 0 ]; then ##Okay in Electro/Dance
                        case $CHOICE in
                        1)
                        clear;
                        mplayer http://23.111.161.50:8002/; #TechouseFM - Techouse
                        ;;
                        2)
                        clear;
                        mplayer http://23.111.161.50:8006/; #DancePopFM
                        ;;
                        3)
                        clear;
                        mplayer http://stream.sunshine-live.de/live/mp3-192/radiosure/; #Sunshine Live
                        ;;
                        4)
                        clear
                        mplayer http://85.21.79.31:7128; #Deep Mix Moscow Radio
                        ;;
                        5)
                        clear;
                        mplayer http://listen.181fm.com:8700; #181.fm - Chilled Out
                        ;;
                        6)
                        clear;
                        mplayer http://listen.181fm.com/181-technoclub_128k.mp3; #181.fm - Techno Club
                        ;;
                        7)
                        clear;
                        mplayer http://sc-dubstep.1.fm:10012/; #1.FM - Dubstep Forward Radio
                        ;;
                        8)
                        clear;
                        mplayer http://minimalmix.radioca.st/media; #Minimal Mix Radio
                        ;;
                        esac
                    elif [ "$?" -eq 1 ]; then ##Cancel in Electro/Dance
                    break;
                        clear;
                    fi
                    done
                    ;;
                    4)
                    while [[ 1 ]]
                    do
                    HEIGHT=17
                    WIDTH=50
                    CHOICE_HEIGHT=8
                    BACKTITLE="PMP v.0.0.25 / Extras / PMPlayer 0.0.3 / Radio / Rock"
                    TITLE="Rock"
                    MENU="Select one:"
                    OPTIONS=(1 "HardRock-FM"
                            2 "SVR Hanse Radio"
                            3 "WTRV 100.5 FM"
                            4 "Idobi Howl"
                            5 "WDR 1Live / Einslive"
                            6 "WDR 2 - Südwestfalen"
                            7 "Radio Technikum Rock"
                            8 "Metal Mayhem Underground")
                    CHOICE=$(dialog --clear \
                                    --backtitle "$BACKTITLE" \
                                    --title "$TITLE" \
                                    --menu "$MENU" \
                    $HEIGHT $WIDTH $CHOICE_HEIGHT \
                    "${OPTIONS[@]}" \
                    2>&1 >/dev/tty)
                    if [ "$?" -eq 0 ]; then ##Okay in Rock
                        case $CHOICE in
                        1)
                        clear;
                        mplayer http://23.111.161.50:8000/; #HardRock-FM
                        ;;
                        2)
                        clear;
                        mplayer http://stream.laut.fm/hanseradio; #SVR Hanse Radio
                        ;;
                        3)
                        clear;
                        mplayer http://54.159.26.198/townsquare-wtrvfmaac-ibc3; #WTRV 100.5 FM
                        ;;
                        4)
                        clear;
                        mplayer http://idobihowl.idobi.com/; #Idobi Howl
                        ;;
                        5)
                        clear;
                        mplayer http://wdr-1live-live.icecast.wdr.de/wdr/1live/live/mp3/128/stream.mp3; #WDR 1Live / Einslive
                        ;;
                        6)
                        clear;
                        mplayer http://wdr-wdr2-suedwestfalen.icecast.wdr.de/wdr/wdr2/suedwestfalen/mp3/128/stream.mp3; #WDR 2 - Südwestfalen
                        ;;
                        7)
                        clear;
                        mplayer http://technikumrockcockpit.macjingle.at:8202/;stream/1 #Radio Technikum Rock
                        ;;
                        8)
                        clear;
                        mplayer http://s5.voscast.com:8922
                        esac
                    elif [ "$?" -eq 1 ]; then ##Cancel in Rock
                    break;
                        clear;
                    fi
                    done
                    ;;
                    5)
                    while [[ 1 ]]
                    do
                    HEIGHT=17
                    WIDTH=50
                    CHOICE_HEIGHT=7
                    BACKTITLE="PMP v.0.0.25 / Extras / PMPlayer 0.0.3 / Radio / Country"
                    TITLE="Country"
                    MENU="Select one:"
                    OPTIONS=(1 "Radio Free Texas"
                            2 "WAXX 104.5 FM Eau Claire, WI"
                            3 "Radio Volksmusik"
                            4 "BRF2"
                            5 "181.fm - Highway 181"
                            6 "KKNU 93.3 FM Springfield, OR"
                            7 "WSM 650 AM Nashville, TN")
                    CHOICE=$(dialog --clear \
                                    --backtitle "$BACKTITLE" \
                                    --title "$TITLE" \
                                    --menu "$MENU" \
                    $HEIGHT $WIDTH $CHOICE_HEIGHT \
                    "${OPTIONS[@]}" \
                    2>&1 >/dev/tty)
                    if [ "$?" -eq 0 ]; then ##Okay in Country
                        case $CHOICE in
                        1)
                        clear;
                        mplayer http://199.195.194.140:8300/; #Radio Free Texas
                        ;;
                        2)
                        clear
                        mplayer http://ice9.securenetsystems.net/WAXX; #WAXX 104.5 FM Eau Claire, WI
                        ;;
                        3)
                        clear;
                        mplayer http://server1.cityedv.at:8021; #Radio Volksmusik
                        ;;
                        4)
                        clear;
                        mplayer http://streaming.brf.be/brf2-high.mp3; #BRF2
                        ;;
                        5)
                        clear;
                        mplayer http://listen.181fm.com/181-highway_128k.mp3 #181.fm - Highway 181
                        ;;
                        6)
                        clear;
                        mplayer http://www.ophanim.net:9170/live #KKNU 93.3 FM Springfield, OR
                        ;;
                        7)
                        clear;
                        mplayer http://stream01048.westreamradio.com/wsm-am-mp3 #WSM 650 AM Nashville, TN
                        ;;
                        esac
                    elif [ "$?" -eq 1 ]; then ##Cancel in Country
                    break;
                        clear;
                    fi
                    done
                    ;;
                    6)
                    while [[ 1 ]]
                    do
                    HEIGHT=17
                    WIDTH=50
                    CHOICE_HEIGHT=6
                    BACKTITLE="PMP v.0.0.25 / Extras / PMPlayer 0.0.3 / Radio / News"
                    TITLE="News"
                    MENU="Select one:"
                    OPTIONS=(1 "BBC World Service News"
                            2 "CBS Radio News"
                            3 "DW Radio English World News"
                            4 "NBC News Radio"
                            5 "CNN HLN"
                            6 "News Radio UK")
                    CHOICE=$(dialog --clear \
                                    --backtitle "$BACKTITLE" \
                                    --title "$TITLE" \
                                    --menu "$MENU" \
                    $HEIGHT $WIDTH $CHOICE_HEIGHT \
                    "${OPTIONS[@]}" \
                    2>&1 >/dev/tty)
                    if [ "$?" -eq 0 ]; then ##Okay in Country
                        case $CHOICE in
                        1)
                        clear;
                        mplayer http://bbcwssc.ic.llnwd.net/stream/bbcwssc_mp1_ws-einws; #BBC World Service News
                        ;;
                        2)
                        clear;
                        mplayer http://20263.live.streamtheworld.com/CBSNEWS_SC #CBS Radio News
                        ;;
                        3)
                        clear;
                        mplayer http://dw-radio-english-mp3.akacast.akamaistream.net/7/779/135362/v1/gnl.akacast.akamaistream.net/dw-radio-english-mp3; #DW Radio English World News
                        ;;
                        4)
                        clear;
                        mplayer http://c3icy.prod.playlists.ihrhls.com/6043_icy #iHeart NBC News Radio (24/7 News)
                        ;;
                        5)
                        clear;
                        mplayer http://tunein.streamguys1.com/cnnhln #CNN Headline News
                        ;;
                        6)
                        clear;
                        mplayer http://s1.rss-streaming.co.uk:8008/stream #News Radio UK
                        ;;
                        esac
                    elif [ "$?" -eq 1 ]; then ##Cancel in Country
                    break;
                        clear;
                    fi
                    done
                    ;;
                    esac
                    elif [ "$?" -eq 1 ]; then ##Cancel in Radio
                    break;
                    clear;
                    fi
                done
                elif [ "$?" -eq 1 ]; then #Mplayer not Installed
                clear;
                dialog \
                --title "Radio" \
                --backtitle "$BACKTITLE / Radio" \
                --yesno "Mplayer is not installed.\nDo you want to install Mplayer?" 6 35;
                    if [ "$?" -eq 0 ]; then #Yes Install Mplayer
                        clear;
                        sudo apt-get install mplayer;
                    elif [ "$?" -eq 1 ]; then #No Install Mplayer
                        clear;
                        dialog --title "Cancel" --backtitle "$BACKTITLE / Radio" --infobox "cancelled..." 3 15;
                        sleep 1.2;
                    fi
                fi
			    ;;
			    esac
			elif [ "$?" -eq 1 ]; then
			break;
			fi
	done
	elif [ "$?" -eq 1 ]; then
	clear
    dialog \
    --title "PMPlayer 0.0.3" \
    --backtitle "$BACKTITLE / PMPlayer 0.0.3" \
    --yesno "Xmms2 is not installed.\nDo you want to install Xmms2?" 6 33;
        if [ "$?" -eq 0 ]; then #Yes Install Xmms2
            clear;
            sudo apt-get install xmms2
        elif [ "$?" -eq 1 ]; then #No Install Xmms2
            clear;
            dialog --title "Cancel" --backtitle "$BACKTITLE / PMPlayer 0.0.3" --infobox "cancelled..." 3 15;
	     sleep 1.2;
        fi
    fi
	;;
	4)
	clear;
	printf "Use 'quit' to exit...\n";
	bc -l;
	;;
	5)
	while [[ 1 ]]
	do
	HEIGHT=10
	WIDTH=15
	CHOICE_HEIGHT=2
	BACKTITLE="PMP v.0.0.25 / Extras / Time & Date"
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
		    0 0;
		    clear;
		    ;;
		    2)
		    dialog --clear \
			   --title "PMP Calendar" \
			   --backtitle "$BACKTITLE / Calendar" \
			   --calendar '' \
		    0 0;
		    clear;
		    ;;
		esac
           elif [ "$?" -eq 1 ]; then ##Cancel Time & Date
           break;
           fi
	done
	;;
	esac
elif [ "$?" -eq 1 ]; then ##Cancel Extras
		clear;
	break;
	fi ##END Extras
        done
	;;
	6)
	while [[ 1 ]]
	do
	HEIGHT=12
	WIDTH=25
	CHOICE_HEIGHT=3
	BACKTITLE="PMP v.0.0.25 / Shut Down"
	TITLE="Shut down"
	MENU="Please choose one of the following Options:"
	OPTIONS=(1 "Shut Down"
             2 "Restart"
             3 "Logout")
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
        BACKTITLE="$BACKTITLE"
	    dialog --title "Shut Down" \
	    --backtitle "$BACKTITLE" \
	    --yesno "Do you want to turn off your computer?" 5 42;
	    if [ "$?" -eq 0 ]; then
        dialog --title "Shut down" \
               --backtitle "$BACKTITLE" \
               --pause "Shutting down in:" 8 30 20;
              if [ "$?" -eq 0 ]; then
                 systemctl poweroff
              elif [ "$?" -eq 1 ]; then
                dialog --title "Cancel" --backtitle "$BACKTITLE" --infobox "cancelled..." 3 15;
                sleep 1.5;
                clear;
              fi
	    elif [ "$?" -eq 1 ]; then
	    dialog --title "Cancel" --backtitle "$BACKTITLE" --infobox "cancelled..." 3 15;
	    sleep 2;
	    clear;
	    fi
        ;;
	    2)
	    BACKTITLE="$BACKTITLE / Restart"
	    dialog --title "Restart" \
	    --backtitle "$BACKTITLE" \
	    --yesno "Do you want to restart your computer?" 5 41;
	    if [ "$?" -eq 0 ]; then ##Yes Log out
         dialog --title "Restart" \
                --backtitle "$BACKTITLE" \
                --pause "Restarting in:" 8 30 20;
                if [ "$?" -eq 0 ]; then ##Yes Reboot
                    systemctl reboot
                elif [ "$?" -eq 1 ]; then ##Cancel Reboot
                 dialog --title "Cancel" --backtitle "$BACKTITLE" --infobox "cancelled..." 3 15;
                 sleep 1.5;
                 clear;
                fi
	     elif [ "$?" -eq 1 ]; then
	     dialog --title "Cancel" --backtitle "$BACKTITLE" --infobox "cancelled..." 3 15;
	     sleep 2;
	     clear;
	     fi
	    ;;
	    3)
	    dialog --title "Logout" \
               --backtitle "$BACKTITLE" \
               --yesno "Do you want to logout of the current session?" 6 33;
        if [ "$?" -eq 0 ]; then ##Yes Log out
        loginctl session-status > /tmp/space.txt;
        SESSION=$(awk '{print $1; exit}' /tmp/space.txt)
        dialog --title "Logout" \
               --backtitle "$BACKTITLE" \
               --pause "Logging out in:" 8 30 20;
               if [ "$?" -eq 0 ]; then ##Okay Logout
               loginctl terminate-session $SESSION;
               elif [ "$?" -eq 1 ]; then ##Cancel Logout
               dialog --title "Cancel" --backtitle "$BACKTITLE" --infobox "cancelled..." 3 15;
                sleep 1.5;
                clear;
               fi
        elif [ "$?" -eq 1 ]; then ##No Log output
        dialog --title "Cancel" --backtitle "$BACKTITLE" --infobox "cancelled..." 3 15;
        sleep 2;
        clear;
        fi
	    ;;
	  esac
	elif [ "$?" -eq 1 ]; then
	  break;
	fi
	done
	;;
	7)
	TITLE="About"
	BACKTITLE="PMP v.0.0.25 / About"
	dialog --clear \
	       --title "$TITLE" \
	       --backtitle "$BACKTITLE" \
	       --msgbox "PMP - Personal Maintain Program\nver.0.0.25\n\nwritten by Kali_Yuga\n2017-2019\n---------------------------\nAll Debian!.\nOnly runs with Debian Systems, like Debian, Ubuntu or Mint.\n\nEasy Update & Maintain your System on the Terminal\nwithout having to know commands.\nThis is basically just a Bash script for learning and it is not professional made! Mainly use it myself,\nso it works for me.\nNo warranty whatsoever!" 19 70;
	clear;
        ;;
        8) ##EXIT
        dialog --title "Exit" \
	       --backtitle "$BACKTITLE / Exit" \
	       --infobox "Goodbye!" 3 20;
	       sleep 1.2;
	       clear;
	       exit 0;
        ;;
esac
	elif [ "$?" -eq 1 ]; then ##MAIN MENU IF USER PRESSED CANCEL
	  dialog --title "Exit" \
		 --backtitle "$BACKTITLE / Exit" \
		 --infobox "Goodbye!" 3 20;
		 sleep 1.2;
		 clear;
		 exit 0;
	fi
elif [ "$?" -eq 1 ]; then ##NO Dialog installed
    clear;
    printf "Sorry... You need to have Dialog installed to run this!\n";
    PS3='Select Options:'
    options=("Install Dialog"
	     "Exit")
	    select opt in "${options[@]}"
	    do
	    case $opt in
	    ("Install Dialog")
	    sudo apt-get update && sudo apt-get install dialog;
	    break;
	    ;;
	    ("Exit")
	    printf "==========================================\n|                Goodbye!                |\n==========================================\n";
	    exit;
	    esac
	    done
fi
done
