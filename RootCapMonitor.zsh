#!/bin/zsh

#  Author: Jared Nay
#  Purpose: Alert whether disk if over 90% full.
#+ This was designed for use with Datto RMM.
#  Version: 20230917

# Get the percentage of disk space used
space_used=$(df -H / | awk 'NR==2{print $5}')

# Remove the % sign from the percentage
space_used=${space_used%\%}

# Check if the space used is greater than or equal to 90%
if [[ $space_used -ge 90 ]]; then
  echo "Hard drive is almost full. Space used: $space_used%"
else
  echo "Hard drive is not full. Space used: $space_used%"
fi
