lancache installer script
=========================

This script has been tested under Debian 8.6 amd64.

    1) git clone -b master --recursive http://github.com/bntjah/lc-installer/
    3) cd lc-installer
	2) chmod +x installer.sh
	3) ./installer.sh
	4) Reboot your system
	
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
		
