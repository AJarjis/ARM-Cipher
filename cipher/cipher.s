@ cipher.s

@ A simple cipher which encypts/decrypts a message with a given key.

@ Authors: Ali Jarjis, Daniel Carey

.data
character: .ascii "%c"

.text
.balign 4
.global main

@ Register Values:
@ R4 - first character of private key
@ R5 - process value (0 = encrypt/ 1 = decrypt)
@ R6 - current char in private key string
@ R7 - private key string index

main:
    PUSH {r4, r5, r6, r7, lr}

    @ retrieves the process (encrypt/decrypt choice) argument and stores in r5
    LDR r5, [r1, #4]
    LDRB r5, [r5]

    @ retrieves the first char of the private key argument and stores in r6
    LDR r4, [r1, #8]
    LDRB r6, [r4]

    BL loopend


@ Processes a character to be normalised and encrypted/decrypted
@ param: r0 - character to normalise and encrypt/decrypt
loop:
    BL normalise

    @ checks if normalised character is a lowercase letter else iterates loop
    CMP r0, #-1
    BEQ loopend

    MOV r0, r0  @ stores normalised character in r0 (redundant but placed to improve readability)
    MOV r1, r6  @ stores private key character in r1

    @ checks if user wishes to encrypt - compares r5 to ascii value of 0
    CMP r5, #48
    BLEQ encrypt

    @ checks if user wishes to decrypt - compares r5 to ascii value of 1
    CMP r5, #49
    BLEQ decrypt

    @ Prints encrypted/decrypted character in r1
    MOV r1, r0
    LDR r0, =character
    BL printf

    @ Iterates over each character in the private key ensuring it loops round
    ADD r7, r7, #1      @ Increases index by 1
    LDRB r6, [r4, r7]   @ Loads a private key character from the new index

    CMP r6, #0          @ Checks if it is a valid character
    MOVEQ r7, #0        @ Resets index if not valid

    LDRB r6, [r4, r7]   @ Reloads the private key character with reset index


@ Retrieves each character from the stream to be processed until no more
loopend:
    BL getchar		@ Retrieves next character from stream

    @ Processes character in loop function if found
    CMP r0, #-1
    BNE loop

    BL end


@ Ensures a character is a lowercase letter by converting uppercase characters
@ or notifies if the character is not a letter at all
@
@ param:  r0 - the character to normalise
@ return: r0 - normalised character or -1 which means character is not a letter
normalise:
    PUSH {r4, r5, r6, r7, lr}

    @ Flags any non alphabetic characters
    CMP r0, #65
    MOVLT r0, #-1

    @ Converts uppercase character to lowercase
    CMP r0, #91
    ADDLT r0, r0, #32

    @ Flags any non alphabetic characters
    CMP r0, #97
    MOVLT r0, #-1

    @ Flags any non alphabetic characters
    CMP r0, #122
    MOVGT r0, #-1

    B end


@ Encrypts a given character using a private key
@
@ param:  r0 - character to encrypt
@ param:  r1 - private key character
@ return: r0 - encrypted character
encrypt:
    PUSH {r4, r5, r6, r7, lr}

    @ Encrypts by adding private key value to character value
    SUB r2, r0, r1

    @ Prevents character from being anything but a lowercase letter by offsetting it's value
    ADD r2, r2, #96
    CMP r2, #97
    ADDLT r2, r2, #26

    MOV r0, r2  @ Returns encrypted character

    BL end


@ Decrypts a given character using a private key
@
@ param:  r0 - character to decrypt
@ param:  r1 - private key character
@ return: r0 - decrypted character
decrypt:
    PUSH {r4, r5, r6, r7, lr}

    @ Decrypts by adding private key value to character value
    ADD r2, r0, r1

    @ Prevents character from being anything but a lowercase letter by offsetting it's value
    SUB r2, r2, #96
    CMP r2, #122
    SUBGT r2, r2, #26

    MOV r0, r2  @ Returns decrypted character

    BL end


@ Ends a function by returning original values of these registers
end:
   POP {r4, r5, r6, r7, pc}
