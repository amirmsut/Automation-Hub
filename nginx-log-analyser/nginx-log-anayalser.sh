#!/bin/bash

if [ $# -ne 1 ]; then
    echo "استفاده: $0 <log-file>"
    exit 1
fi

LOG_FILE="$1"

if [ ! -f "$LOG_FILE" ]; then
    echo "خطا: فایل $LOG_FILE وجود ندارد"
    exit 1
fi

format_output() {
    while read -r count item; do
        echo "$item - $count requests"
    done
}

echo "Top 5 IP addresses with the most requests:"
cat "$LOG_FILE" | awk '{print $1}' | sort | uniq -c | sort -rn | head -5 | awk '{print $1, $2}' | format_output
echo ""

echo "Top 5 most requested paths:"
cat "$LOG_FILE" | awk '{print $7}' | sort | uniq -c | sort -rn | head -5 | awk '{print $1, $2}' | format_output
echo ""

echo "Top 5 response status codes:"
cat "$LOG_FILE" | awk '{print $9}' | sort | uniq -c | sort -rn | head -5 | awk '{print $1, $2}' | format_output
echo ""

echo "Top 5 user agents:"
cat "$LOG_FILE" | awk -F\" '{print $6}' | sort | uniq -c | sort -rn | head -5 | awk '{print $1, $2}' | format_output