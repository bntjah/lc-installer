#!/bin/bash
# Updating local DNS resolvers
ip_2_use=$1
ping -c 4 ${ip_2_use}>/dev/null
if [ "$?"=="0" ]; then
                echo "nameserver "${ip_2_use}> /etc/resolv.conf
        else
                echo "I'm sorry but I can't reach that ip"
fi

## Capture Result for Fancy Status Colors
set EXIT_RESULT=$?

## Display The Result in Color
echo Adding ${IP_2_use} to DNS
if [ "$EXIT_RESULT"=="0" ]; then
                echo_success
        else
                echo_failure
fi
echo

