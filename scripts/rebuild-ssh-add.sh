#!/bin/bash

set -eo pipefail

# Main function of this script
function rebuild_ssh_add {

  # Set the directory where SSH key files are located
  ssh_dir="$HOME/.ssh"

  # Check if the directory exists
  if [ ! -d "$ssh_dir" ]; then
    echo "Directory $ssh_dir does not exist."
    exit 1
  fi

  echo "Clear the ssh-add directory."
  ssh-add -D

  # Loop through files in the directory
  for file in "$ssh_dir"/*; do
    if [ -f "$file" ] && [[ ! $file == *.bkup && ! $file == *.pub ]]; then
      filename=$(basename "$file")

      # Check if the filename matches your criteria
      if [[ $filename == *-lcl-* || $filename == *-dev-* || $filename == *-prod-* ]]; then
        echo "Processing file: $filename"
        ssh-add $ssh_dir/$filename
      fi
    fi
  done
}

#Test or running stand alone.
# install_tool
