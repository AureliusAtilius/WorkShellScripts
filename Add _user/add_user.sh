#!/bin/bash

# Define the username you want to add
USERNAME="newuser"

# Define the public key file path (optional, if you want to set up SSH key-based authentication)
PUBLIC_KEY_FILE="/path/to/public_key.pub"

# Define the hosts you want to add the user to
HOSTS=(
    "host1.example.com"
    "host2.example.com"
    "host3.example.com"
)

# Define the password for the new user (optional, if you want to set a password)
PASSWORD="your_password_here"

# Loop through each host
for HOST in "${HOSTS[@]}"; do
    echo "Adding user $USERNAME to $HOST..."

    # Add the user
    ssh -o "StrictHostKeyChecking=no" "$HOST" "sudo useradd -m -s /bin/bash $USERNAME"

    # Set password if provided
    if [ -n "$PASSWORD" ]; then
        ssh -o "StrictHostKeyChecking=no" "$HOST" "echo \"$USERNAME:$PASSWORD\" | sudo chpasswd"
    fi

    # Set up SSH key-based authentication if public key provided
    if [ -n "$PUBLIC_KEY_FILE" ]; then
        ssh -o "StrictHostKeyChecking=no" "$HOST" "mkdir -p /home/$USERNAME/.ssh && chmod 700 /home/$USERNAME/.ssh && \
            cat $PUBLIC_KEY_FILE | sudo tee -a /home/$USERNAME/.ssh/authorized_keys && \
            chmod 600 /home/$USERNAME/.ssh/authorized_keys && \
            sudo chown -R $USERNAME:$USERNAME /home/$USERNAME/.ssh"
    fi

    echo "User $USERNAME added to $HOST"
done

echo "User addition process completed."
