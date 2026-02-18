# NMCLI Daily Admin Cheat Sheet

| Task | Command | Notes |
|------|---------|-------|
| **Check network status** | `nmcli general status` | Quick check if system is connected |
| **Check interfaces** | `nmcli device status` | See which NICs are up/down |
| **List connection profiles** | `nmcli connection show` | See active and saved profiles |
| **Activate a profile** | `nmcli connection up <profile>` | Switch to a profile (Ethernet/WiFi) |
| **Deactivate a profile** | `nmcli connection down <profile>` | Temporarily disconnect a device |
| **Connect to WiFi** | `nmcli device wifi connect <SSID> password <pass>` | Quick WiFi connection |
| **Disconnect WiFi** | `nmcli device disconnect <interface>` | Disconnect interface from network |
| **Bring interface up/down** | `nmcli device connect/disconnect <interface>` | Hardware-level control |
| **Check connectivity** | `nmcli networking connectivity` | See if you can reach the internet |
| **Assign static IP** | `nmcli connection modify <profile> ipv4.addresses <IP/prefix>`<br>`nmcli connection modify <profile> ipv4.gateway <gateway>`<br>`nmcli connection modify <profile> ipv4.method manual`<br>`nmcli connection up <profile>` | Assign or switch to a static IP on a profile |
| **Revert to DHCP** | `nmcli connection modify <profile> ipv4.method auto`<br>`nmcli connection up <profile>` | Switch profile back to automatic IP |

