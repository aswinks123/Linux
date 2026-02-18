# NMCLI Daily Admin Commands

| Category | Command | Purpose / Notes |
|----------|---------|----------------|
| **General Status** | `nmcli general status` | Check NetworkManager status and overall connectivity |
| | `nmcli device status` | Show all network interfaces and their current state |
| | `nmcli connection show` | List all saved connection profiles |
| **IP / Network Info** | `nmcli device show <interface>` | Show IP, MAC, DNS, and other details for a device |
| | `nmcli -p device show <interface> | grep IP4` | Show only IPv4 addresses for the interface |
| **Manage Devices** | `nmcli device connect <interface>` | Bring interface up |
| | `nmcli device disconnect <interface>` | Bring interface down |
| | `nmcli radio wifi on` | Enable WiFi radio |
| | `nmcli radio wifi off` | Disable WiFi radio |
| **Connection Profiles** | `nmcli connection add type ethernet con-name <name> ifname <interface> [ip4 <IP>/prefix gw4 <gateway>]` | Create new connection profile (DHCP or static IP) |
| | `nmcli connection modify <profile> <property>` | Modify existing profile (IP, DNS, autoconnect, etc.) |
| | `nmcli connection up <profile>` | Activate / switch profile on interface |
| | `nmcli connection down <profile>` | Deactivate a profile |
| | `nmcli connection show <profile>` | Show detailed info of a profile |
| | `nmcli connection delete <profile>` | Remove unused profile |
| **WiFi Management** | `nmcli device wifi list` | Scan and list available WiFi networks |
| | `nmcli device wifi connect <SSID> password <password>` | Connect to a WiFi network |
| | `nmcli device disconnect <interface>` | Disconnect from WiFi |
| **Troubleshooting** | `nmcli connection reload` | Reload all connection profiles |
| | `systemctl restart NetworkManager` | Restart NetworkManager service |
| | `nmcli networking connectivity` | Check network connectivity status |
| **Extras / Backup** | `journalctl -u NetworkManager` | View NetworkManager logs |
| | `cp /etc/NetworkManager/system-connections/* /backup/location/` | Backup connection profiles |
