DATAS SEGMENT

num db '1','2'

DATAS ENDS

STACKS SEGMENT
    ;�˴������ջ�δ���
STACKS ENDS

CODES SEGMENT
    ASSUME CS:CODES,DS:DATAS,SS:STACKS
START:
    MOV AX,DATAS
    MOV DS,AX
    
    mov bx,offset num
    
    mov al,[bx]
    
    MOV AH,4CH
    INT 21H
CODES ENDS
    END START
