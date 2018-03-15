#!/bin/bash
## Set variables
lc_dl_dir=$( pwd )
lc_nginx_version=1.13.9
lc_nginx_url=http://nginx.org/download/nginx-$lc_nginx_version.tar.gz
lc_base_folder=/usr/local/lancache
lc_nginx_loc=/usr/local/nginx
lc_sniproxy_bin=/usr/local/sbin/sniproxy
lc_srv_loc=/srv/lancache
lc_unbound_loc=/etc/unbound
lc_date=$( date +"%m-%d-%y %T" )
lc_hn=$( hostname )
lc_int_log=interface_used.log
lc_list_int=$( ls /sys/class/net )
lc_ip_googledns1=8.8.8.8
lc_ip_googledns2=8.8.4.4
lc_ip_logfile=ip.log
lc_ip_gw=$( /sbin/ip route | awk '/default/ { print $3 }' )

## Create the necessary folders
sudo mkdir -p $lc_base_folder/config/
sudo mkdir -p $lc_base_folder/data/
sudo mkdir -p $lc_base_folder/logs/
sudo mkdir -p $lc_base_folder/temp

sudo chown -R $USER:$USER $lc_base_folder

## Divide the ip in variables
lc_ip=$( ip route get 8.8.8.8 | awk 'NR==1 {print $NF}')
lc_eth_int=$( ip route get 8.8.8.8 | awk '{print $5}' )
lc_eth_netmask=$( sudo ifconfig $lc_eth_int |sed -rn '2s/ .*:(.*)$/\1/p' )
lc_ip_p1=$(echo ${lc_ip} | tr "." " " | awk '{ print $1 }')
lc_ip_p2=$(echo ${lc_ip} | tr "." " " | awk '{ print $2 }')
lc_ip_p3=$(echo ${lc_ip} | tr "." " " | awk '{ print $3 }')
lc_ip_p4=$(echo ${lc_ip} | tr "." " " | awk '{ print $4 }')

## Increment the last IP digit for every Game
lc_incr_steam=$((lc_ip_p4+1))
lc_ip_steam=$lc_ip_p1.$lc_ip_p2.$lc_ip_p3.$lc_incr_steam

lc_incr_riot=$((lc_ip_p4+2))
lc_ip_riot=$lc_ip_p1.$lc_ip_p2.$lc_ip_p3.$lc_incr_riot

lc_incr_blizzard=$((lc_ip_p4+3))
lc_ip_blizzard=$lc_ip_p1.$lc_ip_p2.$lc_ip_p3.$lc_incr_blizzard

lc_incr_hirez=$((lc_ip_p4+4))
lc_ip_hirez=$lc_ip_p1.$lc_ip_p2.$lc_ip_p3.$lc_incr_hirez

lc_incr_origin=$((lc_ip_p4+5))
lc_ip_origin=$lc_ip_p1.$lc_ip_p2.$lc_ip_p3.$lc_incr_origin

lc_incr_sony=$((lc_ip_p4+6))
lc_ip_sony=$lc_ip_p1.$lc_ip_p2.$lc_ip_p3.$lc_incr_sony

lc_incr_microsoft=$((lc_ip_p4+7))
lc_ip_microsoft=$lc_ip_p1.$lc_ip_p2.$lc_ip_p3.$lc_incr_microsoft

lc_incr_enmasse=$((lc_ip_p4+8))
lc_ip_enmasse=$lc_ip_p1.$lc_ip_p2.$lc_ip_p3.$lc_incr_enmasse

lc_incr_gog=$((lc_ip_p4+9))
lc_ip_gog=$lc_ip_p1.$lc_ip_p2.$lc_ip_p3.$lc_incr_gog

lc_incr_arena=$((lc_ip_p4+10))
lc_ip_arena=$lc_ip_p1.$lc_ip_p2.$lc_ip_p3.$lc_incr_arena

lc_incr_wargaming=$((lc_ip_p4+11))
lc_ip_wargaming=$lc_ip_p1.$lc_ip_p2.$lc_ip_p3.$lc_incr_wargaming

lc_incr_uplay=$((lc_ip_p4+12))
lc_ip_uplay=$lc_ip_p1.$lc_ip_p2.$lc_ip_p3.$lc_incr_uplay

lc_incr_apple=$((lc_ip_p4+13))
lc_ip_apple=$lc_ip_p1.$lc_ip_p2.$lc_ip_p3.$lc_incr_apple

lc_incr_glyph=$((lc_ip_p4+14))
lc_ip_glyph=$lc_ip_p1.$lc_ip_p2.$lc_ip_p3.$lc_incr_glyph

lc_incr_uplay=$((lc_ip_p4+15))
lc_ip_uplay=$lc_ip_p1.$lc_ip_p2.$lc_ip_p3.$lc_incr_zenimax

lc_incr_apple=$((lc_ip_p4+16))
lc_ip_apple=$lc_ip_p1.$lc_ip_p2.$lc_ip_p3.$lc_incr_digitalextremes

lc_incr_glyph=$((lc_ip_p4+17))
lc_ip_glyph=$lc_ip_p1.$lc_ip_p2.$lc_ip_p3.$lc_incr_pearlabyss

## Put IP's in the log file
echo [ lc_date ] Information !!! >>$lc_base_folder/logs/$lc_ip_logfile
echo IP addresses being used: >>$lc_base_folder/logs/$lc_ip_logfile
echo >>$lc_base_folder/logs/$lc_ip_logfile
echo IP for $lc_eth_int is $lc_ip_p1.$lc_ip_p2.$lc_ip_p3.$lc_ip_p4 >>$lc_base_folder/logs/$lc_ip_logfile
echo Netmask for $lc_eth_int is $lc_eth_netmask >>$lc_base_folder/logs/$lc_ip_logfile
echo >>$lc_base_folder/logs/$lc_ip_logfile
echo Arena: $lc_ip_arena >>$lc_base_folder/logs/$lc_ip_logfile
echo Apple: $lc_ip_apple >>$lc_base_folder/logs/$lc_ip_logfile
echo Blizzard: $lc_ip_blizzard >>$lc_base_folder/logs/$lc_ip_logfile
echo GOG: $lc_ip_glyph >>$lc_base_folder/logs/$lc_ip_logfile
echo GOG: $lc_ip_gog >>$lc_base_folder/logs/$lc_ip_logfile
echo Hirez: $lc_ip_hirez >>$lc_base_folder/logs/$lc_ip_logfile
echo Microsoft: $lc_ip_microsoft >>$lc_base_folder/logs/$lc_ip_logfile
echo Origin: $lc_ip_origin >>$lc_base_folder/logs/$lc_ip_logfile
echo Riot: $lc_ip_riot >>$lc_base_folder/logs/$lc_ip_logfile
echo Steam: $lc_ip_steam >>$lc_base_folder/logs/$lc_ip_logfile
echo Sony: $lc_ip_sony >>$lc_base_folder/logs/$lc_ip_logfile
echo Enmasse: $lc_ip_enmasse >>$lc_base_folder/logs/$lc_ip_logfile
echo Uplay: $lc_ip_uplay >>$lc_base_folder/logs/$lc_ip_logfile
echo Wargaming: $lc_ip_wargaming >>$lc_base_folder/logs/$lc_ip_logfile
echo Zenimax: $lc_ip_zenimax >>$lc_base_folder/logs/$lc_ip_logfile
echo Digitalextremes: $lc_ip_digitalextremes >>$lc_base_folder/logs/$lc_ip_logfile
echo Pearlabyss: $lc_ip_pearlabyss >>$lc_base_folder/logs/$lc_ip_logfile

## Check Lancache user
    sudo adduser --system --no-create-home lancache
    sudo addgroup --system lancache
    sudo usermod -aG lancache lancache

## Creating the Necessary Folders for Lancache Data
sudo mkdir -p $lc_srv_loc/data/blizzard/
sudo mkdir -p $lc_srv_loc/data/microsoft/
sudo mkdir -p $lc_srv_loc/data/installs/
sudo mkdir -p $lc_srv_loc/data/other/
sudo mkdir -p $lc_srv_loc/data/tmp/
sudo mkdir -p $lc_srv_loc/data/hirez/
sudo mkdir -p $lc_srv_loc/data/origin/
sudo mkdir -p $lc_srv_loc/data/osx
sudo mkdir -p $lc_srv_loc/data/riot/
sudo mkdir -p $lc_srv_loc/data/sony/
sudo mkdir -p $lc_srv_loc/data/steam/
sudo mkdir -p $lc_srv_loc/data/wargaming/
sudo mkdir -p $lc_srv_loc/data/enmasse/
sudo mkdir -p $lc_srv_loc/data/arenanetworks/
sudo mkdir -p $lc_srv_loc/data/gog/
sudo mkdir -p $lc_srv_loc/data/uplay
sudo mkdir -p $lc_srv_loc/data/zenimax
sudo mkdir -p $lc_srv_loc/data/digitalextremes
sudo mkdir -p $lc_srv_loc/data/pearlabyss
sudo mkdir -p $lc_srv_loc/logs/
sudo mkdir -p $lc_srv_loc/logs/Errors
sudo mkdir -p $lc_srv_loc/logs/Keys
sudo mkdir -p $lc_srv_loc/logs/Access

sudo chown -R lancache:lancache $lc_srv_loc/
sudo chmod 755 -R $lc_srv_loc/

# Installing necessary packages
apt-get install -y curl wget git build-essential zlib1g-dev libpcre3-dev libpcre3 libgd2-xpm-dev libgeoip-dev

## Update lancache config folder from github
cd $lc_dl_dir
git pull --recurse-submodules
git submodule update --remote --recursive

## Download and extract nginx if not yet done
#!/bin/bash
## Variables
nginx_workdir=/usr/portbuild/www/nginx/work
## Check if Version is defined Else using our own
if [ -z "$1" ]; then
        nginx_version=$lc_nginx_version
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
                ## Download Nginx
                #if [ ! -d "$nginx_workdir" ]; then
                        mkdir -p "$nginx_workdir"
                #fi
                cd $nginx_workdir
                #if [ ! -d "$nginx_workdir/nginx-$nginx_version" ]; then
                        echo "Downloading Nginx from the internet"
                        wget $nginx_url -O $nginx_workdir/nginx-$nginx_version.tar.gz >/dev/null

                        echo "Unpacking the Downloaded File"
                        tar zxvf $nginx_workdir/nginx-$nginx_version.tar.gz>/dev/null
                #fi

                #if [ ! -d "$nginx_workdir/nginx-push-stream-module-0.5.1" ]; then
                        echo "Unpacking Wandenberg NGNX Push Stream Module"
                        #if [ ! -f "$nginx_workdir/wandenberg-nginx-push-stream-module-0.5.1_GH0.tar.gz" ]; then
                                wget "https://codeload.github.com/wandenberg/nginx-push-stream-module/tar.gz/0.5.1?dummy=/wandenberg-nginx-push-stream-module-0.5.1_GH0.tar.gz" -O "$nginx_workdir/wandenberg-nginx-push-stream-module-0.5.1_GH0.tar.gz" >/dev/null
                        #fi
                        tar zxvf "$nginx_workdir/wandenberg-nginx-push-stream-module-0.5.1_GH0.tar.gz" >/dev/null
                #fi

                #if [ ! -d "$nginx_workdir/ngx_cache_purge-2.3" ]; then
                        echo "Unpacking Frickle Labs NGNX Cache Purge Module"
                        #if [ ! -f "$nginx_workdir/ngx_cache_purge-2.3.tar.gz" ]; then
                                wget "http://labs.frickle.com/files/ngx_cache_purge-2.3.tar.gz" -O "$nginx_workdir/ngx_cache_purge-2.3.tar.gz" >/dev/null
                        #fi
                        tar zxvf "$nginx_workdir/ngx_cache_purge-2.3.tar.gz" >/dev/null
              #fi

                #if [ ! -d "$nginx_workdir/nginx-range-cache" ]; then
                        echo "Downloading Multiplay Range Cache Module"
                        git clone https://github.com/multiplay/nginx-range-cache/ $nginx_workdir/nginx-range-cache>/dev/null
                #fi

                cd  $nginx_workdir/nginx-$nginx_version
                echo "Patching NGINX for Range Cache from Multiplay"
                patch -p1 <$nginx_workdir/nginx-range-cache/range_filter.patch >/dev/null


                echo "Configuring NGINX with the necessary modules"
                ./configure  --modules-path=$nginx_workdir --with-cc-opt='-I /usr/local/include' --with-ld-opt='-L /usr/local/lib' --conf-path=/usr/local/nginx/nginx.conf --sbin-path=/usr/local/sbin/nginx --pid-path=/var/run/nginx.pid --modules-path=/usr/local/libexec/nginx --with-file-aio --add-module=/usr/portbuild/www/nginx/work/ngx_cache_purge-2.3 --with-http_flv_module --with-http_geoip_module=dynamic --with-http_gzip_static_module --with-http_image_filter_module=dynamic --with-http_mp4_module --add-module=/usr/portbuild/www/nginx/work/nginx-range-cache --with-http_realip_module --with-http_slice_module --with-http_stub_status_module --with-pcre --with-http_v2_module --with-stream=dynamic --with-stream_ssl_module --with-stream_ssl_preread_module --with-http_ssl_module --add-module=/usr/portbuild/www/nginx/work/nginx-push-stream-module-0.5.1 --with-threads >/dev/null
                echo "Making... Go Grab a coFfee or Redbull..."
               make >/dev/null
                echo "Installing..."
               make install >/dev/null

echo "Getting ready to install sniproxy"
sleep 3

## Install sniproxy
cd $lc_base_folder/data/
sudo apt-get install libudns0 libudns-dev libev4 libev-dev devscripts automake libtool autoconf autotools-dev cdbs debhelper dh-autoreconf dpkg-dev gettext  pkg-config fakeroot -y
rm -Rf sniproxy
git clone https://github.com/dlundquist/sniproxy
cd sniproxy
./autogen.sh
./configure
sudo make
sudo make install
sudo curl https://raw.githubusercontent.com/OpenSourceLAN/origin-docker/master/sniproxy/sniproxy.conf -o /etc/sniproxy.conf

## Doing the necessary changes for Lancache
cd $lc_dl_dir/lancache/conf
sudo mv $lc_nginx_loc/conf/nginx.conf $lc_nginx_loc/conf/nginx.conf.bak
sudo cp $lc_dl_dir/lancache/conf/nginx.conf $lc_nginx_loc/conf/nginx.conf
sudo mkdir -p $lc_nginx_loc/conf/lancache
sudo mkdir -p $lc_nginx_loc/conf/vhosts-enabled/
sudo cp $lc_dl_dir/lancache/conf/lancache/* $lc_nginx_loc/conf/lancache
sudo cp $lc_dl_dir/lancache/conf/vhosts-enabled/*.conf $lc_nginx_loc/conf/vhosts-enabled/

## Change Limits of the system for Lancache to work without issues
if [ -f "$lc_dl_dir/lancache/limits.conf" ]; then
	sudo mv /etc/security/limits.conf /etc/security/limits.conf.bak
	sudo cp $lc_dl_dir/lancache/limits.conf /etc/security/limits.conf
fi

## Preparing configuration for unbound
sudo mkdir -p /$lc_base_folder/temp/unbound/
cp $lc_dl_dir/lancache/unbound/unbound.conf $lc_base_folder/temp/unbound/
sed -i 's|lc-host-ip|'$lc_ip'|g' $lc_base_folder/temp/unbound/unbound.conf
sed -i 's|lc-host-proxybind|'$lc_ip'|g' $lc_base_folder/temp/unbound/unbound.conf
sed -i 's|lc-host-gw|'$lc_ip_gw'|g' $lc_base_folder/temp/unbound/unbound.conf
sed -i 's|lc-host-arena|'$lc_ip_arena'|g' $lc_base_folder/temp/unbound/unbound.conf
sed -i 's|lc-host-apple|'$lc_ip_apple'|g' $lc_base_folder/temp/unbound/unbound.conf
sed -i 's|lc-host-blizzard|'$lc_ip_blizzard'|g' $lc_base_folder/temp/unbound/unbound.conf
sed -i 's|lc-host-hirez|'$lc_ip_hirez'|g' $lc_base_folder/temp/unbound/unbound.conf
sed -i 's|lc-host-gog|'$lc_ip_gog'|g' $lc_base_folder/temp/unbound/unbound.conf
sed -i 's|lc-host-glyph|'$lc_ip_glyph'|g' $lc_base_folder/temp/unbound/unbound.conf
sed -i 's|lc-host-microsoft|'$lc_ip_microsoft'|g' $lc_base_folder/temp/unbound/unbound.conf
sed -i 's|lc-host-origin|'$lc_ip_origin'|g' $lc_base_folder/temp/unbound/unbound.conf
sed -i 's|lc-host-riot|'$lc_ip_riot'|g' $lc_base_folder/temp/unbound/unbound.conf
sed -i 's|lc-host-steam|'$lc_ip_steam'|g' $lc_base_folder/temp/unbound/unbound.conf
sed -i 's|lc-host-sony|'$lc_ip_sony'|g' $lc_base_folder/temp/unbound/unbound.conf
sed -i 's|lc-host-enmasse|'$lc_ip_enmasse'|g' $lc_base_folder/temp/unbound/unbound.conf
sed -i 's|lc-host-wargaming|'$lc_ip_wargaming'|g' $lc_base_folder/temp/unbound/unbound.conf
sed -i 's|lc-host-uplay|'$lc_ip_uplay'|g' $lc_base_folder/temp/unbound/unbound.conf
sed -i 's|lc-host-zenimax|'$lc_ip_zenimax'|g' $lc_base_folder/temp/unbound/unbound.conf
sed -i 's|lc-host-digitalextremes|'$lc_ip_digitalextremes'|g' $lc_base_folder/temp/unbound/unbound.conf
sed -i 's|lc-host-pearlabyss|'$lc_ip_pearlabyss'|g' $lc_base_folder/temp/unbound/unbound.conf

sudo cp $lc_base_folder/temp/unbound/unbound.conf /etc/unbound/unbound.conf

## Copy The Base Files Over To Temp Folder
cp $lc_dl_dir/lancache/hosts $lc_base_folder/temp/hosts
cp $lc_dl_dir/lancache/interfaces $lc_base_folder/temp/interfaces

## Make the Necessary Changes For The New Host File
sed -i 's|lc-hostname|'$lc_hn'|g' $lc_base_folder/temp/hosts
sed -i 's|lc-host-proxybind|'$lc_ip'|g' $lc_base_folder/temp/hosts
sed -i 's|lc-host-arena|'$lc_ip_arena'|g' $lc_base_folder/temp/hosts
sed -i 's|lc-host-apple|'$lc_ip_apple'|g' $lc_base_folder/temp/hosts
sed -i 's|lc-host-blizzard|'$lc_ip_blizzard'|g' $lc_base_folder/temp/hosts
sed -i 's|lc-host-hirez|'$lc_ip_hirez'|g' $lc_base_folder/temp/hosts
sed -i 's|lc-host-glyph|'$lc_ip_glyph'|g' $lc_base_folder/temp/hosts
sed -i 's|lc-host-gog|'$lc_ip_gog'|g' $lc_base_folder/temp/hosts
sed -i 's|lc-host-microsoft|'$lc_ip_microsoft'|g' $lc_base_folder/temp/hosts
sed -i 's|lc-host-origin|'$lc_ip_origin'|g' $lc_base_folder/temp/hosts
sed -i 's|lc-host-riot|'$lc_ip_riot'|g' $lc_base_folder/temp/hosts
sed -i 's|lc-host-steam|'$lc_ip_steam'|g' $lc_base_folder/temp/hosts
sed -i 's|lc-host-sony|'$lc_ip_sony'|g' $lc_base_folder/temp/hosts
sed -i 's|lc-host-enmasse|'$lc_ip_enmasse'|g' $lc_base_folder/temp/hosts
sed -i 's|lc-host-uplay|'$lc_ip_uplay'|g' $lc_base_folder/temp/hosts
sed -i 's|lc-host-wargaming|'$lc_ip_wargaming'|g' $lc_base_folder/temp/hosts
sed -i 's|lc-host-zenimax|'$lc_ip_zenimax'|g' $lc_base_folder/temp/hosts
sed -i 's|lc-host-digitalextremes|'$lc_ip_digitalextremes'|g' $lc_base_folder/temp/hosts
sed -i 's|lc-host-pearlabyss|'$lc_ip_pearlabyss'|g' $lc_base_folder/temp/hosts

## Make the Necessary Changes For The New Interfaces File
sed -i 's|lc-host-ip|'$lc_ip'|g' $lc_base_folder/temp/interfaces
sed -i 's|lc-host-gateway|'$lc_ip_gw'|g' $lc_base_folder/temp/interfaces
sed -i 's|lc-host-arena|'$lc_ip_arena'|g' $lc_base_folder/temp/interfaces
sed -i 's|lc-host-apple|'$lc_ip_apple'|g' $lc_base_folder/temp/interfaces
sed -i 's|lc-host-blizzard|'$lc_ip_blizzard'|g' $lc_base_folder/temp/interfaces
sed -i 's|lc-host-hirez|'$lc_ip_hirez'|g' $lc_base_folder/temp/interfaces
sed -i 's|lc-host-gog|'$lc_ip_gog'|g' $lc_base_folder/temp/interfaces
sed -i 's|lc-host-glyph|'$lc_ip_glyph'|g' $lc_base_folder/temp/interfaces
sed -i 's|lc-host-microsoft|'$lc_ip_microsoft'|g' $lc_base_folder/temp/interfaces
sed -i 's|lc-host-origin|'$lc_ip_origin'|g' $lc_base_folder/temp/interfaces
sed -i 's|lc-host-riot|'$lc_ip_riot'|g' $lc_base_folder/temp/interfaces
sed -i 's|lc-host-steam|'$lc_ip_steam'|g' $lc_base_folder/temp/interfaces
sed -i 's|lc-host-sony|'$lc_ip_sony'|g' $lc_base_folder/temp/interfaces
sed -i 's|lc-host-enmasse|'$lc_ip_enmasse'|g' $lc_base_folder/temp/interfaces
sed -i 's|lc-host-uplay|'$lc_ip_uplay'|g' $lc_base_folder/temp/interfaces
sed -i 's|lc-host-wargaming|'$lc_ip_wargaming'|g' $lc_base_folder/temp/interfaces
sed -i 's|lc-host-zenimax|'$lc_ip_zenimax'|g' $lc_base_folder/temp/interfaces
sed -i 's|lc-host-digitalextremes|'$lc_ip_digitalextremes'|g' $lc_base_folder/temp/interfaces
sed -i 's|lc-host-pearlabyss|'$lc_ip_pearlabyss'|g' $lc_base_folder/temp/interfaces
sed -i 's|lc-host-netmask|'$lc_eth_netmask'|g' $lc_base_folder/temp/interfaces
sed -i 's|lc-host-vint|'$lc_eth_int'|g' $lc_base_folder/temp/interfaces

## Change the Proxy Bind in Lancache Configs
sudo sed -i 's|lc-host-proxybind|'$lc_ip'|g' $lc_nginx_loc/conf/vhosts-enabled/*.conf

## Copy The init.d file over to /etc/init.d/
sudo cp $lc_dl_dir/lancache/init.d/lancache /etc/init.d/lancache
sudo chmod +x /etc/init.d/lancache
sudo update-rc.d lancache defaults

## Autostarting sniproxy
sudo cp $lc_base_folder/data/sniproxy/debian/init.d /etc/init.d/sniproxy
sudo chmod +x /etc/init.d/sniproxy
sudo update-rc.d sniproxy defaults
sudo sed -i 's|'/usr/sbin'|'/usr/local/sbin'|g' /etc/init.d/sniproxy
sudo echo 'DAEMON_ARGS="-c /etc/sniproxy.conf"' > /etc/default/sniproxy

## Moving Base Files to The Correct Locations
if [ -f "$lc_base_folder/temp/hosts" ]; then
	sudo mv /etc/hosts /etc/hosts.bak
	sudo cp $lc_base_folder/temp/hosts /etc/hosts
fi

if [ -f "$lc_base_folder/temp/interfaces" ]; then
	sudo mv /etc/network/interfaces /etc/network/interfaces.bak
	sudo mv $lc_base_folder/temp/interfaces /etc/network/interfaces
fi

# Disabling IPv6
sudo echo "net.ipv6.conf.all.disable_ipv6=1" >/etc/sysctl.d/disable-ipv6.conf
sudo sysctl -p /etc/sysctl.d/disable-ipv6.conf

# Updating local DNS resolvers
sudo echo "nameserver $lc_ip_googledns1" > /etc/resolv.conf
sudo echo "nameserver $lc_ip_googledns2" >> /etc/resolv.conf

# Install traffic monitoring tools
sudo apt-get install nload iftop tcpdump tshark -y

## Clean up temp folder
sudo rm -rf $lc_base_folder/temp

echo Please reboot your system for the changes to take effect.
exit 0
