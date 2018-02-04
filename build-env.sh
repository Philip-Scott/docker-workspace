#!/usr/bin/env bash
set -euo pipefail
IFS=$'\n\t'

#/ Usage: docker build -t docker-workspace .
#/ Description: Installs all the packages on pkglist
#/   --help: Display this help message
usage() { grep '^#/' "$0" | cut -c4- ; exit 0 ; }
expr "$*" : ".*--help" > /dev/null && usage

readonly LOG_FILE="/tmp/$(basename "$0").log"
info()    { echo "[INFO]    $*" | tee -a "$LOG_FILE" >&2 ; }


if [[ "${BASH_SOURCE[0]}" = "$0" ]]; then
  apt-get update -qq

  info "Adding the elementary repos"
  apt-get -qq -y install software-properties-common
  add-apt-repository -y ppa:elementary-os/os-patches
  add-apt-repository -y ppa:elementary-os/daily
  apt-get update -qq

  info "Installing packages from pkglist..."
  grep -vE "^#" < pkglist | xargs apt-get -qq install -y

  info "Adding the elementary packages"
  apt-get update && apt-get install -y elementary-os-overlay
  apt-get -y dist-upgrade

  mkdir /home/user

  info "Installation complete :)"
fi