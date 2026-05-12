#!/bin/bash
input=$(cat)
MODEL=$(echo "$input" | jq -r '.model.display_name')
COST=$(printf '$%.2f' "$(echo "$input" | jq -r '.cost.total_cost_usd // 0')")
TEXT="$MODEL | $COST"
COLS=$(tput cols 2>/dev/null || echo 80)
printf "%*s" "$COLS" "$TEXT"
