#!/bin/bash
curl -o /etc/yum.repos.d/jenkins.repo https://pkg.jenkins.io/rpm-stable/jenkins.repo
yum upgrade -y
yum install fontconfig java-21-openjdk jenkins -y
systemctl daemon-reload

#resize disk from 20GB to 50GB
growpart /dev/nvme0n1 4
lvextend -L +10G /dev/RootVG/rootVol
lvextend -L +10G /dev/mapper/RootVG-varVol
lvextend -l +100%FREE /dev/mapper/RootVG-varTmpVol
xfs_growfs /
xfs_growfs /var/tmp
xfs_growfs /var

# Start Jenkins
systemctl daemon-reload
systemctl enable jenkins
systemctl start jenkins
echo "================================="
systemctl status jenkins
echo "=================================="


#echo "******* Resize EBS Storage ****************"
# ec2 instance creation request for Docker expense project
# =============================================
# RHEL-9-DevOps-Practice
# t3.micro
# allow-everything
# 50 GB

# lsblk &>>$LOGFILE
# sudo growpart /dev/nvme0n1 4 &>>$LOGFILE #t3.micro used only
# sudo lvextend -l +50%FREE /dev/RootVG/rootVol &>>$LOGFILE
# sudo lvextend -l +50%FREE /dev/RootVG/varVol &>>$LOGFILE
# sudo xfs_growfs / &>>$LOGFILE
# sudo xfs_growfs /var &>>$LOGFILE
# echo "******* Resize EBS Storage ****************"