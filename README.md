# Parasoft Funcitonal Demo VM

## Table of Contents
* Description
* CTP Demo VM Contents
* Upgarde Instructions
* Demo Scripts
* Utilities
* Changelog

## Description
The following image conatiners necessary Parasoft compnents and demo components to support a functional demo. The imae contains CTP, SOAVirt Server w/ pre-loaded demo assets, Data Repository with pre-laoded data, Parabank V1/V2 configured for http and jdbc virtualization, Demo App.

## CTP Demo VM Contents
The image runs a cronjob which can be examined with `crontab -e`.
The cronjob run the following command:
```
@reboot docker-compose -f /home/ec2-user/parasoft/docker-compose/docker-compose.yml start
```

The full directory structure can be seen below:
```
parasoft
 ┣ docker-compose
 ┃ ┣ ctp
 ┃ ┃ ┣ exports
 ┃ ┃ ┗ hsqldb
 ┃ ┣ datarepo
 ┃ ┃ ┗ repositories
 ┃ ┣ parabank
 ┃ ┃ ┣ jdbc.properties
 ┃ ┃ ┣ parabank-baseline.tar
 ┃ ┃ ┣ parabank-updated.tar
 ┃ ┃ ┗ setenv.sh
 ┃ ┣ soavirt
 ┃ ┃ ┣ workspace
 ┃ ┃ ┗ config.properties
 ┃ ┣ .env
 ┃ ┣ .gitignore
 ┃ ┣ docker-compose-${backups}.yml
 ┃ ┗ docker-compose.yml
 ┗ README.md
```

To check running docker conatainers run `docker ps`

## Upgrade Instrcutions

1. Stop Docker Compose:
    ```
    cd /home/ec2-user/parasoft/docker-compose
    docker-compose down
    ```
2. Back up docker-compose.yml
    ```
    cp docker-compose.yml docker-compose-${verison}.yml
    ```
3. Modify docker-compose.yml with your favorite editor or vi:
    - ctp image (line 4)
        - update DB version on restart step 4
    - soavirt-server image (line 28)
        - refersh server on restart step 4
    - datarepo image (line 52)

4. Validate .yml and rebuild and start docker-compose
    ```
    docker-compose up --build -d
    ```
5. Update README.md Changelog section

## Demo Scripts
The following demos are availble and preconfigured on this demo VM        

## Utlities
* docker
* docker-compose
* minikube: https://minikube.sigs.k8s.io/docs/start/
* ncdu: https://www.cyberciti.biz/open-source/install-ncdu-on-linux-unix-ncurses-disk-usage/

## Changelog
- 10/20/25
    + Upgrade CTP/SOAVirt/agents to 2025.3
    - remove LTC
    - remove Admin system in CTP
    + rename Parabank systems to DEV > QA > SIT > UAT > PROD conventions
- 4/29/25
    + added LTC
    + upgraded to 2025.1
- 1/8/24
    + removed agent.jar and replaced with custom Dockerfile per: https://parasoft-tech.atlassian.net/wiki/external/ODZhZWI0Mzg5ZTZjNDRlZTg4ZDVkY2RiMGJkOTcwYTk
    + removed unnecessary Loan Processor assets
    + renamed ProxyBank_Learn -> ParabankLearn and updated relevant paths
- 11/8/24
    + Added Parabank Learning Mode workflow to CTP/EM & Virtualize Server
    + Modified Parabank init.sh to include REST Endpoint for Virtualize proxy
    + Consolidated Loan Processor workflow with CRUD workflow to support REST Endpoint, all working through the Retail Component, the Loan Processor Component is now just for show.  
        - Added two PVAs to show working & broken versions of Loan Processor while also being able to use the environment for Leaning Mode demos
        - Left old PVAs in Virtualize workspace just in case
        - Left old proxies in Virtualize workspace just in case
        - Removed Health Check from Loan Processor Component Instance
    + Added Parabank_CRUD.pva to Virtualize Server (kept old Parabank-CRUD.pva but no longer used in EM)
    + Added Data Reset and Data Generation TSTs to SOAtest Server, added Jobs to run them from CTP
- 10/18/23
    + 2023.2 update
    + remove CAM
    + fix Demo App proxy
        - Demo App Learning Mode Demo?
- 8/30/23
    + fixed a typo in the docker compose file for 'host.docker.internal'
    + smaller tomcat jre flavor for CAM dockerfile.
- 5/17/23
    + Upgrade ctp/soavirt from 2022.2.1 to 2023.1
    + update PSTSec to use PSTSecConfig.xml
    + Convert volume mount to bind mounts
    + Re-upload snapshots for some reason to fix Sandbox flow
- 3/23/23
    + Add CAM on port 6080
- 2/15/23
    + remove parabank volume
    + add parabank/init.sh and demo-app/init.sh
- 1/25/23
    + CTP/SOAVirt 2022.2 -> 2022.2.1
    + Fix "Validte Demo VM Job"
    + Convert parabank image to parasoft/parabank
        - JDBC and Coverage Agent enabled
    + Add demo-app from parasoft/demo-app
        - defuult deployment
    + Install ncdu:
        - reclaimed 11gb of space
    + Install minikube
- 10/26/22:
  + DR 3.6 -> 3.6.1
    + added new variables for connecting to CTP to docker-compose.yml
    + added new vars to .env to satisfy entrypoint.sh script.
- 10/25/22:
  - Added ParabankV2 service on port http/8091/9021/61617
- 10/19/22:
    + Add README.md to ${ec2_user_home}/parasoft
    + 2022.1 -> 2022.2
        + remove deprecated settings in config.properties
        - need to 2022.2.1 -> 2022.1 prior to public image to resolve CTP-8230
    + DR 3.0 -> 3.6
        + changed the repositories volume to bind mount to resolve write permissions
    + resolved CTP-8230
        + removed 'Parabank Accounts REST API.tst' as it is corrupted
        + renamed 'Parabank Account' tests to remove spaces
        + moved to /ParabankAPITests
        + Fixed Health checks in the Parabank System
    + fix 'Clone Sandbox' CTP Job
        + add additional port range in docker-compose.yaml
    + added and validated Parabank-Deposit-CRUD.tst
    + Added 'Validate Demo VM' Job for VM health checks
    
## Other General Notes

### Initial Setup Instructions
1. Install Docker
2. Install Docker Compose
3. Create Volumes
    * hsqldb: `./ctp/hsqldb`
    * exports: `./ctp/exports`
    * workspace: `./soavirt/workspace`
  
### CTP
* Volumes
```
./ctp/hsqldb
./ctp/exports
```

* Set Up DB on Fisrt Start
    1. Create New Database
    2. Select HSQLDB
    3. Click OK

### SOAVirt
* Volume `./soavirt/workspace`
* Mountpoint `./soavirt/config.properties`

* Configurations
    + REST API
        * PUT /preferences
        see docs.parasoft.com
    + config.properties

### Data Repository
* Mountpoint `./datarepo/repositories`

### Parabank
* Mountpoint `./parabank/parabank`
* Demos
    + API Tests
    + Record Loan Processor
    + JDBC demo + TDM

### Demo App
    Need more info

### Licensing
* .env file or CTP
* soavirt/config.properties for SOAVirt

### Update

    cp docker-compose.yml docker-compose-backup.yml
    vi docker-compose.yml

### References
docs.parasoft.com