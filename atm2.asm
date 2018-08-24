DATAS SEGMENT
str1	db	8 dup (?)
str2	db	'password'
count	equ	$-str2
str3	db	'Input the password(8-digit):',13,10,24h
flag	db	'N'
a		db	0
DATAS ENDS



CODES SEGMENT
    ASSUME CS:CODES,DS:DATAS,ES:DATAS
START:
    MOV AX,DATAS
    MOV DS,AX
    mov		es,ax
    
    lea		dx,str3
    mov		ah,9h
    int		21h
;------------------------读入8为字符，并同时输出“*”号
	mov		ah,07H
    int		21h
    mov		str1,al
    
    call	disp
    
	mov		ah,07H
    int		21h
    mov		str1+1,al
    
    call	disp
    
    mov		ah,07H
    int		21h
    mov		str1+2,al
    
    call	disp
    
    mov		ah,07H
    int		21h
    mov		str1+3,al
        
    call	disp
    
    mov		ah,07H
    int		21h
    mov		str1+4,al
    
    call	disp
    
    mov		ah,07H
    int		21h
    mov		str1+5,al
    
    call	disp
    
    mov		ah,07H
    int		21h
    mov		str1+6,al
    
    call	disp
    
    mov		ah,07H
    int		21h
    mov		str1+7,al
    
    call	disp
;-----------------------------
    
    mov		si,offset str1
    mov		di,offset str2
    mov		cx,count
    cld
    repe	cmpsb
    jnz		exit					;比较str1和str2，若不相同跳到exit
    
    mov		flag,'Y'
    
exit:
	mov	dl,0001101B					;显示回车
	mov	ah,2
	int	21h
    
    mov	dl,0001010B					;显示换行
	mov	ah,2
	int	21h
    
	mov	dl,flag						;显示flags的值
	mov	ah,2
	int	21h
    
    MOV AH,4CH
    INT 21H
    
;--------------------------------显示“*”号

disp	proc
	mov		dl,'*'
    mov		ah,2h
    int		21h
    ret
disp	endp
    
CODES ENDS
    END START
