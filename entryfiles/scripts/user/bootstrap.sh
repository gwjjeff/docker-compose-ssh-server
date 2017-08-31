#!/bin/bash

# The file will be run as POWER_USER at $HOME/scripts dir
# this script run as a step of the entrypoint file
# so DO NOT run any service like process here

# echo ===================
# echo $HOME
# echo `dirname $0`

# cd $HOME    \
# && wget -q http://10.0.2.2/downloads/hadoop-2.7.4.tar.gz \
# && tar xf hadoop-2.7.4.tar.gz \
# && rm hadoop-2.7.4.tar.gz

#!/usr/bin/env bash
. /etc/profile.d/misc.sh
. /etc/profile.d/docker_inspects.sh
cp -r $HADOOP_PREFIX/etc/hadoop $HOME/conf

if [ -d $HOME/scripts/$USER/conf ]; then
    find $HOME/scripts/$USER/conf -type f -exec sed -i -e "s~{{CONTAINER_BOX}}~$CONTAINER_BOX~g; s~{{NM_HOSTNAME}}~$CONTAINER_HOSTNAME~g" {} \;
    cp -r $HOME/scripts/$USER/conf $HOME/
    mkdir -p $HOME/log $HOME/pid
fi