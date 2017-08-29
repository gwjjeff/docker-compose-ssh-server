#!/usr/bin/env bash
if [ "$USER" == "hdfs" ]; then
    # $HADOOP_PREFIX/bin/hdfs namenode -format
    
    # $HADOOP_PREFIX/sbin/start-dfs.sh
    # $HADOOP_PREFIX/sbin/start-yarn.sh

    # $HADOOP_PREFIX/bin/hdfs dfs -mkdir /user
    # $HADOOP_PREFIX/bin/hdfs dfs -mkdir /user/$USER
    # $HADOOP_PREFIX/bin/hdfs dfs -put $HOME/conf input

    # $HADOOP_PREFIX/bin/hadoop jar $HADOOP_PREFIX/share/hadoop/mapreduce/hadoop-mapreduce-examples-2.7.4.jar grep input output 'dfs[a-z.]+'
    # $HADOOP_PREFIX/bin/hdfs dfs -cat output/*
fi