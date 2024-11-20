#!/bin/bash

# Initialize DB for Parabank baseline
curl \
-X POST \
--header "Content-Type: application/json" \
--header "Accept: application/json" \
--raw  "http://localhost:8090/parabank/services/bank/initializeDB" >> /home/ec2-user/parabank-startup.log

# Initialize DB for Parabank feature
curl \
-X POST \
--header "Content-Type: application/json" \
--header "Accept: application/json" \
--raw  "http://localhost:8091/parabank/services/bank/initializeDB" >> /home/ec2-user/parabank-startup.log

# Get cookie
curl --cookie-jar tmp.txt -iv --raw "http://localhost:8090/parabank/admin.htm"

# Set Proxies
curl \
-X POST \
--header "Content-Type: application/x-www-form-urlencoded; charset=UTF-8" \
--header "Accept: text/html" \
--header "Accept-Encoding: gzip, deflate, br" \
--header "Cookie: 1" \
--cookie tmp.txt \
--data-urlencode "accessMode=restjson" \
--data-urlencode "soapEndpoint=http://soavirt-server:9080/ParabankProxy" \
--data-urlencode "restEndpoint=http://soavirt-server:9080/ProxyBank_Learn" \
--data-urlencode "endpoint=http://soavirt-server:9080/LoanProcessorProxy" \
--data-urlencode "initialBalance=2000" \
--data-urlencode "minimumBalance=100" \
--data-urlencode "loanProvider=ws" \
--data-urlencode "loanProcessor=funds" \
--data-urlencode "loanProcessorThreshold=20" \
-iv --raw  "http://localhost:8090/parabank/admin.htm" >> /home/ec2-user/parabank-startup.log

#Clean Up
rm -f tmp.txt