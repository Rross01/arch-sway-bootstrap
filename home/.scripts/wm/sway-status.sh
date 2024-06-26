#!/bin/bash

layout() {
    RAW=$(swaymsg -t get_inputs -r | jq '[.[] | select(.type == "keyboard") | .xkb_active_layout_index][0]')
    if [[ $RAW = '0' ]] 
    then
        echo "en"
    else
        echo "ru"
    fi
}

battery() {
    cat /sys/class/power_supply/BAT0/capacity
}

body() {
    cat <<- EOF | jq --compact-output --monochrome-output
    [
        {
            "full_text": "$(date "+%H:%M")",
            "color": "#c5c8c6",
            "separator_block_width": 16
        },
        {
            "full_text": "$(date "+%d.%m")",
            "color": "#c5c8c6",
            "separator_block_width": 16
        },
        {
            "full_text": "$(battery)%",
            "color": "#c5c8c6",
            "separator_block_width": 16
        },
        {
            "full_text": "$(layout)",
            "color": "#c5c8c6",
            "separator_block_width": 16
        }
    ]
EOF
}

echo '{"version":1}'
echo '['

while :;
do
    echo "$(body),"
	sleep 1
done
