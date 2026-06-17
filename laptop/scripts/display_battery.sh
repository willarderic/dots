#!/bin/bash

BAT=$(acpi -b | grep "Battery 1" | grep -E -o '[0-9][0-9]?%')

# Full and short texts

# Set urgent flag below 5% or use orange below 20%
[ ${BAT%?} -le 5  ] && echo "󰂎 $BAT"
[ ${BAT%?} -le 33 ] && echo "󱊡 $BAT"
[ ${BAT%?} -le 67 ] && echo "󱊢 $BAT"
[ ${BAT%?} -le 100 ] && echo "󱊣 $BAT"

exit 0
