#!/bin/bash
## Variables
nginx_workdir=/usr/portbuild/www/nginx/work
## Check if Version is defined Else using our own
if [ -z "$1" ]; then
        nginx_version=1.13.7
else
        nginx_version=$1
fi

## Check if URL for Download is given else using our own
if [ -z "$2" ]; then
        nginx_url=http://nginx.org/download/nginx-$nginx_version.tar.gz
        else
        nginx_url=$2
fi
## Check if Installed; if not build it
if [ ! -f "/usr/local/sbin/nginx" ]; then
                ## Download Nginx
                if [ ! -d "$nginx_workdir" ]; then
                        mkdir -p "$nginx_workdir"
                fi
                cd $nginx_workdir
                if [ ! -d "$nginx_workdir/nginx-$nginx_version" ]; then
                        echo "Downloading Nginx from the internet"
                        wget $nginx_url -O $nginx_workdir/nginx-$nginx_version.tar.gz >/dev/null
                        if [ "$?"=="0" ]; then
                                echo_success
                        else
                                echo_failure
                        fi

                        echo "Unpacking the Downloaded File"
                        tar zxvf $nginx_workdir/nginx-$nginx_version.tar.gz>/dev/null
                        if [ "$?"=="0" ]; then
                                echo_success
                        else
                                echo_failure
                        fi
                fi

                if [ ! -d "$nginx_workdir/nginx-push-stream-module-0.5.1" ]; then
                        echo "Unpacking Wandenberg NGNX Push Stream Module"
                        if [ ! -f "$nginx_workdir/wandenberg-nginx-push-stream-module-0.5.1_GH0.tar.gz" ]; then
                                wget "https://codeload.github.com/wandenberg/nginx-push-stream-module/tar.gz/0.5.1?dummy=/wandenberg-nginx-push-stream-module-0.5.1_GH0.tar.gz" -O "$nginx_workdir/wandenberg-nginx-push-stream-module-0.5.1_GH0.tar.gz" >/dev/null
                        fi
                        tar zxvf "$nginx_workdir/wandenberg-nginx-push-stream-module-0.5.1_GH0.tar.gz" >/dev/null
                        if [ "$?"=="0" ]; then
                                echo_success
                        else
                                echo_failure
                        fi
                fi

                if [ ! -d "$nginx_workdir/ngx_cache_purge-2.3" ]; then
                        echo "Unpacking Frickle Labs NGNX Cache Purge Module"
                        if [ ! -f "$nginx_workdir/ngx_cache_purge-2.3.tar.gz" ]; then
                                wget "http://labs.frickle.com/files/ngx_cache_purge-2.3.tar.gz" -O "$nginx_workdir/ngx_cache_purge-2.3.tar.gz" >/dev/null
                        fi
                        tar zxvf "$nginx_workdir/ngx_cache_purge-2.3.tar.gz" >/dev/null
                        if [ "$?"=="0" ]; then
                                echo_success
                        else
                                echo_failure
                        fi
                fi

                if [ ! -d "$nginx_workdir/nginx-range-cache" ]; then
                        echo "Downloading Multiplay Range Cache Module"
                        git clone https://github.com/multiplay/nginx-range-cache/ $nginx_workdir/nginx-range-cache>/dev/null
                        if [ "$?"=="0" ]; then
                                echo_success
                        else
                                echo_failure
                        fi
                fi

                cd  $nginx_workdir/nginx-$nginx_version
                echo "Patching NGINX for Range Cache from Multiplay"
                patch -p1 <$nginx_workdir/nginx-range-cache/range_filter.patch >/dev/null
                if [ "$?"=="0" ]; then
                        echo_success
                else
                        echo_failure
                fi

                echo "Configuring NGINX with the necessary modules"
                ./configure  --modules-path=$nginx_workdir --with-cc-opt='-I /usr/local/include' --with-ld-opt='-L /usr/local/lib' --conf-path=/usr/local/nginx/nginx.conf --sbin-path=/usr/local/sbin/nginx --pid-path=/var/run/nginx.pid --modules-path=/usr/local/libexec/nginx --with-file-aio --add-module=/usr/portbuild/www/nginx/work/ngx_cache_purge-2.3 --with-http_flv_module --with-http_geoip_module=dynamic --with-http_gzip_static_module --with-http_image_filter_module=dynamic --with-http_mp4_module --add-module=/usr/portbuild/www/nginx/work/nginx-range-cache --with-http_realip_module --with-http_slice_module --with-http_stub_status_module --with-pcre --with-http_v2_module --with-stream=dynamic --with-stream_ssl_module --with-stream_ssl_preread_module --with-http_ssl_module --add-module=/usr/portbuild/www/nginx/work/nginx-push-stream-module-0.5.1 --with-threads --with-http_stub_status_module >/dev/null
                echo "Making... Go Grab a coFfee or Redbull..."
               make >/dev/null
                echo "Installing..."
               make install >/dev/null
        else
                echo "There is already a version of NGINX installed"
fi
