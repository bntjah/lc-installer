#!/bin/bash
## Check if Version is defined Else using our own
if [ -z "$1" ] then
        nginx_version=1.12.1
        else
        nginx_version=$1
fi

## Check if URL for Download is given else using our own
if [ -z "$2" ] then
        nginx_url=http://nginx.org/download/nginx-$nginx_version.tar.gz
        else
        nginx_url=$2
fi

## Check if Range_Cache is requested  or not
if [ -z "$3" ] then
        range_cache=N
        else
        range_cache=Y
fi

## Check if Installed; if not build it
if [ -ne "/usr/local/nginx/bin/nginx/" ] then
                ## Download Nginx
                curl $nginx_url -O  | tar zxvf>/dev/null

                ## BUILD Nginx
                cd $curdir/data/nginx-$nginx_version
                apt-get install -y libpcre3 libpcre3-dev zlib1g-dev libreadline-dev libncurses5-dev libssl-dev
                        if [ "$range_cache"=="N"] then
                                ###  No Range Cache
                                source Files/NoRange.sh
                        else
                                ### Using Range Cache
                                source Files/RangeCache.sh
                        fi
        else
                echo "There is already a version of NGINX installed"
fi
