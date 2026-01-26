#!/bin/bash
set -e

# Update package metadata
apt update -y

# Ensure required packages are installed
apt install -y apache2 openjdk-11-jdk

# Ensure Apache is enabled and running
systemctl enable apache2
systemctl start apache2

# Enforce Apache security hardening
sed -i 's/^ServerTokens OS/ServerTokens Prod/' \
/etc/apache2/conf-available/security.conf

# Apply configuration changes without downtime
systemctl reload apache2
