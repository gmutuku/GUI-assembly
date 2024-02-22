
; You may customize this and other start-up templates; 
; The location of this template is c:\emu8086\inc\0_com_template.txt

org 100h

.MODEL SMALL
.STACK 100h

.DATA
    ; Define window dimensions
    WindowWidth  DB 50
    WindowHeight DB 20

    ; Define button positions and sizes
    Button1PosX  DB 20
    Button1PosY  DB 10
    Button1Width DB 10
    Button1Height DB 3

    Button2PosX  DB 20
    Button2PosY  DB 14
    Button2Width DB 10
    Button2Height DB 3

    ; Define text field positions and sizes
    TextFieldPosX DB 20
    TextFieldPosY DB 5
    TextFieldWidth DB 20
    TextFieldHeight DB 3

.CODE
MAIN PROC
    MOV AX, @DATA
    MOV DS, AX

    CALL DRAW_WINDOW
    CALL DRAW_BUTTON1
    CALL DRAW_BUTTON2
    CALL DRAW_TEXT_FIELD

    ; Wait for user input or any other processing

    ; Exit program
    MOV AH, 4Ch
    INT 21h

MAIN ENDP

DRAW_WINDOW PROC
    ; Draw top border
    MOV AH, 02h
    MOV DL, '+'
    MOV AL, WindowWidth    ; Move the width into AL
    CBW                    ; Convert AL to AX, extending the value to 16 bits

    CALL PRINT_HORIZONTAL_LINE

    ; Draw sides
    MOV AH, 02h
    MOV DL, '|'
    MOV CX, 1
    MOV AL, WindowHeight    ; Move the height into AL
    MOVZX DX, AL            ; Zero-extend AL into DX

    CALL PRINT_VERTICAL_LINE
    ADD DX, TextFieldHeight + 1
    CALL PRINT_VERTICAL_LINE
    ADD DX, Button1Height + 1
    CALL PRINT_VERTICAL_LINE
    ADD DX, Button2Height + 1
    CALL PRINT_VERTICAL_LINE

    ; Draw bottom border
    MOV AH, 02h
    MOV DL, '+'
    MOV CX, WindowWidth
    CALL PRINT_HORIZONTAL_LINE

    RET
DRAW_WINDOW ENDP

DRAW_BUTTON1 PROC
    ; Draw button 1 border
    MOV AH, 02h
    MOV DL, '['
    MOV CX, 1
    MOV DX, Button1PosY
    CALL PRINT_AT_POSITION
    MOV DL, ']'
    CALL PRINT_AT_POSITION

    ; Draw button 1 label
    MOV AH, 09h
    MOV DX, OFFSET Button1Label
    INT 21h

    RET
DRAW_BUTTON1 ENDP

DRAW_BUTTON2 PROC
    ; Draw button 2 border
    ; Similar to DRAW_BUTTON1, adjust positions and labels

    RET
DRAW_BUTTON2 ENDP

DRAW_TEXT_FIELD PROC
    ; Draw text field border
    ; Similar to DRAW_BUTTON1, adjust positions and labels

    RET
DRAW_TEXT_FIELD ENDP

PRINT_HORIZONTAL_LINE PROC
    ; Print a horizontal line of characters
    ; Input:
    ;   AH = 02h (BIOS function to set cursor position)
    ;   DL = character to print
    ;   CX = number of characters to print
    ; Output:
    ;   None
    PUSH BX
    MOV BX, CX
PRINT_HORIZONTAL_LINE_LOOP:
    INT 10h
    LOOP PRINT_HORIZONTAL_LINE_LOOP
    POP BX
    RET
PRINT_HORIZONTAL_LINE ENDP

PRINT_VERTICAL_LINE PROC
    ; Print a vertical line of characters
    ; Input:
    ;   AH = 02h (BIOS function to set cursor position)
    ;   DL = character to print
    ;   CX = number of characters to print
    ;   DX = number of lines to print
    ; Output:
    ;   None
    PUSH BX
    PUSH DX
    MOV BX, DX
PRINT_VERTICAL_LINE_LOOP:
    MOV DH, DL
    CALL PRINT_HORIZONTAL_LINE
    LOOP PRINT_VERTICAL_LINE_LOOP
    POP DX
    POP BX
    RET
PRINT_VERTICAL_LINE ENDP

PRINT_AT_POSITION PROC
    ; Print a character at a specific position
    ; Input:
    ;   AH = 02h (BIOS function to set cursor position)
    ;   DL = character to print
    ;   CX = X-coordinate
    ;   DX = Y-coordinate
    ; Output:
    ;   None
    MOV AH, 02h
    INT 10h
    RET
PRINT_AT_POSITION ENDP

Button1Label DB "Button 1", "$"
Button2Label DB "Button 2", "$"

END MAIN


ret




