#!/bin/bash
## Copy The init.d file over to /etc/init.d/
cp $curdir/lancache/init.d/lancache /etc/init.d/lancache
# Display Result
if [ "$code_ex"=="0" ]; then
        echo
        echo_success
 else
        echo
        echo_failure
fi

chmod +x /etc/init.d/lancache
# Display Result
if [ "$?"=="0" ]; then
        echo
        echo_success
 else
        echo
        echo_failure
fi

echo "Install Init.D to Startup"
update-rc.d lancache defaults
# Display Result
if [ "$?"=="0" ]; then
        echo
        echo_success
 else
        echo
        echo_failure
fi

