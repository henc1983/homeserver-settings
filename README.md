#First You need to change the mod of file install.sh.

sudo chmod u+x install.sh



#Install Node-RED

bash <(curl -sL https://raw.githubusercontent.com/node-red/linux-installers/master/deb/update-nodejs-and-nodered) --confirm-pi --confirm-install --allow-low-ports --nodered-user=homeserver --node18




#Run install.sh

sudo ./install.sh