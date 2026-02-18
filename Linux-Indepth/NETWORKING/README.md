# NMCLI Commands: Manage Networking

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



### Step 1: Check network status

```
aswin@Aswin-HP:Linux$ nmcli general status
STATE      CONNECTIVITY  WIFI-HW  WIFI     WWAN-HW  WWAN    
connected  full          enabled  enabled  missing  enabled 
```
What it does:

Shows if NetworkManager is running

Shows overall connectivity (full, limited, none)

Shows WiFi and WWAN hardware/software status

Shows if the connection is metered

### Step 2: Check interfaces

```
aswin@Aswin-HP:Linux$ nmcli device status
DEVICE           TYPE      STATE                   CONNECTION      
wlx6083e7b7ae0e  wifi      connected               ROGERSNEW       
lo               loopback  connected (externally)  lo              
br-4c65901e7e2e  bridge    connected (externally)  br-4c65901e7e2e 
br-f7a07f80b68a  bridge    connected (externally)  br-f7a07f80b68a 
docker0          bridge    connected (externally)  docker0         
virbr0           bridge    connected (externally)  virbr0          
vnet0            tun       connected (externally)  vnet0           
wlx38a38c6002e0  wifi      disconnected            --              
eno1             ethernet  unavailable             --     
```
What it does:

Shows all network interfaces (physical or virtual)

Shows interface type: ethernet, wifi, loopback, bridge, tun, etc.

Shows STATE: connected, disconnected, unavailable

Shows which profile is currently applied - (CONNECTION) field

### Step 3: List connection profiles

```
aswin@Aswin-HP:Linux$ nmcli connection show
NAME                UUID                                  TYPE      DEVICE          
ROGERSNEW           ead1310e-a9a1-46f7-8b14-6bc65259317d  wifi      wlx6083e7b7ae0e 
lo                  51074511-a4e1-4481-a75f-09bf95a5a425  loopback  lo              
br-4c65901e7e2e     2e7fc80f-a9d1-4bc8-b533-3d461798bbdf  bridge    br-4c65901e7e2e 
br-f7a07f80b68a     f4a529d9-00e9-4075-8969-6135d3591144  bridge    br-f7a07f80b68a 
docker0             612744c0-20bc-44b2-b8d2-b245e7705ff0  bridge    docker0         
virbr0              b4478f50-fcf0-4906-88f4-18187297ee3d  bridge    virbr0          
vnet0               51c9d469-3287-4dfa-aa0d-48014f96b417  tun       vnet0           
84 Legends          181926b1-4a6e-452b-80a5-c115fd8dd7ad  wifi      --              
84 Legends Bell     ca7d18b0-9312-46a6-a654-a653efdd0cc0  wifi      --              
BELL899             f0bc9994-f39a-4c4e-8c7c-0a929eebc811  wifi      --              
Ecto-1              9a03dfb9-2c72-4e3a-8a66-3a263284799d  wifi      --              
Samsung Galaxy S23  b9f7803a-b094-4c86-bf1b-996c0ca8532a  wifi      --              
Wired connection 1  ee89def0-426b-3d07-8a2b-67b90476af8a  ethernet  -- 
```

What it does:

Shows all saved network profiles on the system

Includes active and inactive profiles

Shows which device each profile (NAME field is the profile name) is currently applied to