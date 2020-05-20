.MODEL SMALL            

.STACK 100H             
                        
.DATA                   



DVAR DB 10              ;bien phan chia cua byte va gia tri 10

MSG1  DW "Binary: $"    
MSG2 DW "Decimal: $"    

MSG3 DW ?               
MSG4 DW ?               

    
.CODE                   



MAIN PROC               
    
    
    MOV AX,@DATA        
    MOV DS,AX           
                         
LOOP2:                  
    DEC CH              ;CH=CH-1  
    AND BL,0H           ;BL=BL AND 0H (chuyen dang hex)
    MOV AH,9            
    LEA DX,MSG1         
    INT 21H             ;in ra dong chu BINARY :     
    CALL INPUT          
    MOV AH,4CH          
    INT 21H                         
    MAIN ENDP           


;ctcon    
INPUT PROC              
    POP MSG3            ;lay MSG3  
    MOV CL,8            ;CL=8      (8 bit)     
;nhan
INPUTN:                 
    DEC CL              ;CL=CL-1    (8bit)   
    MOV AH,1            ;chuc nang so 1 AH -> nhap ki tu vao tu ban phim
    INT 21H             ;luu vao thanh ghi AL
    SUB AL,30h           ;AL=AL-48,xem gia tri vua nhap 1 hay 0
    SHL BL,1            ;dich trai 1 lan BL
    OR BL,AL            ;BL=BL OR AL
    ;LAP 8 LAN
    CMP CL,0            ;so sanh CL voi 0
    JNE INPUTN          ;nhay toi INPUTN neu CL #0  
    CALL OP                
    PUSH MSG3           ;luu MSG3 vao stack   
    RET                    
    INPUT ENDP          
     
     
;ctcon     

OP PROC                 
    
    
    POP MSG4            ;lay MSG4  
    MOV AH,2            ;hien thi dang ASCII cua ki tu trong thanh ghi DL
    MOV DL,10           ;luu gia tri cua 10 vao thanh ghi DL
    INT 21H                
    INT 21H                 
    MOV AH,9            ;chuc nang soo 9 cua AH
    LEA DX,MSG2         ;lay dia chi offset cua MSG2 
    INT 21H            
  
    MOV BH,0H           ;thap phan
     
    MOV AX,BX           ;luu gia tri BX->AX

    
    DIVOP:                  
                            
    
        DIV DVAR            ;thanh ghi AX : DVAR (AX:10)
        
        CMP AH,0            ;so sanh AH vs 0
        JE PN1              ;nhay PN1 neu AH =0 0
        
        MOV DL,AH           ;luu AH -> DL
        
        AND DH,0H           
        
        MOV AH,0H           ;luu AH = 0
        
        PUSH DX             ;luu gia tri DX vao stack
                            
        JMP DIVOP           ;nhay toi nhan
    
                            
    PN1:    
      
    PRINTF:                 
        
        MOV AH,2            ;chuc nang so 2 cua AH    
        POP DX              ;lay gia tri DX     
        ADD DX,30h           ;Dx=DX+48    
        INT 21H             ;   
        CMP SP,100H         ;so sanh 100 vs SP
        JNE PRINTF          ;nhay toi PRINTF neu SP#100h
       
        PUSH MSG4           ;luu MSG4 vao ngan xep  
        RET                    
        OP ENDP               
                                   
                 
END MAIN                