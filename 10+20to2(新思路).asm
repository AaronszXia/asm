       CODES  SEGMENT
      START:
              MOV       BL,10
              ADD       BL,20

              CALL      DISP        ;调用disp子程序
		
              MOV       DL,'B'      ;显示字母“B”
              CALL      PRINT_CHAR  ;调用print_char子程序
		
       EXIT:  MOV       AH,4CH
              INT       21H         ;返回DOS

;-----------------------------

        DISP  PROC                  ;显示bl中的二进制数
              MOV       CX,8        ;循环体循环次数cx=8

       LAST:  RCL       BL,1        ;P100带进位的循环右移指令

              MOV       DL,'0'
              JNC       NEXT        ;P92转移条件X>=Y
              MOV       DL,'1'
       NEXT:  CALL      PRINT_CHAR

              LOOP      LAST
		
              RET                   ;P97段间无参数返回指令，此处用于子程序返回
        DISP  ENDP

;-----------------------------

  PRINT_CHAR  PROC                  ;子程序：调用2号DOS功能显示dl中的一个字符
              MOV       AH,2
              INT       21H
              RET
  PRINT_CHAR  ENDP

;-----------------------------

       CODES  ENDS
              END       START

