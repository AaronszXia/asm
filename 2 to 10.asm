.386
codes segment use16
    assume cs:codes
    
num16	dw		65535			;16λ���������ܱ�ʾ���������2^16-1=65535

begin:
    	mov		ax,num16		;�������ĵ�16λ
    	mov		bx,10			;����

    	mov		cx,0
last:	
		mov		dx,0			;�������ĸ�16λ��Ϊ0
		div		bx				;�̣�16λ���͵�ax��������16λ���͵�dx

		push	dx				;������ջ

		inc		cx				;ͳ�Ƴ�����������Ϊagainѭ�����ѭ������

		cmp		ax,0			;�Ƚ����Ƿ�Ϊ0
		jnz		last			;��Ϊ0������last��

again:	
		pop		dx				;������ջ����һ����ջ�Ķ�Ӧ10���������λ���֣�
		add		dl,30h			;������ת��Ϊ��Ӧ��ASCIIֵ

		mov		ah,2
		int		21h				;��ʾ��ջ��һλ��
		loop	again
		
		mov		ah,4ch
		int		21h
codes 	ends
end		begin


