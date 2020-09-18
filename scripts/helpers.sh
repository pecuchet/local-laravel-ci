#!/usr/scripts/env bash

# Coloured and underlined text
# with leading and trailing line-breaks
echo_title() {
    echo_color ${2:-cyan} "\n\033[4m${1}" '\n'
}

# Red text preceded by a high voltage sign
echo_error() {
    echo_color red "⚡ ${1}" '\n'
}

# Red text preceded by a tick
echo_success() {
    echo_color green "✓ ${1}" '\n'
}

# ASCII flag
echo_flag() {
    local title=$1
    local color=${2:-light-cyan}
    local char_count=$((${#title} + 3))
    local line=$(printf "%-${char_count}s" "-")

    echo_color ${color} "\n\n |${line// /-}\n | ${title}\n |${line// /-}\n |\n |\n _\n"
}

# Colour printing
echo_color() {
    local color=$1
    local target=$2
    local append=$3

    case ${color} in
        dark-gray)      color='1;30';;
        light-gray)     color='0;37';;
        white)          color='1;37';;
        red)            color='0;31';;
        light-red)      color='1;31';;
        khaki)          color='0;33';;
        yellow)         color='1;33';;
        blue)           color='0;34';;
        light-blue)     color='1;34';;
        purple)         color='0;35';;
        light-purple)   color='1;35';;
        purple)         color='0;35';;
        cyan)           color='0;36';;
        light-cyan)     color='1;36';;
        green)          color='0;32';;
        light-green)    color='1;32';;
        *)              color='0'
	esac

    echo -e "\033[${color}m${target}\033[0m${append}";
}
