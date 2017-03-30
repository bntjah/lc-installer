lancache installer script
=========================

## Short Changelog
* 12-30-2016 Initial Creation
* 3-30-2017 TravisPK
    * Removed old bind stuff
    * Rearranged IP's to match Interface order
    * Made almost all steps perform regardless if it has been done in prior runs of the installer. The will ensure if anything is updated in git, etc. that it will be properly deployed to the system.
    * Updated to Nginx 1.11.12
    * Made a version variable for nginix
    * Cleaned up various things and bug fixes

This script has been tested under Debian 8.6 amd64.

    1) git clone -b master --recursive http://github.com/bntjah/lc-installer/
    2) cd lc-installer
	3) chmod +x installer.sh
	4) ./installer.sh
	5) Reboot your system
	
Notes:

	A) It should ask you the first time which interface you want it to use for lancache .
	If you want to reconfigure this at a later stage, please delete the file: /usr/local/lancache/config/interface_used

	Optional A) Monitor Through nload
		-A.1 sudo apt-get install nload -y
		-A.2 sudo nload -U G - u M -i 102400 -o 102400
	Optional B) Monitor Network Usage Through iftop
		-B.1 sudo apt-get install iftop -y
		-B.2 sudo iftop -i eth1
		Note: eth1 is the interface I've defined for lancache to use (please use it only as an example)
		
