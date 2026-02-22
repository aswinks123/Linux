# What is iptables

iptables is the Linux firewall utility for filtering packets

Works at kernel level using netfilter

Controls traffic entering, leaving, or passing through your machine


### Chains: The “Traffic Paths”


| Chain   | Direction                    | When Used                                |
| ------- | ---------------------------- | ---------------------------------------- |
| INPUT   | Incoming to this machine     | SSH, HTTP, ping incoming                 |
| OUTPUT  | Outgoing from this machine   | VM → Host, VM → Internet                 |
| FORWARD | Passing through (router/NAT) | VM routing traffic or Docker/K8s         |

IMPORTANT NOTE: Packets go through chains in order -  first match wins


### Targets:  What You Can Do With Packets


| Target | Meaning                        |
| ------ | ------------------------------ |
| ACCEPT | Allow the packet               |
| DROP   | Silently discard (no response) |
| REJECT | Discard and send ICMP error    |
| LOG    | Log packet info to syslog      |


### Rule Syntax

```
iptables -A <CHAIN> -p <PROTOCOL> -s <SOURCE> -d <DEST> --dport <PORT> -j <TARGET>
```

Explanation of flags

-A - append rule

-D - delete rule

-F - flush (delete all rules in chain)

-L - list rules

-n - numeric output (no DNS resolution)

-v - verbose (shows packet/byte counts)


### Rule Order & Default Policy

Rules are checked top to bottom

First match wins - later rules ignored

Default policy applies if no rule matches