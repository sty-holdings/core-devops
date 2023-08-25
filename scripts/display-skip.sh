#!/bin/bash
#
# This is reusable code for displaying skip message on the screen
#

function display_skip_message() {
  if [[ ("$1" == "Y") || ("$1" == "y") ]]; then
    echo " Do you want to ${BLACK}${ON_YELLOW}SKIP${COLOR_OFF} this step? (${BLACK}${ON_YELLOW}Y${COLOR_OFF}/n)"
  else
    echo " Do you want to ${BLACK}${ON_YELLOW}SKIP${COLOR_OFF} this step? (y/${BLACK}${ON_YELLOW}N${COLOR_OFF})"
  fi
}
