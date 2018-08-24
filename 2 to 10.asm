.386
codes segment use16
    assume cs:codes
    
num16	dw		65535			;16位二进制数能表示的最大数是2^16-1=65535

begin:
    	mov		ax,num16		;被除数的低16位
    	mov		bx,10			;除数

    	mov		cx,0
last:	
		mov		dx,0			;被除数的高16位恒为0
		div		bx				;商（16位）送到ax，余数（16位）送到dx

		push	dx				;余数入栈

		inc		cx				;统计除法次数，作为again循环体的循环次数

		cmp		ax,0			;比较商是否为0
		jnz		last			;不为0则跳到last段

again:	
		pop		dx				;余数出栈（第一个出栈的对应10进制数最高位数字）
		add		dl,30h			;将数字转换为对应的ASCII值

		mov		ah,2
		int		21h				;显示出栈的一位数
		loop	again
		
		mov		ah,4ch
		int		21h
codes 	ends
end		begin


