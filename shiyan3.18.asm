.586
DATA SEGMENT USE16   

MESG1 	DB	'Enter your name (no more than 10 digits):',13,10,'$'

MESG2	db	13,10
	 	DB	'Enter your password (8 digits):',13,10,'$'

mesg3	db	13,10,'Aaronsz, welcome!$'

mesg4	db	13,10,'Sorry, your user name or password is wrong$'

str1	db	'Aaronsz'
count1	equ	$-str1

str2	db	'password'
count2	equ	$-str2

BUF1	DB	10
		DB	?
		DB	10 DUP(?)
		

BUF2	DB	10
		DB	?
		DB	10 DUP(?)
		
flag	db	0
		
DATA ENDS



CODE SEGMENT USE16

	ASSUME	CS:CODE,DS:DATA,es:data

BEG:
	MOV		AX,DATA
	MOV		DS,AX
	mov		es,ax
	
	MOV		AH,9
    MOV		DX,OFFSET MESG1
    INT		21H				;ѯ������

    MOV		AH,0AH
    MOV		DX,OFFSET  BUF1
    INT   	21H				;���ռ����ַ���������
       
    MOV	    AH,9
    MOV		DX,OFFSET MESG2
    INT    	21H				;ѯ������
       
    MOV   	AH,0AH
    MOV   	DX,OFFSET BUF2
    INT   	21H				;���ռ����ַ���������
    
    ;-----------------------------
    
    MOV   	BL,BUF1+1			;ʵ�ʼ���������ַ�����->BX
    MOV   	BH,0
    
    cmp		bx,count1			;�Ƚ�����������ַ������Ƿ���ͬ
 	jnz		no
    
    mov		si,offset str1
    mov		di,offset buf1+2
    
    mov		cx,count1
    call	compare						;�Ƚ�����
    
    cmp		flag,1
    jnz		no
    
    ;-------------------------
    
    mov		flag,0
    
    MOV   	BL,BUF2+1			;ʵ�ʼ���������ַ�����->BX
    MOV   	BH,0
    
    cmp		bx,count2			;�Ƚ�����������ַ������Ƿ�Ϊ8
 	jnz		no
    
    mov		si,offset str2
    mov		di,offset buf2+2
    
    mov		cx,count2
    call	compare				;�Ƚ�����
    
    cmp		flag,1
    jnz		no
    
    ;----------------------------------
    
yes:
	mov		dx,offset mesg3
	call	dispstr
	jmp		exit
    
    
no:
	mov		dx,offset mesg4
	call	dispstr
	jmp		exit

exit:     
	MOV  	AH,4CH
    INT		21H      			;���� DOS
       
compare	proc
 	
 	cld
 	repe	cmpsb
 	jnz		next
 	
 	mov		flag,1
 	
next:
 	ret
compare endp
       
dispstr	proc					;�ӳ�����ʾdx����ַ���
	mov		ah,9
	int		21h
	ret
dispstr	endp
       
CODE	ENDS 
 		END   BEG

