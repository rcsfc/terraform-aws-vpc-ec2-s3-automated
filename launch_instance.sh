#!/bin/bash

# Run our PowerShell prompt to ask the user what they'd like to name the project
# This will cause resources to be spun up under this project name in AWS when terraform is run
# thus ensuring unique resource names each time

echo "Enter the project name: "
read project_name

# Run our Bash commands
mkdir -p ~/terraform/$project_name
mkdir -p ~/terraform/state_backups/$project_name
cd  ~/terraform/$project_name

# Clone the latest version of the repo to the directory we're in so we always have the latest code
git clone https://github.com/rcsfc/terraform-aws-vpc-ec2-s30-automated.git .

# Replace the default variable of CHANGEME with our project name so that all of the resources will be unique in our AWS account
find . -type f -exec sed -i "s/CHANGEME/$project_name/g" {} +

# Initialize terrform and then run terraform apply to spin up the resources
terraform init
terraform apply

# Copy our state files to the backup folder so we can retrieve them later
# This isn't recommended for production use and is here more to spark the idea that you should backup your state files (but in a secure way)
find . -name "*.tfstate" -type f -exec cp {} ~/terraform/state_backups/$project_name/ \;

# Goodbye
echo "Project $project_name has been deployed. See you next time!"
exit
