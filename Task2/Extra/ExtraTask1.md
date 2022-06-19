# Task 2 (Clouds)
## Task (Extra 1, Sub-task 1)

### Infrastructure

PM / DM me to check created AWS infrastructure
[Add some image here (With preview)](https://exadel-tasks.s3.amazonaws.com/2/extra/screencapture-52-22-139-132-info-html-2022-06-18-18_53_34.png)


### Task details

> Ping and SSH connections between **two servers** is working\
  Ping and SSH connections between **client and server** is working

- Created two **VPCs** with following settings:
  - **First VPC**:
    - Name: **task-2-extra-2**
    - CIDR: `10.0.1.0/24` (Max. 255 IPs)
  - **Second VPC**:
    - Name: **task-2-extra-1**
    - CIDR: `10.0.2.0/24` (Max. 255 IPs)
- Created two **subnets** with following settings attached to previously created VPC:
  - **First subnet**:
    - Availability zone (AZ): `us-east-1a`
    - CIDR: `10.0.0.1/24`
  - **Second subnet**:
    - Availability zone (AZ): `us-east-1a`
    - CIDR: `10.0.0.2/24`
- Created two **Internet Gateway** attached to VPCs created at first step
- Leased two **Elastic IPs** from AWS IP pool:
  - `44.207.96.49`
  - `52.73.170.146`
- Created one **Peering connection** with following settings:
  - Requester VPC: **task-2-extra-2**
  - Accepter VPC: **task-2-extra-1**
  - Classic Link:
    - Allow outbound communication from ClassicLink instances in requester VPC to accepter VPC: yes
    - Allow outbound communication from ClassicLink instances in accepter VPC to requester VPC: yes
- Created two **Routing table** with following settings:
    - Name: **task-2-extra-1**
    - Routes:
      - Destination: `0.0.0.0/0`
        - Target: Internet gateway for 1st VPC in extra step
      - Destination: `10.0.2.0/0`
        - Target: Peering connection created before
    - Name: **task-2-extra-2**
    - Routes:
      - Destination: `0.0.0.0/0`
        - Target: Internet gateway for extra 2nd VPC
      - Destination: `10.0.1.0/0`
        - Target: Peering connection created before
- Created **security groups** with following rules:

| Protocol (L4) | Protocol (L7) | Port | Source IP | Description |
| ----------- | ----------- | ----------- | ----------- | ----------- |
| UDP | ICMP | 1-65535 | 0.0.0.0/0 | To allow ping |
| TCP | SSH | 22 | 0.0.0.0/0 | Make SSH clients able to connect to instance |
| TCP | HTTP | 80 | 0.0.0.0/0 | Make available to connect to nginx web-server port 80 |
| TCP | HTTPS | 443 | 0.0.0.0/0 | Make available to connect to nginx web-server port 443 |



## Task (Extra 1, Sub-task 2)

> The following Bash script will update installed packages, install nginx and generate file with 'Hello world' and system info to specified location\
> Open http://52.73.170.146/info.html to see script result

---

``` shell
# Stop script when some step is failed
set -e

# Output of info file
SYSTEM_INFO_FILE_LOCATION="/var/www/html/info.html"


# Update package index
printf "\n#####################################################"
printf "\n############## Updating packages ... ################"
printf "\n#####################################################\n\n"

sudo apt-get -y update


# Upgrade all installed packages
printf "\n#####################################################"
printf "\n############## Upgrading packages ... ###############"
printf "\n#####################################################\n\n"

sudo apt-get -y upgrade


# Install nginx web-server
printf "\n#####################################################"
printf "\n############## Installing nginx web server ... ######"
printf "\n#####################################################\n\n"

sudo apt-get -y install nginx


# Wait 3 seconds
printf "\n#####################################################"
printf "\n############## Waiting 3 seconds ... ################"
printf "\n#####################################################\n\n"

sleep 3


# Generate page with "Hello World" text and system information
printf "\n#####################################################"
printf "\n############## Generating webpage with ##############"
printf "\n############## Hello World text and #################"
printf "\n############## system information ###################"
printf "\n#####################################################\n\n"

# Empty info file
echo "" > $SYSTEM_INFO_FILE_LOCATION

# Fill contents
cat << EOF >> $SYSTEM_INFO_FILE_LOCATION
<!DOCTYPE html>
<html>
<head>
    <meta charset="utf-8">
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <link
        rel="stylesheet"
        href="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/css/bootstrap.min.css"
        integrity="sha384-1BmE4kWBq78iYhFldvKuhfTAU6auU8tT94WrHftjDbrCEXSU1oBoqyl2QvZ6jIW3"
        crossorigin="anonymous"
    >
    <title>System info file</title>
</head>
<body>
    <div class="container">
        <div class="row">
            <div class="col">
                <h1 class="text-center mt-3">Hello World</h1>
            </div>
        </div>

        <div class="row">
            <div class="col">
                <hr />
            </div>
        </div>

        <div class="row">
            <div class="col">
                <h3 class="mb-2 mt-4">OS version (Output of <code>cat /etc/os-release</code>):</h3>
                <pre>
$(sudo bash -c "echo -en '$(cat /etc/os-release)\n'")
                </pre>
            </div>
        </div>

        <div class="row">
            <div class="col">
                <hr />
            </div>
        </div>

        <div class="row">
            <div class="col">
                <h3 class="mb-2 mt-4">Free disk space (Output of <code>df -h</code>):</h3>
                <pre>
$(sudo bash -c "echo -en '$(df -h)\n'")
                </pre>
            </div>
        </div>

        <div class="row">
            <div class="col">
                <hr />
            </div>
        </div>

        <div class="row">
            <div class="col">
                <h3 class="mb-2 mt-4">Memory status (Output of <code>free -mh</code>):</h3>
                <pre>
$(sudo bash -c "echo -en '$(free -mh)\n'")
                </pre>
            </div>
        </div>

        <div class="row">
            <div class="col">
                <hr />
            </div>
        </div>

        <div class="row">
            <div class="col">
                <h3 class="mb-2 mt-4">Process list (Output of <code>ps aux</code>):</h3>
                <pre>
$(sudo bash -c "echo -en '$(ps aux | tr '<' '&lt;' | tr '>' '&gt;')\n'")
                </pre>
            </div>
        </div>
    </div>

</body>

EOF

printf "\n#####################################################"
printf "\n############## Done ... #############################"
printf "\n#####################################################\n"

```


---


## Task (Extra 1, Sub-task 3)


- Created IAM role:
  - Name: **custom-ec2-ssm**
    - Trusted entity type: **AWS Service**
    - Trusted entity use case: **EC2**
    - Permission policies:
      - **AmazonSSMManagedInstanceCore**
- Set EC2 instance IAM Role value to role created in previous step
- Go to (**AWS Systems manager > Node Manager > Session Manager > Start session**)
- Wait from 3 to 15 minutes (refresh page every 15-30 seconds)
- After waiting and refreshing page you see EC2 instance that you've changed IAM Role
- Select it (with radio button in left side) and press **Start session**
- After connecting to EC2 instance type `sudo su root` to get access to root user of this EC2 instance
