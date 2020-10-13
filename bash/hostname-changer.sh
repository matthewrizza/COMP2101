#!/bin/bash
#
# This script is for the bash lab on variables, dynamic data, and user input
# Download the script, do the tasks described in the comments
# Test your script, run it on the production server, screenshot that
# Send your script to your github repo, and submit the URL with screenshot on Blackboard

# Get the current hostname using the hostname command and save it in a variable
currentHostname=$(hostname)
# Tell the user what the current hostname is in a human friendly way
echo "Your current hostname is: $currentHostname"
# Ask for the user's student number using the read command
read -p "Please enter your student number: " studentNumber
# Use that to save the desired hostname of pcNNNNNNNNNN in a variable, where NNNNNNNNN is the student number entered by the user
desiredHostname=pc$studentNumber
# If that hostname is not already in the /etc/hosts file, change the old hostname in that file to the new name using sed or something similar and
#     tell the user you did that
#e.g. sed -i "s/$oldname/$newname/" /etc/hosts
grep $desiredHostname /etc/hosts || (printf "$desiredHostname Does not already exist.\n Changing hostname to $desiredHostname." && sudo sed -i "s/$currentHostname/$desiredHostname/" /etc/hosts)
# If that hostname is not the current hostname, change it using the hostnamectl command and
#     tell the user you changed the current hostname and they should reboot to make sure the new name takes full effect
#e.g. hostnamectl set-hostname $newname
test $currentHostname == $desiredHostname && echo "Your hostname is already named $desiredHostname." || hostnamectl set-hostname $desiredHostname && echo "Please restart your machine for the changes to take full effect."
