.486
DATA SEGMENT use16

sum		db	?

mesg	db	'25+9=$'

s		db	0,0,'$'

n1		db	9

n2		db	25
		
DATA ENDS

CODE SEGMENT use16
    ASSUME CS:CODE,DS:DATA
beg:
    MOV AX,DATA
    MOV DS,AX

	mov	bx,offset sum
	mov	ah,n1
	mov	al,n2
	add	ah,al
	mov	[bx],ah
	
	call	chang
	
	mov	ah,9
	mov	dx,offset mesg
	int 21h
	
	mov	ah,9
	mov	dx,offset s
	int 21h

    MOV AH,4CH
    INT 21H
    
chang	proc
last:
	cmp	byte ptr [bx],10
	jc	next
	sub	byte ptr [bx],10
	inc	s
	jmp	last
	
next:
	mov	bx,offset s
	mov al,sum
	add	byte ptr [bx+1],al
	add byte ptr [bx],30h
	add byte ptr [bx+1],30h
	ret
chang endp
	    
CODE ENDS
    END beg


