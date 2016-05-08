TITLE A083361 

KODIKAS SEGMENT PUBLIC
ASSUME CS:KODIKAS,DS:DATA,SS:SOROS   



   MAIN PROC NEAR
    MOV AX,DATA
    MOV DS,AX
    
    MOV SI,0
      MOV N1,0
      MOV N2,0
     LEA DX,MES
     MOV AH,9
     INT 21H
     
     call eisag_monohex
     
     MOV N1,AL                  
                       
     LEA DX,MES
     MOV AH,9
     INT 21H
     
     call eisag_monohex
      MOV BH,0 
      MOV AH,0
      
      
      MOV N2,AL
      
      
      LEA DX,MES1
     MOV AH,9
     INT 21H
      
 INPRAKSI:    ;THA GINEI EISAGWGI ENOS XARAKTIRA GIA NA GINEI I PRAKSI
 
    mov ah,08
    int 21h
    
    CMP AL,'+'
    JE SIN
       
       
    CMP AL,'*'
    JE EPI
    
    
    JMP INPRAKSI
    SIN: 
        mov dl,al

        mov ah,2
        int 21h


        MOV BL,N1
        ADD BL,N2
        MOV N,BL
        JMP EMFANISI
    EPI:  
    
         mov dl,al

        mov ah,2
        int 21h 
        
         MOV AH,0
         MOV AL,N1
         MOV CL,N2
         
         MUL CL
    
         MOV N,AL
  
        
  
 EMFANISI:    ;THA GINEI EMFANISI TOU APOTELESMATOS
    
    
    
     LEA DX,DEN
     MOV AH,9
     INT 21H 
      
       MOV DL,N
       CALL DISPLAY_HEX
      ;MOV DX,BX
      ;CALL DISPLAY
      JMP TELOS1
      
      eisag_monohex proc near  
     l1:
mov ah,8
int 21h

cmp al,'0'
jb l1

cmp al,'9'
jbe l2

cmp al,'A'
jb l1

cmp al,'F'
ja l1

l2:
mov dl,al

mov ah,2
int 21h

sub al,48

cmp al,9
ja l3

jmp l5

l3:

sub al,7

l5:
	 ret
	
	eisag_monohex endp
     
     DISPLAY_HEX PROC NEAR
MOV BL,DL  ;METAFERW TO PREIEXOMENO TOU DL SE ALLO KATAXORITI GT TO XREIAZOMAI

MOV BH,0 ;MIDENIZW TO BH KAI ETCI KSERW OTI O BX EXEI AYTO POU EIXE O BL
MOV CL,4 ;BAZW 4 STO CL GIA NA EXW TOSES EPANALIPSEIS

SHL BX,CL ;METATOPIZW ARISTERA TON BX TOSA BIT OSA EIXE O CL
MOV DL,BH ;METAFEROUME TON PROTO HEX ARITHMO APO TO BH STO DL GIA NA GINEI TO PERASM...

CALL ONE_DIGIT ;KALOUME TIN ONE_DIGIT

MOV CL,4 

SHR BL,CL
MOV DL,BL

CALL ONE_DIGIT

RET

DISPLAY_HEX ENDP 
     
    DISPLAY PROC NEAR 
        
        
     
          MOV BL,DL  ;METAFERW TO PREIEXOMENO TOU DL SE ALLO KATAXORITI GT TO XREIAZOMAI

MOV BH,0 ;MIDENIZW TO BH KAI ETCI KSERW OTI O BX EXEI AYTO POU EIXE O BL
MOV CL,4 ;BAZW 4 STO CL GIA NA EXW TOSES EPANALIPSEIS

SHL BX,CL ;METATOPIZW ARISTERA TON BX TOSA BIT OSA EIXE O CL
MOV DL,BH ;METAFEROUME TON PROTO HEX ARITHMO APO TO BH STO DL GIA NA GINEI TO PERASM...

CALL ONE_DIGIT ;KALOUME TIN ONE_DIGIT
 MOV CL,4 

SHR BL,CL
MOV DL,BL

CALL ONE_DIGIT



RET



        DISPLAY ENDP 
    
    ONE_DIGIT PROC NEAR
	
	CMP DL,9	; Sygkrinoume to DL me to 9 gia na ksexoriso an o DL exei arithmo 0-9 H metaksi 10-15
	JA GRAMMA	; An o DL einai metaksi 10-15 phgaine stin etiketa "Gramma" gia na emfanistei apo A-F

	ADD DL,48	; Metatrepoume ton arithmo poy exei o DL se xaraktira poy einai antistoixos se ASCII
	JMP NEXT	; Phgainoyme stin etiketa "Next" giati i epomeni grammi anaferetai gia arithmoys 10-15

GRAMMA:	ADD DL, 'A'-10	; Metatrepoume ton aritho pou einai 10-15 sto antistoixo gramma A-F prosthetontas 55

NEXT:	MOV AH,02H	; Emfanizoyme stin othoni to periexomeno tou DL
	INT 21H 

TELOS:	RET		; Epistrefo stin thesi apo opou klithike h yporoutina

ONE_DIGIT ENDP
      TELOS1:       MOV AH,4CH
              INT 21H

        KODIKAS ENDS


   DATA SEGMENT
    N DB 1
    N1 DB 0
    N2 DB 0
    BUFFER DB SI(0) 
    EK DD (0
   
  MES DB 10,13,"EISAGETE ENA DEKAEKSADIKO: ",10,13,"$"
  MES1 DB 10,13,"DWSTE ENA SYMBOLO PRAKSIS: ",10,13,"$"
  DEN DB 10,13,"$"
       
DATA ENDS 
SOROS SEGMENT STACK
    DB 256 DUP(0)
  SOROS ENDS
END MAIN

