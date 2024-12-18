#!/bin/sh
dateformat="%H:%M %d.%m.%Y"
date="$(date +'%H:%M %d.%m.%y')"
player=" - "
noOfPackagesToUpdate=""

center() {
  termwidth=$1
  padding="$(printf '%0.1s' \ {1..500})"
  arg2="$2"
  length=${#arg2} 
  paddingwidth="$(($termwidth/2 - $length/2))"
  if [ "$length" -gt "$termwidth" ] ; then
    printf "${arg2:0:termwidth-3}..."
    return
  fi
  printf '%*.*s %s %*.*s\n' 0 $paddingwidth "$padding" "$2" 0 $paddingwidth "$padding"
}

metrics() {
  cpupercent=$(top -bn1 | grep '%Cpu' | tail -1 | grep -P '(....|...) id,'| awk '{print ($8/16)}')
  ramfree=$(free -m | grep -i mem  | awk '{print ($3/$2)*100}')
  printf "%s" "CPU ${cpupercent:0:3}%, RAM ${ramfree:0:2}%"
}

while true; do 
  (( 10#$(date +%s) % 30 )) || date=$(date +'%H:%M %d.%m.%y')
  (( 10#$(date +%s) % 10 )) || player="$(playerctl -a metadata artist) - $(playerctl -a metadata title)"
  (( 10#$(date +%s) % 10 )) || noOfPackagesToUpdate="$(pacman -S -u -p --print-format %n| wc -l)"
  xsetroot -name "| $(center "60" "$player") | $(center "20" "$(metrics)") | $(center "15" "$date") |";
  sleep 1;

  # $(center "12" "updates: $noOfPackagesToUpdate") 
done &

# anti - tearing
picom -b

# auto start apps
firefox &
lutris &
heroic &
thunderbird &
steam &
signal-desktop &
dropbox &
flameshot &
