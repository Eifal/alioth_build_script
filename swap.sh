#!/bin/bash

# Check if running as root
if [ "$(id -u)" -ne "0" ]; then
  echo "This script must be run as root. Please use 'sudo' or switch to root user."
  exit 1
fi

# Create and activate swap file (32GB)
SWAPFILE="/swapfile"
if [ ! -f "$SWAPFILE" ]; then
  echo "Creating swap file..."
  fallocate -l 32G $SWAPFILE
  chmod 600 $SWAPFILE
  mkswap $SWAPFILE
  swapon $SWAPFILE
  echo "$SWAPFILE none swap sw 0 0" >> /etc/fstab
  echo "Swap file created and activated."
else
  echo "Swap file already exists."
fi
