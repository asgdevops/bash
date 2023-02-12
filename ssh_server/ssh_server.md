# Install SSH server

## Symptom

```
ssh: connect to host `hostname` port 22: Connection refused
```

## Solution steps

1. Verify SSH is installed on your system.

    ```bash
    sudo apt list --installed | grep openssh-server
    ```
2. Install OpenSSH server.

    ```bash
    sudo apt install openssh-server -y
    ```
3. Check the status of the SSH service.

    ```bash
    sudo service ssh status
    ```

4. Commands to start or stop the SSH service
    ```bash
    sudo service ssh start
    sudo service ssh restart
    sudo service ssh stop
    ```

5. Check SSH Server Listening Port.

    ```bash
    sudo netstat -ltnp | grep sshd
    ```
6. Allow SSH in Firewall
    
    ```bash
    sudo ufw allow port /tcp
    sudo ufw reload
    ```

# References 
- [How to Fix Connection Refused by Port 22 Debian/Ubuntu](https://linuxhint.com/fix_connection_refused_ubuntu/)
