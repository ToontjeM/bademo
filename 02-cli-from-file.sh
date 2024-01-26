#!/bin/bash
source env.sh
less config_file.yaml
printf "${H}--- biganimal cluster create -F config_file.yaml --- ${N}\n"
biganimal cluster create -F config_file.yaml
biganimal cluster show