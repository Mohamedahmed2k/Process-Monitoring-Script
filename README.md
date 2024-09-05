# Process Monitoring Script

A Bash script for interactive and real-time process monitoring. The script allows you to list running processes, search for specific processes, kill processes, monitor overall system statistics, and receive alerts based on CPU and memory usage thresholds. 

## Features

- **List Running Processes**: View processes sorted by CPU usage.
- **Search for Specific Processes**: Find processes by PID or owner.
- **Kill Processes**: Terminate processes by PID.
- **Overall System Statistics**: View aggregate CPU and memory usage.
- **Real-Time Monitoring**: Continuously monitor and display system statistics and alerts.
- **Alerts**: Notify when CPU or memory usage exceeds configured thresholds.

## Installation

1. **Clone the Repository**:
    ```bash
    git clone https://github.com/Mohamedahmed2k/Process-Monitoring-Script.git
    ```

2. **Navigate to the Directory**:
    ```bash
    cd Process-Monitoring-Script
    ```

3. **Make the Script Executable**:
    ```bash
    chmod +x BASH.sh
    ```

4. **Create a Configuration File**:
    Create a file named `process_monitor.conf` with the following format:
    ```ini
    UPDATE_INTERVAL=5
    CPU_ALERT_THRESHOLD=80
    MEMORY_ALERT_THRESHOLD=80
    ```

## Usage

1. **Run the Script**:
    ```bash
    ./BASH.sh
    ```

2. **Interactive Mode**:
    - **List Running Processes**: View processes and their CPU usage.
    - **Search Specific Process**: Search for a process by PID or owner.
    - **Kill Process**: Terminate a process by PID.
    - **Overall Statistics**: Display overall system CPU and memory usage.
    - **Alerts**: Show alerts for processes exceeding CPU or memory thresholds.
    - **Exit**: Exit the interactive mode.

3. **Real-Time Monitoring Mode**:
    - Continuously display overall system statistics, running processes, and alerts based on the interval specified in the configuration file.

4. **Exit**:
    - Logs summary and actions performed will be saved to `log.txt`.

## Configuration

Edit `process_monitor.conf` to configure:
- `UPDATE_INTERVAL`: Time in seconds between real-time updates.
- `CPU_ALERT_THRESHOLD`: CPU usage percentage to trigger an alert.
- `MEMORY_ALERT_THRESHOLD`: Memory usage percentage to trigger an alert.

## Example Configuration File

```ini
UPDATE_INTERVAL=5
CPU_ALERT_THRESHOLD=80
MEMORY_ALERT_THRESHOLD=80
