# :book: arguments with getops 

## Goal

Create a script with arguments using getopts.

## Script

- Type 1: single value argument.

  i.e.

  ```bash
  ./script.sh a b c
  ```

  ```bash
  while getopts "abc" in option; do
    message="";
    case ${option} in
      a) message = "You selected option ${option}" ;;
      b) message = "You selected option ${option}" ;;
      c) message = "You selected option ${option}" ;;
      *) 
        echo "unkown option" ;
        exit ;
      ;;
    esac
    echo ${message} ;
  done; 
  ```

- Type 2: key pair argument.

  i.e.

  ```bash
  ./script.sh -a value1 -b value2 -c value3
  ```

  ```bash
  while getopts "a:b:c:" in option; do
    message="";
    case ${option} in
      a) message = "You selected option ${OPTARG}" ;;
      b) message = "You selected option ${OPTARG}" ;;
      c) message = "You selected option ${OPTARG}" ;;
      *) 
        echo "unkown option" ;
        exit ;
      ;;
    esac
    echo ${message} ;
  done; 
  ```


# :books: References

- [Linux “getopts” Example](https://linuxhint.com/getopts-usage-example-linux/)

- [Bash While Loop Examples](https://www.cyberciti.biz/faq/bash-while-loop/)

<br/>

:arrow_backward: [back](../README.md)