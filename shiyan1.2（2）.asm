.486
DATA SEGMENT USE16
SUM     DB      ?
MESG    DB      '25+9=$'
S       DB      0,0,'$'
N1      DB      9
N2      DB      25
DATA ENDS
CODE SEGMENT USE16
    ASSUME CS:CODE,DS:DATA
BEG:
    MOV AX,DATA
    MOV DS,AX

        MOV     BX,OFFSET SUM
        MOV     AH,N1
        MOV     AL,N2
        ADD     AH,AL
        MOV     [BX],AH

        CALL    CHANG
        MOV     AH,9
        MOV     DX,OFFSET MESG
        INT     21H

        MOV     AH,9
        MOV     DX,OFFSET S
        INT     21H
        MOV     AH,4CH
        INT     21H
CHANG   PROC
LAST:
        CMP     BYTE PTR [BX],10
        JC      NEXT
        SUB     BYTE PTR [BX],10
        INC     S
        JMP     LAST
NEXT:
        MOV     BX,OFFSET S
        MOV     AL,SUM
        ADD     BYTE PTR [BX+1],AL
        ADD     BYTE PTR [BX],30H
        ADD     BYTE PTR [BX+1],30H
        RET
CHANG ENDP
CODE ENDS
    END BEG
