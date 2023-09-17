#!/bin/sh

#  Author: Jared Nay
#  Purpose: macOS Disk Capacity Monitor for APFS drives
#+ This was designed for use with Datto RMM.
#  Version: 20230917

# Get the total capacity of the disk in bytes
total_bytes=$(diskutil info / | awk '/Disk Size/ {print $3}' | tr -d ',')

# Get the amount of free space on the disk in bytes
free_bytes=$(diskutil info / | awk '/Free Space/ {print $4}' | tr -d ',')

# Calculate the percentage of free space available
percent_free=$(echo "$free_bytes * 100 / $total_bytes" | bc)

# Check if the usage is greater than or equal to 90%
if (( $(echo "$percent_free <= 10" | bc -l) )); then
  echo "The disk is more than 90% full"
else
  echo "The disk space is good"
fi

# Output the results as XML
echo "<total_capacity>$total_bytes</total_capacity>"
echo "<free_space>$free_bytes</free_space>"
echo "<percent_free>$percent_free%</percent_free>"
