FROM centos:6.9

RUN curl -s http://mirrors.163.com/.help/CentOS6-Base-163.repo > /etc/yum.repos.d/CentOS-Base.repo \
    && sed -i 's/enabled=1/enabled=0/' /etc/yum/pluginconf.d/fastestmirror.conf \
    && yum clean all \
    && yum makecache

RUN yum -y install openssh-server openssh-clients wget rsync
RUN yum -y install epel-release
# auto make cache
RUN yum -y install yum-utils
RUN yum-config-manager --enable rhui-REGION-rhel-server-extras rhui-REGION-rhel-server-optional
RUN yum -y install python-setuptools
RUN easy_install supervisor
RUN mkdir -p /etc/supervisor
COPY ./src/supervisord.conf /etc/supervisor/supervisord.conf

RUN yum -y install sudo
RUN sed -i \
	-e 's~^# %wheel\tALL=(ALL)\tALL~%wheel\tALL=(ALL) ALL~g' \
	-e 's~\(.*\) requiretty$~#\1requiretty~' \
	/etc/sudoers

# Generating SSH host key
RUN service sshd start && service sshd stop

# sshd / ssh
RUN sed -i 's/PasswordAuthentication yes/PasswordAuthentication no/' /etc/ssh/sshd_config

COPY ./src/entrypoint.sh /
RUN chmod +x /entrypoint.sh
ENTRYPOINT ["/entrypoint.sh"]
CMD ["/usr/bin/supervisord", "-c", "/etc/supervisor/supervisord.conf"]
