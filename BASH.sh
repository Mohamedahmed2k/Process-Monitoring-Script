#!/usr/bin/bash -i


#glopal var
kill=0
search=0
list=0
overall=0
Alerts=0
interval=0
Cpu_Usage=0
Mem_Usage=0
Realtime_Mode=0 
RED=1
GREEN=2
YELLOW=3
BLUE=4
PURPLE=5
killed=()
# help func
function Color () {
 echo "$(tput setaf $1) $2 Not exist$(tput sgr0)"
}
# verbs :# list running process
         # specific process
         # kill specific process
         # processes ovarall 
         # real time monitoring
         #Alerts

# inputs: - PID
# functions
#list
function list_running_processes() {
    Color $BLUE "List Process"
ps aux --sort=-%cpu | awk 'NR==1 || $3 > 1.5'
}
#search
function Specific_Process() {
    Color $BLUE "Search for $1 "
    ps aux --sort=-%cpu | grep -w "$1" | grep -v grep
}
#kill
function Kill_Process() {
    Color $RED "Kill Process $1 "
    kill "$1"
}
#Overlall
function Process_ovarall() {
    Color $BLUE "Overall System Process Statistics"
sum_cpu=$(ps aux --sort=-%cpu  | awk 'NR > 1 { sum_cpu += $3 } END { print sum_cpu }')
sum_mem=$(ps aux --sort=-%cpu  | awk 'NR > 1 { sum_mem += $4 } END { print sum_mem }')

Color $GREEN "CPU: $sum_cpu "
Color $PURPLE "MEM: $sum_mem "
}
#alerts
function Alerts_Process() {
Color $RED "Alert CPU usage:"
ps aux --sort=-%cpu | awk -v cpu=$Cpu_Usage '$3 > cpu {print $0}'
Color $RED "Alert Memory usage:"
ps aux --sort=-%cpu | awk -v cpu=$Mem_Usage '$4 > cpu {print $0}'
}
#config file
function Configration () {
   if [ ! -f "process_monitor.conf" ]; then
        Color $RED "Configration File : process_monitor.conf Not exist."
        exit 1
   fi
config_file="process_monitor.conf"

# Get 'UPDATE_INTERVAL' from the configuration file
interval=$(grep -oP '^\s*UPDATE_INTERVAL\s*=\s*\K[0-9]+' "$config_file")
# Check if the interval was found and is a number
if [[ ! "$interval" =~ ^[0-9]+$ ]]; then
Color $RED "Error: interval value not found or not a number."
  exit 2
fi

# Get 'CPU_ALERT_THRESHOLD' from the configuration file
Cpu_Usage=$(grep -oP '^\s*CPU_ALERT_THRESHOLD\s*=\s*\K[0-9]+' "$config_file")
# Check if the Cpu_Usage was found and is a number
if [[ ! "$Cpu_Usage" =~ ^[0-9]+$ ]]; then
Color $RED "Error: Cpu_Usage value not found or not a number."
  exit 2
fi

# Get 'MEMORY_ALERT_THRESHOLD' from the configuration file
Mem_Usage=$(grep -oP '^\s*MEMORY_ALERT_THRESHOLD\s*=\s*\K[0-9]+' "$config_file")
# Check if the Mem_Usage was found and is a number
if [[ ! "$Mem_Usage" =~ ^[0-9]+$ ]]; then
Color $RED "Error: Mem_Usage value not found or not a number."
  exit 2
fi
}

# operation
function main() {
   if [ -f "log.txt" ]; then
       rm log.txt
   fi   
    Configration
select USE in "Inetrctive_Mode" "Realtime_Mode" "Exist"; do 
    case "${USE}" in
       Inetrctive_Mode)
            select USE in "List_Running" "Alerts" "Search_specific_process" "Kill_process" "Ovarall" "Exist"; do 
            case "${USE}" in
            Ovarall)
                    clear
                    Process_ovarall
                    overall=$((overall + 1))
                ;;
                Alerts)
                    clear
                    Alerts_Process
                    Alerts=$((Alerts + 1))
                ;;
                Kill_process)
                    clear
                    echo "enter PID of the process:"
                    read input
                    Kill_Process $input
                    kill=$((kill + 1)) 
                    killed+=("$input")
                ;;
                Search_specific_process)
                    clear
                    echo "enter PID or Owner of the process:"
                    read input
                    Specific_Process $input
                    search=$((search + 1))
                ;;
                List_Running)
                    clear
                    list_running_processes
                    list=$((list + 1))
                ;;
                Exist)
                    clear
                    break
                ;;
                *)
                    clear
                    echo "default (none of above)"
                    break
                ;;
            esac
        done
        ;;
        Realtime_Mode)
        Realtime_Mode=$((Realtime_Mode + 1))
        while (true); do
            clear
            Process_ovarall
            Color $YELLOW "--------------------------------------------------------"
            list_running_processes
            Color $YELLOW "--------------------------------------------------------"
            Alerts_Process
            sleep $interval
        done
        ;;
        Exist)
            clear
            Color $YELLOW "CLOSED"
            touch log.txt
            echo "Logs" > log.txt
            echo "Realtime : $Realtime_Mode ," >> log.txt
            echo "List : $list ," >> log.txt
            echo "Search : $search ," >> log.txt
            echo "Alerts : $Alerts ," >> log.txt
            echo "Kill : $kill ," >> log.txt
            echo "Ovarall : $overall ," >> log.txt
            echo "Killed process PID :" "${killed[@]}" >> log.txt
            break
        ;;
        *)
            clear
            echo "default (none of above)"
            
            break
        ;;
    esac
done
}
#output
main $1



