#!/bin/bash
## Check if the Lancache user exists if not creating the user
if id -u "lancache" >/dev/null 2>&1; then
        echo The user lancache exists so nothing needs to be done!
else
    adduser --system --no-create-home lancache
    addgroup --system lancache
    usermod -aG lancache lancache
fi
