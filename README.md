# ARM Cipher

Enciphers and deciphers any text using a [Caesar Cipher](https://en.wikipedia.org/wiki/Caesar_cipher).
Built completely using ARM assembly code.

## Required Tools

- [docker](https://www.docker.com/products/docker-desktop/)

## Initial Setup

To be able to compile the code, use the docker container provided to run the code.

### Build Docker Image

This image has been setup to run ARMv6 32-bit and will also compile the assembly code.

```bash
make build
```

### Run Docker Container

```bash
make run
```

After both the build and run commands have been run you can run the commands below within the container.

## Usage

Below is how to call the compiled file. It takes two parameters:

- An encrypt (0) or decrypt (1) boolean variable
- A key which will be used to encrypt/decrypt the text

```bash
$>  ./build/cipher <encrypt/decrypt> <key>
```

The text that will be encrypted/decrypted is read via whatever is piped in, as shown in the examples below.

### Encrypting Data Example

```bash
$> echo 'hello' | ./build/cipher 0 lock || echo -e '\n'
$> vpiac
```

Use the same private key to encrypt/decrypt your message.

### Decrypting Data Example

```bash
$> echo 'vpiac' | ./build/cipher 1 lock || echo -e '\n'
$> hello
```
