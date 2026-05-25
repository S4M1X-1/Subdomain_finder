#!/bin/bash

# =========================================================
# Simple Subdomain Finder
# Author: S4m1X
# Description:
#   - Downloads a webpage
#   - Extracts possible subdomains from links
#   - Checks if they are reachable
#   - Resolves their IP addresses
# =========================================================

# Check if the user provided a domain
if [ $# -eq 0 ]; then
    echo "Usage: ./sub_finder.sh <domain>"
    echo "Example: ./sub_finder.sh https://www.example.com"
    exit 1
fi

# Store the target domain
domain="$1"

# Extract the base domain name
# Example:
#   www.google.com -> google
base=$(echo "$domain" | cut -d "." -f2)

echo "[+] Target Domain: $domain"
echo "[+] Base Domain: $base"

# Download the webpage silently
echo "[+] Downloading webpage..."
wget -q "$domain" -O index.html

# Extract possible subdomains from href links
echo "[+] Extracting subdomains..."

grep "href=" index.html \
| cut -d '"' -f2 \
| grep "$base" \
| sort -u > sub.txt

echo "[+] Subdomains saved in sub.txt"

# Create/empty the valid subdomains file
> valid_subs.txt

# Check if subdomains are reachable
echo "[+] Checking reachable subdomains..."

while read sub; do

    # Send 1 ping request with 1 second timeout
    if ping -c 1 -W 1 "$sub" > /dev/null 2>&1; then

        echo "[VALID] $sub"
        echo "$sub" >> valid_subs.txt

    else
        echo "[INVALID] $sub"
    fi

done < sub.txt

echo "[+] Reachable subdomains saved in valid_subs.txt"

# Resolve IP addresses
echo "[+] Resolving IP addresses..."

> ips.txt

while read sub; do

    # Extract IPv4 addresses
    host "$sub" | awk '/has address/ {print $4}' >> ips.txt

done < valid_subs.txt

echo "[+] IP addresses saved in ips.txt"
echo "[+] Done."
