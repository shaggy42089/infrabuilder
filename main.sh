#!/bin/bash

if [[ -d /usr/local/infrabuilder ]]; then
  mkdir /usr/local/infrabuilder
fi

#this is for apt systems, check the official docker documentation for more
#support :
#https://docs.docker.com/engine/install/
sudo apt-get install docker-ce docker-ce-cli containerd.io docker-buildx-plugin docker-compose-plugin

while [ $# -gt 0 ]; do
  cmd=$1
  shift
  case $cmd in
    --help)
      echo "usage : $0 [deploy|isolate|close] [infrastructure] [options]"
      return 1
      ;;
    --deploy)
      if [ -z $1 ];then
        echo "empty infrastructure type"
      fi

  esac
done
