#!/bin/bash
# Check if menu is currently open
if eww active-windows | grep -q "bar"; then
    eww close bar
else
    # Menu is closed, open it
    eww open bar
fi
