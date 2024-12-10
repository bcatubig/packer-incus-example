#!/usr/bin/env bash

set -euo pipefail

apt-get update
apt-get -y dist-upgrade
apt-get -y install \
  ansible \
  curl \
  git \
  openssh-server \
  sudo \
  vim

# Add ubuntu user
useradd --create-home -s /usr/bin/zsh -G sudo -U example
echo "example ALL=(ALL) NOPASSWD:ALL" >/etc/sudoers.d/90-incus
chmod 440 /etc/sudoers.d/90-incus
