#!/bin/bash

# Set the GCP project details
PROJECT_ID="peaceful-campus-449014-b0"  # Replace with your GCP Project ID
ZONE="us-central1-f"               # Replace with your VM's zone (e.g., us-central1-a)
INSTANCE_ID="5268997931165599090"  # GCP VM instance ID

# Retrieve the external IP address of the specified GCP VM instance
ipv4_address=$(gcloud compute instances describe $INSTANCE_ID --project $PROJECT_ID --zone $ZONE --format='get(networkInterfaces[0].accessConfigs[0].natIP)')

# Path to the .env file
file_to_find="../backend/.env.docker"

# Check the current FRONTEND_URL in the .env file
current_url=$(sed -n "4p" $file_to_find)

# Update the .env file if the IP address has changed
if [[ "$current_url" != "FRONTEND_URL=\"http://${ipv4_address}:5173\"" ]]; then
    if [ -f $file_to_find ]; then
        sed -i -e "s|FRONTEND_URL.*|FRONTEND_URL=\"http://${ipv4_address}:5173\"|g" $file_to_find
        echo "Updated FRONTEND_URL in .env.docker to: http://${ipv4_address}:5173"
    else
        echo "ERROR: File not found."
    fi
else
    echo "No update needed, IP is the same."
fi


#!/bin/bash

# Set the Instance ID and path to the .env file
#INSTANCE_ID="i-030da7d31a1dbbffc"

# Retrieve the public IP address of the specified EC2 instance
#ipv4_address=$(aws ec2 describe-instances --instance-ids $INSTANCE_ID --query 'Reservations[0].Instances[0].PublicIpAddress' --output text)

# Path to the .env file
#file_to_find="../backend/.env.docker"

# Check the current FRONTEND_URL in the .env file
#current_url=$(sed -n "4p" $file_to_find)

# Update the .env file if the IP address has changed
#if [[ "$current_url" != "FRONTEND_URL=\"http://${ipv4_address}:5173\"" ]]; then
    #if [ -f $file_to_find ]; then
        #sed -i -e "s|FRONTEND_URL.*|FRONTEND_URL=\"http://${ipv4_address}:5173\"|g" $file_to_find
    #else
        #echo "ERROR: File not found."
    #fi
#fi
