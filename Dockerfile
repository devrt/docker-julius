# Julius base image
# - install julius
# - install dictationkit
# - run ssh server

FROM devrt/base

MAINTAINER Yosuke Matsusaka "yosuke.matsusaka@gmail.com"

RUN apt-get -y update
RUN apt-get install -y openssh-server

RUN mkdir -p /var/run/sshd
RUN echo 'root:julius' | chpasswd

ADD . /chef
RUN cd /chef && /opt/chef/embedded/bin/berks install --path /chef/cookbooks
RUN chef-solo -c /chef/solo.rb -j /chef/solo.json

EXPOSE 22

CMD ["/usr/sbin/sshd", "-D"]
