# Task 2 (Clouds)

## Task 1 (Mandatory)
### Result page
:globe_with_meridians: http://52.73.170.146/info.html


<!-- ### Infrastructure -->

<!-- :speech_balloon: PM / DM me to check created AWS infrastructure -->


### Task details

> Ping and SSH connections between **two servers** is working\
  Ping and SSH connections between **second server and client** is working

- Created one **VPC** with following settings:
  - CIDR: `10.0.0.0/24` (Max. 255 IPs, 10.0.0.1-10.0.0.255)
- Created one **subnet** with following settings attached to previously created VPC:
  - Availability zone (AZ): `us-east-1a`
  - CIDR: `10.0.0.0/24`
- Created one **Internet Gateway** attached to VPC created at first step
- Leased one **Elastic IP** from AWS IP pool:
  - `52.73.170.146`
- Created one **Route table** attached to VPC created at first step
- Created two **EC2 instances** in same VPC without auto assigning public IP with following Elastic IPs:
  - [\<No Elastic IP\> / 10.0.0.72](http://10.0.0.72/) (First EC2 instance, Works on **Amazon Linux 2**)
  - [52.73.170.146 / 10.0.0.134](http://52.73.170.146/) (Second EC2 instance, Works on **Ubuntu 22.04**)
- Created **security group** for **first** EC2 instance with following rules:

| Protocol (L4) | Protocol (L7) | Port | Source IP | Description |
| ----------- | ----------- | ----------- | ----------- | ----------- |
| UDP | ICMP | 1-65535 | 10.0.0.134/32 | To allow ping |
| TCP | SSH | 22 | 10.0.0.134/32 | Make SSH clients able to connect to instance |

- Created **security group** for **second** EC2 instance with following rules:

| Protocol (L4) | Protocol (L7) | Port | Source IP | Description |
| ----------- | ----------- | ----------- | ----------- | ----------- |
| UDP | ICMP | 1-65535 | 0.0.0.0/0 | To allow ping |
| TCP | SSH | 22 | 0.0.0.0/0 | Make SSH clients able to connect to instance |
| TCP | HTTP | 80 | 0.0.0.0/0 | Make available to connect to nginx web-server port 80 |
| TCP | HTTPS | 443 | 0.0.0.0/0 | Make available to connect to nginx web-server port 443 |


---
