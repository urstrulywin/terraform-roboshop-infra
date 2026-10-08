#!/bin/bash
set -euo pipefail

component=${1:?"usage: $0 <component> <environment>"}   # e.g. mongodb
environment=${2:?"usage: $0 <component> <environment>"} # e.g. dev

REPO_URL="https://github.com/urstrulywin/ansible-project-roles.git"
REPO_DIR="/home/ec2-user/ansible-project-roles"
LOG_DIR="/var/log/roboshop"

# Install packages only if missing
command -v ansible-playbook >/dev/null 2>&1 || dnf install -y ansible
command -v git >/dev/null 2>&1 || dnf install -y git

# Log directory and file
mkdir -p "$LOG_DIR"
touch "$LOG_DIR/ansible.log"
chown -R ec2-user:ec2-user "$LOG_DIR"
chmod -R 755 "$LOG_DIR"

# Clone on first run, update on later runs
if [ -d "$REPO_DIR/.git" ]; then
  sudo -u ec2-user git -C "$REPO_DIR" pull --ff-only
else
  sudo -u ec2-user git clone "$REPO_URL" "$REPO_DIR"
fi

cd "$REPO_DIR"
ansible-playbook -e component="$component" -e env="$environment" main.yml