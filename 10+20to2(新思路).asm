       CODES  SEGMENT
      START:
              MOV       BL,10
              ADD       BL,20

              CALL      DISP        ;����disp�ӳ���
		
              MOV       DL,'B'      ;��ʾ��ĸ��B��
              CALL      PRINT_CHAR  ;����print_char�ӳ���
		
       EXIT:  MOV       AH,4CH
              INT       21H         ;����DOS

;-----------------------------

        DISP  PROC                  ;��ʾbl�еĶ�������
              MOV       CX,8        ;ѭ����ѭ������cx=8

       LAST:  RCL       BL,1        ;P100����λ��ѭ������ָ��

              MOV       DL,'0'
              JNC       NEXT        ;P92ת������X>=Y
              MOV       DL,'1'
       NEXT:  CALL      PRINT_CHAR

              LOOP      LAST
		
              RET                   ;P97�μ��޲�������ָ��˴������ӳ��򷵻�
        DISP  ENDP

;-----------------------------

  PRINT_CHAR  PROC                  ;�ӳ��򣺵���2��DOS������ʾdl�е�һ���ַ�
              MOV       AH,2
              INT       21H
              RET
  PRINT_CHAR  ENDP

;-----------------------------

       CODES  ENDS
              END       START

