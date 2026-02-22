# IPTABLE : Manage Firewall Rules .  Logs, ordering

### Lab Setup

Host machine: runs nginx on port 80

VM: used to practice iptables

Goal: block and unblock VM traffic to host port 80




## PART 1 - Adding, Deleting, and Flushing Rules.


### Step 1: Check Current Rules

Command: sudo iptables -L -v -n --line-numbers

Note: --line-numbers will come in handy when we delete rules. so better to learn this flag.


```
[root@RHEL ~]# iptables -L --line-numbers

Chain INPUT (policy ACCEPT)
num  target     prot opt source               destination         

Chain FORWARD (policy ACCEPT)
num  target     prot opt source               destination         

Chain OUTPUT (policy ACCEPT)
num  target     prot opt source               destination         
[root@RHEL ~]# 
```

Shows all current rules

Chains: INPUT, OUTPUT, FORWARD


### Step 2: Add a Rule to Block Port 80 (Outgoing traffic from the VM)

```
# Add the block rule
[root@RHEL ~]# iptables -A OUTPUT -p tcp --dport 80 -j DROP

# Checking the tables status
[root@RHEL ~]# iptables -L --line-numbers
Chain INPUT (policy ACCEPT)
num  target     prot opt source               destination         

Chain FORWARD (policy ACCEPT)
num  target     prot opt source               destination         

# Check the output. A new rule hasbeen added.

Chain OUTPUT (policy ACCEPT)
num  target     prot opt source               destination         
1    DROP       tcp  --  anywhere             anywhere             tcp dpt:http    # Newly added rule.
[root@RHEL ~]# 
```

Explanation of Command:

 -A OUTPUT - append to OUTPUT chain

-p tcp - protocol TCP

--dport 80 - destination port 80

-j DROP - silently drop packet

## Step 3: Test the Rule

We have nginx running on Host server on port 80. Let's try connecting.

Command: curl http://<host-ip>

```
[root@RHEL ~]# curl 192.168.122.1 

 <NOTHING HAPPENING> because the outbound connection is blocked!

```


Step 4: Remove the Rule

Option 1: Delete by full rule

Command: iptables -D OUTPUT -p tcp --dport 80 -j DROP

-D : Used to delete the rule.

```
[root@RHEL ~]# iptables -D OUTPUT -p tcp --dport 80 -j DROP
```

### Step 5: Verify the connectivity


```
[root@RHEL ~]# curl 192.168.122.1 


<!DOCTYPE html>
<html>
<head>
<title>Welcome to nginx!</title>
<style>
html { color-scheme: light dark; }
body { width: 35em; margin: 0 auto;
font-family: Tahoma, Verdana, Arial, sans-serif; }
</style>
</head>
<body>
<h1>Welcome to nginx!</h1>
<p>If you see this page, the nginx web server is successfully installed and
working. Further configuration is required.</p>

<p>For online documentation and support please refer to
<a href="http://nginx.org/">nginx.org</a>.<br/>
Commercial support is available at
<a href="http://nginx.com/">nginx.com</a>.</p>

<p><em>Thank you for using nginx.</em></p>
</body>
</html>
[root@RHEL ~]# 

```

Connection is successful because we deleted the rule.


Additional Option:

We can also use line number to delete the rule:

Lets verify the Iptables with line number

```

[root@RHEL ~]# iptables -L --line-numbers



Chain INPUT (policy ACCEPT)
num  target     prot opt source               destination         

Chain FORWARD (policy ACCEPT)
num  target     prot opt source               destination         

Chain OUTPUT (policy ACCEPT)
num  target     prot opt source               destination        

# This is the rule with number 1

1    DROP       tcp  --  anywhere             anywhere             tcp dpt:http

```


Now delete the rule by number:

```
[root@RHEL ~]# iptables -D OUTPUT 1  #COmmand to delete rule by number


# Print the iptables again

[root@RHEL ~]# iptables -L --line-numbers

Chain INPUT (policy ACCEPT)
num  target     prot opt source               destination         

Chain FORWARD (policy ACCEPT)
num  target     prot opt source               destination         

Chain OUTPUT (policy ACCEPT)
num  target     prot opt source               destination         
[root@RHEL ~]# 

```

### Flushing the Rules

To flush a chain, we can use the "iptables -F"  command

Command: iptables -F OUTPUT

To flush all chains (INPUT, OUTPUT, FORWARD)

Command: iptables -F  


### Additionl Information

Adding an INPUT rule is same as adding OUTPUT rule. Only difference is we use -A INPUT , and It should be added on the destination server (HOST)