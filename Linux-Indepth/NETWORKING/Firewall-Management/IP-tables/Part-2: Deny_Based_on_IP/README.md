# PART 2 - Deny Traffic From Specific IP Address

### Lab Setup

Host machine: Connect to VM  on port 80

VM: runs nginx on port 80 

Goal: Block only Host IP address from accessing port 80


### Step 1: Check the Host IP address

Command: ip a 

```

aswin@Aswin-HP:~$ ip a show virbr0  (virbr0 because VM is in same host)



5: virbr0: <BROADCAST,MULTICAST,UP,LOWER_UP> mtu 1500 qdisc noqueue state UP group default qlen 1000
    link/ether 52:54:00:ed:70:04 brd ff:ff:ff:ff:ff:ff
    inet 192.168.122.1/24 brd 192.168.122.255 scope global virbr0
       valid_lft forever preferred_lft forever


```

IP address of host is: 192.168.122.1



### Step 2: Block Host IP on Port 80


Command: sudo iptables -A INPUT -p tcp -s <HOST-IP> --dport 80 -j DROP

Flag used to specify HOST IP

-s <HOST-IP> - source IP (HOST MACHINE)


```
[root@RHEL ~]# iptables -A INPUT -s 192.168.122.1 -p tcp --dport 80 -j DROP


# View the rule. -n is used to display the IP address , because sometimes IP tables show IP ending with .1 as gateway.


[root@RHEL ~]# iptables -L --line-numbers -n    



Chain INPUT (policy ACCEPT)
num  target     prot opt source               destination         
1    DROP       tcp  --  192.168.122.1        0.0.0.0/0            tcp dpt:80

Chain FORWARD (policy ACCEPT)
num  target     prot opt source               destination         

Chain OUTPUT (policy ACCEPT)
num  target     prot opt source               destination         
[root@RHEL ~]# 


```

### Step 3: Verify the connectivity


```
aswin@Aswin-HP:~$ curl 192.168.122.50

<NOTHING HAPPENING BECAUSE WE ARE NOT ALLOWEDED TO ACCESS THE PORT 80>

```



### Step 4: Remove the Rule

```
[root@RHEL ~]# iptables -D INPUT 1   # Delete rule 1 from INPUT chain



[root@RHEL ~]# iptables -L --line-numbers -n

Chain INPUT (policy ACCEPT)
num  target     prot opt source               destination         

Chain FORWARD (policy ACCEPT)
num  target     prot opt source               destination         

Chain OUTPUT (policy ACCEPT)
num  target     prot opt source               destination        

```


### Step 5: Verify the connectivity again

```
swin@Aswin-HP:~$ curl 192.168.122.50
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.1//EN" "http://www.w3.org/TR/xhtml11/DTD/xhtml11.dtd">

<html xmlns="http://www.w3.org/1999/xhtml" xml:lang="en">
	<head>
		<title>Test Page for the HTTP Server on AlmaLinux</title>
		<meta http-equiv="Content-Type" content="text/html; charset=UTF-8" />
		<style type="text/css">
			/*<![CDATA[*/
			body {
				background-color: #fff;
				color: #000;
				font-size: 1.1em;
				font-family: "Red Hat Text", Helvetica, Tahoma, sans-serif;
				margin: 0;
				padding: 0;
                border-bottom: 30px solid #082336;
				min-height: 100vh;


```

Now we learned how to add rules based on IP addresses, and also how to remove it.