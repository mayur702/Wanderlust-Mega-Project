#!/bin/bash

# Set the GCP project details
PROJECT_ID="peaceful-campus-449014-b0"  # GCP Project ID
ZONE="us-central1-f"                    # GCP VM zone (e.g., us-central1-a)
INSTANCE_ID="5268997931165599090"        # GCP VM Instance ID

# Retrieve the external IP address of the specified GCP VM instance
ipv4_address=$(gcloud compute instances describe $INSTANCE_ID --project $PROJECT_ID --zone $ZONE --format='get(networkInterfaces[0].accessConfigs[0].natIP)')

# Path to the .env file
file_to_find="../frontend/.env.docker"

# Check the current VITE_API_PATH in the .env file
current_url=$(cat $file_to_find)

# Update the .env file if the IP address has changed
if [[ "$current_url" != "VITE_API_PATH=\"http://${ipv4_address}:31100\"" ]]; then
    if [ -f $file_to_find ]; then
        sed -i -e "s|VITE_API_PATH.*|VITE_API_PATH=\"http://${ipv4_address}:31100\"|g" $file_to_find
        echo "Updated VITE_API_PATH in .env.docker to: http://${ipv4_address}:31100"
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
#file_to_find="../frontend/.env.docker"

# Check the current VITE_API_PATH in the .env file
#current_url=$(cat $file_to_find)

# Update the .env file if the IP address has changed
#if [[ "$current_url" != "VITE_API_PATH=\"http://${ipv4_address}:31100\"" ]]; then
    #if [ -f $file_to_find ]; then
        #sed -i -e "s|VITE_API_PATH.*|VITE_API_PATH=\"http://${ipv4_address}:31100\"|g" $file_to_find
    #else
    #    echo "ERROR: File not found."
    #fi
#fi
