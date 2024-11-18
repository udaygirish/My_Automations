#!/bin/bash

# Get list of available Tailscale devices
devices=$(tailscale status | awk '{print $2}' | grep -v "^$")

# Create numbered list of devices
echo "Available devices:"
i=1
while IFS= read -r device; do
    echo "$i) $device"
    i=$((i+1))
done <<< "$devices"

# Get user selection
echo -n "Select device number: "
read selection

# Get the selected device name
selected_device=$(echo "$devices" | sed -n "${selection}p")

# Get username
echo -n "Enter username: "
read username

# Establish SSH connection
ssh "${username}@${selected_device}"