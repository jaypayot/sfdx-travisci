#!/bin/bash -e

echo "Start running script"
    
export CLIURL=https://developer.salesforce.com/media/salesforce-cli/sfdx-linux-386.tar.xz
#https://developer.salesforce.com/media/salesforce-cli/sfdx-linux-amd64.tar.xz
export SFDX_AUTOUPDATE_DISABLE=false
export SFDX_USE_GENERIC_UNIX_KEYCHAIN=true
export SFDX_DOMAIN_RETRY=300
export SFDX_DISABLE_APP_HUB=true
export SFDX_LOG_LEVEL=DEBUG


#Create SFDX Directory
echo "Creating Directory"
mkdir sfdx

#Install Salesforce CLI
echo "Installing Salesforce CLI"

wget -qO- $CLIURL | tar xJ -C sfdx --strip-components 1
sudo ./sfdx/install
export PATH=./sfdx/$(pwd):$PATH


echo "Checking version"
sfdx --version
echo "Checking plugin core"
sfdx plugins --core

# Output CLI version and plug-in information
echo "Checking update is disable"
echo "TO:DO Need to look why S3 host is not reachable during update"
#sfdx update

#Install git packager
echo "Ignore the sfdx-git-packager due to error"
#echo y | sfdx plugins:install sfdx-git-packager

