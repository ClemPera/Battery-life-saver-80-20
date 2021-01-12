This script help to save life of your battery (Work on Linux with X server)

Add this in crontab : @reboot XDG_RUNTIME_DIR=/run/user/$(id -u) /home/clement/scripts/batterynotify.sh

You can change the MIN, MAX or TIME (set how long the notification stay) value if you want
