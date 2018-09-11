# ARM Cipher

## What it does?
Encipher and deciphers a piece of text using a caesar cipher. Built completely using ARM assemblya and allows you to encipher/decipher any input with a given private key.

## So does it work?
Yes. Example of use: 
```
cat textfile.txt | ./cw2 0 lock. 
```

Use 0 as a parameter to encrypt the input and 1 to decrypt followed by the private key (e.g. "lock"). This will encrypt/decrypt whetever is piped through.

## Why was it made?
Primarily made as a way of learning about operating systems and assembly language. 

