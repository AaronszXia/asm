DATAS SEGMENT

BUF		db		'3','0'
;BUF		db		'3','4','8','9'
COUNT	equ		2
;COUNT	equ		$-BUF
	
DATAS ENDS







CODES SEGMENT
    	ASSUME	CS:CODES,DS:DATAS
START:
    	MOV 	AX,DATAS
    	MOV 	DS,AX
		
	    mov		cx,COUNT								
		mov		si,offset BUF
		mov		ax,0
		mov		dh,0
		mov		bx,10
	
aga:	mul		bx
		mov		dl,[si]
		sub		dl,30h
		add		ax,dx
		inc		si
		loop	aga
		
		mov		bx,ax

		call	disp
		
		mov		ah,2
		mov		dl,'B'
		int		21h
		
exit:	mov		ah,4Ch
		int		21h

;-------------------------------

disp	proc

		mov		cx,16

last:	mov		dl,'0'
		rcl		bx,1			;P100带进位的循环右移指令
		
		jnc		next			;P92转移条件X>=Y
		
		mov		dx,'1'
		
next:	mov		ah,2
		int		21h
		
		loop	last
		
		ret						;P97段间无参数返回指令
		
disp	endp

CODES	ENDS
    	END 	START







