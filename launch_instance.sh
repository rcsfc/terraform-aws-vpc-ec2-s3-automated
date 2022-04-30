#!/bin/bash

# Run our PowerShell prompt to ask the user what they'd like to name the project
# This will cause resources to be spun up under this project name in AWS when terraform is run
# thus ensuring unique resource names each time

echo "Enter the project name: "
read project_name

# Run our Bash commands
if [ ! -d ~/terraform/$project_name ]; then
   mkdir -p ~/terraform/$project_name
   cd  ~/terraform/$project_name
   git clone https://github.com/rcsfc/terraform-aws-vpc-ec2-s3-automated.git .
   find . -type f -print0 | xargs -0 sed -i "s/CHANGEME/$project_name/g"
   terraform init
   terraform apply -auto-approve
else
   echo "Project already exists. Exiting."
   exit 1
fi

# Copy our state files to the backup folder so we can retrieve them later
# This isn't recommended for production use and is here more to spark the idea that you should backup your state files (but in a secure way)
if [ ! -d ~/terraform/state_backups/$project_name ]; then
   mkdir -p ~/terraform/state_backups/$project_name
   find . -name "*.tfstate" -type f -exec cp {} ~/terraform/state_backups/$project_name/ \;
else
   echo "Project backup directory already exists. Did you already create this project?"
   echo "Exiting without overwriting the files."
   exit 1
fi

# Goodbye
echo "Project $project_name has been deployed. See you next time!"
exit
