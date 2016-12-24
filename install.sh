#!/bin/bash

# Install git
echo "Installing git"
sudo apt-get install git -y

# Change to a temporary path
cd /tmp

# Clone Repository Numix Cursor
echo "Clone Repository Numix Cursor"
git clone https://github.com/uloco/numix-cursor.git
cd /tmp/numix-cursor

# Copy to path system
echo "Copying /usr/share/icons/"
sudo cp -rf theme/Numix-Cursor/ /usr/share/icons/

# Configure files
echo "Update cursor.theme"
sudo update-alternatives --install /usr/share/icons/default/index.theme x-cursor-theme /usr/share/icons/Numix-Cursor/cursor.theme 90

echo "Choose the Numix Theme"
sudo update-alternatives --config x-cursor-theme

# Finish files
echo "The cursor files are already installed."

# Space. For visual use only
echo -ne '\n'

# Warning Message
echo "Now you have to restart the X Server."
echo "When the session is executed and the executed applications are closed."
echo "If you decide not to restart at this time, you can do this by restarting the operating system or logging off manually."

# Space. For visual use only
echo -ne '\n'

# Clean screen
PS3='Do you want to continue?: '
options1=("No" "Yes")
select opt in "${options1[@]}"
do
	case $opt in
		"Yes")
		clear
		# Search type of X Server
		echo "Search type of X Server"
		ps -ef | grep '/[X]'

		# Space. For visual use only
		echo -ne '\n'

		# Bash Menu Restart X Server
		PS3='Please enter the number according to the previous result: '
		options=("GDM" "MDM" "KDM" "LightDM" "Do not restart")
		select opt2 in "${options[@]}"
		do
			case $opt2 in
				"GDM")
				sudo service gdm restart
				;;

				"MDM")
				sudo service mdm restart
				;;

				"KDM")
				sudo service kdm restart
				;;

				"LightDM")
				sudo service lightdm restart
				;;

				"Do not restart")
				break
				;;
				*) echo invalid option;;
			esac
		done
		break
		;;

		"No")
		echo "Bye."
		break
		;;
		*) echo invalid option;;
	esac
done
