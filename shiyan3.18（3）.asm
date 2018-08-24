.586
data segment use16

MESG1 	DB	'Enter your username (no more than 10 digits):',13,10,'$'

MESG2	db	13,10,'Enter your password (8 digits):',13,10,'$'

mesg3	db	13,10,'Aaronsz, welcome!$'

mesg4	db	13,10,'Sorry,your username and password do not match$'

str1	db	'Aaronsz'
count1	equ	$-str1

str2	db	'password'
count2	equ	$-str2

buf1	DB	10
		DB	?
		DB	10 DUP(?)				;记录输入的用户名（最大长度10个字符）
		

buf2	DB	8 DUP(?)				;记录输入的密码（8个字符长度）
		
data ends



code segment USE16

	assume	cs:code,ds:data,es:data

beg:
	MOV		AX,DATA
	MOV		DS,AX
	mov		es,ax
	
	MOV		AH,9			;输出字符串，询问用户名
    MOV		DX,OFFSET MESG1
    INT		21H

    MOV		AH,0AH			;接收键入字符串，用户名
    MOV		DX,OFFSET  BUF1
    INT   	21H
       
    MOV	    AH,9			;输出字符串，询问密码
    MOV		DX,OFFSET MESG2
    INT    	21H
;----------------------------读入8位键入字符，并同时输出“*”号
	mov		ah,07H
    int		21h
    mov		buf2,al
    
    call	disp
    
	mov		ah,07H
    int		21h
    mov		buf2+1,al
    
    call	disp
    
    mov		ah,07H
    int		21h
    mov		buf2+2,al
    
    call	disp
    
    mov		ah,07H
    int		21h
    mov		buf2+3,al
        
    call	disp
    
    mov		ah,07H
    int		21h
    mov		buf2+4,al
    
    call	disp
    
    mov		ah,07H
    int		21h
    mov		buf2+5,al
    
    call	disp
    
    mov		ah,07H
    int		21h
    mov		buf2+6,al
    
    call	disp
    
    mov		ah,07H
    int		21h
    mov		buf2+7,al
    
    call	disp
;--------------------------------
    MOV   	BL,BUF1+1			;实际键入的用户名字符个数->BX
    MOV   	BH,0
    
    cmp		bx,count1			;比较输入的用户名字符个数是否相同
 	jnz		no					;如果与预设的用户名字符个数不同，直接跳到no标号段
    
    mov		si,offset str1
    mov		di,offset buf1+2
    mov		cx,count1
    cld
 	repe	cmpsb				;比较用户名
    jnz		no					;如果与预设的用户名不同，直接跳到no标号段
;---------------------------------
    mov		si,offset str2
    mov		di,offset buf2
    mov		cx,count2
    cld
 	repe	cmpsb				;比较密码
    jnz		no					;如果与预设的密码不同，直接跳到no标号段
;----------------------------------
yes:							;如果用户名和密码均正确，跳到此标号段
	mov		dx,offset mesg3
	call	dispstr
	jmp		exit
    
no:
	mov		dx,offset mesg4
	call	dispstr
	jmp		exit

exit:
	MOV  	AH,4CH
    INT		21H      			;返回 DOS
;--------------------------------   
dispstr	proc					;子程序功能：显示dx里的字符串
	mov		ah,9
	int		21h
	ret
dispstr	endp
;--------------------------------
disp	proc					;子程序功能：显示一个“*”号
	mov		dl,'*'
    mov		ah,2h
    int		21h
    ret
disp	endp
;--------------------------------
code	ends
 		end   beg


