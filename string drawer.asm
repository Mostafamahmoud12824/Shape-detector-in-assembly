                     CODE	SEGMENT
	ASSUME	CS:CODE,DS:CODE,ES:CODE,SS:CODE	

command	equ	00  
key	equ	01h
stat	equ 02
data	equ	04 
PPIC_C EQU 1EH
PPIC  EQU 1CH
PPIB  EQU 1AH
PPIA  EQU 18H
STRING DB 16 DUP(?)

		org 1000h
            call init   
            MOV SI ,0
mov cx ,16
getdata:	
		  
		
		call scan 
		MOV STRING[SI],BL
		
	    mov al ,STRING[SI]
	    INC SI
        out data , al                                            ;;;;    1( A ,B ,C )  2( D ,E ,F)  3( G ,H ,I)
        call busy                                                ;;;;    4( J ,K ,L )  5( M ,N ,O)  6( P ,Q ,R)
loop getdata                                                     ;;;;    7( S ,T ,U )  8( V ,W ,X)  9( Y ,Z )



;----------------------------------------------------- 
;dot matrix display PROC
;Show all the characters that were taken from the user on dot matrix.
;Receives: nulls
;Returns: on PPIB the value from AL  
;-----------------------------------------------------                                                                    
MOD0: 

  
MOV SI,0    
MOV BX,-1
    
    loopprint: 
       CALL TIMER
       CALL TIMER
        
        CALL busy 
        CALL TIMER
       CALL TIMER
       CALL TIMER
       CALL TIMER
       
    MOV DL ,0
    inc BX 
    MOV SI,BX
     
cmp string[si],'A'
JE  PRINTA
 cmp string[si],'B'
JE  PRINTB   
cmp string[si],'C'
JE  PRINTC
 cmp string[si],'D'
JE  PRINTD   
cmp string[si],'E'
 JE  PRINTE
jmp next
          
 PRINTA:
    CALL PRINTCA
    JMP loopprint
  
   PRINTB:
     CALL PRINTCB
    JMP loopprint 
    
    
    
  PRINTC:
  CALL PRINTCC
    JMP loopprint
    
    
    
    PRINTD:
    CALL PRINTCD
    JMP loopprint
    
    
    
    
    PRINTE:
    CALL PRINTCE 
    JMP loopprint 
       
  next:
 cmp string[si],'F'
JE  PRINTF   
cmp string[si],'G'
JE  PRINTG
 cmp string[si],'H'
JE  PRINTH 
cmp string[si],'I'
JE  PRINTI
 cmp string[si],'J'
JE  PRINTJ 
jmp next1
          
         
         
    PRINTF:
    CALL PRINTCF   
    JMP loopprint
  
  PRINTG:
    CALL PRINTCG
    JMP loopprint
  
   PRINTH:
     CALL PRINTCH
    JMP loopprint 
    
    
    
  PRINTI:
  CALL PRINTCI
    JMP loopprint
    
    
    
    PRINTJ:
    CALL PRINTCJ
    JMP loopprint
       
  next1:  
cmp string[si],'K'
JE  PRINTK
 cmp string[si],'L'
JE  PRINTL   
cmp string[si],'M'
JE  PRINTM
 cmp string[si],'N'
JE  PRINTN   
cmp string[si],'O'
JE  PRINTO 
jmp next2
          
      
    PRINTK:
    CALL PRINTCK 
    JMP loopprint 
         
         
         
    PRINTL:
    CALL PRINTCL   
    JMP loopprint
          
          
          
    PRINTM:
    CALL PRINTCM
    JMP loopprint
        
        
        
   PRINTN:
     CALL PRINTCN
    JMP loopprint 
    
    
    
  PRINTO:
  CALL PRINTCO
    JMP loopprint
    
       
  next2:
 cmp string[si],'P'
JE  PRINTP 
cmp string[si],'Q'
JE  PRINTQ
 cmp string[si],'R'
JE  PRINTR   
cmp string[si],'S'
JE  PRINTS
 cmp string[si],'T'
JE  PRINTT
jmp next3
          
       
    PRINTP:
    CALL PRINTCP
    JMP loopprint
    
    
    
    
    PRINTQ:
    CALL PRINTCQ 
    JMP loopprint 
         
         
                                                                                                           
    PRINTR:
    CALL PRINTCR   
    JMP loopprint
    
    PRINTS:
    CALL PRINTCS
    JMP loopprint
  
   PRINTT:
     CALL PRINTCT
    JMP loopprint 
       
  next3:   
cmp string[si],'U'
JE  PRINTU
 cmp string[si],'V'
JE  PRINTV   
cmp string[si],'W'
JE  PRINTW
 cmp string[si],'X'
JE  PRINTX 
cmp string[si],'Y'
JE  PRINTY
 cmp string[si],'Z'
JE  PRINTZ 

 

 CALL PRINTCLEAR
     
      HLT        
    
    
  PRINTU:
  CALL PRINTCU
    JMP loopprint                                                                       
    
    
    
    PRINTV:
    CALL PRINTCV
    JMP loopprint
    
    
    
    
    PRINTW:
    CALL PRINTCW 
    JMP loopprint 
         
         
         
    PRINTX:
    CALL PRINTCX   
    JMP loopprint
    
    
       PRINTY:
    CALL PRINTCY 
    JMP loopprint 
         
         
         
    PRINTZ:
    CALL PRINTCZ   
    JMP loopprint
    
    PRINTCLEAR:
    CALL PRINTCCLEAR  
    
    



;;;;;;;;;;;; dot matrixe 

         
        hlt


;---------------Display initialization procedure--------
init:	        call busy
		mov al,30h
		out command,al
		call busy
		mov al,0fh
		out command,al
		call busy
		mov al,06h
		out command,al
		call busy
		mov al,02
		out command,al
		call busy
		mov al,01
		out command,al
		call busy
		ret
		
    TIMER: 
MOV CX,300
TIMER1:
NOP
NOP
NOP
NOP
LOOP TIMER1
RET

;-----------------display ready procedure------------		
busy:	IN AL,Stat
		test AL,10000000b
		jnz busy
		ret 

;---------------------------PRINT CHRACTERS--------------- 

  PRINTCA:
  
 call noop
MOV  AL, 10000000B 
OUT PPIC_C , AL 

MOV AL,11111111B  
OUT PPIA, AL
 
LA1: MOV SI,OFFSET A                        

MOV AH,11111110B

LA2:MOV AL, BYTE PTR CS:[SI]
OUT PPIC,AL

MOV AL,AH
OUT PPIB,AL
CALL TIMER 

INC SI
CLC
ROL AH,1
JC LA2
INC DL 
  CMP DL ,16
  je shift1A 
  jmp LA1
 
 
 shift1A:
 LA1s: MOV SI,OFFSET A                        
MOV AH,11111110B
LA2s:MOV AL, BYTE PTR CS:[SI]   
shr al ,1
OUT PPIC,AL 
MOV AL,AH
OUT PPIB,AL
CALL TIMER 

INC SI
CLC
ROL AH,1
JC LA2s
INC DL 
  shr al ,1
  CMP DL ,32
   je shift2A  
   jmp shift1A
       
   
   shift2A:
 LA1s2: MOV SI,OFFSET A                        
MOV AH,11111110B
LA2s2:MOV AL, BYTE PTR CS:[SI]   
shr al ,1  
shr al ,1
OUT PPIC,AL 
MOV AL,AH
OUT PPIB,AL
CALL TIMER 

INC SI
CLC
ROL AH,1
JC LA2s2
INC DL 
  shr al ,1  
  shr al ,1
  CMP DL ,48
   jne shift2A
   ret
 
 
A:                         
DB 10000100B
DB 10000100B
DB 10000100B
DB 11111100B
DB 10000100B 
DB 10000100B
DB 01001000B
DB 00110000B 
  


;------------------------------------------------
PRINTCB: 
MOV  AL, 10000000B 
OUT PPIC_C , AL 

MOV AL,11111111B  
OUT PPIA, AL
  
LB1: MOV SI,OFFSET B                        

MOV AH,11111110B

LB2:MOV AL, BYTE PTR CS:[SI]
OUT PPIC,AL

MOV AL,AH
OUT PPIB,AL
CALL TIMER
INC SI
CLC
ROL AH,1
JC LB2 
INC DL
  CMP DL,16
  je  shift1B
  jmp  LB1
 
 shift1B:
 LB1s: MOV SI,OFFSET B                        
MOV AH,11111110B
LB2s:MOV AL, BYTE PTR CS:[SI]   
shr al ,1
OUT PPIC,AL 
MOV AL,AH
OUT PPIB,AL
CALL TIMER 

INC SI
CLC
ROL AH,1
JC LB2s
INC DL 
  shr al ,1
  CMP DL ,32
   je shift2B  
   jmp shift1B
       
   
   shift2B:
 LB1s2: MOV SI,OFFSET B                        
MOV AH,11111110B
LB2s2:MOV AL, BYTE PTR CS:[SI]   
shr al ,1  
shr al ,1
OUT PPIC,AL 
MOV AL,AH
OUT PPIB,AL
CALL TIMER 

INC SI
CLC
ROL AH,1
JC LB2s2
INC DL 
  shr al ,1  
  shr al ,1
  CMP DL ,48
   jne shift2B
   ret
       
         
B:  
DB 01111100B
DB 10000100B
DB 10000100B
DB 01111100B
DB 10000100B 
DB 10000100B
DB 01111100B
DB 00000000B 

;---------------------------------------------------
 PRINTCC:
 MOV  AL, 10000000B 
OUT PPIC_C , AL 

MOV AL,11111111B  
OUT PPIA, AL
  
LC1: MOV SI,OFFSET C                        

MOV AH,11111110B

LC2:MOV AL, BYTE PTR CS:[SI]
OUT PPIC,AL

MOV AL,AH
OUT PPIB,AL
CALL TIMER
INC SI
CLC
ROL AH,1
JC LC2 
INC DL
  CMP DL,16
  je  shift1C
  jmp  LC1
 
 shift1C:
 LC1s: MOV SI,OFFSET C                        
MOV AH,11111110B
LC2s:MOV AL, BYTE PTR CS:[SI]   
shr al ,1
OUT PPIC,AL 
MOV AL,AH
OUT PPIB,AL
CALL TIMER 

INC SI
CLC
ROL AH,1
JC LC2s
INC DL 
  shr al ,1
  CMP DL ,32
   je shift2C  
   jmp shift1C
       
   
   shift2C:
 LC1s2: MOV SI,OFFSET C                        
MOV AH,11111110B
LC2s2:MOV AL, BYTE PTR CS:[SI]   
shr al ,1  
shr al ,1
OUT PPIC,AL 
MOV AL,AH
OUT PPIB,AL
CALL TIMER 

INC SI
CLC
ROL AH,1
JC LC2s2
INC DL 
  shr al ,1  
  shr al ,1
  CMP DL ,48
   jne shift2C
   ret
   
C:
DB 01111000B
DB 10000100B
DB 00000100B
DB 00000100B
DB 00000100B 
DB 10000100B
DB 01111000B
DB 00000000B



;------------------------------------------------
PRINTCD: 
 MOV  AL, 10000000B 
OUT PPIC_C , AL 

MOV AL,11111111B  
OUT PPIA, AL
  
LD1: MOV SI,OFFSET D                        

MOV AH,11111110B

LD2:MOV AL, BYTE PTR CS:[SI]
OUT PPIC,AL

MOV AL,AH
OUT PPIB,AL
CALL TIMER
INC SI
CLC
ROL AH,1
JC LD2 
INC DL
  CMP DL,16
  je  shift1D
  jmp  LD1
 
 shift1D:
 LD1s: MOV SI,OFFSET D                        
MOV AH,11111110B
LD2s:MOV AL, BYTE PTR CS:[SI]   
shr al ,1
OUT PPIC,AL 
MOV AL,AH
OUT PPIB,AL
CALL TIMER 

INC SI
CLC
ROL AH,1
JC LD2s
INC DL 
  shr al ,1
  CMP DL ,32
   je shift2D  
   jmp shift1D
       
   
   shift2D:
 LD1s2: MOV SI,OFFSET D                        
MOV AH,11111110B
LD2s2:MOV AL, BYTE PTR CS:[SI]   
shr al ,1  
shr al ,1
OUT PPIC,AL 
MOV AL,AH
OUT PPIB,AL
CALL TIMER 

INC SI
CLC
ROL AH,1
JC LD2s2
INC DL 
  shr al ,1  
  shr al ,1
  CMP DL ,48
   jne shift2D
   ret
      
         
D:
DB 01111100B
DB 10000100B
DB 10000100B
DB 10000100B
DB 10000100B 
DB 10000100B
DB 10000100B
DB 01111100B 

;---------------------------------------------------  
  PRINTCE:
  
 MOV  AL, 10000000B 
OUT PPIC_C , AL 

MOV AL,11111111B  
OUT PPIA, AL
  
LE1: MOV SI,OFFSET E                        

MOV AH,11111110B

LE2:MOV AL, BYTE PTR CS:[SI]
OUT PPIC,AL

MOV AL,AH
OUT PPIB,AL
CALL TIMER
INC SI
CLC
ROL AH,1
JC LE2 
INC DL
  CMP DL,16
  je  shift1E
  jmp  LE1
 
 shift1E:
 LE1s: MOV SI,OFFSET E                        
MOV AH,11111110B
LE2s:MOV AL, BYTE PTR CS:[SI]   
shr al ,1
OUT PPIC,AL 
MOV AL,AH
OUT PPIB,AL
CALL TIMER 

INC SI
CLC
ROL AH,1
JC LE2s
INC DL 
  shr al ,1
  CMP DL ,32
   je shift2E  
   jmp shift1E
       
   
   shift2E:
 LE1s2: MOV SI,OFFSET E                        
MOV AH,11111110B
LE2s2:MOV AL, BYTE PTR CS:[SI]   
shr al ,1  
shr al ,1
OUT PPIC,AL 
MOV AL,AH
OUT PPIB,AL
CALL TIMER 

INC SI
CLC
ROL AH,1
JC LE2s2
INC DL 
  shr al ,1  
  shr al ,1
  CMP DL ,48
   jne shift2E
   ret
     
E:
DB 11111100B
DB 00000100B
DB 00000100B
DB 11111100B
DB 00000100B 
DB 00000100B
DB 11111100B
DB 00000000B 
  


;------------------------------------------------
PRINTCF: 
MOV  AL, 10000000B 
OUT PPIC_C , AL 

MOV AL,11111111B  
OUT PPIA, AL
  
LF1: MOV SI,OFFSET F                        

MOV AH,11111110B

LF2:MOV AL, BYTE PTR CS:[SI]
OUT PPIC,AL

MOV AL,AH
OUT PPIB,AL
CALL TIMER
INC SI
CLC
ROL AH,1
JC LF2 
INC DL
  CMP DL,16
  je  shift1F
  jmp  LF1
 
 shift1F:
 LF1s: MOV SI,OFFSET F                        
MOV AH,11111110B
LF2s:MOV AL, BYTE PTR CS:[SI]   
shr al ,1
OUT PPIC,AL 
MOV AL,AH
OUT PPIB,AL
CALL TIMER 

INC SI
CLC
ROL AH,1
JC LF2s
INC DL 
  shr al ,1
  CMP DL ,32
   je shift2F  
   jmp shift1F
       
   
   shift2F:
 LF1s2: MOV SI,OFFSET F                        
MOV AH,11111110B
LF2s2:MOV AL, BYTE PTR CS:[SI]   
shr al ,1  
shr al ,1
OUT PPIC,AL 
MOV AL,AH
OUT PPIB,AL
CALL TIMER 

INC SI
CLC
ROL AH,1
JC LF2s2
INC DL 
  shr al ,1  
  shr al ,1
  CMP DL ,48
   jne shift2F
   ret
     
         
F:
DB 00000100B
DB 00000100B
DB 00000100B
DB 00000100B
DB 11111100B 
DB 00000100B
DB 00000100B
DB 11111100B 


;---------------------------------------------------
 PRINTCG:
 MOV  AL, 10000000B 
OUT PPIC_C , AL 

MOV AL,11111111B  
OUT PPIA, AL
  
LG1: MOV SI,OFFSET G                        

MOV AH,11111110B

LG2:MOV AL, BYTE PTR CS:[SI]
OUT PPIC,AL

MOV AL,AH
OUT PPIB,AL
CALL TIMER
INC SI
CLC
ROL AH,1
JC LG2 
INC DL
  CMP DL,16
  je  shift1G
  jmp  LG1
 
 shift1G:
 LG1s: MOV SI,OFFSET G                         
MOV AH,11111110B
LG2s:MOV AL, BYTE PTR CS:[SI]   
shr al ,1
OUT PPIC,AL 
MOV AL,AH
OUT PPIB,AL
CALL TIMER 

INC SI
CLC
ROL AH,1
JC LG2s
INC DL 
  shr al ,1
  CMP DL ,32
   je shift2G  
   jmp shift1G
       
   
   shift2G:
 LG1s2: MOV SI,OFFSET G                        
MOV AH,11111110B
LG2s2:MOV AL, BYTE PTR CS:[SI]   
shr al ,1  
shr al ,1
OUT PPIC,AL 
MOV AL,AH
OUT PPIB,AL
CALL TIMER 

INC SI
CLC
ROL AH,1
JC LG2s2
INC DL 
  shr al ,1  
  shr al ,1
  CMP DL ,48
   jne shift2G
   ret
     
G:
DB 01111000B
DB 10000100B
DB 10000100B
DB 11100100B
DB 00000100B 
DB 10000100B
DB 01111000B
DB 00000000B 
  


;------------------------------------------------
PRINTCH: 
MOV  AL, 10000000B 
OUT PPIC_C , AL 

MOV AL,11111111B  
OUT PPIA, AL
  
LH1: MOV SI,OFFSET H                        

MOV AH,11111110B

LH2:MOV AL, BYTE PTR CS:[SI]
OUT PPIC,AL

MOV AL,AH
OUT PPIB,AL
CALL TIMER
INC SI
CLC
ROL AH,1
JC LH2 
INC DL
  CMP DL,16
  je  shift1H
  jmp  LH1
 
 shift1H:
 LH1s: MOV SI,OFFSET H                        
MOV AH,11111110B
LH2s:MOV AL, BYTE PTR CS:[SI]   
shr al ,1
OUT PPIC,AL 
MOV AL,AH
OUT PPIB,AL
CALL TIMER 

INC SI
CLC
ROL AH,1
JC LH2s
INC DL 
  shr al ,1
  CMP DL ,32
   je shift2H  
   jmp shift1H
       
   
   shift2H:
 LH1s2: MOV SI,OFFSET H                        
MOV AH,11111110B
LH2s2:MOV AL, BYTE PTR CS:[SI]   
shr al ,1  
shr al ,1
OUT PPIC,AL 
MOV AL,AH
OUT PPIB,AL
CALL TIMER 

INC SI
CLC
ROL AH,1
JC LH2s2
INC DL 
  shr al ,1  
  shr al ,1
  CMP DL ,48
   jne shift2H
   ret
         
         
H:
DB 10000100B
DB 10000100B
DB 10000100B
DB 11111100B
DB 10000100B 
DB 10000100B
DB 10000100B
DB 10000100B

;---------------------------------------------------  
PRINTCI:
  
MOV  AL, 10000000B 
OUT PPIC_C , AL 

MOV AL,11111111B  
OUT PPIA, AL
  
LI1: MOV SI,OFFSET I                        

MOV AH,11111110B

LI2:MOV AL, BYTE PTR CS:[SI]
OUT PPIC,AL

MOV AL,AH
OUT PPIB,AL
CALL TIMER
INC SI
CLC
ROL AH,1
JC LI2 
INC DL
  CMP DL,16
  je  shift1I
  jmp  LI1
 
 shift1I:
 LI1s: MOV SI,OFFSET I                        
MOV AH,11111110B
LI2s:MOV AL, BYTE PTR CS:[SI]   
shr al ,1
OUT PPIC,AL 
MOV AL,AH
OUT PPIB,AL
CALL TIMER 

INC SI
CLC
ROL AH,1
JC LI2s
INC DL 
  shr al ,1
  CMP DL ,32
   je shift2I  
   jmp shift1I
       
   
   shift2I:
 LI1s2: MOV SI,OFFSET I                        
MOV AH,11111110B
LI2s2:MOV AL, BYTE PTR CS:[SI]   
shr al ,1  
shr al ,1
OUT PPIC,AL 
MOV AL,AH
OUT PPIB,AL
CALL TIMER 

INC SI
CLC
ROL AH,1
JC LI2s2
INC DL 
  shr al ,1  
  shr al ,1
  CMP DL ,48
   jne shift2I
   ret
     
  
I:
DB 01111100B
DB 00010000B
DB 00010000B
DB 00010000B
DB 00010000B 
DB 00010000B
DB 00010000B
DB 01111100B

  


;------------------------------------------------
PRINTCJ: 
MOV  AL, 10000000B 
OUT PPIC_C , AL 

MOV AL,11111111B  
OUT PPIA, AL
  
LJ1: MOV SI,OFFSET J                        

MOV AH,11111110B

LJ2:MOV AL, BYTE PTR CS:[SI]
OUT PPIC,AL

MOV AL,AH
OUT PPIB,AL
CALL TIMER
INC SI
CLC
ROL AH,1
JC LJ2 
INC DL
  CMP DL,16
  je  shift1J
  jmp  LJ1
 
 shift1J:
 LJ1s: MOV SI,OFFSET J                        
MOV AH,11111110B
LJ2s:MOV AL, BYTE PTR CS:[SI]   
shr al ,1
OUT PPIC,AL 
MOV AL,AH
OUT PPIB,AL
CALL TIMER 

INC SI
CLC
ROL AH,1
JC LJ2s
INC DL 
  shr al ,1
  CMP DL ,32
   je shift2J  
   jmp shift1J
       
   
   shift2J:
 LJ1s2: MOV SI,OFFSET J                        
MOV AH,11111110B
LJ2s2:MOV AL, BYTE PTR CS:[SI]   
shr al ,1  
shr al ,1
OUT PPIC,AL 
MOV AL,AH
OUT PPIB,AL
CALL TIMER 

INC SI
CLC
ROL AH,1
JC LJ2s2
INC DL 
  shr al ,1  
  shr al ,1
  CMP DL ,48
   jne shift2J
   ret
     

J:
DB 00011000B
DB 00100100B
DB 00100100B
DB 00100000B
DB 00100000B 
DB 00100000B
DB 00100000B
DB 11111000B  
 

;---------------------------------------------------
 PRINTCK:
  
MOV  AL, 10000000B 
OUT PPIC_C , AL 

MOV AL,11111111B  
OUT PPIA, AL
  
LK1: MOV SI,OFFSET K                      

MOV AH,11111110B

LK2:MOV AL, BYTE PTR CS:[SI]
OUT PPIC,AL

MOV AL,AH
OUT PPIB,AL
CALL TIMER
INC SI
CLC
ROL AH,1
JC LK2 
INC DL
  CMP DL,16
  je  shift1K
  jmp  LK1
 
 shift1K:
 LK1s: MOV SI,OFFSET K                        
MOV AH,11111110B
LK2s:MOV AL, BYTE PTR CS:[SI]   
shr al ,1
OUT PPIC,AL 
MOV AL,AH
OUT PPIB,AL
CALL TIMER 

INC SI
CLC
ROL AH,1
JC LK2s
INC DL 
  shr al ,1
  CMP DL ,32
   je shift2K  
   jmp shift1K
       
   
   shift2K:
 LK1s2: MOV SI,OFFSET K                         
MOV AH,11111110B
LK2s2:MOV AL, BYTE PTR CS:[SI]   
shr al ,1  
shr al ,1
OUT PPIC,AL 
MOV AL,AH
OUT PPIB,AL
CALL TIMER 

INC SI
CLC
ROL AH,1
JC LK2s2
INC DL 
  shr al ,1  
  shr al ,1
  CMP DL ,48
   jne shift2K
   ret
     
k:
DB 01000100B
DB 00100100B
DB 00010100B
DB 00001100B
DB 00010100B
DB 00100100B
DB 01000100B
DB 10000100B

  


;------------------------------------------------
PRINTCL: 
MOV  AL, 10000000B 
OUT PPIC_C , AL 

MOV AL,11111111B  
OUT PPIA, AL
  
LL1: MOV SI,OFFSET L                        

MOV AH,11111110B

LL2:MOV AL, BYTE PTR CS:[SI]
OUT PPIC,AL

MOV AL,AH
OUT PPIB,AL
CALL TIMER
INC SI
CLC
ROL AH,1
JC LL2 
INC DL
  CMP DL,16
  je  shift1L
  jmp  LL1
 
 shift1L:
 LL1s: MOV SI,OFFSET L                        
MOV AH,11111110B
LL2s:MOV AL, BYTE PTR CS:[SI]   
shr al ,1
OUT PPIC,AL 
MOV AL,AH
OUT PPIB,AL
CALL TIMER 

INC SI
CLC
ROL AH,1
JC LL2s
INC DL 
  shr al ,1
  CMP DL ,32
   je shift2L  
   jmp shift1L
       
   
   shift2L:
 LL1s2: MOV SI,OFFSET L                        
MOV AH,11111110B
LL2s2:MOV AL, BYTE PTR CS:[SI]   
shr al ,1  
shr al ,1
OUT PPIC,AL 
MOV AL,AH
OUT PPIB,AL
CALL TIMER 

INC SI
CLC
ROL AH,1
JC LL2s2
INC DL 
  shr al ,1  
  shr al ,1
  CMP DL ,48
   jne shift2L
   ret
          
         
L:
DB 11111100B
DB 00000100B
DB 00000100B
DB 00000100B
DB 00000100B 
DB 00000100B
DB 00000100B
DB 00000100B
 

;---------------------------------------------------  
  PRINTCM:
  
 MOV  AL, 10000000B 
OUT PPIC_C , AL 

MOV AL,11111111B  
OUT PPIA, AL
  
LM1: MOV SI,OFFSET M                        

MOV AH,11111110B

LM2:MOV AL, BYTE PTR CS:[SI]
OUT PPIC,AL

MOV AL,AH
OUT PPIB,AL
CALL TIMER
INC SI
CLC
ROL AH,1
JC LM2 
INC DL
  CMP DL,16
  je  shift1M
  jmp  LM1
 
 shift1M:
 LM1s: MOV SI,OFFSET  M                       
MOV AH,11111110B
LM2s:MOV AL, BYTE PTR CS:[SI]   
shr al ,1
OUT PPIC,AL 
MOV AL,AH
OUT PPIB,AL
CALL TIMER 

INC SI
CLC
ROL AH,1
JC LM2s
INC DL 
  shr al ,1
  CMP DL ,32
   je shift2M  
   jmp shift1M
       
   
   shift2M:
 LM1s2: MOV SI,OFFSET M                       
MOV AH,11111110B
LM2s2:MOV AL, BYTE PTR CS:[SI]   
shr al ,1  
shr al ,1
OUT PPIC,AL 
MOV AL,AH
OUT PPIB,AL
CALL TIMER 

INC SI
CLC
ROL AH,1
JC LM2s2
INC DL 
  shr al ,1  
  shr al ,1
  CMP DL ,48
   jne shift2M
   ret
      
M: 
DB 10000100B
DB 10000100B
DB 10000100B
DB 10000100B
DB 10000100B
DB 10110100B
DB 11001100B       
DB 10000100B
        
;------------------------------------------------
PRINTCN: 
MOV  AL, 10000000B 
OUT PPIC_C , AL 

MOV AL,11111111B  
OUT PPIA, AL
  
LN1: MOV SI,OFFSET N                      

MOV AH,11111110B

LN2:MOV AL, BYTE PTR CS:[SI]
OUT PPIC,AL

MOV AL,AH
OUT PPIB,AL
CALL TIMER
INC SI
CLC
ROL AH,1
JC LN2 
INC DL
  CMP DL,16
  je  shift1N
  jmp  LN1
 
 shift1N:
 LN1s: MOV SI,OFFSET N                       
MOV AH,11111110B
LN2s:MOV AL, BYTE PTR CS:[SI]   
shr al ,1
OUT PPIC,AL 
MOV AL,AH
OUT PPIB,AL
CALL TIMER 

INC SI
CLC
ROL AH,1
JC LN2s
INC DL 
  shr al ,1
  CMP DL ,32
   je shift2N 
   jmp shift1N
       
   
   shift2N:
 LN1s2: MOV SI,OFFSET N                       
MOV AH,11111110B
LN2s2:MOV AL, BYTE PTR CS:[SI]   
shr al ,1  
shr al ,1
OUT PPIC,AL 
MOV AL,AH
OUT PPIB,AL
CALL TIMER 

INC SI
CLC
ROL AH,1
JC LN2s2
INC DL 
  shr al ,1  
  shr al ,1
  CMP DL ,48
   jne shift2N
   ret
       
         
N:   
DB 10000100B
DB 10000100B
DB 11000100B
DB 10100100B
DB 10010100B
DB 10001100B
DB 10000100B 
DB 10000100B



;---------------------------------------------------
 PRINTCO:
  
 MOV  AL, 10000000B 
OUT PPIC_C , AL 

MOV AL,11111111B  
OUT PPIA, AL
  
LO1: MOV SI,OFFSET O                       

MOV AH,11111110B

LO2:MOV AL, BYTE PTR CS:[SI]
OUT PPIC,AL

MOV AL,AH
OUT PPIB,AL
CALL TIMER
INC SI
CLC
ROL AH,1
JC LO2 
INC DL
  CMP DL,16
  je  shift1O
  jmp  LO1
 
 shift1O:
 LO1s: MOV SI,OFFSET O                        
MOV AH,11111110B
LO2s:MOV AL, BYTE PTR CS:[SI]   
shr al ,1
OUT PPIC,AL 
MOV AL,AH
OUT PPIB,AL
CALL TIMER 

INC SI
CLC
ROL AH,1
JC LO2s
INC DL 
  shr al ,1
  CMP DL ,32
   je shift2O  
   jmp shift1O
       
   
   shift2O:
 LO1s2: MOV SI,OFFSET O                        
MOV AH,11111110B
LO2s2:MOV AL, BYTE PTR CS:[SI]   
shr al ,1  
shr al ,1
OUT PPIC,AL 
MOV AL,AH
OUT PPIB,AL
CALL TIMER 

INC SI
CLC
ROL AH,1
JC LO2s2
INC DL 
  shr al ,1  
  shr al ,1
  CMP DL ,48
   jne shift2O
   ret
      
O:
DB 01111000B
DB 10000100B
DB 10000100B
DB 10000100B
DB 10000100B 
DB 10000100B
DB 01111000B
DB 00000000B   

  


;------------------------------------------------
PRINTCP: 
 MOV  AL, 10000000B 
OUT PPIC_C , AL 

MOV AL,11111111B  
OUT PPIA, AL
  
LP1: MOV SI,OFFSET P                       

MOV AH,11111110B

LP2:MOV AL, BYTE PTR CS:[SI]
OUT PPIC,AL

MOV AL,AH
OUT PPIB,AL
CALL TIMER
INC SI
CLC
ROL AH,1
JC LP2 
INC DL
  CMP DL,16
  je  shift1P
  jmp  LP1
 
 shift1P:
 LP1s: MOV SI,OFFSET P                        
MOV AH,11111110B
LP2s:MOV AL, BYTE PTR CS:[SI]   
shr al ,1
OUT PPIC,AL 
MOV AL,AH
OUT PPIB,AL
CALL TIMER 

INC SI
CLC
ROL AH,1
JC LP2s
INC DL 
  shr al ,1
  CMP DL ,32
   je shift2P  
   jmp shift1P
       
   
   shift2P:
 LP1s2: MOV SI,OFFSET P                        
MOV AH,11111110B
LP2s2:MOV AL, BYTE PTR CS:[SI]   
shr al ,1  
shr al ,1
OUT PPIC,AL 
MOV AL,AH
OUT PPIB,AL
CALL TIMER 

INC SI
CLC
ROL AH,1
JC LP2s2
INC DL 
  shr al ,1  
  shr al ,1
  CMP DL ,48
   jne shift2P
   ret
 
P:
DB 00000100B
DB 00000100B
DB 00000100B
DB 01111100B
DB 10000100B 
DB 10000100B
DB 01111100B
DB 00000000B    



;---------------------------------------------------
PRINTCQ:
  
  MOV  AL, 10000000B 
OUT PPIC_C , AL 

MOV AL,11111111B  
OUT PPIA, AL
  
LQ1: MOV SI,OFFSET Q                       

MOV AH,11111110B

LQ2:MOV AL, BYTE PTR CS:[SI]
OUT PPIC,AL

MOV AL,AH
OUT PPIB,AL
CALL TIMER
INC SI
CLC
ROL AH,1
JC LQ2 
INC DL
  CMP DL,16
  je  shift1Q
  jmp  LQ1
 
 shift1Q:
 LQ1s: MOV SI,OFFSET Q                        
MOV AH,11111110B
LQ2s:MOV AL, BYTE PTR CS:[SI]   
shr al ,1
OUT PPIC,AL 
MOV AL,AH
OUT PPIB,AL
CALL TIMER 

INC SI
CLC
ROL AH,1
JC LQ2s
INC DL 
  shr al ,1
  CMP DL ,32
   je shift2Q  
   jmp shift1Q
       
   
   shift2Q:
 LQ1s2: MOV SI,OFFSET Q                       
MOV AH,11111110B
LQ2s2:MOV AL, BYTE PTR CS:[SI]   
shr al ,1  
shr al ,1
OUT PPIC,AL 
MOV AL,AH
OUT PPIB,AL
CALL TIMER 

INC SI
CLC
ROL AH,1
JC LQ2s2
INC DL 
  shr al ,1  
  shr al ,1
  CMP DL ,48
   jne shift2Q
   
  ret
Q:  
DB 00000000B
DB 11111000B
DB 11000100B
DB 10000100B
DB 10000100B 
DB 10000100B
DB 01111000B
DB 00000000B 
 
  


;------------------------------------------------
PRINTCR: 
 MOV  AL, 10000000B 
OUT PPIC_C , AL 

MOV AL,11111111B  
OUT PPIA, AL
  
LR1: MOV SI,OFFSET R                       

MOV AH,11111110B

LR2:MOV AL, BYTE PTR CS:[SI]
OUT PPIC,AL

MOV AL,AH
OUT PPIB,AL
CALL TIMER
INC SI
CLC
ROL AH,1
JC LR2 
INC DL
  CMP DL,16
  je  shift1R
  jmp  LR1
 
 shift1R:
 LR1s: MOV SI,OFFSET R                        
MOV AH,11111110B
LR2s:MOV AL, BYTE PTR CS:[SI]   
shr al ,1
OUT PPIC,AL 
MOV AL,AH
OUT PPIB,AL
CALL TIMER 

INC SI
CLC
ROL AH,1
JC LR2s
INC DL 
  shr al ,1
  CMP DL ,32
   je shift2R 
   jmp shift1R
       
   
   shift2R:
 LR1s2: MOV SI,OFFSET R                       
MOV AH,11111110B
LR2s2:MOV AL, BYTE PTR CS:[SI]   
shr al ,1  
shr al ,1
OUT PPIC,AL 
MOV AL,AH
OUT PPIB,AL
CALL TIMER 

INC SI
CLC
ROL AH,1
JC LR2s2
INC DL 
  shr al ,1  
  shr al ,1
  CMP DL ,48
   jne shift2R
   ret
  
R:
DB 10000100B
DB 01000100B
DB 00100100B
DB 01111100B
DB 10000100B 
DB 10000100B
DB 01111100B
DB 00000000B 


;---------------------------------------------------
 PRINTCS:
  
 MOV  AL, 10000000B 
OUT PPIC_C , AL 

MOV AL,11111111B  
OUT PPIA, AL
  
LS1: MOV SI,OFFSET S                       

MOV AH,11111110B

LS2:MOV AL, BYTE PTR CS:[SI]
OUT PPIC,AL

MOV AL,AH
OUT PPIB,AL
CALL TIMER
INC SI
CLC
ROL AH,1
JC LS2 
INC DL
  CMP DL,16
  je  shift1S
  jmp  LS1
 
 shift1S:
 LS1s: MOV SI,OFFSET S                        
MOV AH,11111110B
LS2s:MOV AL, BYTE PTR CS:[SI]   
shr al ,1
OUT PPIC,AL 
MOV AL,AH
OUT PPIB,AL
CALL TIMER 

INC SI
CLC
ROL AH,1
JC LS2s
INC DL 
  shr al ,1
  CMP DL ,32
   je shift2S  
   jmp shift1S
       
   
   shift2S:
 LS1s2: MOV SI,OFFSET S                        
MOV AH,11111110B
LS2s2:MOV AL, BYTE PTR CS:[SI]   
shr al ,1  
shr al ,1
OUT PPIC,AL 
MOV AL,AH
OUT PPIB,AL
CALL TIMER 

INC SI
CLC
ROL AH,1
JC LS2s2
INC DL 
  shr al ,1  
  shr al ,1
  CMP DL ,48
   jne shift2S
   ret
S:  
DB 01111100B
DB 10000000B
DB 10000000B
DB 01111000B
DB 00000100B 
DB 00000100B
DB 11111000B
DB 00000000B 
  


;------------------------------------------------
PRINTCT: 
 MOV  AL, 10000000B 
OUT PPIC_C , AL 

MOV AL,11111111B  
OUT PPIA, AL
  
LT1: MOV SI,OFFSET T                       

MOV AH,11111110B

LT2:MOV AL, BYTE PTR CS:[SI]
OUT PPIC,AL

MOV AL,AH
OUT PPIB,AL
CALL TIMER
INC SI
CLC
ROL AH,1
JC LT2 
INC DL
  CMP DL,16
  je  shift1T
  jmp  LT1
 
 shift1T:
 LT1s: MOV SI,OFFSET T                        
MOV AH,11111110B
LT2s:MOV AL, BYTE PTR CS:[SI]   
shr al ,1
OUT PPIC,AL 
MOV AL,AH
OUT PPIB,AL
CALL TIMER 

INC SI
CLC
ROL AH,1
JC LT2s
INC DL 
  shr al ,1
  CMP DL ,32
   je shift2T  
   jmp shift1T
       
   
   shift2T:
 LT1s2: MOV SI,OFFSET T                       
MOV AH,11111110B
LT2s2:MOV AL, BYTE PTR CS:[SI]   
shr al ,1  
shr al ,1
OUT PPIC,AL 
MOV AL,AH
OUT PPIB,AL
CALL TIMER 

INC SI
CLC
ROL AH,1
JC LT2s2
INC DL 
  shr al ,1  
  shr al ,1
  CMP DL ,48
   jne shift2T
   ret
T:
DB 00000000B
DB 00100000B
DB 00100000B
DB 00100000B
DB 00100000B 
DB 00100000B
DB 11111000B
DB 00000000B 

;---------------------------------------------------  
  PRINTCU:
  
  MOV  AL, 10000000B 
OUT PPIC_C , AL 

MOV AL,11111111B  
OUT PPIA, AL
  
LU1: MOV SI,OFFSET U                      

MOV AH,11111110B

LU2:MOV AL, BYTE PTR CS:[SI]
OUT PPIC,AL

MOV AL,AH
OUT PPIB,AL
CALL TIMER
INC SI
CLC
ROL AH,1
JC LU2 
INC DL
  CMP DL,16
  je  shift1U
  jmp  LU1
 
 shift1U:
 LU1s: MOV SI,OFFSET U                       
MOV AH,11111110B
LU2s:MOV AL, BYTE PTR CS:[SI]   
shr al ,1
OUT PPIC,AL 
MOV AL,AH
OUT PPIB,AL
CALL TIMER 

INC SI
CLC
ROL AH,1
JC LU2s
INC DL 
  shr al ,1
  CMP DL ,32
   je shift2U  
   jmp shift1U
       
   
   shift2U:
 LU1s2: MOV SI,OFFSET U                        
MOV AH,11111110B
LU2s2:MOV AL, BYTE PTR CS:[SI]   
shr al ,1  
shr al ,1
OUT PPIC,AL 
MOV AL,AH
OUT PPIB,AL
CALL TIMER 

INC SI
CLC
ROL AH,1
JC LU2s2
INC DL 
  shr al ,1  
  shr al ,1
  CMP DL ,48
   jne shift2U
   ret
U:  
DB 00000000B
DB 01111000B
DB 10000100B
DB 10000100B
DB 10000100B 
DB 10000100B
DB 10000100B
DB 00000000B 
 
  


;------------------------------------------------
PRINTCV: 
 MOV  AL, 10000000B 
OUT PPIC_C , AL 

MOV AL,11111111B  
OUT PPIA, AL
  
LV1: MOV SI,OFFSET V                       

MOV AH,11111110B

LV2:MOV AL, BYTE PTR CS:[SI]
OUT PPIC,AL

MOV AL,AH
OUT PPIB,AL
CALL TIMER
INC SI
CLC
ROL AH,1
JC LV2 
INC DL
  CMP DL,16
  je  shift1V
  jmp  LV1
 
 shift1V:
 LV1s: MOV SI,OFFSET V                        
MOV AH,11111110B
LV2s:MOV AL, BYTE PTR CS:[SI]   
shr al ,1
OUT PPIC,AL 
MOV AL,AH
OUT PPIB,AL
CALL TIMER 

INC SI
CLC
ROL AH,1
JC LV2s
INC DL 
  shr al ,1
  CMP DL ,32
   je shift2V  
   jmp shift1V
       
   
   shift2V:
 LV1s2: MOV SI,OFFSET V                        
MOV AH,11111110B
LV2s2:MOV AL, BYTE PTR CS:[SI]   
shr al ,1  
shr al ,1
OUT PPIC,AL 
MOV AL,AH
OUT PPIB,AL
CALL TIMER 

INC SI
CLC
ROL AH,1
JC LV2s2
INC DL 
  shr al ,1  
  shr al ,1
  CMP DL ,48
   jne shift2V
   ret
V:
DB 00000000B
DB 00100000B
DB 01010000B
DB 10001000B
DB 10001000B 
DB 10001000B
DB 10001000B 
DB 00000000B
 

;---------------------------------------------------
 PRINTCW:
  
 MOV  AL, 10000000B 
OUT PPIC_C , AL 

MOV AL,11111111B  
OUT PPIA, AL
  
LW1: MOV SI,OFFSET W                       

MOV AH,11111110B

LW2:MOV AL, BYTE PTR CS:[SI]
OUT PPIC,AL

MOV AL,AH
OUT PPIB,AL
CALL TIMER
INC SI
CLC
ROL AH,1
JC LW2 
INC DL
  CMP DL,16
  je  shift1W
  jmp  LW1
 
 shift1W:
 LW1s: MOV SI,OFFSET W                        
MOV AH,11111110B
LW2s:MOV AL, BYTE PTR CS:[SI]   
shr al ,1
OUT PPIC,AL 
MOV AL,AH
OUT PPIB,AL
CALL TIMER 

INC SI
CLC
ROL AH,1
JC LW2s
INC DL 
  shr al ,1
  CMP DL ,32
   je shift2W  
   jmp shift1W
       
   
   shift2W:
 LW1s2: MOV SI,OFFSET W                        
MOV AH,11111110B
LW2s2:MOV AL, BYTE PTR CS:[SI]   
shr al ,1  
shr al ,1
OUT PPIC,AL 
MOV AL,AH
OUT PPIB,AL
CALL TIMER 

INC SI
CLC
ROL AH,1
JC LW2s2
INC DL 
  shr al ,1  
  shr al ,1
  CMP DL ,48
   jne shift2W
   ret
W:

DB 10001000B
DB 10001000B
DB 11011000B
DB 10101000B
DB 10001000B
DB 10001000B
DB 10001000B 
DB 00000000B

  


;------------------------------------------------
PRINTCY: 
 MOV  AL, 10000000B 
OUT PPIC_C , AL 

MOV AL,11111111B  
OUT PPIA, AL
  
LY1: MOV SI,OFFSET Y                       

MOV AH,11111110B

LY2:MOV AL, BYTE PTR CS:[SI]
OUT PPIC,AL

MOV AL,AH
OUT PPIB,AL
CALL TIMER
INC SI
CLC
ROL AH,1
JC LY2 
INC DL
  CMP DL,16
  je  shift1Y
  jmp  LY1
 
 shift1Y:
 LY1s: MOV SI,OFFSET Y                       
MOV AH,11111110B
LY2s:MOV AL, BYTE PTR CS:[SI]   
shr al ,1
OUT PPIC,AL 
MOV AL,AH
OUT PPIB,AL
CALL TIMER 

INC SI
CLC
ROL AH,1
JC LY2s
INC DL 
  shr al ,1
  CMP DL ,32
   je shift2Y  
   jmp shift1Y
       
   
   shift2Y:
 LY1s2: MOV SI,OFFSET Y                        
MOV AH,11111110B
LY2s2:MOV AL, BYTE PTR CS:[SI]   
shr al ,1  
shr al ,1
OUT PPIC,AL 
MOV AL,AH
OUT PPIB,AL
CALL TIMER 

INC SI
CLC
ROL AH,1
JC LY2s2
INC DL 
  shr al ,1  
  shr al ,1
  CMP DL ,48
   jne shift2Y
   ret    
         
Y:
DB 00100000B
DB 00100000B
DB 00100000B
DB 01010000B
DB 10001000B
DB 10001000B 
DB 10001000B
DB 00000000B

;---------------------------------------------------   
 PRINTCX:
  
  MOV  AL, 10000000B 
OUT PPIC_C , AL 

MOV AL,11111111B  
OUT PPIA, AL
  
LX1: MOV SI,OFFSET X                       

MOV AH,11111110B

LX2:MOV AL, BYTE PTR CS:[SI]
OUT PPIC,AL

MOV AL,AH
OUT PPIB,AL
CALL TIMER
INC SI
CLC
ROL AH,1
JC LX2 
INC DL
  CMP DL,16
  je  shift1X
  jmp  LX1
 
 shift1X:
 LX1s: MOV SI,OFFSET X                        
MOV AH,11111110B
LX2s:MOV AL, BYTE PTR CS:[SI]   
shr al ,1
OUT PPIC,AL 
MOV AL,AH
OUT PPIB,AL
CALL TIMER 

INC SI
CLC
ROL AH,1
JC LX2s
INC DL 
  shr al ,1
  CMP DL ,32
   je shift2X  
   jmp shift1X
       
   
   shift2X:
 LX1s2: MOV SI,OFFSET X                        
MOV AH,11111110B
LX2s2:MOV AL, BYTE PTR CS:[SI]   
shr al ,1  
shr al ,1
OUT PPIC,AL 
MOV AL,AH
OUT PPIB,AL
CALL TIMER 

INC SI
CLC
ROL AH,1
JC LX2s2
INC DL 
  shr al ,1  
  shr al ,1
  CMP DL ,48
   jne shift2X
   ret
X: 
DB 00000000B
DB 00000000B
DB 10001000B
DB 01010000B
DB 00100000B
DB 01010000B
DB 10001000B
DB 00000000B
  


;------------------------------------------------
PRINTCZ: 
 MOV  AL, 10000000B 
OUT PPIC_C , AL 

MOV AL,11111111B  
OUT PPIA, AL
  
LZ1: MOV SI,OFFSET Z                       

MOV AH,11111110B

LZ2:MOV AL, BYTE PTR CS:[SI]
OUT PPIC,AL

MOV AL,AH
OUT PPIB,AL
CALL TIMER
INC SI
CLC
ROL AH,1
JC LZ2 
INC DL
  CMP DL,16
  je  shift1Z
  jmp  LZ1
 
 shift1Z:
 LZ1s: MOV SI,OFFSET Z                        
MOV AH,11111110B
LZ2s:MOV AL, BYTE PTR CS:[SI]   
shr al ,1
OUT PPIC,AL 
MOV AL,AH
OUT PPIB,AL
CALL TIMER 

INC SI
CLC
ROL AH,1
JC LZ2s
INC DL 
  shr al ,1
  CMP DL ,32
   je shift2Z  
   jmp shift1Z
       
   
   shift2Z:
 LZ1s2: MOV SI,OFFSET Z                       
MOV AH,11111110B
LZ2s2:MOV AL, BYTE PTR CS:[SI]   
shr al ,1  
shr al ,1
OUT PPIC,AL 
MOV AL,AH
OUT PPIB,AL
CALL TIMER 

INC SI
CLC
ROL AH,1
JC LZ2s2
INC DL 
  shr al ,1  
  shr al ,1
  CMP DL ,48
   jne shift2Z
   ret

Z:  
DB 11111100B
DB 00001000B
DB 00010000B
DB 00100000B
DB 01000000B 
DB 11111100B
DB 00000000B
DB 00000000B 
         

;---------------------------------------------------  
 
 PRINTCCLEAR:  
       call noop
MOV  AL, 10000000B 
OUT PPIC_C , AL 

MOV AL,11111111B  
OUT PPIA, AL
 
CL1: MOV SI,OFFSET CLEAR                       

MOV AH,11111110B

CL2:MOV AL, BYTE PTR CS:[SI]
OUT PPIC,AL

MOV AL,AH
OUT PPIB,AL
CALL TIMER 

INC SI
CLC
ROL AH,1
JC CL2
INC DL
  CMP DL,8
  jne CL1
       ret
  CLEAR:
DB 00000000B
DB 00000000B
DB 00000000B
DB 00000000B
DB 00000000B
DB 00000000B
DB 00000000B
DB 00000000B 

 ;--------------------------------------------------- 
noop:		
nop
nop
nop
nop
nop
nop
nop
nop
ret	
  ;-----------------------------------------------------  
;Mod PROC
;Convert key address to the proper alphabet according to number of presses on the key
;Receives: AL=hold input character from user
;Returns: BL= hold required character 

 ;-----------------------------
 MOD1:
    mov bl ,'A'
		mov cx ,0
waitB:
call noop
IN AL,key					
TEST AL,10000000b
jz doneB
loop waitB		
RET		
doneB :
mov bl,'B'
AND al,00011111b			
		OUT key,AL 
	mov cx ,0
waitC:
call noop 
IN AL,key					
TEST AL,10000000b
jz doneC
loop waitC   

RET
doneC:
mov bl,'C'  
     nop
nop
nop
nop
AND al,00011111b			
		OUT key,AL 
 RET 
 
 
 
 
 
 MOD2:
 mov bl ,'D'
		mov cx ,0
waitE:
call noop
IN AL,key					
TEST AL,10000000b
jz doneE
loop waitE		
RET		
doneE :
mov bl,'E'
AND al,00011111b			
		OUT key,AL 
	mov cx ,0
waitF:
call noop 
IN AL,key					
TEST AL,10000000b
jz doneF
loop waitF   

RET
doneF:
mov bl,'F' 
call noop
AND al,00011111b			
		OUT key,AL 
 RET        
 
 MOD3:
 mov bl ,'G'
		mov cx ,0
waitH:
  call noop
IN AL,key					
TEST AL,10000000b
jz doneH
loop waitH		
RET	
doneH :
mov bl,'H'
AND al,00011111b			
		OUT key,AL 
	mov cx ,0
waitI:
call noop 
IN AL,key					
TEST AL,10000000b
jz doneI
loop waitI   

RET
doneI:
mov bl,'I'  
 call noop
AND al,00011111b			
		OUT key,AL
 RET 
 
 MOD4:
 mov bl ,'J'
		mov cx ,0
waitK:
call noop
IN AL,key					
TEST AL,10000000b
jz doneK
loop waitK		
RET	
doneK :
mov bl,'K'
AND al,00011111b			
		OUT key,AL 
	mov cx ,0
waitL:
call noop 
IN AL,key					
TEST AL,10000000b
jz doneL
loop waitL   

RET
doneL:
mov bl,'L' 
call noop
AND al,00011111b			
		OUT key,AL 
 RET 
 
 
 MOD5:
 mov bl ,'M'
		mov cx ,0
waitN:
call noop
IN AL,key					
TEST AL,10000000b
jz doneN
loop waitN		
RET		
doneN :
mov bl,'N'
AND al,00011111b			
		OUT key,AL 
	mov cx ,0
waitO:
call noop 
IN AL,key					
TEST AL,10000000b
jz doneO
loop waitO   

RET
doneO:
mov bl,'O'  
call noop
AND al,00011111b			
		OUT key,AL 
 RET 
 
 
 MOD6:
 mov bl ,'P'
		mov cx ,0
waitQ:
call noop
IN AL,key					
TEST AL,10000000b
jz doneQ
loop waitQ		
RET		
doneQ :
mov bl,'Q'
AND al,00011111b			
		OUT key,AL 
	mov cx ,0
waitR:
call noop 
IN AL,key					
TEST AL,10000000b
jz doneR
loop waitR   

RET
doneR:
mov bl,'R' 
call noop
AND al,00011111b			
		OUT key,AL
		RET
		
		
		MOD7:
		mov bl ,'S'
		mov cx ,0
waitT:
call noop
IN AL,key					
TEST AL,10000000b
jz doneT
loop waitT		
RET	
doneT :
mov bl,'T'
AND al,00011111b			
		OUT key,AL 
	mov cx ,0
waitU:
call noop
IN AL,key					
TEST AL,10000000b
jz doneU
loop waitU   

RET
doneU:
mov bl,'U'  
call noop
AND al,00011111b			
		OUT key,AL 
		RET
		  
		  
		  
		  
		MOD8:
		    mov bl ,'V'
		mov cx ,0
waitW:
call noop
IN AL,key					
TEST AL,10000000b
jz doneW
loop waitW		
RET	
doneW :
mov bl,'W'
AND al,00011111b			
		OUT key,AL 
	mov cx ,0
waitX:
call noop
IN AL,key					
TEST AL,10000000b
jz doneX
loop waitX   

RET
doneX:
mov bl,'X' 
call noop
AND al,00011111b			
		OUT key,AL 
		RET  
		
		
		   
		MOD9:
		mov bl ,'Y'
		mov cx ,0
waitZ:
call noop
IN AL,key					
TEST AL,10000000b
jz doneZ
loop waitZ		
RET	
doneZ :
mov bl,'Z'
AND al,00011111b			
		OUT key,AL  
		RET   
;------------------------keypad scan procedure---------------------	
;Scan PROC
;Knowing the mode that the user wants to enter and take word from it.
;Receives: AL= key address
;Returns: BL= hold required character 
;-----------------------------------------------------  

scan:	IN AL,key					;read from keypad register
		TEST AL,10000000b			;test status flag of keypad register
		JNZ Scan   
		
		AND al,00011111b			;mask the valid bits for code
		OUT key,AL 
		cmp al,00h 		
		je f0
		cmp al,01h 		
		je f1 
		cmp al,02h 		
		je f2   
		cmp al,03h 		
		je f3 
		cmp al,04h 		
		je f4  
		cmp al,05h 		
		je f5 
		cmp al,06h 		
		je f6  
		cmp al,07h 		
		je f7 
		cmp al,08h 		
		je f8  
		cmp al,09h 		
		je f9     
		jmp scan 
		F0:		        ;;;;; mode 1 ( A B C )
   call MOD0
 jmp f10
		 
f1:		        ;;;;; mode 1 ( A B C )
   call MOD1
 jmp f10

f2:		        ;;;;; mode 2 ( D E F )
   call MOD2
 jmp f10
 f3:		        ;;;;; mode 3 ( G H I )
   call MOD3
 jmp f10
 f4:		        ;;;;; mode 4 ( J K L )
   call MOD4
 jmp f10

f5:		        ;;;;; mode 5 ( M N O )
   call MOD5
 jmp f10
 f6:		        ;;;;; mode 6 ( P Q R )
   call MOD6
 jmp f10
 f7:		        ;;;;; mode 7 ( S T U )
   call MOD7
 jmp f10

f8:		        ;;;;; mode 8 ( V W X )
   call MOD8
 jmp f10
 f9:		        ;;;;; mode 9 ( Y  Z )
   call MOD9
 jmp f10


                     
                  
   
   
f10:						;get the keypad ready to read another key
		ret
		
		
		
		
		
CODE	ENDS
	END		