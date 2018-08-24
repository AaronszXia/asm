DATAS SEGMENT

DATAS ENDS



CODES SEGMENT
    	ASSUME	CS:CODES,DS:DATAS
START:
    	MOV 	AX,DATAS
    	MOV 	DS,AX

		mov		al,10
		add		al,20							

		mov		bl,al			;al->bl
		call	disp			;调用disp函数
		
		mov		ah,2			;显示字母“B”
		mov		dl,'B'
		int		21h
		
exit:	mov		ah,4Ch
		int		21h

;-------------------------------

disp	proc					;显示bl中的二进制数

		mov		cx,8			;循环体循环次数cx=8

last:	mov		dl,'0'
		rcl		bl,1			;P100带进位的循环右移指令

		jnc		next			;P92转移条件X>=Y
		
		mov		dl,'1'
		
next:	mov		ah,2
		int		21h
		
		loop	last

		
		ret						;P97段间无参数返回指令
		
disp	endp

CODES	ENDS
    	END 	START





