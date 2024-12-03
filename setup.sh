#!/bin/bash

SCRIPT_DIR=$(realpath "$(dirname "${BASH_SOURCE[0]}")")


cp monitor_test.sh /usr/local/bin/
chmod +x /usr/local/bin/monitor_test.sh

cp monitor_test.service /etc/systemd/system/
cp monitor_test.timer /etc/systemd/system/

systemctl daemon-reload
systemctl enable monitor_test.service
systemctl enable monitor_test.timer
systemctl start monitor_test.timer
