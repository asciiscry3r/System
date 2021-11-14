#!/usr/bin/env bash

iptables -N TCP
iptables -N UDP
iptables -N LOG
iptables -N LOG_AND_DROP
iptables -N LOG_AND_REJECT

iptables -P FORWARD DROP
iptables -P OUTPUT ACCEPT
iptables -P INPUT DROP

iptables -A LOG_AND_REJECT LOG --log-prefix "iptables deny: " --log-level 7
iptables -A LOG_AND_REJECT -j REJECT --reject-with icmp-proto-unreachable

iptables -A INPUT -m conntrack --ctstate RELATED,ESTABLISHED -j ACCEPT
iptables -A INPUT -i lo -j ACCEPT

iptables -A LOG_AND_DROP -j LOG --log-prefix "iptables deny: " --log-level 7
iptables -A LOG_AND_DROP -j DROP

iptables -A INPUT -p icmp --icmp-type 8 -m conntrack --ctstate NEW -j ACCEPT
iptables -A INPUT -m conntrack --ctstate INVALID -j LOG_AND_DROP
iptables -A INPUT -p udp -m conntrack --ctstate NEW -j UDP
iptables -A INPUT -p tcp --syn -m conntrack --ctstate NEW -j TCP
iptables -A INPUT -p tcp -m recent --set --rsource --name TCP-PORTSCAN -j REJECT --reject-with tcp-reset
iptables -A INPUT -p udp -m recent --set --rsource --name UDP-PORTSCAN -j REJECT --reject-with icmp-port-unreachable

iptables -t raw -I PREROUTING -m rpfilter --invert -j LOG_AND_DROP
iptables -A INPUT -j LOG_AND_REJECT

########## Ipv6

ip6tables -N TCP
ip6tables -N UDP
ip6tables -N LOG
ip6tables -N LOG_AND_DROP
ip6tables -N LOG_AND_REJECT

ip6tables -P FORWARD DROP
ip6tables -P OUTPUT ACCEPT
ip6tables -P INPUT DROP

ip6tables -A LOG_AND_REJECT LOG --log-prefix "iptables deny: " --log-level 7
ip6tables -A LOG_AND_REJECT -j REJECT --reject-with icmp6-adm-prohibited

ip6tables -A INPUT -m conntrack --ctstate RELATED,ESTABLISHED -j ACCEPT
ip6tables -A INPUT -i lo -j ACCEPT

ip6tables -A LOG_AND_DROP -j LOG --log-prefix "iptables deny: " --log-level 7
ip6tables -A LOG_AND_DROP -j DROP

ip6tables -A INPUT -p icmp --icmp-type 8 -m conntrack --ctstate NEW -j ACCEPT
ip6tables -A INPUT -m conntrack --ctstate INVALID -j LOG_AND_DROP
ip6tables -A INPUT -p udp -m conntrack --ctstate NEW -j UDP
ip6tables -A INPUT -p tcp --syn -m conntrack --ctstate NEW -j TCP
ip6tables -A INPUT -p tcp -m recent --set --rsource --name TCP-PORTSCAN -j REJECT --reject-with tcp-reset
ip6tables -A INPUT -p udp -m recent --set --rsource --name UDP-PORTSCAN -j REJECT --reject-with icmp6-adm-prohibited

ip6tables -t raw -I PREROUTING -m rpfilter --invert -j LOG_AND_DROP
ip6tables -A INPUT -j LOG_AND_REJECT

ip6tables -A INPUT -p ipv6-icmp --icmpv6-type 128 -m conntrack --ctstate NEW -j ACCEPT
ip6tables -A INPUT -s fe80::/10 -p ipv6-icmp -j ACCEPT
ip6tables -A INPUT -p udp --sport 547 --dport 546 -j ACCEPT
ip6tables -t raw -A PREROUTING -m rpfilter -j ACCEPT
ip6tables -t raw -A PREROUTING -m rpfilter -j ACCEPT
ip6tables -t raw -A PREROUTING -j LOG_AND_DROP
