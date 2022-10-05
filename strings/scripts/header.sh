#!/usr/bin/bash
# Name:         header.sh
# Description:  Display a simple bash header message
# Usage:        header.sh -m "<message>" {-c '<char>'} {-j '[l|c|r]'}  {-w <width>}
# Where:
#     -m "<message>":  is the header message to be displayed. (mandatory)
#   Optional:
#     -c '<char>': is the character used to decorate the header. ('-')
#     -j <justification>: 
#         use 'l' for left justification. ('l')
#         use 'c' for center justification.
#         use 'r' for right justification.
#     -w <width>: is the width or characters size of the header.  (80)
#     (<value>): Is the default value when the argument is omitted.
#
#   Example:
#     ./$(basename ${0}) -m "Here is the header example" -c '~' -j 'c' -w 100 
#
# ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
# | Log        | Who                                             | What |
# | :--        | :--                                             | :--  |
# | 2022-10-04 | antonio.salazar.devops@gmail.com                | Initial creation. |
# ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
#
# Script version
#
version="v22.1.0.0";

#
# Show Usage
#
usage() {
tee msg.txt<<EOF

Usage:
  ./$(basename ${0}) -m "<message>" {-c '<char>'} {-j '[l|c|r]'}  {-w <width>}

Where:
  -m "<message>":  is the header message to be displayed. (mandatory)

Optional:
  -c '<char>': is the character used to decorate the header. ('-')
  -j <justification>: 
      use 'l' for left justification. ('l')
      use 'c' for center justification.
      use 'r' for right justification.
  -w <width>: is the width or characters size of the header.  (80)

  (<value>): Is the default value when the argument is omitted.

Example:
  ./$(basename ${0}) -m "Here is the header example" -c '~' -j 'c' -w 100 

EOF
rm -f msg.txt ;
}

#
#  Displays a header according to the arguments below: 
#
set_header(){
  local filler="";
  local blanks="";

  #
  # Get the message justification
  #
  case $justify in
    l|left)   offset=0 ;;
    c|center) offset=$(( ( ${width} - ${#message} ) /2 )) ;;
    r|rigth)  offset=$((${width} - ${#message})) ;;
    *)        offset=0 ;;
  esac

  #
  # Fill with $chars according to the $width size
  #
  for ((i=0; i<${width}; i++)); do
    filler="${filler}${char}"
  done

  #
  # Fill with $blanks according to the $offset size
  #
  for ((i=0; i<${offset}; i++)); do
    blanks="${blanks} "
  done

  #
  # Display header message with decorative characters
  #
  echo "$filler";
  echo "${blanks}${message}";
  echo "$filler";

  unset filler blanks;
}

#
# Main
#

#
# Veriyfy number of arguments
#
if [[ "$#" -lt 2 ]]; then
  echo "Error: At least one argument expected." ;
  usage;
  exit 1;
fi

#
# Read dynamyc options
#
while [[ "$#" > 0 ]] ; do
	key="$1" ;
	shift ;
	case $key in
		-c) char="$1";    shift ;;
    -m) message="$1"; shift ;;
		-w)	width="$1";	  shift ;;
		-j) justify="$(echo $1|tr '[:upper:]' '[:lower:]')"; shift ;;
		*)
      echo "Error: Unkown argument:";
      usage;
      exit 2;
		;;
	esac;
done;

#
# Set default values
#
[ -z $char ] && char="-" ;
[ -z $width ] && width=80 ;

set_header ;
