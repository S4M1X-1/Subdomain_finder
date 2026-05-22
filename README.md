# Subdomain Finder

A simple Bash script for extracting and validating subdomains from a target website.

## Features

- Downloads webpage source code
- Extracts possible subdomains from links
- Checks reachable hosts using ping
- Resolves IP addresses of valid subdomains

## Requirements

Make sure these tools are installed:

- bash
- wget
- grep
- awk
- host
- ping

## Installation

Clone the repository:

```bash
git clone https://github.com/yourusername/subdomain-finder.git
cd subdomain-finder
```

Give execution permissions:

```bash
chmod +x sub_finder.sh
```

## Usage

```bash
./sub_finder.sh https://www.example.com
```

## Output Files

| File | Description |
|------|-------------|
| sub.txt | Extracted subdomains |
| valid_subs.txt | Reachable subdomains |
| ips.txt | Resolved IP addresses |

## Example

```bash
./sub_finder.sh https://www.google.com
```

## Limitations

- Only extracts subdomains found inside page links
- Does not perform brute force enumeration
- Some servers may block ping requests
- Parsing HTML with grep is not fully reliable

## Future Improvements

- Add multithreading
- Use curl instead of wget
- Add DNS bruteforce
- Export results to JSON
- Improve domain extraction logic

