#!/bin/bash
#set -x

QR_OOPS_CMD_NOTHING=0
QR_OOPS_CMD_PRINT_MESSAGES=1
QR_OOPS_CMD_PRINT_PACKETS=2
QR_OOPS_CMD_DELETE_MESSAGE=3
QR_OOPS_CMD_DELETE_PACKET=4
QR_OOPS_CMD_PAUSE=5
QR_OOPS_CMD_RESUME=6
QR_OOPS_CMD_CLEAR_QUEUE=7
QR_OOPS_CMD_STOP=8

QR_OOPS_CMD="/sys/module/kernel/parameters/qr_oops_cmd"
QR_OOPS_PARAM0="/sys/module/kernel/parameters/qr_oops_param0"
QR_OOPS_PARAM1="/sys/module/kernel/parameters/qr_oops_param1"

tolower()
{
	echo $1 | tr "[:upper:]" "[:lower:]" ;
}

toupper()
{
	echo $1 | tr "[:lower:]" "[:upper:]" ;
}

function invalid_command
{
	echo "Invalid command. Run help command to see full usage"
}

function display_help
{
	echo "qr-oops: "
	echo "	pause		= pause QR rendering"
	echo "	resume		= resume QR rendering"
	echo "	help		= display this help"
}

function give_cmd
{
	echo $2 > QR_OOPS_PARAM0
	echo $3 > QR_OOPS_PARAM1
	echo $1 > QR_OOPS_CMD
}

function pause
{
	give_cmd QR_OOPS_CMD_PAUSE 0 0
}

function resume
{
	give_cmd QR_OOPS_CMD_RESUME 0 0
}

if [[ $# -eq 0 ]] ; then
	display_help
elif [[ $# -eq 1 ]] ; then
	PARAM1=$(tolower $1)

	if [ "$PARAM1" == "help" ] ; then
		display_help
	elif [ "$PARAM1" == "pause" ] ; then
		pause
	elif [ "$PARAM1" == "resume" ] ; then
		resume
	else
		invalid_command
		exit 1
	fi
elif [[ $# -eq 2 ]] ; then
	PARAM1=$(tolower $1)
	PARAM2=$(tolower $2)

	if [[ "$PARAM1" == "del-msg" ]] ; then
		exit 1
	else
		invalid_command
		exit 1
	fi
else
	invalid_command
	exit 1
fi
