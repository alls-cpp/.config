#!/bin/bash

capacity=$(acpi | tr -d -c 0-9 | cut -c 4-5)
if [[ $capacity -le 20 ]]; then
    notify-send \
        "LOW BATTERY" \
        "Only ${capacity}% battery remaining"
fi
