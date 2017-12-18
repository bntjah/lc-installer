#!/bin/bash

## Checking if CURL is installed if not installing it
if [ ! -f "/usr/bin/curl" ]; then
        echo "Installing CURL"
        apt-get install -y curl >/dev/null
                if [ "$?"=="0" ]; then
                        echo_success
                else
                        echo_failure
                fi
fi

## Checking if WGET is installed if not installing it
if [ ! -f "/usr/bin/wget" ]; then
        echo "Installing WGET"
        apt-get install -y wget >/dev/null
                if [ "$?"=="0" ]; then
                        echo_success
                else
                        echo_failure
                fi
fi


## Checking if GIT is installed if not installing it
if [ ! -f "/usr/bin/git" ]; then
        echo "Installing GIT"
        apt-get install -y git >/dev/null
                if [ "$?"=="0" ]; then
                        echo_success
                else
                        echo_failure
                fi
fi

## Checking Build Essential is installed if not installing it
if [ ! -f "/usr/bin/make" ]; then
        echo "Installing Build-Essential"
        apt-get install -y build-essential>/dev/null
                if [ "$?"=="0" ]; then
                        echo_success
                else
                        echo_failure
                fi
fi

## Checking Zlib1G-Dev
if [ ! -f "/usr/include/zlib.h" ]; then
        echo "Installing Zlib1G-Dev"
        apt-get install -y zlib1g-dev>/dev/null
                if [ "$?"=="0" ]; then
                        echo_success
                else
                        echo_failure
                fi
fi

## Checking LibPCRE3
if [ ! -f "/usr/lib/x86_64-linux-gnu/libpcre32.so " ]; then
        echo "Installing LibPCRE3-Dev and LibPCRE3"
        apt-get install -y libpcre3-dev libpcre3>/dev/null
                if [ "$?"=="0" ]; then
                        echo_success
                else
                        echo_failure
                fi
fi

## Checking LibGD
if [ ! -f "/usr/lib/x86_64-linux-gnu/libgd.so/usr/lib/x86_64-linux-gnu/libgd.so" ]; then
        echo "Installing LIBGD2-XPM-DEV"
        apt-get install -y libgd2-xpm-dev>/dev/null
                if [ "$?"=="0" ]; then
                        echo_success
                else
                        echo_failure
                fi
fi

## Checking LibGeoIP
if [ ! -f "/usr/lib/x86_64-linux-gnu/libGeoIP.so" ]; then
                echo "Installing LibGeoIP-Dev"
                apt-get install -y libgeoip-dev>/dev/null
                if [ "$?"=="0" ]; then
                        echo_success
                else
                        echo_failure
                fi
fi
