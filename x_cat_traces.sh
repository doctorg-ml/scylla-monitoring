#!/bin/bash

# Prompt user for name (default is luis.gonzalez)
read -p "Enter your name (default: luis.gonzalez): " name
name=${name:-luis.gonzalez}

# Prompt user for ticket number
read -p "Enter ticket number: " ticket_number

# Define array for commands
commands=(
    "cat /home/support/.cassandra/${ticket_number}/*-sessions.csv > \"\$(date +%Y%m%d%H%M%S)-sessions.csv\""
    "cat /home/support/.cassandra/${ticket_number}/*-events.csv > \"\$(date +%Y%m%d%H%M%S)-events.csv\""
)

# Loop through commands
for command in "${commands[@]}"
do
    # Execute command
    ssh -A -t "${name}@scylladb.com@sgw-tlog.prd.dbaas.scyop.net" -- -o StrictHostKeyChecking=accept-new -l support 44.208.176.178 "$command"
done
