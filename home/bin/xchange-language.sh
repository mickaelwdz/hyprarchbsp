#!/bin/bash

CURRENT_LAYOUT=$(xset -q|grep LED| awk '{ print $10 }')
setxkbmap -layout fr -option "grp:alt_shift_toggle"
