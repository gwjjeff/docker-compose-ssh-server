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

CONTAINER_NAME=`curl -s --unix-socket /var/run/docker.sock "http:/v1.24/containers/${HOSTNAME%%.*}/json" | jq -r '.Name' | sed 's~/~~'`
echo "export CONTAINER_NAME=$CONTAINER_NAME" >> /etc/profile.d/docker_inspects.sh
echo "export CONTAINER_BOX=/data/$CONTAINER_NAME" >> /etc/profile.d/docker_inspects.sh

if [ -f /root/entryfiles/scripts/user/bootstrap.sh ]; then
    echo copy entry files....
    cp -r /root/entryfiles/scripts/user $POWER_USER_HOME/scripts
    chown -R $POWER_USER:$POWER_USER $POWER_USER_HOME/scripts
    echo copy user bootstrap script....
    su - $POWER_USER -c "sh $POWER_USER_HOME/scripts/bootstrap.sh"
fi

if [ -f $POWER_USER_HOME/scripts/${POWER_USER}_run.sup.conf ]; then
    echo copy user specified supervisor config....
    cp $POWER_USER_HOME/scripts/${POWER_USER}_run.sup.conf /etc/supervisor/supervisord.user.d
fi

if [ -d /data ]; then
    echo init data directory...
    mkdir -p /data/$CONTAINER_NAME
    chown $POWER_USER:$POWER_USER /data/$CONTAINER_NAME
fi

exec "$@"