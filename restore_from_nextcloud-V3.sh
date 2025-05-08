#!/bin/bash

# Ask user for confirmation
read -p " Use at your own Risk. Are you sure you want to continue? (yes/no): " CONFIRMATION

# Check user input
if [[ "$CONFIRMATION" != "yes" ]]; then
    echo "Operation canceled."
    exit 0
fi

# Define Nextcloud path
NEXTCLOUD_PATH="$HOME/Nextcloud"

# Ensure Nextcloud folders exist
if [ ! -d "$NEXTCLOUD_PATH/Desktop" ] || [ ! -d "$NEXTCLOUD_PATH/Documents" ]; then
    echo "Error: Nextcloud folders not found."
    exit 1
fi

# Remove symbolic links if they exist
rm -f "$HOME/Desktop"
rm -f "$HOME/Documents"

# Recreate local Desktop and Documents folders
mkdir -p "$HOME/Desktop"
mkdir -p "$HOME/Documents"

# Create shortcut links *inside* restored folders, rather than replacing them
ln -s "$NEXTCLOUD_PATH/Desktop" "$HOME/Desktop/Nextcloud_Shortcut"
ln -s "$NEXTCLOUD_PATH/Documents" "$HOME/Documents/Nextcloud_Shortcut"

# Refresh Finder without logout
killall Finder

# Notify user
echo "Desktop and Documents folders restored locally while keeping data in Nextcloud."
echo "Shortcut links to Nextcloud created inside Desktop and Documents."