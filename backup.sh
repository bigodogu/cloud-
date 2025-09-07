#!/bin/bash
#Author : Nil
# Backup Script: Compress a directory and save with timestamp

# Exit immediately if a command exits with a non-zero status
set -e

# Function to show usage
usage() {
    echo "Usage: $0 <source_directory> <destination_directory>"
    exit 1
}

# Check for required arguments
if [ "$#" -ne 2 ]; then
    usage
fi

SOURCE_DIR="$1"
DEST_DIR="$2"
TIMESTAMP=$(date +"%Y-%m-%d_%H-%M-%S")
BACKUP_NAME="backup_${TIMESTAMP}.tar.gz"

# Check if source directory exists
if [ ! -d "$SOURCE_DIR" ]; then
    echo "Error: Source directory '$SOURCE_DIR' does not exist."
    exit 2
fi

# Create destination directory if it doesn't exist
mkdir -p "$DEST_DIR"

# Create the backup
tar -czf "${DEST_DIR}/${BACKUP_NAME}" -C "$SOURCE_DIR" .

# Check if backup was created successfully
if [ -f "${DEST_DIR}/${BACKUP_NAME}" ]; then
    echo " Backup successful: ${DEST_DIR}/${BACKUP_NAME}"
else
    echo " Backup failed."
    exit 3
fi
