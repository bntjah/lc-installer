#!/bin/bash
## Install sniproxy
#apt-get install libudns0 libudns-dev libev4 libev-dev devscripts automake libtool autoconf autotools-dev cdbs debhelper dh-autoreconf dpkg-dev gettext  pkg-config fakeroot -y

git clone https://github.com/dlundquist/sniproxy $nginx_workdir/sniproxy >/dev/null
cd $nginx_workdir/sniproxy
echo "Running AutoGen.sh"
./autogen.sh
if [ "$?"=="0" ]; then
        echo_success
else
        echo_failure
fi
echo "Configuring..."
./configure >/dev/null
if [ "$?"=="0" ]; then
        echo_success
else
        echo_failure
fi
echo "Making preparations..."
make >/dev/null
if [ "$?"=="0" ]; then
        echo_success
else
        echo_failure
fi
echo "Installing Sniproxy"
make install >/dev/null
if [ "$?"=="0" ]; then
        echo_success
else
        echo_failure
fi
echo "Downloading Our Sniproxy Config from bntjah's Github"
curl https://raw.githubusercontent.com/OpenSourceLAN/origin-docker/master/sniproxy/sniproxy.conf -o /etc/sniproxy.conf >/dev/null
if [ "$?"=="0" ]; then
        echo_success
else
        echo_failure
fi
