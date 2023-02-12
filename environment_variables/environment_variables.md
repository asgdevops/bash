# :book: Set up the environment variables on Ubuntu 22.04

An environment variable is a key pair value published to the entire operating system.

That means the operating system is familiar with such value every time you refer to it.

## Goal

- Create a working directory.
- Set up the environment variables to make the working directory visible the entire system.

## Scenario

Suppose that you want to have a working directory where to keep your bash scripts.

But you also want to set an alias or short name to call them anywhere on your system.

## About Bash startup files

The [Bash startup files](../bash_startup_files/bash_startup_files.md) execute when initiating a shell session or running a script remotely using SSH.

## Configuration Steps

1. Create your bash scripts working directory on `$HOME/scripts/bash`.

    ```bash
    [ ! -d ~/scripts/bash ] && mkdir -p ~/scripts/bash ;
    ```

2. Create your alias directory on `$HOME/scripts/bin`.

    ```bash
    [ ! -d ~/scripts/bin ] && mkdir -p ~/scripts/bin ;
    ```

3. Set up the `SCRIPTS_HOME` environment variable.

    ```bash
    export SCRIPTS_HOME=~/scripts/bin ;
    ```

4. Make variable `SCRIPTS_HOME` visible to the entire system by adding it to the `$PATH` system environment variable.

    ```bash
    export PATH=$PATH:$SCRIPTS_HOME ;
    ```

5. Turn the changes persistent so that when rebooting the system, the configuration is enabled and remains active.

  - In the example below, I am using `~/.bashrc` as the startup file because it is called by `~/.bash_profile`. But you can use the most convenient for you.
  - Click [About Bash startup files](../bash_startup_files/bash_startup_files.md) for more details.

    ```bash
    echo 'export SCRIPTS_HOME=~/scripts/bin' >> ~/.bashrc ;
    echo 'export PATH=$PATH:$SCRIPTS_HOME' >> ~/.bashrc ;
    ```

## Test the configuration

1. Create a `~/scripts/bash/hello_world.sh` script.

    ```bash
    echo 'echo "Hello World!"' > ~/scripts/bash/hello_world.sh;
    chmod +x ~/scripts/bash/hello_world.sh;
    ```

2. Set up a symbolic link named `~/scripts/bin/hello`.

    ```bash
    ln -s ~/scripts/bash/hello_world.sh ~/scripts/bin/hello;
    ```

3. Source the environment variables.

    ```bash
    source ~/.bash_profile;
    ```

4. Execute the script from different directories on your system.

    ```bash
    hello
    ```

# References

   