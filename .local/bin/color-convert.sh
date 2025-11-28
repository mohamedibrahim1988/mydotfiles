#!/bin/bash
color_to_hex() {
    local color_num=$1

    if [[ $color_num -lt 0 || $color_num -gt 255 ]]; then
        echo "Error: Color number must be between 0-255" >&2
        return 1
    fi

    if [[ $color_num -lt 16 ]]; then
        # Basic colors
        local basic=("000000" "800000" "008000" "808000"
            "000080" "800080" "008080" "c0c0c0"
            "808080" "ff0000" "00ff00" "ffff00"
            "0000ff" "ff00ff" "00ffff" "ffffff")
        echo "#${basic[$color_num]}"
    elif [[ $color_num -lt 232 ]]; then
        # 6x6x6 color cube
        local idx=$((color_num - 16))
        local r=$((idx / 36))
        local g=$(((idx % 36) / 6))
        local b=$((idx % 6))

        local r_val=$((r > 0 ? 55 + r * 40 : 0))
        local g_val=$((g > 0 ? 55 + g * 40 : 0))
        local b_val=$((b > 0 ? 55 + b * 40 : 0))

        printf "#%02x%02x%02x\n" $r_val $g_val $b_val
    else
        # Grayscale
        local gray=$((8 + (color_num - 232) * 10))
        printf "#%02x%02x%02x\n" $gray $gray $gray
    fi
}

# Hex to 256-color approximation
hex_to_color() {
    local hex=$1
    # Remove # if present
    hex=${hex##\#}

    if [[ ${#hex} -eq 3 ]]; then
        # Expand short hex (abc -> aabbcc)
        hex="${hex:0:1}${hex:0:1}${hex:1:1}${hex:1:1}${hex:2:1}${hex:2:1}"
    fi

    if [[ ${#hex} -ne 6 || ! $hex =~ ^[0-9a-fA-F]+$ ]]; then
        echo "Error: Invalid hex color format. Use #RGB or #RRGGBB" >&2
        return 1
    fi

    local r=$((16#${hex:0:2}))
    local g=$((16#${hex:2:2}))
    local b=$((16#${hex:4:2}))

    # Find closest 256-color
    local closest_color=0
    local min_distance=1000000

    for ((color_num = 0; color_num < 256; color_num++)); do
        local test_hex=$(color_to_hex $color_num | tr -d '#')
        local test_r=$((16#${test_hex:0:2}))
        local test_g=$((16#${test_hex:2:2}))
        local test_b=$((16#${test_hex:4:2}))

        # Calculate Euclidean distance in RGB space
        local distance=$(((r - test_r) ** 2 + (g - test_g) ** 2 + (b - test_b) ** 2))

        if [[ $distance -lt $min_distance ]]; then
            min_distance=$distance
            closest_color=$color_num
        fi
    done

    echo $closest_color
}

# Color number to RGB
color_to_rgb() {
    local color_num=$1
    local hex=$(color_to_hex $color_num | tr -d '#')

    local r=$((16#${hex:0:2}))
    local g=$((16#${hex:2:2}))
    local b=$((16#${hex:4:2}))

    echo "$r $g $b"

}

# Display color sample in terminal
show_color() {
    local color_num=$1
    local hex=$(color_to_hex $color_num)

    echo -n "Color $color_num: $hex "

    # Show colored block (if terminal supports it)
    if command -v tput >/dev/null && [[ $(tput colors) -ge 256 ]]; then
        echo -e "$(tput setaf $color_num)██████$(tput sgr0)"
    else
        echo "[Sample]"
    fi
}

# Print usage information
usage() {
    cat <<EOF
Usage: $0 [OPTION] [VALUE]

Convert between terminal color numbers, hex codes, and RGB values.

Options:
  -n, --number NUM    Convert color number (0-255) to hex and RGB
  -x, --hex HEX       Convert hex color (#RRGGBB or #RGB) to closest color number
  -s, --show NUM      Show color sample for color number
  -h, --help          Show this help message

Examples:
  $0 -n 157           # Convert color 157 to hex and RGB
  $0 -x "#afff5f"     # Find closest color number to hex
  $0 -s 157           # Show sample of color 157

EOF
}
# Main script logic
main() {
    case "${1:-}" in
    -n | --number)
        if [[ -z "$2" ]]; then
            echo "Error: Color number required" >&2
            usage
            exit 1
        fi
        local hex=$(color_to_hex "$2")
        local rgb=$(color_to_rgb "$2")
        printf "%s: %s\n" "Number" "$2"
        printf "%s: %s\n" "HEX" "$hex"
        printf "%s: %s" "RGB" "$rgb"
        ;;
    -x | --hex)
        if [[ -z "$2" ]]; then
            echo "Error: Hex color required" >&2
            usage
            exit 1
        fi
        local color_num=$(hex_to_color "$2")
        local rgb=$(color_to_rgb $color_num)
        printf "%s: %s\n" "HEX" "$2"
        printf "%s: %s\n" "Color" "$color_num"
        printf "%s: %s" "RGB" "$rgb"
        ;;
    -s | --show)
        if [[ -z "$2" ]]; then
            echo "Error: Color number required" >&2
            usage
            exit 1
        fi
        show_color "$2"
        ;;
    -h | --help)
        usage
        ;;
    *)
        echo "Error: Unknown option '$1'" >&2
        usage
        exit 1
        ;;
    esac
}

# Run main function if script is executed directly
if [[ "${BASH_SOURCE[0]}" == "${0}" ]]; then
    main "$@"
fi
