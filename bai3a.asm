
.MODEL SMALL
.DATA 

    MSG2 DB "BINARY NUMBER IS : $\"
    STR1 DB 30 DUP("$")        ;do dai day bit
    STR2 DB 30 DUP("$")        ;do dai day bit
    STP DW 100                  ; so decimal
          
.CODE 

main    PROC
             
         MOV AX,@DATA
         MOV DS,AX 
         CALL doi10sang2
main    ENDP  
    
 ;ham con
doi10sang2 PROC  
             
         LEA SI,STR1       ;lay dia chi segment cua STR1
         MOV AX,STP        ;luu dia chi STP -> AX
         MOV BH,00         ; BH=00
         MOV BL,2          ; BL=2  ; co so 2  
      
      
      ;nhan L1 thuc hien lien tiep viec chia cho 2 , neu du (1) -> (AH=1 + 30h) -> them 1 vao STR1 , neu khong du -> them 0 vao STR1
      
      L1:DIV BL            ;AX:BL
         ADD AH,30h        ;chuyen AH ve dang ASCII
         MOV [SI],AH
         MOV AH,00         ;AH=0
         INC SI            ;SI=SI+1
         INC BH            ;BH=BH+1
         CMP AL,00         ; so sanh AL vs 00
         JNE L1            ; nhay toi nhan L1 neu AL # 00
         
         
         
         MOV CL,BH         ;chuyen noi dung BH->CL
         LEA SI,STR1       ;lay dia chi offset cua STR1 dat vao SI
         LEA DI,STR2       ;lay dia chi offset cua STR2 dat vao DI
         MOV CH,00         ;CH=0
         ADD SI,CX         ;SI=SI+CX  ,CX giu nguyen
         DEC SI            ;SI=SI-1
      ;thuc hien doi cho STR1 cho STR2 (vd : 1000 -> 0001)  
      
      L2:MOV AH,[SI]       ; chuyen dia chi offset cua SI -> AH
         MOV [DI],AH       ;
         DEC SI            ;SI=SI-1
         INC DI            ;DI=DI+1
         LOOP L2           ;CX=0->STOP , moi LOOP CX-1

         
         MOV AH,09H
         LEA DX,MSG2
         INT 21H 
         MOV AH,09H
         LEA DX,STR2
         INT 21H
         MOV AH,4CH
         INT 21H     
         RET
 doi10sang2 endp    
 doi2sang10 proc
 RET
 doi2sang10 endp       
        
ENDP     MAIN

