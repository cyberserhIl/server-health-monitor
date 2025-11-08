#!/usr/bin/env bash

# Server Health Monitor v1.2
# Author: Serhii Chornobai
# Date created: 07.11.2025
# Last modified: 08.11.2025

set -euo pipefail # Exit on error, undefined vars, pipe failures

# Colors
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[0;33m'
NC='\033[0m'

# Flags
while [[ $# -gt 0 ]]; do
    case "$1" in
        -v|--version)
            echo "Server Health Monitor: version 1.2"
            exit 0
            ;;
				-h|--help)
						echo
						echo "Server Health Monitor v1.2"
						echo "Author: Serhii Chornobai"
						echo "Usage: $0 [OPTIONS]"
						echo
						echo "Options:"
						echo "  -h, --help        Show this help message and exit"
						echo "  -v, --version     Show script version and exit"
						echo
						echo "This script monitors server health:"
						echo "  - CPU usage"
						echo "  - RAM usage"
						echo "  - Disk usage"
						echo
						echo "Output is color-coded:"
						echo -e "  ${RED}CRITICAL${NC} - Usage above critical threshold"
						echo -e "  ${YELLOW}WARNING${NC} - Usage above warning threshold"
						echo -e "  ${GREEN}OK${NC} - Usage below warning threshold"
						echo
						exit 0
						;;
        *)
            echo "Unknown option: $1"
            ;;
    esac
    shift
done

# Start output

echo "==========================================="
echo "   Server Health Monitor started"
echo "   Date: $(date '+%Y-%m-%d %H:%M:%S')"
echo "==========================================="
echo

# CPU

read cpu user nice system idle iowait irq softirq steal guest < <(grep '^cpu ' /proc/stat)
total_before=$((user + nice + system + idle + iowait + irq + softirq + steal))
sleep 1
read cpu user2 nice2 system2 idle2 iowait2 irq2 softirq2 steal2 guest2 < <(grep '^cpu ' /proc/stat)
total_after=$((user2 + nice2 + system2 + idle2 + iowait2 + irq2 + softirq2 + steal2))

total_diff=$((total_after - total_before))
idle_diff=$((idle2 - idle))

if (( total_diff == 0 )); then
  cpu_usage=0
else
  cpu_usage=$(( (100 * (total_diff - idle_diff)) / total_diff ))
fi

if [[ $cpu_usage -ge 90 ]]; then
	echo -e "${RED}CPU[CRITICAL]: $cpu_usage%!${NC}"
elif [[ $cpu_usage -ge 80 ]]; then
	echo -e "${YELLOW}CPU[WARNING]: $cpu_usage%!${NC}"
else
	echo -e "${GREEN}CPU[OK]: $cpu_usage%${NC}"
fi

# RAM
if ! command -v free &> /dev/null; then
  echo -e "${RED}Error: 'free' command not found${NC}" >&2
  exit 1
fi
ram_usage=$(free | awk '/^Mem:/ {print int($3*100/$2)}')

if [[ $ram_usage -ge 90 ]]; then
	echo -e "${RED}RAM[CRITICAL]: $ram_usage%!${NC}"
elif [[ $ram_usage -ge 75 ]]; then
	echo -e "${YELLOW}RAM[WARNING]: $ram_usage%!${NC}"
else
	echo -e "${GREEN}RAM[OK]: $ram_usage%${NC}"
fi

# Disk
if ! command -v df &> /dev/null; then
  echo -e "${RED}Error: 'df' command not found${NC}" >&2
  exit 1
fi
disk_usage=$(df -h / | awk 'NR==2 {gsub("%","",$5); print $5}')

if [[ $disk_usage -ge 95 ]]; then
	echo -e "${RED}Disk[CRITICAL]: $disk_usage%!${NC}"
elif [[ $disk_usage -ge 85 ]]; then
	echo -e "${YELLOW}Disk[WARNING]: $disk_usage%!${NC}"
else
	echo -e "${GREEN}Disk[OK]: $disk_usage%${NC}"
fi