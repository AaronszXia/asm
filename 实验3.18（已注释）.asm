DATA       SEGMENT      
MESG1      DB          0DH,0AH ;�س�������
           DB          'Please input username:$'  
MESG2      DB          0DH,0AH ;�س�������
           DB          'Please input password:$'  
MESG3      DB          0DH,0AH ;�س�������
           DB          'YOU HAVE LOGGED IN!$'  
USERNAME   DB          'B16111902$'  
PASSWORD   DB          'MY1998$'  
FLAG       DB          ?  ;?
BUF        DB          30  ;���ݽ��ջ�����
           DB          ?  
           DB          30 DUP(?)  
DATA       ENDS  
  
CODE       SEGMENT       
           ASSUME      CS:CODE,DS:DATA  
BEG:       MOV         AX,DATA  ;��DATAָ�����ݶμĴ��������ӶμĴ������̶���
           MOV         DS,AX  
           MOV         ES,AX  
AGAIN:     MOV         FLAG,0  ;FLAG?
           MOV         AH,9        ;��ʾMESG1(�û�����ʾ��Ϣ) 
           MOV         DX,OFFSET   MESG1  
           INT         21H  
             
           MOV         AH,0AH       ;�����û���,�����������ݻ�����  
           MOV         DX,OFFSET   BUF  
           INT         21H
           
           MOV         BL,BUF+1  ;ʵ�ʼ�����ַ�����->BX
           MOV         BH,0
           MOV         SI,OFFSET   BUF+2
           MOV         BYTE  PTR   [BX+SI],'$'  ;��'$'��Ϊ��������
  
           MOV         SI,OFFSET   BUF+2      ;��֤�û����Ƿ���ȷ  
           MOV         DI,OFFSET   USERNAME  
           MOV         CX,9  				;;9�ǽ�Ҫ�Ƚϵ��ַ������ȣ��ڵ���cmpsb��ʱ�������һ������Ҫ
           CLD  
           REPE        CMPSB  
           MOV         FLAG,CL  			;;���¿�����Ϊ�˴�clΪ0�Ļ����������ַ�������ͬ��cl��Ϊ0�Ļ��Ͳ���ͬ���û�������ˣ�
         
           MOV         AH,9          ;��ʾ��ʾ��Ϣ�����룩  
           MOV         DX,OFFSET   MESG2  
           INT         21H  
             
           MOV         SI,OFFSET BUF+2 ;������������  
INPUT:     
			MOV        AH,0CH          ;������̻�����  
           	INT        21H  
           
           	MOV        AH,8  
           	INT        21H  
			
			CMP        AL,13  			;;�ж��Ƿ��ǻس�����13��0DH�����ǻس���ASCIIֵ��
           	JZ         NEXT  			;;���ǻس���������ѭ��������next�Σ�
           	
           MOV         [SI],AL  		;;�����ǻس����������ASCIIֵ����si����ŵĵ�ַ��
           INC         SI  				;;siָ����һ�洢��Ԫ���ֽڣ�
           
           MOV         AH,2  			;;���һ��*��
           MOV         DL,2AH  
           INT         21H  
           
           JMP         INPUT  
             
NEXT:      CMP         FLAG,0  
           JNZ         ERROR			;���flag�������㣨�û�������ˣ���������error��
             
           MOV         SI,OFFSET   BUF+2      ;��֤�����Ƿ���ȷ  
           MOV         DI,OFFSET   PASSWORD  
           MOV         CX,9  					
           CLD  
           REPE        CMPSB  
           JNZ         ERROR  					;;�������������Ԥ������벻ͬ�����������ˣ�������error��

           MOV         AH,4CH  
           INT         21H  
             
ERROR:     MOV         AH,9  
           MOV         DX,OFFSET   MESG3  
           INT         21H  
           JMP         AGAIN
CODE        ENDS  
           END         BEG  
		;;;���error��Ϊɶ������ǡ�you have logged in��?
		;;;���ҵ��û�������û�������������ʱ��Ҳû����ʾ��Ϣ




