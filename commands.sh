#!/bin/bash
read nick chan saying

function has { $(echo "$1" | grep -Pi "$2" > /dev/null)
    }
function say { echo "PRIVMSG $1 :$2"
    }

if [ "$nick" = Envy ]
then
    if has "$saying" "[Ss]ic 'em"
    then
        say $chan ">:T"
        say $chan "Grrrr..."
    elif has "$saying" "WrathBot: [Ss]peak"
    then
        say $chan ">:3"
        say $chan "Rawrrr!"
    elif has "$saying" "Wrathbot: fetch"
    then
        food=$(echo $saying | cut -d ' ' -f 3)  
        echo "PRIVMSG zb :zb buy $food as Envy"
        echo -e "PRIVMSG $chan :\001ACTION fetches :D\001" 
    fi
        
elif [ "$nick" = wheezl ]  #|| [ "$nick" = Synt4x ]
    then
    if has "$saying" "[Hh]i [Ww]rath[Bb]ot"
    then
        say $chan ":3"
        echo -e "PRIVMSG $chan :\001ACTION cuddles wheezl\001"
    elif has "$saying" "\b[Ss]ic 'em"
    then
        say $chan ">:T"
        echo -e "PRIVMSG $chan :\001ACTION growls deeply\001"
    fi
else
    if has "$saying" "WrathBot"
    then
        say $chan "I'll fite you!"
    fi
fi

if has "$saying" "[Ww]rath[Bb]ot: [Ii]nfo" || has "$saying" "[Ww]rath[Bb]ot: [Aa]bout"
then
    say $chan "Are you REALLY asking me that?! I'm WRATHBOT! I'm one of Envy's bots. I do tricks and I HATE ASTERISKS!"
fi

if has "$saying" "WrathBot: help"
then
    say $chan "I can fight you. Would that help?"
fi
