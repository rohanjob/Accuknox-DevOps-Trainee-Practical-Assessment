#!/bin/bash

# Configuration
CPU_THRESHOLD=80
MEM_THRESHOLD=80
DISK_THRESHOLD=80
LOG_FILE="system_health.log"

# Function to log and alert
alert() {
    local message="$1"
    echo "$(date): $message" | tee -a "$LOG_FILE"
}

# Check CPU usage
cpu_usage=$(top -bn1 | grep "Cpu(s)" | awk '{print $2 + $4}' | cut -d. -f1)
if [ "$cpu_usage" -gt "$CPU_THRESHOLD" ]; then
    alert "ALERT: High CPU usage detected: $cpu_usage%"
fi

# Check Memory usage
mem_usage=$(free | grep Mem | awk '{print $3/$2 * 100.0}' | cut -d. -f1)
if [ "$mem_usage" -gt "$MEM_THRESHOLD" ]; then
    alert "ALERT: High Memory usage detected: $mem_usage%"
fi

# Check Disk space
disk_usage=$(df / | grep / | awk '{print $5}' | sed 's/%//')
if [ "$disk_usage" -gt "$DISK_THRESHOLD" ]; then
    alert "ALERT: High Disk usage detected: $disk_usage%"
fi

# Check running processes (optional: just listing count)
process_count=$(ps aux | wc -l)
alert "System Health Check - CPU: $cpu_usage%, MEM: $mem_usage%, DISK: $disk_usage%, Processes: $process_count"
