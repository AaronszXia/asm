DATA       SEGMENT      
MESG1      DB          0DH,0AH ;回车、换行
           DB          'Please input username:$'  
MESG2      DB          0DH,0AH ;回车、换行
           DB          'Please input password:$'  
MESG3      DB          0DH,0AH ;回车、换行
           DB          'YOU HAVE LOGGED IN!$'  
USERNAME   DB          'B16111902$'  
PASSWORD   DB          'MY1998$'  
FLAG       DB          ?  ;?
BUF        DB          30  ;数据接收缓冲区
           DB          ?  
           DB          30 DUP(?)  
DATA       ENDS  
  
CODE       SEGMENT       
           ASSUME      CS:CODE,DS:DATA  
BEG:       MOV         AX,DATA  ;将DATA指向数据段寄存器、附加段寄存器（固定）
           MOV         DS,AX  
           MOV         ES,AX  
AGAIN:     MOV         FLAG,0  ;FLAG?
           MOV         AH,9        ;显示MESG1(用户名提示信息) 
           MOV         DX,OFFSET   MESG1  
           INT         21H  
             
           MOV         AH,0AH       ;输入用户名,存在输入数据缓冲区  
           MOV         DX,OFFSET   BUF  
           INT         21H
           
           MOV         BL,BUF+1  ;实际键入的字符个数->BX
           MOV         BH,0
           MOV         SI,OFFSET   BUF+2
           MOV         BYTE  PTR   [BX+SI],'$'  ;用'$'作为串结束符
  
           MOV         SI,OFFSET   BUF+2      ;验证用户名是否正确  
           MOV         DI,OFFSET   USERNAME  
           MOV         CX,9  				;;9是将要比较的字符串长度，在调用cmpsb的时候必须这一步必须要
           CLD  
           REPE        CMPSB  
           MOV         FLAG,CL  			;;大致可以认为此处cl为0的话，上面两字符串就相同，cl不为0的话就不相同（用户名输错了）
         
           MOV         AH,9          ;显示提示信息（密码）  
           MOV         DX,OFFSET   MESG2  
           INT         21H  
             
           MOV         SI,OFFSET BUF+2 ;处理输入密码  
INPUT:     
			MOV        AH,0CH          ;清除键盘缓冲区  
           	INT        21H  
           
           	MOV        AH,8  
           	INT        21H  
			
			CMP        AL,13  			;;判断是否是回车键（13（0DH）就是回车的ASCII值）
           	JZ         NEXT  			;;若是回车键，跳出循环（跳至next段）
           	
           MOV         [SI],AL  		;;若不是回车，将键入的ASCII值送入si所存放的地址处
           INC         SI  				;;si指向下一存储单元（字节）
           
           MOV         AH,2  			;;输出一个*号
           MOV         DL,2AH  
           INT         21H  
           
           JMP         INPUT  
             
NEXT:      CMP         FLAG,0  
           JNZ         ERROR			;如果flag不等于零（用户名输错了），就跳至error段
             
           MOV         SI,OFFSET   BUF+2      ;验证密码是否正确  
           MOV         DI,OFFSET   PASSWORD  
           MOV         CX,9  					
           CLD  
           REPE        CMPSB  
           JNZ         ERROR  					;;如果输入的密码跟预设的密码不同（密码数错了），跳至error段

           MOV         AH,4CH  
           INT         21H  
             
ERROR:     MOV         AH,9  
           MOV         DX,OFFSET   MESG3  
           INT         21H  
           JMP         AGAIN
CODE        ENDS  
           END         BEG  
		;;;你的error段为啥输出的是‘you have logged in’?
		;;;而且当用户输入的用户名和密码错误的时候也没有提示信息




