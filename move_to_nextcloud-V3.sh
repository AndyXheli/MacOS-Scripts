#!/bin/bash

# Define Nextcloud path (modify if necessary)
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

# Move Desktop to Nextcloud ONLY if it exists, while preserving permissions
if [ -d "$NEXTCLOUD_PATH/Desktop" ]; then
    echo "Nextcloud Desktop folder already exists. Merging contents..."
    rsync -a --progress "$HOME/Desktop/" "$NEXTCLOUD_PATH/Desktop/"
    rm -rf "$HOME/Desktop"  # Remove original Desktop after merging
else
    mv "$HOME/Desktop" "$NEXTCLOUD_PATH/Desktop"
fi

# Move Documents to Nextcloud ONLY if it exists, while preserving permissions
if [ -d "$NEXTCLOUD_PATH/Documents" ]; then
    echo "Nextcloud Documents folder already exists. Merging contents..."
    rsync -a --progress "$HOME/Documents/" "$NEXTCLOUD_PATH/Documents/"
    rm -rf "$HOME/Documents"  # Remove original Documents after merging
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
echo "Existing folders were merged, and permissions were preserved."
