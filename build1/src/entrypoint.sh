#!/bin/sh
set -e

useradd $POWER_USER

POWER_USER_HOME=$(eval echo ~$POWER_USER)

echo "$POWER_USER ALL=(ALL)       NOPASSWD: ALL" >> /etc/sudoers
cp -r /root/entryfiles/_ssh $POWER_USER_HOME/.ssh
cat $POWER_USER_HOME/.ssh/inscure_id_rsa_docker.pub > $POWER_USER_HOME/.ssh/authorized_keys
mv $POWER_USER_HOME/.ssh/inscure_id_rsa_docker $POWER_USER_HOME/.ssh/id_rsa
chown -R $POWER_USER:$POWER_USER $POWER_USER_HOME/.ssh
chmod 600 $POWER_USER_HOME/.ssh/id_rsa $POWER_USER_HOME/.ssh/authorized_keys
echo power user has been created: $POWER_USER

ifconfig

exec "$@"