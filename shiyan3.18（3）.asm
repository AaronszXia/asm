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
		DB	10 DUP(?)				;��¼������û�������󳤶�10���ַ���
		

buf2	DB	8 DUP(?)				;��¼��������루8���ַ����ȣ�
		
data ends



code segment USE16

	assume	cs:code,ds:data,es:data

beg:
	MOV		AX,DATA
	MOV		DS,AX
	mov		es,ax
	
	MOV		AH,9			;����ַ�����ѯ���û���
    MOV		DX,OFFSET MESG1
    INT		21H

    MOV		AH,0AH			;���ռ����ַ������û���
    MOV		DX,OFFSET  BUF1
    INT   	21H
       
    MOV	    AH,9			;����ַ�����ѯ������
    MOV		DX,OFFSET MESG2
    INT    	21H
;----------------------------����8λ�����ַ�����ͬʱ�����*����
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
    MOV   	BL,BUF1+1			;ʵ�ʼ�����û����ַ�����->BX
    MOV   	BH,0
    
    cmp		bx,count1			;�Ƚ�������û����ַ������Ƿ���ͬ
 	jnz		no					;�����Ԥ����û����ַ�������ͬ��ֱ������no��Ŷ�
    
    mov		si,offset str1
    mov		di,offset buf1+2
    mov		cx,count1
    cld
 	repe	cmpsb				;�Ƚ��û���
    jnz		no					;�����Ԥ����û�����ͬ��ֱ������no��Ŷ�
;---------------------------------
    mov		si,offset str2
    mov		di,offset buf2
    mov		cx,count2
    cld
 	repe	cmpsb				;�Ƚ�����
    jnz		no					;�����Ԥ������벻ͬ��ֱ������no��Ŷ�
;----------------------------------
yes:							;����û������������ȷ�������˱�Ŷ�
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
;--------------------------------   
dispstr	proc					;�ӳ����ܣ���ʾdx����ַ���
	mov		ah,9
	int		21h
	ret
dispstr	endp
;--------------------------------
disp	proc					;�ӳ����ܣ���ʾһ����*����
	mov		dl,'*'
    mov		ah,2h
    int		21h
    ret
disp	endp
;--------------------------------
code	ends
 		end   beg


