#!/bin/bash

### I have no problem with you redistributing this under your own name
### Just leave the following piece of line in there
### Base created by Geoffrey "bn_" @ https://github.com/bntjah

# Disable IPV6?
# If you want to disable put a 1 below
# Otherwise leave it 0
lc_d_ipv6=0
# The version of NGINX you wish to download
lc_nginx_version=1.13.12
## Set the following to create a seperate user for the Lancache or not
## Set 1 for creation; and 0 to use the built in www account
lc_d_ucreate=0
## Set the following to install all the pre requisites
## Set 1 for yes; and 0 if you already have them installed
lc_i_prereq=1
## Set the following to compile and install a custom version of NGINX
## Set 1 for yes; and 0 to use the repository version
lc_c_nginx=1
nginx_workdir=/usr/portbuild/www/nginx/work


# Variables you should most likely not touch
# Unless you know what you are doing
lc_base_folder=/usr/local/lancache
lc_tmp_ip=/tmp/services_ips.txt
lc_tmp_unbound=$lc_base_folder/temp/unbound.conf
lc_tmp_hosts=$lc_base_folder/temp/hosts
lc_nginx_loc=/usr/local/nginx
lc_sniproxy_bin=/usr/local/sbin/sniproxy
lc_srv_loc=/srv/lancache
lc_unbound_loc=/etc/unbound
lc_nginx_url=http://nginx.org/download/nginx-$lc_nginx_version.tar.gz
lc_tmp_yaml=$lc_base_folder/temp/01-lancache.yaml


# Arrays used
# Services used and set ip for and created the lancache folders for
declare -a lc_services=(arena apple blizzard hirez gog glyph microsoft origin riot steam sony enmasse wargaming uplay zenimax digitalextremes pearlabyss)
# Installer Folders
declare -a lc_folders=(config data logs temp)
# Log Folders
declare -a lc_logfolders=(Access Error Keys)



### Below Be Dragons ###

# Following Checks if you run as ROOT or not
if [ "$EUID" -ne 0 ]
  then echo "Please run as root"
  exit
fi

# Pre Requisites
if [ ! "$lc_i_prereq" == "0" ]; then
        apt install -y libudns0 libudns-dev libev4 libev-dev devscripts automake libtool autoconf autotools-dev cdbs debhelper dh-autoreconf dpkg-dev gettext  pkg-config fakeroot libpcre3-dev libgd-dev libgeoip-dev libssl-dev
fi

declare -a ip_eth=$( ip link show | grep ens | tr ":" " " | awk '{ print $2 }' )
for int in ${ip_eth[@]}; do
        inet_eth=$( ip route get 8.8.8.8 | tr " " " " | awk '{ print $5 }'  )
        if [ "$inet_eth" == "$int" ]; then
                lc_ip_eth=$int
        fi
done

lc_ip=$( /bin/ip -4 addr show $lc_ip_eth | grep -oP "(?<=inet ).*(?=br)" )
#1st octet
lc_ip_p1=$(echo ${lc_ip} | tr "." " " | awk '{ print $1 }')
#2nd octet
lc_ip_p2=$(echo ${lc_ip} | tr "." " " | awk '{ print $2 }')
#3rd octet
lc_ip_p3=$(echo ${lc_ip} | tr "." " " | awk '{ print $3 }')
#4th octet
lc_ip_p4=$(echo ${lc_ip} | tr "." " " | awk '{ print $4 }' | cut -f1 -d "/" )
#Subnet
lc_ip_sn=$(echo ${lc_ip} | sed 's:.*/::' )


## Update lancache config folder from github
cd $lc_dl_dir
git pull --recurse-submodules
git submodule update --remote --recursive

for folder in ${lc_folders[@]}; do
        # Check if the folder exists if not creates it
        if [ ! -d "$lc_base_folder/$folder" ]; then
                mkdir -p $lc_base_folder/$folder
        fi
done

if [ ! -f "$lc_tmp_ip" ]; then
        for service in ${lc_services[@]}; do
                        # Check if the folder exists if not creates it
                        if [ ! -d "/tmp/data/$service" ]; then
                                mkdir -p /tmp/data/$service
                        fi

                        # Increases the IP with Every Run
                        lc_ip_p4=$(expr $lc_ip_p4 + 1)
                        # Writes the IP to A File to use it later on as Array
                        # This for Netplan later on
                        echo $lc_ip_p1.$lc_ip_p2.$lc_ip_p3.$lc_ip_p4/$lc_ip_sn >> "$lc_tmp_ip"

                        # This Changes the Unbound File with the correct IP Adresses
                        sed -i 's|lc-host-'$service'|'$lc_ip_p1.$lc_ip_p2.$lc_ip_p3.$lc_ip_p4'|g' $lc_tmp_unbound

                        # This Corrects the Host File For The Gameservices
                        sed -i 's|lc-host-'$service'|'$lc_ip_p1.$lc_ip_p2.$lc_ip_p3.$lc_ip_p4'|g' $lc_tmp_hosts

                        # This Corrects the Host File For The Netplan
                        sed -i 's|lc-host-'$service'|'$lc_ip_p1.$lc_ip_p2.$lc_ip_p3.$lc_ip_p4'|g' $lc_tmp_yaml

                done
        else
                echo Sorry Something went wrong as the file $lc_tmp_ip already exists!
fi

for logfolder in ${lc_logfolders[@]}; do
        # Check if the folder exists if not creates it
        if [ ! -d "$lc_base_folder/$folder" ]; then
                mkdir -p $lc_base_folder/$logfolder
        fi
done



if [ ! "$lc_d_ipv6" == "0" ]; then
                # Disabling IPv6
                sudo echo "net.ipv6.conf.all.disable_ipv6=1" >/etc/sysctl.d/disable-ipv6.conf
                sudo sysctl -p /etc/sysctl.d/disable-ipv6.conf
        else
                echo Leaving IPV6 untouched
fi

### Create Lancache User
if [ ! "$lc_d_ucreate" == "0" ]; then
        if id -u "lancache" >/dev/null 2>&1; then
                echo The user lancache exists so nothing needs to be done!
        else
                ## Create Lancache user with no home and no login ability
                adduser -s /usr/bin/nologin -d /srv/lancache -m lancache 
                # Add the group Lancache
                addgroup --system lancache
                # Add lancache user to group lancache
                usermod -aG lancache lancache
        fi
                chown -R lancache:lancache /srv/lancache
        else
                # Change Ownership of folders
                chown -R www-data:www-data /srv/lancache
fi

### Get Nginx Files and compile it with the addons
## Check if URL for Download is given else using our own
if [ -z "$2" ]; then
        nginx_url=http://nginx.org/download/nginx-$nginx_version.tar.gz
        else
        nginx_url=$2
fi

if [ ! "$lc_c_nginx" == "0"]; then
                ## Check if Installed; if not build it
                ## Download Nginx
                if [ ! -d "$nginx_workdir" ]; then
                mkdir -p "$nginx_workdir"
                fi

                cd $nginx_workdir
                echo "Downloading Nginx from the internet"
                # Get the version from the internet and compile it
                wget $nginx_url -O$nginx_workdir/nginx-$nginx_version.tar.gz >/dev/null
                echo "Unpacking the Downloaded File"
                tar zxvf $nginx_workdir/nginx-$nginx_version.tar.gz>/dev/null

                # Check if a previous workdir contains nginx-push-stream-module
                # If not download it and compile it again
                if [ ! -d "$nginx_workdir/nginx-push-stream-module-0.5.1" ]; then
                        echo "Unpacking Wandenberg NGNX Push Stream Module"
                        if [ ! -f "$nginx_workdir/wandenberg-nginx-push-stream-module-0.5.1_GH0.tar.gz" ]; then
                                wget "https://codeload.github.com/wandenberg/nginx-push-stream-module/tar.gz/0.5.1?dummy=/wandenberg-nginx-push-stream-module-0.5.1_GH0.tar.gz" -O "$nginx_workdir/wandenberg-nginx-push-stream-module-0.5.1_GH0.tar.gz" >/dev/null
                        fi
                        tar zxvf "$nginx_workdir/wandenberg-nginx-push-stream-module-0.5.1_GH0.tar.gz" >/dev/null
                fi
                # Check if a previous workdir contains nginx-cache-purge-module
                # If not download it and compile it again
                if [ ! -d "$nginx_workdir/ngx_cache_purge-2.3" ]; then
                        echo "Unpacking Frickle Labs NGNX Cache Purge Module"
                if [ ! -f "$nginx_workdir/ngx_cache_purge-2.3.tar.gz" ]; then
                                wget "http://labs.frickle.com/files/ngx_cache_purge-2.3.tar.gz" -O "$nginx_workdir/ngx_cache_purge-2.3.tar.gz" >/dev/null
                fi
                        tar zxvf
                        "$nginx_workdir/ngx_cache_purge-2.3.tar.gz" >/dev/null
                fi

                # Check if a previous workdir contains nginx-cache-purge-module
                # If not download it and compile it again
                if [ ! -d "$nginx_workdir/nginx-range-cache" ]; then
                echo "Downloading Multiplay Range Cache Module"
                git clone https://github.com/multiplay/nginx-range-cache/
                $nginx_workdir/nginx-range-cache>/dev/null
                fi

                cd  $nginx_workdir/nginx-$nginx_version
                echo "Patching NGINX for Range Cache from Multiplay"
                # Installing NGINX Patch module with the patch provided by Multiplay GITHUB
                patch -p1<$nginx_workdir/nginx-range-cache/range_filter.patch >/dev/null

                echo "Configuring NGINX with the necessary modules"
                # Compile NGINX With the above compiled modules
                ./configure  --modules-path=$nginx_workdir --with-cc-opt='-I /usr/local/include' --with-ld-opt='-L /usr/local/lib' --conf-path=/usr/local/nginx/nginx.conf --sbin-path=/usr/local/sbin/nginx --pid-path=/var/run/nginx.pid --modules-path=/usr/local/libexec/nginx --with-file-aio --add-module=/usr/portbuild/www/nginx/work/ngx_cache_purge-2.3 --with-http_flv_module --with-http_geoip_module=dynamic --with-http_gzip_static_module --with-http_image_filter_module=dynamic --with-http_mp4_module --add-module=/usr/portbuild/www/nginx/work/nginx-range-cache --with-http_realip_module --with-http_slice_module --with-http_stub_status_module --with-pcre --with-http_v2_module --with-stream=dynamic --with-stream_ssl_module --with-stream_ssl_preread_module --with-http_ssl_module --add-module=/usr/portbuild/www/nginx/work/nginx-push-stream-module-0.5.1 --with-threads >/dev/null
                echo "Making... Go Grab a coffee or another caffeine drink..."
                make >/dev/null
                echo "Installing..."
                make install >/dev/null
        else
                apt install nginx
fi

echo "Getting ready to install sniproxy"
sleep 3

# Check if a previous workdir contains sniproxy
# If not download it and compile it again
if [ ! -d "$lc_base_folder/data/sniproxy" ]; then
        echo "Downloading Sniproxy"
        git clone https://github.com/dlundquist/sniproxy $lc_base_folder/data/sniproxy
        cd $lc_base_folder/data/sniproxy
        ./autogen.sh
        echo "Configuring Sniproxy with the necessary modules"
        ./configure >/dev/null
        echo "Making... Go Grab a coffee or another caffeine drink..."
        make >/dev/null
        echo "Installing..."
        make install >/dev/null
        curl https://raw.githubusercontent.com/OpenSourceLAN/origin-docker/master/sniproxy/sniproxy.conf -o /etc/sniproxy.conf
fi

### Change limits
if [ -f "$lc_dl_dir/lancache/limits.conf" ]; then
        sudo mv /etc/security/limits.conf /etc/security/limits.conf.bak
        sudo cp $lc_dl_dir/lancache/limits.conf /etc/security/limits.conf
fi

## Doing the necessary changes for Lancache
mv $lc_nginx_loc/conf/nginx.conf $lc_nginx_loc/conf/nginx.conf.bak
cp $lc_dl_dir/lancache/conf/nginx.conf $lc_nginx_loc/conf/nginx.conf
mkdir -p $lc_nginx_loc/conf/lancache
mkdir -p $lc_nginx_loc/conf/vhosts-enabled/
cp $lc_dl_dir/lancache/conf/lancache/* $lc_nginx_loc/conf/lancache
cp $lc_dl_dir/lancache/conf/vhosts-enabled/*.conf $lc_nginx_loc/conf/vhosts-enabled/

### To Do Still
### Change the proxy bind
### Systemd Scripts for everything
### ... and stuff I forgot ...
