# Linux File Encryption/Decryption using OpenSSL

## Encrypt the password and passphrase

1. Remove any existing password file
   ```bash
   rm ~/._p* ;
   ```

2. Create a new password file and grant read only access.
   ```bash
   echo -n "Type new password: "; stty -echo; read PASSWORD; stty echo; echo ;
   echo $PASSWORD | openssl enc -aes-256-cbc -a -salt -pass pass:$PASSWORD > ~/._pd ; 
   chmod 600 ~/._pd ; 
   ```

3. Create a new passphrase file and grant read only access.
   ```bash
   echo -n "Type new passphrase: "; stty -echo; read PASSPHRASE; stty echo; echo ;
   echo $PASSPHRASE | openssl enc -aes-256-cbc -a -salt -pass pass:$PASSWORD > ~/._ph ; 
   chmod 600 ~/._ph ;
   ```

4. Encrypt the password file 
   ```bash
   echo $(openssl enc -aes-256-cbc -a -d -salt -pass pass:$PASSWORD < ~/._pd) > ~/._ptmp ;
   gpg --batch --passphrase $(openssl enc -aes-256-cbc -a -d -salt -pass pass:$PASSWORD < ~/._ph) --output ~/._pd.gpg --symmetric ~/._ptmp ;
   rm ~/._ptmp ;
   ```

5. Grant read access to the default $USER
   ```bash
   setfacl -m u:$USER:r ~/._ph ~/._pd.gpg ;
   # or
   chmod 600 ~/._pd.gpg ;
   ```

   > _**Notice** it is important to **write down** the password and the passphrase prior the encryption, so that is is **possible** to decrypt those later._

### Decrypt the password and passphrase
1. Decrypt the password
   ```bash
   gpg -d --batch --passphrase $(openssl enc -aes-256-cbc -a -d -salt -pass pass:$PASSWORD < ~/._ph) ~/._pd.gpg 2>/dev/null ;
   ```

- Decrypt the password using a shell variable
   ```bash
   P=`gpg -d --batch --passphrase $(openssl enc -aes-256-cbc -a -d -salt -pass pass:$PASSWORD < ~/._ph) ~/._pd.gpg 2>/dev/null` ; 
   echo $P ;
   ```

2.  Decrypt passprhase
      ```bash
      cat ~/._ph | openssl enc -aes-256-cbc -a -d -salt -pass pass:$PASSWORD
      ```

3. Clear the variable values
   ```bash
   PASSWORD=`cat /dev/null`; 
   PASSPHRASE=`cat /dev/null`;
   echo $PASSWORD ;
   echo $PASSPHRASE ;
   ```

# Hash encoding

- **Encrypt**
   ```bash
   key="master key";
   psw="password to encrypt or decrypt";
   cde=$(echo $psw | openssl enc -aes-256-cbc -a -salt -pass pass:$key);
   ``` 
 
 - **Decrypt**
   ```bash
   echo $cde | openssl enc -aes-256-cbc -a -d -salt -pass pass:$key
   ```   
   
- BASH script example:
   ```bash
   encrypt() {
      # $1 is the password or message to encrypt
      # $2 is the passphrase to encrypt
      echo "$1" | openssl enc -aes-256-cbc -a -salt -pass pass:$2;
   }

   decrypt() {
      # $1 is the hash code to decrypt
      # $2 is the passphrase to decrypt
      echo "$1" | openssl enc -aes-256-cbc -a -d -salt -pass pass:$2;
   }

   #
   # Main
   # 
   key="master_key";
   msg="message_to_encrypt_or_decrypt";
   hsh=$(encrypt $psw $key);
   echo $hsh;
   decrypt $hsh $key;
   ```

# References
- [Encrypting and Decrypting Files in Linux](https://www.baeldung.com/linux/encrypt-decrypt-files) by [Mohan Sundararaju](https://www.baeldung.com/linux/author/mohan-sundararaju).
- [Homebrew Formulae](https://formulae.brew.sh/formula/gnupg)