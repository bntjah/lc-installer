#!/bin/bash
## Finding the ethernet connected to internet
lc_ip=$(ip route get 8.8.8.8 | awk 'NR==1 {print $NF}')
## Dividing the found IP in multiple variables
lc_ip_p1=$(echo ${lc_ip} | tr "." " " | awk '{ print $1 }')
lc_ip_p2=$(echo ${lc_ip} | tr "." " " | awk '{ print $2 }')
lc_ip_p3=$(echo ${lc_ip} | tr "." " " | awk '{ print $3 }')
lc_ip_p4=$(echo ${lc_ip} | tr "." " " | awk '{ print $4 }')
