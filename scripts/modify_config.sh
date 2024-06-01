#!/bin/bash
# run as `./scripts/modify_config.sh`

config="config.json"
deps_file="deps.list"
install_file="install.list"

deps_to_config() {
  local deps=$(grep '\S' $deps_file | jq -nR '[inputs]')
  cat <<<$(
    jq --argjson deps "$deps" '.check.apt = $deps' $config
  ) >$config
}

config_to_deps() {
  jq -r '.check.apt[]' $config >$deps_file
}

install_to_config() {
  local install=$(grep '\S' $install_file | jq -nR '[inputs]')
  cat <<<$(
    jq --argjson install "$install" '.install.apt = $install' $config
  ) >$config
}

config_to_install() {
  jq -r '.install.apt[]' $config >$install_file
}

install_to_config
