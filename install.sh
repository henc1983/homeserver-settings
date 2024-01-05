#!/bin/sh

echo "*****************************************************
<-- INSTALL HOMESERVER -->
*****************************************************

"

NODERED_SETTINGS=/usr/bin/node-red

if test -f "$NODERED_SETTINGS";
then
echo "*************************************
<-- Updating and Updgrade APT packages -->
*************************************

"
apt-get update
apt-get upgrade -y
clear 

echo "*************************************
<-- Install APT packages -->
- MQTT server and clients (Mosquitto)
- MySQL server (MariaDB)
*************************************

"
PACKAGES="mosquitto mosquitto-clients mariadb-server qbittorrent qbittorrent-nox samba samba-common-bin"
apt-get install $PACKAGES -y
clear

echo "*************************************
<-- Customizing NODE-RED settings -->
*************************************

"
systemctl enable nodered.service
cd /home/homeserver/
mkdir static
cd static
npm init -y
npm install bootstrap jquery
cd /home/homeserver/.node-red
npm install @node-red-contrib-themes/theme-collection node-red-contrib-stackhero-mysql node-red-contrib-homekit-bridged node-red-dashboard
cd /home/homeserver/homeserver-settings
cp settings.js /home/homeserver/.node-red
cp -R assets/* /home/homeserver/static
systemctl start nodered.service

echo "*************************************
<-- Setting up MySQL database -->
*************************************

"
mysql -u root < mysql.sql
echo "*************************************
<-- Database Access -->
database: homeserver
username: homeserver
password: Kangen1983
*************************************

"

echo "*************************************
<-- Setting up MQTT broker -->
*************************************

"
systemctl enable mosquitto.service
MOSQUITTO_CONF="/etc/mosquitto/mosquitto.conf"
if grep -Fq "listener" $MOSQUITTO_CONF
then
    sed -i "/listener/c\listener 1883" $MOSQUITTO_CONF
else
    echo "listener 1883" >> $MOSQUITTO_CONF
fi

if grep -Fq "allow_anonymous" $MOSQUITTO_CONF
then
    sed -i "/allow_anonymous/c\allow_anonymous false" $MOSQUITTO_CONF
else
    echo "allow_anonymous false" >> $MOSQUITTO_CONF
fi


echo "*************************************
<-- Set password and disallow anonymous connection to MQTT broker -->
*************************************
port: 1883
username: homeserver
password: Kangen1983

"
mosquitto_passwd -c -b /etc/mosquitto/passwd homeserver Kangen1983

if grep -Fq "password_file" $MOSQUITTO_CONF
then
    sed -i "/password_file/c\password_file /etc/mosquitto/passwd" $MOSQUITTO_CONF
else
    echo "password_file /etc/mosquitto/passwd" >> $MOSQUITTO_CONF
fi

if grep -Fq "per_listener_settings" $MOSQUITTO_CONF
then
    sed -i "/per_listener_settings/c\per_listener_settings true" $MOSQUITTO_CONF
else
    sed -i '1 i\per_listener_settings true' $MOSQUITTO_CONF
fi

echo "*************************************
<-- Restart MQTT Service -->
*************************************

"
systemctl restart mosquitto.service
echo "*************************************
<-- Clear display and exit after 5 seconds -->
*************************************

"
seconds=5
start="$(($(date +%s) + $seconds))"
while [ "$start" -ge `date +%s` ]; do
    time="$(( $start - `date +%s` ))"
    printf '%s\r' "$(date -u -d "@$time" +%H:%M:%S)"
done
clear

else
    echo "*****************************************************
    <-- First You should to run the following command -->
    *****************************************************
    
    "
    echo "bash <(curl -sL https://raw.githubusercontent.com/node-red/linux-installers/master/deb/update-nodejs-and-nodered) --confirm-pi --confirm-install --allow-low-ports --nodered-user=homeserver --node18"
fi