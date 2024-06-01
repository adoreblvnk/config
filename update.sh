#!/bin/bash
# /usr/bin

set -euo pipefail

if ! command -v jq &>/dev/null; then
  sudo apt-get -qq update
  sudo apt-get -qy install jq
fi

# ----- Apt -----

sudo apt-get update -qq
sudo apt-get upgrade -qy
if $(jq '.update.aptFull' config.json); then
  sudo apt-get autoclean -qqy
  sudo apt-get autoremove -qqy
fi

# ----- Flatpak -----
if $(jq '.update.flatpak' config.json) && command -v flatpak &>/dev/null; then
  flatpak update -y
fi

# ----- Rust -----
if $(jq '.update.rust' config.json) && command -v rustup &>/dev/null; then
  rustup update
  cargo install-update -a
fi
