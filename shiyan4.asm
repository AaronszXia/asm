          ;FILENAME:931_1.ASM
DATA      SEGMENT
TEXT      DB    'THE QUICK BROWN FOX JUMPS OVER LAZY DOG'
          DB      0DH,0AH

LLL       EQU     $-TEXT

ERROR     DB      'COM1 BAD !',0DH,0AH,'$'
DATA      ENDS

;--------------------------------------

CODE      SEGMENT
          ASSUME  CS:CODE,DS:DATA
BEG:      MOV     AX,DATA
          MOV     DS,AX
          
          CALL    I8250                 ;�����ڳ�ʼ��
          
          MOV     CH,10                 ;10����CH
AGAIN:    MOV     CL,LLL                ;���ĳ�����CL
          MOV     BX,OFFSET TEXT

TSCAN:    MOV     DX,3FDH
          IN      AL,DX
          TEST    AL,20H               ;���ͱ��ּĴ����� ?
          JZ      TSCAN                 ;��
          
          MOV     AL,[BX]               ;ȡ�ַ�
SEND:     MOV     DX,3F8H
          OUT     DX,AL               ;�����������ݼĴ���

          MOV     SI,0
RSCAN:    MOV     DX,3FDH
          IN      AL,DX
          TEST    AL,01H                ;һ֡��������� ?
          JNZ     REVEICE               ;����ת��Ҳ����AL��D0λΪ1ʱ��
          
          DEC     SI
          JNZ     RSCAN                 ;��ʱ
          
          JMP     DISPERR               ;��ʱ,ת������
          
REVEICE:  MOV     DX,3F8H
          IN      AL,DX                 ;�����ݼĴ���
          AND     AL,7FH	;7FH=01111111B
          
DISP:     MOV     AH,2
          MOV     DL,AL
          INT     21H                   ;��Ļ��ʾ
          
          INC     BX
          DEC     CL                    ;����
          JNZ     TSCAN
          
          DEC     CH                    ;�м���
          JNZ     AGAIN
          
          JMP     RETURN
          
DISPERR:  MOV     AH,9
          MOV     DX,OFFSET ERROR
          INT     21H                   ;��ʾ������Ϣ
          
RETURN:   MOV     AH,4CH
          INT     21H                   ;���� DOS
          
;----------------------------------
I8250     PROC                     ;�����ڳ�ʼ���ӳ���
          MOV     DX,3FBH
          MOV     AL,80H
          OUT     DX,AL                 ;Ѱַλ��1
          
          MOV     DX,3F9H
          MOV     AL,00H
          OUT     DX,AL                 ;д������8λ
          
          MOV     DX,3F8H
          MOV     AL,60H
          OUT     DX,AL                 ;д������8λ
          
          MOV     DX,3FBH
          MOV     AL,03H
          OUT     DX,AL         ;��У�鴫��,8λ����
          
          MOV     DX,3F9H
          MOV     AL,00H
          OUT     DX,AL              ;��ֹ8250�ڲ��ж�
          
          MOV     DX,3FCH
          MOV     AL,10h
          ;MOV     AL,0
          OUT     DX,AL         ;8250�շ���ʽ,��ֹ�ж�
          
          RET
I8250     ENDP
;-------------------------------

CODE      ENDS
          END     BEG


