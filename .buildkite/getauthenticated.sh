#!/bin/bash -e

echo "Start running Authentication"

ls -al

#Checking the encripted key
test -f ./assets/server.key.enc && echo "$FILE server key exists."


#Decript key
echo "running the decript key"
openssl enc -aes-256-cbc -md sha256 -salt -d -in ./assets/server.key.enc -out ./assets/server.key -k $SERVER_KEY_PASSWORD -pbkdf2

test -f ./assets/server.key && echo "$FILE decrypted key exists."

echo "running the auth using JWT"
sfdx force:auth:jwt:grant --clientid $SALESFORCE_CONSUMER_KEY --jwtkeyfile ./assets/server.key --username $SF_USERNAME -s --setalias TestAuto --instanceurl $SF_URL

#sleep 5

#running all test
#sfdx force:apex:test:run --wait 10 --resultformat human --codecoverage --testlevel RunLocalTests -u TestAuto

#running specified test
#sfdx force:apex:test:run --wait 10 --resultformat human --codecoverage --testlevel RunSpecifiedTests -u TestAuto -n CbtCustomerServiceTest
#sfdx force:apex:test:run --wait 10 --resultformat human --codecoverage --testlevel RunSpecifiedTests -u TestAuto -n UserProvisioningControllerTest


wait 


#echo "running the force:auth:list"
#sfdx force:auth:list --loglevel trace

#echo y | sfdx force:auth:logout -u TestAuto