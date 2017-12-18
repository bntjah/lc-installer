#!/bin/bash
## Increment the last IP digit for every Game
lc_incr_steam=$((lc_ip_p4+0))
lc_incr_riot=$((lc_ip_p4+0))
lc_incr_blizzard=$((lc_ip_p4+0))
lc_incr_hirez=$((lc_ip_p4+0))
lc_incr_origin=$((lc_ip_p4+0))
lc_incr_sony=$((lc_ip_p4+0))
lc_incr_microsoft=$((lc_ip_p4+0))
lc_incr_tera=$((lc_ip_p4+0))
lc_incr_gog=$((lc_ip_p4+0))
lc_incr_arena=$((lc_ip_p4+0))
lc_incr_wargaming=$((lc_ip_p4+0))
lc_incr_uplay=$((lc_ip_p4+0))
lc_incr_apple=$((lc_ip_p4+0))
lc_incr_glyph=$((lc_ip_p4+0))

        if [ ! -d "$curdir/files/" ]; then
                echo "Downloading the Config Files from bntjah's GITHUB"
                git clone -b Single-IP https://github.com/bntjah/lancache $curdir/files/>/dev/null
                # exit code check fancy
        fi
