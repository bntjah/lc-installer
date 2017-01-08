This script has been tested under Debian 8.6 amd64.

    1) git clone -b master --recursive http://github.com/fhibler/lc-installer/
	2) chmod +x installer.sh
	3) sh installer.sh
	4) sudo /etc/init.d/lancache start
	
Notes:

	A) It should ask you the first time wich ETH you want it to configure to.
	If you want to reconfigure this at a later state delete the file: /usr/local/lancache/config/interface_used
	B) It can be used to run at startup after initial install; then you need to add a line for it to start nginx

	Optional A) Monitor Through nload
		-A.1 sudo apt-get install nload -y
		-A.2 sudo nload -U G - u M -i 102400 -o 102400
	Optional B) Monitor Network Usage Through iftop
		-B.1 sudo apt-get install iftop -y
		-B.2 sudo iftop -i eth1
		Note: eth1 is the interface I've defined for Lancache to use
		
