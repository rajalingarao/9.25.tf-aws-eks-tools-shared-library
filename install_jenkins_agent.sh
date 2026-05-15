#!/bin/bash

#resize disk from 20GB to 50GB
growpart /dev/nvme0n1 4

lvextend -L +10G /dev/mapper/RootVG-homeVol
lvextend -L +10G /dev/mapper/RootVG-varVol
lvextend -l +100%FREE /dev/mapper/RootVG-varTmpVol

xfs_growfs /home
xfs_growfs /var/tmp
xfs_growfs /var

#java-21 installation on Jenkins Agent
yum install fontconfig java-21-openjdk -y
#This repository We are using for Jenkins only. So not below installation steps.

# docker
yum install -y yum-utils
yum-config-manager --add-repo https://download.docker.com/linux/centos/docker-ce.repo
yum install docker-ce docker-ce-cli containerd.io docker-buildx-plugin docker-compose-plugin -y
systemctl start docker
systemctl enable docker
usermod -aG docker ec2-user

# echo "******* Resize EBS Storage ****************"
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


#Installing Terraform on Jenkins Agent
yum install -y yum-utils
yum-config-manager --add-repo https://rpm.releases.hashicorp.com/RHEL/hashicorp.repo
yum -y install terraform


#Node JS installation
dnf module disable nodejs -y
dnf module enable nodejs:20 -y
dnf install nodejs -y

#Installing zip in Jenins Agent
yum install zip -y

#We can't do resize ec2 instance volume in the ec2 instance creation.

# Helm
curl -fsSL -o get_helm.sh https://raw.githubusercontent.com/helm/helm/main/scripts/get-helm-3
chmod 700 get_helm.sh
./get_helm.sh


echo "*************   kubectl installation - start *************"
curl -O https://s3.us-west-2.amazonaws.com/amazon-eks/1.30.0/2024-05-12/bin/linux/amd64/kubectl 
sudo chmod +x ./kubectl 
sudo mv kubectl  /usr/local/bin/ 
kubectl version --client 
echo "*************   kubectl installation - completed *************"