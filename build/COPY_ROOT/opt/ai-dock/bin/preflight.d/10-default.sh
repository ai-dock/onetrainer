#!/bin/false

# This file will be sourced in init.sh

function preflight_main() {
    preflight_update_onetrainer
}


function preflight_update_onetrainer() {
    if [[ ${AUTO_UPDATE,,} != "false" ]]; then
        /opt/ai-dock/bin/update-onetrainer.sh
    else
        printf "Skipping auto update (AUTO_UPDATE=false)"
    fi
}



preflight_main "$@"
