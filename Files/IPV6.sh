#!/bin/bash
# Disabling IPv6
echo "net.ipv6.conf.all.disable_ipv6=1">/etc/sysctl.d/disable-ipv6.conf
sysctl -p /etc/sysctl.d/disable-ipv6.conf

## Capture Result for Fancy Status Colors
set EXIT_RESULT=$?

## Display The Result in Color
echo Disabling IPV6
if [ "$EXIT_RESULT"=="0" ]; then
                echo_success
        else
                echo_failure
fi
echo
