#!/bin/bash

# Check if fzy is installed
command -v fzy >/dev/null 2>&1 || return
# Setup marks file
if [[ -z ${FZY_MARKS_FILE} ]]; then
    FZY_MARKS_FILE="$HOME/.fzy-marks"
fi

# Create marks file if it doesn't exist
if [[ ! -f $FZY_MARKS_FILE ]]; then
    touch "$FZY_MARKS_FILE"
fi

# Default fzy command if not set
if [[ -z $FZY_MARKS_COMMAND ]]; then
    FZY_MARKS_COMMAND='fzy -i -l 25 -c -p "Change dir.. "'
fi

# Completion function
function _fzym_setup_completion {
    complete -W "$(sed 's/ : .*//' "$FZY_MARKS_FILE")" fzym
}

# Function to mark current directory
function fzymark {
    local mark_to_add
    mark_to_add="${*:-$(basename "$(pwd)") : $(pwd)}"

    if grep -qxFe "${mark_to_add}" "$FZY_MARKS_FILE"; then
        echo "The following mark already exists.."
    else
        printf '%s\n' "${mark_to_add}" >>"${FZY_MARKS_FILE}"
        echo "The following mark has been added..."
    fi

    _fzym_color_marks <<<"$mark_to_add"
    _fzym_setup_completion
}

function _fzym_color_marks {
    if [[ "${FZY_MARKS_NO_COLORS-}" == "1" ]]; then
        cat
    else
        local esc c_lhs c_rhs c_colon
        esc=$(printf '\033')
        c_lhs=${FZY_MARKS_COLOR_LHS:-39}
        c_rhs=${FZY_MARKS_COLOR_RHS:-36}
        c_colon=${FZY_MARKS_COLOR_COLON:-33}
        sed "s/^\(.*\) : \(.*\)$/${esc}[${c_lhs}m\1${esc}[0m ${esc}[${c_colon}m:${esc}[0m ${esc}[${c_rhs}m\2${esc}[0m/"
    fi
}
fzym() {
    # Ensure marks file exists
    if [[ ! -f "${FZY_MARKS_FILE}" ]]; then
        echo "Marks file not found: ${FZY_MARKS_FILE}"
        return 1
    fi
    # Run selection
    local selected_line
    selected_line="$(eval "$FZY_MARKS_COMMAND" <"${FZY_MARKS_FILE}")"
    # Ensure something was selected
    if [[ -z "$selected_line" ]]; then
        echo "No directory selected."
        return 1
    fi
    # Extract path after " : "
    local selected_path
    selected_path="${selected_line##* : }"
    # Validate path
    [[ -d "$selected_path" ]] || {
        echo "Not a directory: $selected_path"
        return 1
    }
    # Change directory
    cd "$selected_path" || return 1
    printf "Changed directory to: %s\n" "$selected_line"
}

## Keybinding function
_fzym_setup_bindings() {
    bind '"\C-n":"\C-u fzym\C-m"'
}
_fzym_setup_bindings
# Setup completion on shell initialization
_fzym_setup_completion
