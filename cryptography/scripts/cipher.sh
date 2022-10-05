#!/usr/bin/bash
# Name:         cipher.sh
# Description:  Encrypts or decrypts a list of files using GPG symmetric method.
# Usage:        cipher.sh <action {'-e' to encrypt | '-d' to decrypt }>  <passphrase> <file list>
# Output:       The encrytped files are placed onto a directory named $PWD/secret using .sec extension.
#               When decrypting the .sec extension is removed from the file name and the files are placed onto $PWD/restore directory.
# Examples:      
#     - Encrypt files with .txt extension
#     cipher -e mypassphrase *.txt
#
#     - Dencrypt files with .sec extension
#     cipher -c mypassphrase *.sec
#
# ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
# | Log        | Who                                             | What |
# | :--        | :--                                             | :--  |
# | 2022-10-01 | antonio.salazar.devops@gmail.com                | Initial creation. |
# ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
#
# Script version
#
version="v22.1.0.0";

#
# Show usage
#
usage() {
  echo "crypt.sh <action> <passphrase> <file list>";
  echo "Where:";
  echo "  <action>={'e' to encrypt | 'd' to decrypt}.";
  echo "  <passphrase> is the symmetrical pasphrase.";
  echo "  <file list> is the list of files to encrypt or decrypt.";
  echo ;
}

#
# Verify the number of arguments
#
if [ "$#" -lt 3 ] ; then
  echo "Error: three arguments expected at least.";
  usage;
  exit 1;
fi

#
# Get argument list
#
action="$1" && shift ;
passphrase="$1" && shift ;
file_list=$@

#
# Encrypt or decrypt sing the passphrased provided
#
case $action in
  #
  # Encrypt adding the '.sec' file extenstion and placing the encrypted files onto $PWD/secret
  #
  -e|--encrypt)
    [ ! -d ./secret ] && mkdir ./secret; 
    for file in $file_list; do
      gpg --batch --output ./secret/$file.sec --passphrase $passphrase --symmetric $file
    done
  ;;

  #
  # Decrypt removing the '.sec' file extenstion and placing the decrypted files onto $PWD/restore
  #
  -d|--decrypt)
    [ ! -d ./.ret ] && mkdir ./.ret; 
    for file in $file_list; do
      new_name=`echo $file | sed "s/.sec//g"`
      gpg --batch --output $new_name --passphrase $passphrase --decrypt $file;
    done
    [ -d ./.ret ] && mv ./.ret ./restore; 
  ;;

  #
  # Unexpected argument
  #
  *)
    echo "Unkown action";
    usage;
  ;;
esac
