#!/usr/bin/env bash

# Server Health Monitor v1.0
# Author: Serhii Chornobai
# Date created: 07.11.2025
# Last modified: 07.11.2025

set -euo pipefail # Exit on error, undefined vars, pipe failures

# CPU

cpu_usage=$(awk -v cores="$(nproc)" '{print int($1/cores*100)}' /proc/loadavg)

if [[ $cpu_usage -ge 85 ]]; then
	echo "Critical! Usage of CPU: $cpu_usage%!"
else
	echo "Usage of CPU: $cpu_usage%"
fi

# RAM

ram_usage=$(free | awk '/^Mem:/ {print int($3*100/$2)}')

if [[ $ram_usage -ge 80 ]]; then
	echo "Critical! Usage of RAM: $ram_usage%!"
else
	echo "Usage of RAM: $ram_usage%"
fi

# Disk

disk_usage=$(df -h / | awk 'NR==2 {gsub("%","",$5); print $5}')

if [[ $disk_usage -ge 90 ]]; then
	echo "Critical! Usage of disk: $disk_usage%!"
else
	echo "Usage of disk: $disk_usage%"
fi