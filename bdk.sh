#!/bin/bash

# Directory containing sounds and config file
KIT_DIR="kits"

# Colors
RED='\033[0;31m'
LRED="\033[1;31m"
BLUE="\033[0;34m"
LBLUE="\033[1;34m"
GREEN="\033[0;32m"
LGREEN="\033[1;32m"
YELLOW="\033[1;33m"
CYAN="\033[0;36m"
LCYAN="\033[1;36m"
PURPLE="\033[0;35m"
LPURPLE="\033[1;35m"
BWHITE="\e[1m"
NC='\033[0m' # No Color



#Check for kits and load the config
#load default kit if specified kit not found

defaultKit(){
    echo
	printf "${LRED}The kit: '${1}' was not found${NC}\n"
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
			defaultKit ${1}

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
            printf "\n"
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


printf "${LPURPLE}\(*)/ BDK - Bash Drum Kit${NC}\n"
key(){
    echo
    printf "${LCYAN}[${KP}] = Kick${NC} | ${LGREEN}[${HHC}] = Hi-Hat Closed${NC} | ${YELLOW}[enter] = Snare${NC} | ${LPURPLE}[h] help${NC} |${LRED} [q] Quit${NC}\n"
}

key

echo
while true;do
    printf "${YELLOW}(*)>${NC}  "

    read -s -n 1 key
	# -s: do not echo input character. -n 1: read only 1 character (separate with space)

    if [[ $key = "${KP}" ]]; then
       ${PLAYER} ${KICK} >/dev/null 2>/dev/null &
        printf "${LCYAN}[${KP}] Kick${NC}\n"
    elif [[ $key == ${SD} ]];then
        ${PLAYER} ${SNARE} >/dev/null 2>/dev/null &
        printf "${YELLOW}[${SD}] Snare Drum${NC}\n"
    elif [[ $key == "${HHC}" ]];then
        ${PLAYER} ${HIHAT} >/dev/null 2>/dev/null &
        printf "${LGREEN}[${HHC}] Hi-Hat Closed${NC}\n"
    elif [[ $key == "h" ]];then
        key
    elif [[ $key == "q" ]];then
        exit 0;
    else
        printf "${LRED}'${key}' does nothing!${NC}\n"
    fi
done
