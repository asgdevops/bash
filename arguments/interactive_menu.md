# :book: interactive menu with select 

## Goal

Create an ineractive menu using select with case.

## Script

```bash
PS3="Please select an option: " ;
select opt in "one" "two" "three" "quit";
do
  echo "You picked the ${REPLY} option: $opt" ;
  message="";
  case "$opt" in
      "one")   message="$opt" ;;
      "two")   message="$opt" ;;
      "three") message="$opt" ;;
      "quit")  break ;;
      *)
        echo "Unkown option";
        break 
      ;;
  esac ;
done ;
```  


# :books: References

- [Bash Select Command](https://linuxhint.com/bash_select_command/)

<br/>

:arrow_backward: [back](../README.md)