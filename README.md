# Test Process Monitoring Script

This repository provides a Bash script and necessary configuration files to monitor the `test` process on a Linux system. The monitoring script performs the following actions:

1. Runs every minute to check if the `test` process is active.
2. Sends a status request to `https://test.com/monitoring/test/api` if the process is running.
3. Logs to `/var/log/monitoring.log` if the process restarts or if the monitoring server is unavailable.

---

## Installation

To set up the monitoring script on your target server:

1. Clone this repository:
   ```bash
   git clone https://github.com/iamrunn/monitoring_test.git
   cd monitoring_test/
   ```
2. Run the setup script:
   ```bash
   sudo ./setup.sh
   ```
3. Checking the service and timer
   ```bash
   systemctl status monitor_test.service
   systemctl status monitor_test.timer
   ```

---

## Logs

The script writes logs to `/var/log/monitoring.log` for the following events:
- When the test process restarts.
- When the monitoring server (https://test.com/monitoring/test/api) is unavailable.
