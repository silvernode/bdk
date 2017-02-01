#!/bin/bash

# Directory containing sounds and config file
KIT_DIR="kits"

#Check for kits and load the config
#load default kit if specified kit not found

defaultKit(){
	echo "the kit: ${1} was not found"
	echo "Loading default kit.."
	echo

	KIT="${KIT_DIR}/default"
	cd ${KIT}

	if [ -f config ];then
			. config
	else
			echo "Could not load config"
			exit 0
	fi

}

checkKits(){
	if [ -d kits/${1} ];then

        KIT="${KIT_DIR}/${1}"
				cd ${KIT}

        if [ -f config ];then
            . config
        else
            echo "Could not load config"
						cd .. && cd ..
						defaultKit
        fi

    else
			defaultKit

    fi
}

help(){
	printf """
    BDK - BASH DRUM KIT

    ${0} [options] [kit-name]



    [options]  [Description]

    -k          Load drum kit
    -l          List available kits


    """
}

case $1 in
    -k | --kit)
 			checkKits  ${2}

    ;;

		-l | --list)
			printf "[ Installed Kits]\n"
			if [[ $(ls -A $DIR) ]];then
				ls ${KIT_DIR}
				exit 0
			else
				printf "There are no kits currently installed...\n"
				exit 0
			fi
		;;
    *)
			help
			exit 0
    ;;
esac


echo "BDK - Bash Drum Kit"
key(){
    echo
    echo "[d] = Bass Drum | [s] = Hi-Hat | [enter] = Snare | [h] help | [q] Quit"
}

key

echo
while true;do
    printf "(*)>  "

    read -s -n 1 key
	# -s: do not echo input character. -n 1: read only 1 character (separate with space)

    if [[ $key = "d" ]]; then
        aplay ${KICK} >/dev/null 2>/dev/null &
        echo "[d] Bass Drum"
    elif [[ $key == '' ]];then
        aplay ${SNARE} >/dev/null 2>/dev/null &
        echo "[enter] Snare Drum"
    elif [[ $key == "s" ]];then
        aplay ${HIHAT} >/dev/null 2>/dev/null &
        echo "[s] Hi-hat"
    elif [[ $key == "h" ]];then
        key
    elif [[ $key == "q" ]];then
        exit 0;
    else
        echo "'${key}' does nothing!"
    fi
done
