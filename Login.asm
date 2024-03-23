
; You may customize this and other start-up templates; 
; The location of this template is c:\emu8086\inc\0_com_template.txt

org 100h

.MODEL small
.STACK 100h

.DATA
    uinp db 13, 0, 14 DUP('$')  ; Username register input, max 12 letters
    pinp db 17, 0, 16 DUP('$')  ; Password register input, max 16 letters
    ulinp db 13, 0, 14 DUP('$') ; Username login input
    plinp db 17, 0, 16 DUP('$') ; Password login input
    valid_username db "myuser", 0 ; Valid username (change as needed)
    valid_password db "mypassword", 0 ; Valid password (change as needed)
    wlmsg db "Welcome user!", 10, 13, "$" ; Welcome message
    wlmsg2 db "Please login...", 10, 13, "$" ; Login prompt
    umsg db "Username: ", 10, 13
    pmsg db "Password: ", 10, 13
    success_msg db "Login successful!", 10, 13, "$"
    failure_msg db "Invalid credentials. Please try again.", 10, 13, "$"

.CODE
    mov ax, @data
    mov ds, ax

    ; Display welcome messages
    mov dx, offset wlmsg
    mov ah, 09h
    int 21h

    mov dx, offset wlmsg2
    int 21h

    ; Get user input (username and password)
    mov dx, offset umsg
    mov ah, 09h
    int 21h
    mov dx, offset ulinp
    mov ah, 0Ah
    int 21h

    mov dx, offset pmsg
    mov ah, 09h
    int 21h
    mov dx, offset plinp
    mov ah, 0Ah
    int 21h

    ; Validate credentials
    mov si, offset ulinp
    mov di, offset valid_username
    cld
    repe cmpsb
    jnz invalid_credentials

    mov si, offset plinp
    mov di, offset valid_password
    cld
    repe cmpsb
    jnz invalid_credentials

    ; Display success message
    mov dx, offset success_msg
    mov ah, 09h
    int 21h
    jmp exit_program

invalid_credentials:
    ; Display failure message
    mov dx, offset failure_msg
    mov ah, 09h
    int 21h

exit_program:
    ; Exit program
    mov ah, 4Ch
    int 21h


ret




