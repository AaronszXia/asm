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
          
          CALL    I8250                 ;主串口初始化
          
          MOV     CH,10                 ;10行送CH
AGAIN:    MOV     CL,LLL                ;电文长度送CL
          MOV     BX,OFFSET TEXT

TSCAN:    MOV     DX,3FDH
          IN      AL,DX
          TEST    AL,20H               ;发送保持寄存器空 ?
          JZ      TSCAN                 ;否
          
          MOV     AL,[BX]               ;取字符
SEND:     MOV     DX,3F8H
          OUT     DX,AL               ;送主串口数据寄存器

          MOV     SI,0
RSCAN:    MOV     DX,3FDH
          IN      AL,DX
          TEST    AL,01H                ;一帧数据收完否 ?
          JNZ     REVEICE               ;收完转（也就是AL的D0位为1时）
          
          DEC     SI
          JNZ     RSCAN                 ;延时
          
          JMP     DISPERR               ;超时,转出错处理
          
REVEICE:  MOV     DX,3F8H
          IN      AL,DX                 ;读数据寄存器
          AND     AL,7FH	;7FH=01111111B
          
DISP:     MOV     AH,2
          MOV     DL,AL
          INT     21H                   ;屏幕显示
          
          INC     BX
          DEC     CL                    ;计数
          JNZ     TSCAN
          
          DEC     CH                    ;行计数
          JNZ     AGAIN
          
          JMP     RETURN
          
DISPERR:  MOV     AH,9
          MOV     DX,OFFSET ERROR
          INT     21H                   ;显示出错信息
          
RETURN:   MOV     AH,4CH
          INT     21H                   ;返回 DOS
          
;----------------------------------
I8250     PROC                     ;主串口初始化子程序
          MOV     DX,3FBH
          MOV     AL,80H
          OUT     DX,AL                 ;寻址位置1
          
          MOV     DX,3F9H
          MOV     AL,00H
          OUT     DX,AL                 ;写除数高8位
          
          MOV     DX,3F8H
          MOV     AL,60H
          OUT     DX,AL                 ;写除数低8位
          
          MOV     DX,3FBH
          MOV     AL,03H
          OUT     DX,AL         ;无校验传送,8位数据
          
          MOV     DX,3F9H
          MOV     AL,00H
          OUT     DX,AL              ;禁止8250内部中断
          
          MOV     DX,3FCH
          MOV     AL,10h
          ;MOV     AL,0
          OUT     DX,AL         ;8250收发方式,禁止中断
          
          RET
I8250     ENDP
;-------------------------------

CODE      ENDS
          END     BEG


