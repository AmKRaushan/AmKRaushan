#!/bin/bash

## Moving to the .ssh directory
cd ~/.ssh
read -p "Enter your mail to use it as comments on generating ssh-key: " mail

## Generating ssh-keys on ed25519 algorithmS
ssh-keygen -t ed25519 -C $mail

read -p "Enter your ssh-key name, that you previously entered the file name while generating ssh-keys: " ssh_key_name

## Starting the ssh-agent service
eval $(ssh-agent -s)
ssh-add ~/.ssh/$ssh_key_name

## Copying the public key to clipboard
if [ -f ~/.ssh/$ssh_key_name.pub ]; then
    cat ~/.ssh/$ssh_key_name.pub | clip
else
    echo "Public key file not found."
fi

## Confirm the operation
echo "SSH public key copied to clipboard, now paste it on your github account."

read -p "Are you pasted your public ssh-key on your github account? (y/n): " answer
if [ "$answer" == "y" ]; then
    echo "Now you can clone your repository using ssh."
else
    echo "Please paste your public ssh-key on your github account and try again."
fi

## Generating the configurations for ssh
read -p "Enter the local host name (e.g., AmKRaushan): " host
read -p "Enter the public host name (e.g., github.com, gitlab.com): " host_name
read -p "Enter the user name (e.g., AmKRaushan): " user

## Config file contexts

config_block="
Host $host
  HostName $host_name
  User $user
  IdentityFile ~/.ssh/$ssh_key_name
  AddKeysToAgent yes
"
echo $config_block | clip
echo "Configurations copied, now paste it into your config file at ~/.ssh/config"

## Confirm the configurations for config file
read -p "Are you pasted your configurations with a valid indentations on your config file and saved? (y/n): " config
if [ "$config" == "y" ]; then
    echo "Now you can verify your configurations."
else
    echo "Please paste your configurations on your config file and save it."
fi

# verifying configurations
ssh -vT git@$host

## SSH login succeed with exit code 1 status
echo "You have successfully logged in to your SSH account."

## Feedback from user
read -p "Please give us your feedback about this script in the comment box on my youtube channel named [AmKRaushan], had you given your feedback? (y/n): " feedback

if [ "$feedback" == "y" ]; then
    echo "Thanks for subscribing us..."
else
    echo "Please share your feedback in the comment box on my youtube channel [AmKRaushan], did you accessed your github accounts using this bash script"
fi