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
		call	disp			;����disp����
		
		mov		ah,2			;��ʾ��ĸ��B��
		mov		dl,'B'
		int		21h
		
exit:	mov		ah,4Ch
		int		21h

;-------------------------------

disp	proc					;��ʾbl�еĶ�������

		mov		cx,8			;ѭ����ѭ������cx=8

last:	mov		dl,'0'
		rcl		bl,1			;P100����λ��ѭ������ָ��

		jnc		next			;P92ת������X>=Y
		
		mov		dl,'1'
		
next:	mov		ah,2
		int		21h
		
		loop	last

		
		ret						;P97�μ��޲�������ָ��
		
disp	endp

CODES	ENDS
    	END 	START





