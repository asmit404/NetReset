#!/bin/bash
# Reset macOS network and firewall settings
# WARNING: This will forget ALL Wi-Fi networks and reset firewall rules

echo "This will reset all network and firewall settings."
read -p "Are you sure you want to continue? (y/N) " confirm
if [[ "$confirm" != "y" && "$confirm" != "Y" ]]; then
    echo "Cancelled."
    exit 1
fi

# Ask for admin privileges upfront
sudo -v

echo "Resetting network settings..."
# Remove network preferences
sudo rm -f /Library/Preferences/SystemConfiguration/com.apple.airport.preferences.plist
sudo rm -f /Library/Preferences/SystemConfiguration/com.apple.network.identification.plist
sudo rm -f /Library/Preferences/SystemConfiguration/NetworkInterfaces.plist
sudo rm -f /Library/Preferences/SystemConfiguration/preferences.plist

# Restart networking
echo "Restarting network services..."
sudo ifconfig en0 down
sudo ifconfig en0 up
sudo killall -HUP mDNSResponder

echo "Resetting firewall to defaults..."
# Turn off firewall
sudo /usr/libexec/ApplicationFirewall/socketfilterfw --setglobalstate off
# Delete firewall preferences
sudo rm -f /Library/Preferences/com.apple.alf.plist
# Turn firewall back on
sudo /usr/libexec/ApplicationFirewall/socketfilterfw --setglobalstate on
# Enable stealth mode
sudo /usr/libexec/ApplicationFirewall/socketfilterfw --setstealthmode on

echo "Flushing packet filter rules..."
sudo pfctl -F all -f /etc/pf.conf

echo "Network and firewall settings reset."
echo "You may need to reconnect to Wi-Fi manually."