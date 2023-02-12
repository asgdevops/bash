# User management

## Add a user

- Syntax `useradd [options] [username]`
- Example:
  
  ```bash
  sudo useradd -m -s /bin/bash test
  sudo passwd test
  ```

  |Options|Description|
  |--|--|
  |`-m`| Creates a default `/home/$USER` directory.|
  |`-s`| Specifies the default shell.|

## Remove a user
- Syntax `userdel [options] [username]`
- Example:
  
  ```bash
  sudo userdel -r test
  ```

# References
- [useradd(8) — Linux manual page](https://man7.org/linux/man-pages/man8/useradd.8.html)
- [userdel(8) — Linux manual page](https://man7.org/linux/man-pages/man8/userdel.8.html)