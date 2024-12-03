#!/bin/bash

PROCESS_NAME="test"
LOG_FILE="/var/log/monitoring.log"
URL="https://test.com/monitoring/test/api"
REQUEST_MAX_TIME=4
PREV_PID_FILE="/tmp/${PROCESS_NAME}.prev_pid"

function is_server_available {
    curl --max-time ${REQUEST_MAX_TIME} -w "%{http_code}" -o /dev/null -s "${URL}" | grep "200\|201" > /dev/null && return 0 || return 1
}
function get_process_pid {
    echo $(pgrep -x "${PROCESS_NAME}")
}

prev_pid=$(cat "${PREV_PID_FILE}" 2> /dev/null || echo "")
current_pid=$(get_process_pid)

if [[ -n "${current_pid}" ]]; then
    if [[ "${current_pid}" != "${prev_pid}" ]]; then
        echo "$(date) - Proccess ${PROCESS_NAME} was restarted. New PID: ${current_pid}" >> "${LOG_FILE}"
        echo "${current_pid}" > "${PREV_PID_FILE}"
    fi
    if ! is_server_available; then
        echo "$(date) - Monitoring server is unavailable: ${URL}" >> "${LOG_FILE}"
    fi
fi
