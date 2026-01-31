#!/bin/bash
#
# Banner Grabbing Script
# Author: Mduduzi W Radebe
# Purpose: Automate banner grabbing for multiple services
# Date: December 28, 2024

echo "=================================="
echo "Banner Grabbing Tool"
echo "=================================="
echo ""

# Check if user provided a target
if [ -z "$1" ]; then
    echo "Usage: $0 <target>"
    echo "Example: $0 example.com"
    exit 1
fi

TARGET=$1
OUTPUT_DIR=~/Labs/Project8_Banner_Grabbing_Netcat/outputs
TIMESTAMP=$(date +%Y%m%d_%H%M%S)

echo "Target: $TARGET"
echo "Timestamp: $TIMESTAMP"
echo ""

# Function to grab banner
grab_banner() {
    local port=$1
    local service=$2
    
    echo "[$service] Checking port $port..."
    timeout 3 nc -v -w 2 $TARGET $port > $OUTPUT_DIR/${TARGET}_${service}_${TIMESTAMP}.txt 2>&1
    
    if [ $? -eq 0 ]; then
        echo "  ✓ Port $port is open"
        echo "  Banner saved to: ${TARGET}_${service}_${TIMESTAMP}.txt"
    else
        echo "  ✗ Port $port is closed or filtered"
    fi
    echo ""
}

# Test common ports
grab_banner 21 "ftp"
grab_banner 22 "ssh"
grab_banner 25 "smtp"
grab_banner 80 "http"
grab_banner 443 "https"
grab_banner 3306 "mysql"

echo "=================================="
echo "Banner grabbing complete!"
echo "Results saved in: $OUTPUT_DIR"
echo "=================================="
