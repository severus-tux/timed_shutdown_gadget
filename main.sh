#!/bin/bash

#    Tested on : Ubuntu 16.04 LTS , Arch Linux   
#    Date      : 19-May-2016
#    By        : Vishwa Prakash H V
#    Copyright (C) 2016  Vishwa Prakash H V
#
#    This program is free software: you can redistribute it and/or modify
#    it under the terms of the GNU General Public License as published by
#    the Free Software Foundation, either version 3 of the License, or
#    (at your option) any later version.
#
#    This program is distributed in the hope that it will be useful,
#    but WITHOUT ANY WARRANTY; without even the implied warranty of
#    MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
#    GNU General Public License for more details.
#
#   You should have received a copy of the GNU General Public License
#    along with this program.  If not, see <http://www.gnu.org/licenses/>.         

set -- `zenity --title="Scheduled-action" \
    --forms \
    --text='<span foreground="green">Enter Relative time</span>'  \
    --add-entry="hours" \
    --add-entry="min" -\
    --add-entry="sec" \
    --separator=".0 " \
    --add-combo=action --combo-values="poweroff|restart|suspend|logout"`

hrs=$1
min=$2
sec=$3
action=$4

time=$hrs\h\ $min\m\ $sec\s

#Checking validity of the input :

re='^[0-9]*([.][0-9]+)?$'

if ! [[ $hrs =~ $re ]] || ! [[ $min =~ $re ]] || ! [[ $sec =~ $re ]]
then
    zenity  --error \
            --title="Invalid Input" \
            --text="You have entered an Invalid time! \n\nOnly positive integers supported"
            exit 1
fi



case $action in
    "poweroff")
        zenity --title=Confirm --question \
        --text="Your system is about to <span foreground=\"red\">$action</span> in ${hrs%%.*} hours ${min%%.*} minutes ${sec%%.*} seconds. \nAre you sure \?"
        if [ $? -eq 0 ]
        then 
            sleep $time && poweroff
        else
            exit
        fi  ;;

    "restart")
        zenity --title=Confirm --question \
        --text="Your system is about to <span foreground=\"red\">$action</span> in ${hrs%%.*} hours ${min%%.*} minutes ${sec%%.*} seconds. \nAre you sure \?"
        if [ $? -eq 0 ]
        then 
            sleep $time && reboot
        else
            exit
        fi  ;;
    "suspend")

        zenity --title=Confirm --question \
        --text="Your system is about to <span foreground=\"red\">$action</span> in ${hrs%%.*} hours ${min%%.*} minutes ${sec%%.*} seconds. \nAre you sure \?"
        if [ $? -eq 0 ]
        then 
            sleep $time && systemctl suspend -i
        else
            exit
        fi  ;;
    "logout")
        zenity --title=Confirm --question \
        --text="Your system is about to <span foreground=\"red\">$action</span> in ${hrs%%.*} hours ${min%%.*} minutes ${sec%%.*} seconds. \nAre you sure \?"
        if [ $? -eq 0 ]
        then 
            sleep $time && gnome-session-quit --logout --no-prompt
        else
            exit
        fi  ;;
esac
