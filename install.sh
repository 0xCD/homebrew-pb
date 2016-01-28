#!/bin/bash
if [[ $EUID -ne 0 ]]; then
  echo "Root is required. Try 'sudo install.sh'."
  exit 1
else
  pb='/usr/local/bin/pb';
  if [[ $(cp ./pb.sh ${pb}) -eq 0 ]] && [[ $(chmod +x ${pb}) -eq 0 ]]; then
    echo "Successfully installed. Login required"
    ./login.sh
    exit 0;
  else
    echo "Failed to install pb. Do you have permission to write in /usr/local/bin?"
    exit 1;
  fi
fi