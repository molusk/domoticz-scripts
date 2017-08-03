#! /bin/sh
upSeconds=`/usr/bin/cut -d. -f1 /proc/uptime`
secs=$(($upSeconds%60))
mins=$(($upSeconds/60%60))
hours=$(($upSeconds/3600%24))
days=$(($upSeconds/86400))
UPTIME=`printf "%d days, %02dh %02dm %02ds " "$days" "$hours" "$mins" "$secs"`

# get the load averages
read one five fifteen rest < /proc/loadavg

echo "\033[0;32m
   .~~.   .~~.            \033[0;37m`date +"%A, %e %B %Y, %R"`\033[0;32m
  '. \ ' ' / .'           \033[0;37m`uname -srmo`\033[0;31m
   .~ .~~~..~.            \033[0;37m\033[0;31m
  : .~.'~'.~. :           \033[0;37mUptime..............: $UPTIME\033[0;31m
 ~ (   ) (   ) ~          \033[0;37mMemoire.............: $((`cat /proc/meminfo | grep MemFree | awk {'print $2'}`/1024))Mo (libre) / $((`cat /proc/meminfo | grep MemTotal | awk {'print $2'}`/1024))Mo (Totale)\033[0;31m
( : '~'.~.'~' : )         \033[0;37mEspace disque.......: $(df -Ph | grep -E '^/dev/mmcblk0p2' | awk '{ print $4 " (libre) / " $2 " (Total)" }')\033[0;31m
 ~ .~ (   ) ~. ~          \033[0;37mProcessus en cours..: `ps ax | wc -l | tr -d " "`\033[0;31m
  (  : '~' :  )           \033[0;37mCharge CPU..........: ${one}, ${five}, ${fifteen} (1, 5, 15 min)\033[0;31m
   '~ .~~~. ~'            \033[0;37mAddresses IP........: `ip a | grep glo | awk '{print $2}' | head -1 | cut -f1 -d/` / `wget -q -O - http://icanhazip.com/ | tail`\033[0;31m
       '~'                \033[0;37mTemperature.........: `vcgencmd measure_temp | sed "s/temp=//"`\033[0;31m
\033[0;32m"
#\033[0;32m"> /etc/motd
