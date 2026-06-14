L3 Linux Troubleshooting Tools

In this session, we are going to learn the following advanced Linux troubleshooting tools.

## 1. Process & System Call Debugging

strace

Traces system calls made by a process
Used to debug: Application hangs, File not found / permission issues, Startup failures

ltrace

Traces library calls (glibc, OpenSSL, shared libs)
Used for: Dynamic library issues, Dependency failures

## 2. Process Monitoring & Analysis

top / htop

Real-time CPU and memory monitoring
Used for:
High CPU detection
Memory spikes
Zombie processes

ps (ps aux / ps -ef)

Snapshot of running processes
Used for:
PID identification
Process tree analysis

pidstat

Per-process CPU/memory tracking over time
Used for:
Performance trend analysis

## 3. Memory Troubleshooting

free / /proc/meminfo

Memory usage overview
Used for: RAM pressure detection

vmstat

System-wide CPU, memory, and I/O stats
Used for:
Swap issues
System bottlenecks

pmap

Memory map of a process
Used for:
Memory leak investigation

## 4. Disk & I/O Troubleshooting

iostat

Disk read/write performance monitoring
Used for:
Disk bottleneck detection

iotop

Real-time per-process disk usage
Used for:
Identifying heavy disk users

df / du

Disk space usage tools
Used for:
Full filesystem issues

## 5. Network Troubleshooting

ss

Displays sockets and open ports
Used for:
Connection states
Port listening checks

tcpdump

Packet capture tool
Used for:
Deep network debugging
Packet loss analysis

nload / iftop

Real-time network bandwidth monitoring
Used for:
Traffic spikes

dig / nslookup

DNS troubleshooting tools
Used for:
Domain resolution issues

## 6. Logs & Kernel Debugging

dmesg

Kernel logs
Used for:
Hardware errors
Boot issues

journalctl

systemd log viewer
Used for:
Service failure debugging
Application logs

## 7. Performance & Kernel-Level Tools

perf

CPU profiling tool
Used for:
Function-level performance analysis

sar

Historical system performance data
Used for:
Trend analysis in production

eBPF / bpftrace

Advanced kernel tracing
Used for:
Deep observability
Production-grade debugging

## 8. File & Binary Troubleshooting

ldd

Checks shared library dependencies
Used for:
Missing library issues

file

Identifies file type
Used for:
Corrupt binary detection

strings

Extracts readable text from binaries
Used for:
Reverse debugging unknown binaries