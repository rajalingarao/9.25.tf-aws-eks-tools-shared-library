# Jenkins Plugins:
Pipeline stage view
AnsiColor
Pipeline Utility Steps
Nexus Artifact Uploader
Rebuild
Restart Jenkins once plugins are installed

Configure aws credentials in jenkins agent. you should configure with normal user.

disable node monitoring since our instances are with less memory. add jenkins agent as node inside jenkins master.



# Terraform commands jenkins master and agents
```
terraform init -reconfigure
```
```
terraform plan
```
```
terraform apply -auto-approve
```

# Nexus Commands
How to login into Nexus Server and create a backend repository?
ssh -i  ~/.ssh/tools ubuntu@34.238.246.76

ssh -i ~/.ssh/tools ubuntu@nexus.lithesh.shop, it’s not working here, use nexus Ip address.
username:admin
password is located in /opt/sonatype-work/nexus3/admin.password on the server
cat /opt/sonatype-work/nexus3/admin-password
copy and paste before @ubuntu, the code before/upto @ubuntu terminal.

Open in the browser:
http://nexus.lithesh.shop:8081/
Nexus can run on Ubuntu and its port number is 8081

Go to Repository --> 
maven2(hosted)
permissive
allow-redeploy


# Sonarqube Server
How to login into Nexus Server and create a backend repository?
ssh -i  ~/.ssh/tools ubuntu@35.173.211.65
sudo cat /opt/default-sonar-login.txt


* Sonarqube server Login:
Username:admin
Password: random generated value copy and paste it.

Open in the browser:
http://sonarqube.lithesh.shop:9000/
http://54.83.99.123:9000/


Dashboard > Manage Jenkins > Plugins
SonarQube scanner plugin

Dashboard > Manage Jenkins >Tools
SonarQube scanner installation

Dashboard > Manage Jenkins > System
Set up sonar server installation url

Please add nexus credentials in Global Credentials in Jenkins
ssh-auth
nexus-auth
sonar-auth  key based authentication
generate key in sonarqube and attach in Jenkins as secret text.
Myaccountsecuritygenerate tokens(sonar-key, Global analysis token, no expiration)
Copy and save key. 

Go to Jenkins credentials and select secret test and save as sonar-key. And select in sonar qube under Jenkins plugins

Please restart the Jenkins system
$sudo systemctl restart Jenkins

SonarQube server will run on 9000 ports



# How to Login into VPN Server:
ssh -i ~/.ssh/OpenVPN openvpnas@107.23.133.209
yes
yes
yes
yes
enter
enter
enter
enter
yes
yes
password:Abcd#1234

https://44.220.144.240:943/admin
username:openvpn
password:Abcd#1234

