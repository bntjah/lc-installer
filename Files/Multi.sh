#!/bin/bash
## Increment the last IP digit for every Game
lc_incr_steam=$((lc_ip_p4+1))
lc_incr_riot=$((lc_ip_p4+2))
lc_incr_blizzard=$((lc_ip_p4+3))
lc_incr_hirez=$((lc_ip_p4+4))
lc_incr_origin=$((lc_ip_p4+5))
lc_incr_sony=$((lc_ip_p4+6))
lc_incr_microsoft=$((lc_ip_p4+7))
lc_incr_tera=$((lc_ip_p4+8))
lc_incr_gog=$((lc_ip_p4+9))
lc_incr_arena=$((lc_ip_p4+10))
lc_incr_wargaming=$((lc_ip_p4+11))
lc_incr_uplay=$((lc_ip_p4+12))
lc_incr_apple=$((lc_ip_p4+13))
lc_incr_glyph=$((lc_ip_p4+14))

        if [ ! -d "$curdir/files/" ]; then
                echo "Downloading the Config Files from bntjah's GITHUB"
                git clone -b Master https://github.com/bntjah/lancache $curdir/files/>/dev/null
                # exit code check fancy
        fi
echo "Modifying our interfaces file with the ip's defined above"
## Make the Necessary Changes For The New Interfaces File
sed -i 's|lc-host-ip|'$lc_ip'|g' $curdir/files/interfaces
sed -i 's|lc-host-gateway|'$lc_ip_gw'|g' $curdir/files/interfaces
sed -i 's|lc-host-arena|'$lc_ip_arena'|g' $curdir/files/interfaces
sed -i 's|lc-host-apple|'$lc_ip_apple'|g' $curdir/files/interfaces
sed -i 's|lc-host-blizzard|'$lc_ip_blizzard'|g' $curdir/files/interfaces
sed -i 's|lc-host-hirez|'$lc_ip_hirez'|g' $curdir/files/interfaces
sed -i 's|lc-host-gog|'$lc_ip_gog'|g' $curdir/files/interfaces
sed -i 's|lc-host-glyph|'$lc_ip_glyph'|g' $curdir/files/interfaces
sed -i 's|lc-host-microsoft|'$lc_ip_microsoft'|g' $curdir/files/interfaces
sed -i 's|lc-host-origin|'$lc_ip_origin'|g' $curdir/files/interfaces
sed -i 's|lc-host-riot|'$lc_ip_riot'|g' $curdir/files/interfaces
sed -i 's|lc-host-steam|'$lc_ip_steam'|g' $curdir/files/interfaces
sed -i 's|lc-host-sony|'$lc_ip_sony'|g' $curdir/files/interfaces
sed -i 's|lc-host-tera|'$lc_ip_tera'|g' $curdir/files/interfaces
sed -i 's|lc-host-uplay|'$lc_ip_uplay'|g' $curdir/files/interfaces
sed -i 's|lc-host-wargaming|'$lc_ip_wargaming'|g' $curdir/files/interfaces
sed -i 's|lc-host-netmask|'$lc_eth_netmask'|g' $curdir/files/interfaces
sed -i 's|lc-host-vint|'$lc_eth_int'|g' $curdir/files/interfaces

echo "Backing Up The Current Interfaces File"
mv /etc/interfaces /etc/interfaces.old
# exit code check fancy
echo "Installing our Modified Interfaces File"
cp $curdir/files/interfaces /etc/interfaces
# exit code check fancy

echo "Backing up the Current Hosts File"
cp /etc/hosts /etc/hosts.old
## Make the Necessary Changes For The New Host File
sed -i 's|lc-hostname|'$lc_hn'|g' $curdir/files/hosts
sed -i 's|lc-host-proxybind|'$lc_ip'|g' $curdir/files/hosts
sed -i 's|lc-host-arena|'$lc_ip_arena'|g' $curdir/files/hosts
sed -i 's|lc-host-apple|'$lc_ip_apple'|g' $curdir/files/hosts
sed -i 's|lc-host-blizzard|'$lc_ip_blizzard'|g' $curdir/files/hosts
sed -i 's|lc-host-hirez|'$lc_ip_hirez'|g' $curdir/files/hosts
sed -i 's|lc-host-glyph|'$lc_ip_glyph'|g' $curdir/files/hosts
sed -i 's|lc-host-gog|'$lc_ip_gog'|g' $curdir/files/hosts
sed -i 's|lc-host-microsoft|'$lc_ip_microsoft'|g' $curdir/files/hosts
sed -i 's|lc-host-origin|'$lc_ip_origin'|g' $curdir/files/hosts
sed -i 's|lc-host-riot|'$lc_ip_riot'|g' $curdir/files/hosts
sed -i 's|lc-host-steam|'$lc_ip_steam'|g' $curdir/files/hosts
sed -i 's|lc-host-sony|'$lc_ip_sony'|g' $curdir/files/hosts
sed -i 's|lc-host-tera|'$lc_ip_tera'|g' $curdir/files/hosts
sed -i 's|lc-host-uplay|'$lc_ip_uplay'|g' $curdir/files/hosts
sed -i 's|lc-host-wargaming|'$lc_ip_wargaming'|g' $curdir/files/hosts
mv $curdir/files/hosts /etc/hosts
