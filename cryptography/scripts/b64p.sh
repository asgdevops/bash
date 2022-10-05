#!/usr/bin/bash
# Name:         b64p.sh
# Description:  Creates a secret file from a password set interactively using the base64 algorithm
# Usage:        b64p.sh
# Output:       b64p.sec
# Important:    run 'cat b64p.sec | base64 --decode' to decrypt the message
# ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
# | Log        | Who                                             | What |
# | :--        | :--                                             | :--  |
# | 2022-10-05 | antonio.salazar.devops@gmail.com                | Initial creation. |
# ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
#
# Script version
#
version="v22.1.0.0";

#
# Display warning and exit
#
abort() {
  echo "Warning: Operation aborted." && exit 1;
}

#
# Read the password from user in silent mode
#
read -p "Input the new secret password': " -s new_password ; 
echo "$new_password" | sed 's/./*/g';
echo "Thanks for your input." ;

#
# Encrypt the password and writes it to a secret file
#
if [ -f ./b64p.sec ]; then
  echo "File 64pwd.sec alredy exists";
  read -p "Overwrite '64pwd.sec' file (yes/no): " answer ; 
  
  [ -z "$answer" ] && abort;

  answer=`echo "$answer" | tr '[:upper:]' '[:lower:]'`;

  if [ "$answer" == "yes" ]; then
    rm -f ./b64p.sec ;
  else
    abort;
  fi

fi

#
# Write encrypted password to secret file and set read-only privileges
#
echo -n $new_password | base64 > b64p.sec ;
[ -f ./b64p.sec ] && chmod 400 b64p.sec ;
[ $? -eq 0 ] && echo "Secret file `ls b64p.sec` created successfully";
