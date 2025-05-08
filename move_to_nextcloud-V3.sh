#!/bin/bash

# Define Nextcloud path
NEXTCLOUD_PATH="$HOME/Nextcloud"

# Ask user for confirmation
read -p "Use at your own Risk. Are you sure you want to continue? (yes/no): " CONFIRMATION

if [[ "$CONFIRMATION" != "yes" ]]; then
    echo "Operation canceled."
    exit 0
fi

# Ensure Nextcloud folder exists
if [ ! -d "$NEXTCLOUD_PATH" ]; then
    echo "Error: Nextcloud folder not found at $NEXTCLOUD_PATH"
    exit 1
fi

# Generate timestamp to avoid overwriting existing folders
TIMESTAMP=$(date +"%Y%m%d_%H%M%S")

# Check if Desktop folder already exists in Nextcloud, and create a new one if necessary
if [ -d "$NEXTCLOUD_PATH/Desktop" ]; then
    echo "Nextcloud Desktop folder already exists. Creating a new folder..."
    NEW_DESKTOP="$NEXTCLOUD_PATH/Desktop_$TIMESTAMP"
    mv "$HOME/Desktop" "$NEW_DESKTOP"
else
    mv "$HOME/Desktop" "$NEXTCLOUD_PATH/Desktop"
fi

# Check if Documents folder already exists in Nextcloud, and create a new one if necessary
if [ -d "$NEXTCLOUD_PATH/Documents" ]; then
    echo "Nextcloud Documents folder already exists. Creating a new folder..."
    NEW_DOCUMENTS="$NEXTCLOUD_PATH/Documents_$TIMESTAMP"
    mv "$HOME/Documents" "$NEW_DOCUMENTS"
else
    mv "$HOME/Documents" "$NEXTCLOUD_PATH/Documents"
fi

# Create symbolic links to preserve access
ln -s "$NEXTCLOUD_PATH/Desktop" "$HOME/Desktop"
ln -s "$NEXTCLOUD_PATH/Documents" "$HOME/Documents"

# Refresh Finder without logout
killall Finder

# Notify user
echo "Successfully moved Desktop and Documents to Nextcloud."
echo "If existing folders were detected, new ones were created with a timestamp."