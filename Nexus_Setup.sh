#!/bin/bash
# Update and upgrade packages
sudo apt update -y
sudo apt upgrade -y
sudo apt install openjdk-11-jdk -y

# Add a user and give them a password
sudo adduser nexus --gecos "Nexus Repository" --disabled-password
echo "nexus:nexuspassword" | sudo chpasswd

# Give the same user sudo permissions
sudo usermod -aG sudo nexus

# Download Nexus Repository Manager
cd /opt
sudo wget https://download.sonatype.com/nexus/3/latest-unix.tar.gz

# Extract the tarball
sudo tar -xvf latest-unix.tar.gz

# Rename the extracted folder
sudo mv nexus-3.* nexus

# Set ownership permissions for Nexus
sudo chown -R nexus:nexus /opt/nexus
sudo chown -R nexus:nexus /opt/sonatype-work

# Configure Nexus as a service
echo 'run_as_user="nexus"' | sudo tee -a /opt/nexus/bin/nexus.rc

# Create the systemd service for Nexus
sudo bash -c 'cat > /etc/systemd/system/nexus.service <<EOF
[Unit]
Description=Nexus Repository Manager
After=network.target

[Service]
Type=forking
LimitNOFILE=65536
ExecStart=/opt/nexus/bin/nexus start
ExecStop=/opt/nexus/bin/nexus stop
User=nexus
Restart=on-abort

[Install]
WantedBy=multi-user.target
EOF'

# Enable and start Nexus service
sudo systemctl enable nexus
sudo systemctl start nexus

