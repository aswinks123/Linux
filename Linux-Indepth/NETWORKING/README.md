# NMCLI Commands: Manage Networking

Learn Daily used networking commands using nmcli - Network manager command line tool


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

### Step 4: Activate a profile

A profile is a file that contains the configuration that need to be applied to an interface. It contain the details of IP, gateway, etc.

Let's create a sample profile named: enp1s0-static with IP address: 192.168.122.50/24 

```
[root@RHEL ~]# nmcli connection add type ethernet con-name enp1s0-static ifname enp1s0 ipv4.addresses 192.168.122.50/24 ipv4.gateway 192.168.122.1 ipv4.method manual
Connection 'enp1s0-static' (12d99f15-c3fc-44aa-afa9-e09387b49b14) successfully added.


[root@RHEL ~]# nmcli connection show
NAME           UUID                                  TYPE      DEVICE 
enp1s0         0f2152ea-3615-37ab-b592-f0b80143d566  ethernet  enp1s0 
lo             817beb23-c012-4f7f-8c28-eee1b9981d30  loopback  lo     
enp1s0-static  12d99f15-c3fc-44aa-afa9-e09387b49b14  ethernet  --  

```


enp1s0-static is a new profile we created, with a new IP defined. but as you can see, its not conneced to any devies now.


Before we apply this profile, lets check the current IP of the inteface: (enp1s0: 192.168.122.10/24)

```
[root@RHEL ~]# ip a | grep enp1s0: -A5
2: enp1s0: <BROADCAST,MULTICAST,UP,LOWER_UP> mtu 1500 qdisc fq_codel state UP group default qlen 1000
    link/ether 52:54:00:3e:65:8e brd ff:ff:ff:ff:ff:ff
    altname enx5254003e658e
    inet 192.168.122.10/24 brd 192.168.122.255 scope global noprefixroute enp1s0
       valid_lft forever preferred_lft forever
    inet6 fe80::5054:ff:fe3e:658e/64 scope link noprefixroute 
```


* Now lets activate the new profile:

Note: If you are using an SSH session, it will disconnect the session. Be careful!!

```

[root@RHEL ~]# nmcli connection up enp1s0-static


NAME           UUID                                  TYPE      DEVICE 
enp1s0-static  12d99f15-c3fc-44aa-afa9-e09387b49b14  ethernet  enp1s0 
lo             817beb23-c012-4f7f-8c28-eee1b9981d30  loopback  lo     
enp1s0         0f2152ea-3615-37ab-b592-f0b80143d566  ethernet  -- 

```
As you can see now the active profile is : enp1s0-static which is tied to device: enp1s0

Also check the current IP (192.168.122.50/24) of the interface. It matches the one we defined in the new profile.

```
2: enp1s0: <BROADCAST,MULTICAST,UP,LOWER_UP> mtu 1500 qdisc fq_codel state UP group default qlen 1000
    link/ether 52:54:00:3e:65:8e brd ff:ff:ff:ff:ff:ff
    altname enx5254003e658e
    inet 192.168.122.50/24 brd 192.168.122.255 scope global noprefixroute enp1s0
       valid_lft forever preferred_lft forever
    inet6 fe80::2643:67b9:eef8:6788/64 scope link noprefixroute 
       valid_lft forever preferred_lft forever

```

### Step 5: Deactivate a profile 

```
nmcli connection down <profile name>
```

What it does:

Temporarily disconnects a profile from its interface

The interface becomes inactive (disconnected)

Settings (IP, gateway, DNS) from that profile are no longer applied

Useful for troubleshooting or switching profiles


### Step 6: Connect to WiFi

First lets scan the available wifi

```
aswin@Aswin-HP:~$ nmcli device wifi list
IN-USE  BSSID              SSID                MODE   CHAN  RATE        SIGNAL  BARS  SECURITY    
        D2:28:68:DB:DD:72  Samsung Galaxy S23  Infra  1     130 Mbit/s  100     ▂▄▆█  WPA2        
        C6:4F:D5:EE:BC:D9  ROGERSNEW           Infra  6     260 Mbit/s  100     ▂▄▆█  WPA2 WPA3   
        C6:4F:D5:EE:BC:DE  --                  Infra  6     260 Mbit/s  100     ▂▄▆█  WPA2 802.1X 
        C6:4F:D5:EE:BC:DA  --                  Infra  6     260 Mbit/s  100     ▂▄▆█  WPA2        
*       C6:4F:D5:F5:BC:DA  ROGERSNEW           Infra  44    540 Mbit/s  97      ▂▄▆█  WPA2 WPA3   
        C6:4F:D5:F5:BC:DD  --                  Infra  44    540 Mbit/s  95      ▂▄▆█  WPA2        
        C6:4F:D5:F5:BC:DF  --                  Infra  44    540 Mbit/s  94      ▂▄▆█  WPA2 802.1X 
        3A:B7:F1:BB:C5:45  Ecto-1              Infra  6     130 Mbit/s  62      ▂▄▆_  WPA2        
        BE:D5:ED:FB:3F:87  84 Legends Bell     Infra  44    540 Mbit/s  62      ▂▄▆_  WPA2        
        BC:D5:ED:FB:3F:86  --                  Infra  44    540 Mbit/s  62      ▂▄▆_  WPA2        
        5A:B7:F1:BB:C5:45  --                  Infra  6     130 Mbit/s  60      ▂▄▆_  WPA2        
        2A:B7:F1:BB:C5:45  --                  Infra  6     130 Mbit/s  60      ▂▄▆_  WPA2        
        BC:D5:ED:FB:3F:85  84 Legends Bell     Infra  11    540 Mbit/s  59      ▂▄▆_  WPA2   

```

Now let's connect to wifi: Samsung Galaxy S23

```
aswin@Aswin-HP:~$ nmcli device wifi connect "Samsung Galaxy S23" password MyPassword-123'

Device 'wlx6083e7b7ae0e' successfully activated with 'b9f7803a-b094-4c86-bf1b-996c0ca8532a'.
```

Verify the connnection: 

```
aswin@Aswin-HP:~$ nmcli device status
DEVICE           TYPE      STATE                   CONNECTION         
  wifi      connected               Samsung Galaxy S23 
lo               loopback  connected (externally)  lo                 
br-4c65901e7e2e  bridge    connected (externally)  br-4c65901e7e2e    
br-f7a07f80b68a  bridge    connected (externally)  br-f7a07f80b68a    
```
Great!, Now our wifi is connected to new network.

To disconnect wifi:   nmcli device disconnect wlx6083e7b7ae0e

### 7: Bring interface up/down

```
nmcli device connect <interface>   # Bring interface up

nmcli device disconnect <interface> # Bring interface down

```
Let's try it:

```
[root@RHEL ~]# nmcli device status
DEVICE  TYPE      STATE      CONNECTION 
enp1s0  ethernet  connected  enp1s0     
lo      loopback  connected  lo      

#Disconnecting enp1s0

[root@RHEL ~]# nmcli device disconnect enp1s0
Device 'enp1s0' successfully disconnected.


#Check status again

[root@RHEL ~]# nmcli device status
DEVICE  TYPE      STATE         CONNECTION 
lo      loopback  connected     lo         
enp1s0  ethernet  disconnected  -- 

```

### nmcli connection down vs nmcli connection down

*** nmcli connection down <profile> ***

Deactivates a profile, not the hardware.

Interface stays physically up.

IP, gateway, DNS from the profile are removed.

Useful for switching profiles or resetting settings.

*** nmcli connection down <profile> ***

Disconnects the interface itself.

Interface becomes physically/logically down.

Profile may still exist but cannot apply settings until interface is back up.

Useful for temporarily disabling a NIC or troubleshooting hardware.



### 8: Create a new Profile and Assign static IP 

Step 1: Create the profile

```
nmcli connection add type ethernet con-name <profile-name> ifname <interface> ipv4.addresses <IP/prefix> ipv4.gateway <gateway> ipv4.method manual

```
Step 2: Modify the existnig profile (If needed)

```
nmcli connection modify <profile> ipv4.addresses <IP/prefix>
nmcli connection modify <profile> ipv4.gateway <gateway>
nmcli connection modify <profile> ipv4.method manual

```
Step 3: Apply the changes

```
nmcli connection up <profile-name> 
```

### 9: Switch back to DHCP mode for the profile

```
nmcli connection modify <profile> ipv4.method auto
nmcli connection up <profile>
```





