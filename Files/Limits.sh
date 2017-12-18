#!/bin/bash
## Change Limits of the system for Lancache to work without issues
if [ -f "$curdir/files/limits.conf" ]; then
        echo Backing up the original Limits.conf
        mv /etc/security/limits.conf /etc/security/limits.conf.bak
        # Display Result
        if [ "$?"=="0" ]; then
                echo_success
                echo
        else
                echo_failure
                echo
        fi

        echo Installing Our New File
        cp $curdir/lancache/limits.conf /etc/security/limits.conf
        # Display Result
        if [ "$?"=="0" ]; then
                echo_success
                echo
         else
                echo_failure
                echo
        fi

fi
