# :penguin: Linux File Encryption/Decryption using GPG (GNU Private Guard) 

## Types of encryption
### **Symetric**
When only a data string or passphrase is used for both encryption and decryption.
Use symmetric encryption when it is not needed to share the encrypted files with anyone else. 

### **Asymetric**
Asymmetric encryption is more suitable for the sharing of encrypted files, as it requires sharing only one of the two data strings. 

## Key Types
- In asymmetric encryption **key pairs** are used.
- A key pair consists of a **public key** and a **private key**.
- The **public key** is not confidential and can be shared with people without any risk.
- The **private key** should be kept in secret and never share it with anyone.
- Public keys are always used for encryption and private keys for decryption.
> _Key pairs are also used for digital signatures. In such cases, the private key creates the signature and its corresponding public key verifies its authenticity._ 

## Installing GPG
1. Verify thether gpg is installed or not.
   ```bash
   gpg --version
   ```

2. It the feeback is somthing like `command not found: gpg` proceed to install the package in your system.

   ### Debian 
   ```bash
   sudo apt install -y gnupg
   ```

   ### RHEL
   ```bash
   sudo yum install -y gnupg
   ```

   ### MacOS
   ```bash
   brew install gnupg
   ```

## Symmetric file encryption
### Encrypting files
1. Create a file.
   ```bash
   echo "Hello, wonderful world!" > file.txt
   ```

2. Encrypt the file using a passphrase.
   ```bash
   gpg --batch --output file_encrypted.txt --passphrase mypassword --symmetric file.txt
   ```

3. Verify the output file is encrypted, thus no readable.
   ```bash
   cat file_encrypted.txt
   ```

### Decrypting files
4. Decrypt the previous file.
   ```bash
   gpg --batch --output file_decrypted.txt --passphrase mypassword --decrypt file_encrypted.txt
   ```

5. Verify and compare it has been decrypted.
   ```bash
   cat file_decrypted.txt
   diff file.txt file_decrypted.txt
   ```

### Parameter explanation
- `--batch` runs in silent mode, avoiding to prompt for the passphrase input.
- `--output` indicates the name of the output file.
- `--passphrase` is the password.
- `--symmetric` sets the symmetric encryption method.

## Asymmetric file encryption
This encryption type requires to have defined roles, a sneder and a receiver.

|Role|Responsibility|
|--|--|
|:lock: Sender|Encrypts the file using the public key shared by the receiver.|
|:key: Receiver|Decrypts the received file. Generates the key pair, sends the public key to the sender and, keeps the private key save.|

### Generating the Key Pair (public and private keys)
1. The receiver is responsible of generating the keypair
    ```bash
    mkdir receiver &&  cd receiver ;
    passphrase='Example$123'
    gpg --batch --generate-key <<EOF
    Key-Type: RSA
    Key-Length: 3072
    Subkey-Type: RSA
    Subkey-Length: 3072
    Name-Real: Antonio Salazar
    Name-Email: antonio.salazar.devops@gmail.com
    Passphrase: $passphrase
    Expire-Date: 30
    %pubring receiver_public_keyring.kbx
    %commit
    EOF
    ```

2. Validate the contents of the public key.
   ```bash
   gpg --keyring ./receiver_public_keyring.kbx --no-default-keyring --list-keys
   ```

   > _**pub** refers to the public key._

3. Verify the contents of the private key.
   ```bash
   gpg --keyring ./receiver_public_keyring.kbx --no-default-keyring --list-secret-keys
   ```
   > _**sec** refers to the public key._

### Sharing and Importing the Public Key 

Now the receiver is able to share the public key to the sender so that the file gets encrypted. 

1. Export the public key.
   ```bash
   gpg --keyring ./receiver_public_keyring.kbx --no-default-keyring --armor --output rpubkey.gpg --export antonio.salazar.devops@gmail.com
   ```

2. Share the public key with the sender (anyone capable of encrypting the desired files).
   ```bash
   # For testing purposes the key is copied to other directory
   mkdir ../sender
   cp rpubkey.gpg ../sender
   cd ../sender 
   ls -l rpubkey.gpg
   ```

3. Import the receiver's public key onto the sender's keyring file.
   ```bash
   gpg --keyring ./sender_public_keyring.kbx --no-default-keyring --import rpubkey.gpg
   ```

4. Set the key status to trusted
   ```bash
   gpg --keyring ./sender_public_keyring.kbx --no-default-keyring --edit-key "antonio.salazar.devops@gmail.com" trust
   ```

   When prompted by the trust level question:
   - Specify our choice as 5 = I trust ultimately
   - Confirm as yes. 
   - Type quit to exit from the shell.

### Encrypt with the Sender's Public Key
1. Create the new file to encrypt.
   ```bash
   echo 'Hello Wonderful World!' > file.txt
   ```

2. State who is the receiver by setting their email address
   ```bash
   gpg --keyring ./sender_public_keyring.kbx --no-default-keyring --encrypt --recipient "antonio.salazar.devops@gmail.com" file.txt
   ```

3.  Copy the encrypted file to its destination.
    ```bash
    cp file.txt.gpg  ../receiver
    ```

### Dencrypt the file
1. Go to the receiver's directory
   ```bash
   cd ../receiver
   ```

2. Issue the decrypt command using the receiver's public key
   ```bash
   gpg --keyring ./receiver_public_keyring.kbx --no-default-keyring --pinentry-mode=loopback --passphrase "$passphrase" --output file2.txt --decrypt file.txt.gpg
   ```

3. Compare the differences
   ```bash
   diff -s file2.txt ../sender/file.txt
   ```

# :books: References
- :link: [Encrypting and Decrypting Files in Linux](https://www.baeldung.com/linux/encrypt-decrypt-files) by [Mohan Sundararaju](https://www.baeldung.com/linux/author/mohan-sundararaju).
- :link: [Homebrew Formulae](https://formulae.brew.sh/formula/gnupg)
