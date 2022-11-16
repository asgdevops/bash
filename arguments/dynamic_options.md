# :book: Dynamic Options

## Goal

Create a script using key pair arguments.

## Script

- Type 1: single value argument.

  i.e.

  ```bash
  ./script.sh a b c
  ```

  ```bash
  #!/bin/bash
  #
  # Dynamic options
  #
  while [[ "$#" > 0 ]] ; do
    key="$1" && shift ;
    case $key in
      a|1) value="$1" ;;
      b|2) value="$1" ;;
      c|3) value="$1" ;;
      *) value="$1" ;;
    esac;
    echo "key ${key} value ${var}"
  done;
  ```

- Type 2: key pair argument.

  i.e.

  ```bash
  ./script.sh -a value1 -b value2 -c value3
  ```

  ```bash
  #!/bin/bash
  #
  # Dynamic options
  #
  while [[ "$#" > 0 ]] ; do
    key="$1" && shift ;
    case $key in
      -a|--one)   value="$1" && shift ;;
      -b|--two)   value="$1" && shift ;;
      -c|--three)	value="$1" && shift ;;
      *) 
        echo "anything else" ;
        exit ;
      ;;
    esac;
    echo "key ${key} value ${value}"
  done;
  ```

## How it works

- Loop using `while [[ <condition> ]]` 

- Condition: `$# > 0` number of arguments is greater than zero.

- `key="$1"` means key variable stores the **first** argument from the arguments list. 

- `shift` gets the next argument from the list. 

- `<command 1> && <command 2>` means Command 2 executes if Command 1 is successful, otherwise it is not executed.

- Case condition: 
  
  ```bash
  case <value> in
    <conditionA (option 1)> | <conditionA (option 2)> )
      <script block>
    ;;
    ...
    *)
      <otherwise script block>
    ;;
  esac
  ```


# :books: References

- [Adding arguments and options to your Bash scripts](https://www.redhat.com/sysadmin/arguments-options-bash-scripts)

- [Bash While Loop Examples](https://www.cyberciti.biz/faq/bash-while-loop/)

<br/>

:arrow_backward: [back](../README.md)