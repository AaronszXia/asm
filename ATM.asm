DATAS SEGMENT
str1	db	8 dup (?)
str2	db	'password'
str3	db	'Input the password(8 bits):',13h,10h,24h
count	equ	$-str2
flag	db	'N'
DATAS ENDS



CODES SEGMENT
    ASSUME CS:CODES,DS:DATAS,ES:DATAS
START:
    MOV AX,DATAS
    MOV DS,AX
    mov		es,ax
    		
    mov		dx,str3
    mov		ah,9h
    int		21h
    
    mov		cx,count
aga:
	mov		ah,07H
    mov		dx,offset str1
    int		21h
    
    inc		str1
    
    mov		dl,'*'
    mov		ah,2h
    int		21h
    loop	aga
    
    mov		ch,0
    
    cmp		cx,0
    jnz		exit
    
    
    
    mov		si,offset str1
    mov		di,offset str2
    cld
    repe	cmpsb
    jnz		exit
    
    mov		flag,'Y'
    
exit:
	mov	dl,0001101B
	mov	ah,2
	int	21h
    
    mov	dl,0001010B
	mov	ah,2
	int	21h
    
	mov	dl,flag
	mov	ah,2
	int	21h
    
    MOV AH,4CH
    INT 21H
CODES ENDS
    END START


