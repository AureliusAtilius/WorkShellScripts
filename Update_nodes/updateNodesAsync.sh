
#!/bin/bash

# ------------------------------------------------------------------
# Script: updateNodesAsync.sh
# Description: Connects to multiple Rocky Linux hosts via SSH and updates the OS asynchronously.
# Requirements:
#   - for now run as root until I set up ssh key
# Usage:
#   ./updateNodesAsync.sh
# ------------------------------------------------------------------

# ----------------------- Configuration ----------------------------



# List of Rocky Linux Hosts
HOSTS=(
    "host1"
    "host2"
    "host3"
)

# Update Command
UPDATE_CMD="sudo yum update -y"

# Logging
LOG_FILE="update_rocky_linux.log"
echo "=== Update started at $(date) ===" >> "$LOG_FILE"

# ----------------------- Functions -------------------------------

# Function to update a single host asynchronously
update_host_async() {
    local HOST="$1"
    echo "[$(date)] Starting update on $HOST..." | tee -a "$LOG_FILE"

    ssh -o "StrictHostKeyChecking=no" -o  BatchMode=yes -o ConnectTimeout=10 "$HOST" "$UPDATE_CMD" >> "$LOG_FILE" 2>&1

    if [ $? -eq 0 ]; then
        echo "[$(date)] Successfully updated $HOST." | tee -a "$LOG_FILE"
    else
        echo "[$(date)] Failed to update $HOST. Check the log for details." | tee -a "$LOG_FILE"
    fi
}

# ----------------------- Main Script -----------------------------



# Iterate over each host and update asynchronously
for HOST in "${HOSTS[@]}"; do
    update_host_async "$HOST" &  # Run update for each host in the background
done

# Wait for all background processes to finish
wait

echo "=== Update completed at $(date) ===" | tee -a "$LOG_FILE"
