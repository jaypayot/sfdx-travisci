#!/bin/bash -e

#create temp folder 
mkdir TEMP_DEPLOY
mkdir METADATATODEPLOY

echo "Running Git Diff - current branch to master"

#Check the diff from the start of create branch to the last commit
git config diff.renameLimit 999999
git diff --name-only --patience master..HEAD > diffListFiles

head -n 10 diffListFiles

echo "Running TAR file and extract"
#create a tar file to get all delta files
tar -czvf deploy_files.taz.gz -X excludedFilesList --files diffListFiles 

#unzip the tar file so we can convert to temp folder
tar -zxvf deploy_files.taz.gz -C ./TEMP_DEPLOY
ls -la ./TEMP_DEPLOY

#echo "Running Convert to mdAPI"
#convert the unzip tar file to mdapi data
#sfdx force:mdapi:convert --rootdir ./TEMP_DEPLOY/force-app/ --outputdir ./METADATATODEPLOY

#ls -la ./METADATATODEPLOY

sfdx force:source:deploy --wait 10 --sourcepath ./TEMP_DEPLOY/force-app --targetusername TestAuto
#echo "Running Deploy to mdAPI"
#sfdx force:mdapi:deploy --deploydir ./METADATATODEPLOY --targetusername TestAuto
#sfdx force:mdapi:deploy --zipfile deploy_files.taz.gz  --targetusername TestAuto

#sfdx force:source:deploy --ignoreerrors --ignorewarnings --sourcepath force-app --targetusername TestAuto


