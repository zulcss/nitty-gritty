FROM registry.access.redhat.com/ubi8/ubi:latest

# Silence annoying subscription messages.
RUN echo "enabled=0" >> /etc/yum/pluginconf.d/subscription-manager.conf

RUN yum update -y && \
    yum install -y python3-pip python3-devel gcc gcc-c++ make sudo \
        git

RUN useradd -u 1001 stack && \
    echo "stack ALL=(ALL) NOPASSWD:ALL" > /etc/sudoers.d/00-stack-user
RUN mkdir /browbeat && chown -R stack /browbeat

USER stack
ENV HOME /home/stack
RUN pip3 install --user git+https://github.com/zulcss/browbeat.git
RUN pip3 install --user rally rally-openstack autopep8
RUN pip3 install --user 'jsonschema<3.0.2'
