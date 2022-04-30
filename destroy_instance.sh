#!/bin/bash

# Asks the user what project they'd like to destroy and then proceeds to remove the resources matching the associated project
# Allows for multiple project folders stored on your local system with different .tfstate files for each

echo "Enter the project name to DESTROY: "
read project_name

# Change to the project directory if it exists and run terraform destroy.
# Otherwise, exit without taking any action
if [ -d ~/terraform/$project_name ];then
   cd ~/terraform/$project_name
   terraform destroy -auto-approve
   rm -f ~/.ssh/"$project_name"_ssh_key.pub.pem
   rm -fr ~/terraform/state_backups/$project_name
else
   echo "Project directory not found. Exiting."
   exit 1
fi

# Goodbye
echo "Project $project_name has been DESTROYED. System powering down..."
exit
