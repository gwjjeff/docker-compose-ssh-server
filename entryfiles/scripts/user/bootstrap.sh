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
cp -r $HADOOP_PREFIX/etc/hadoop $HOME/conf
cp $HOME/scripts/$USER/* $HOME/conf

mkdir -p $HOME/log $HOME/pid
