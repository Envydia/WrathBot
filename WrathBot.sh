#!/bin/bash

key=`cat chankey`

function send {
    echo "-> $1"
    echo "$1" >> .botfile
}

rm .botfile
mkfifo .botfile

tail -f .botfile | openssl s_client -connect irc.cat.pdx.edu:6697 | while true
do
    if [[ -z $started ]]
    then
        send "USER WrathBot WrathBot Wrathbot :Angry Bot Envy"
        send "NICK WrathBot"
        send "JOIN #EnvyTest"
        send "JOIN #tabletop"
        send "JOIN #mtg"
        send "JOIN #necromancers $key"
        send "JOIN #robots $key"
        send "JOIN #bots $key"
        started="yes"
    fi

    read irc 
    echo "<- $irc"

    if $(echo $irc | cut -d ' ' -f 1 | grep PING > /dev/null)
    then
        send "PONG"

    elif $(echo $irc | grep PRIVMSG > /dev/null)
    then 
        chan=$(echo $irc | cut -d ' ' -f 3)
        barf=$(echo $irc | cut -d ' ' -f 1-3)
        saying=$(echo ${irc##$barf :}|tr -d "\r\n")
        nick="${irc%%!*}"
        nick="${nick#:}"
        var=$(echo "$nick" "$chan" "$saying" | ./commands.sh)
        if [[ ! -z $var ]]
        then
            send "$var"
        fi
    fi
done
