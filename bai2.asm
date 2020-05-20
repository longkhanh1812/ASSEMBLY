.MODEL SMALL
.DATA
        VAL1    DB      ?                                                 ;bien kieu byte
        NL1     DB      "NHAP SO PHAN TU BAN MUON :$"
        NL2     DB      "NHAP DU LIEU PHAN TU :$"
        NL3     DB      "TRUNG BINH CONG LA :$"
.CODE
MAIN    PROC
        MOV AX,@DATA             ;
        MOV DS,AX                ;dat dia chi segment cua data vao thanh ghi DS

        LEA DX,NL1               ;lay dia chi offset cua NL1 dat vao DX
        MOV AH,9                 ;chuc nang so 9 AH -> hien thi 1 chuoi ki tu (DX)
        INT 21H                  ;ngat 21h

        MOV AH,1                 ;chuc nang so 1 AH -> nhap 1 ki tu tu ban phim 
        INT 21H                  ;luu vao thanh ghi AL
        SUB AL,30h               ;AL=AL-30h , doi ki tu nhap vao tu ban phim thanh so thap phan tuong ung

        MOV CL,AL                ; dua gia tri thanh ghi AL vao thanh ghi CL   (de thuc hien nhan LBL1)
        MOV BL,AL                ; dua gia tri thanh ghi AL vao thanh ghi BL
        MOV AL,00                ;AL==0
        MOV VAL1,AL              ;dua gia tri AL vao VAL1

LBL1:                            ;nhan LBL1
        LEA DX,NL2               ;lay dia chi offset cua NL2 dat vao DX
        MOV AH,9                 ;chuc nang so 9 cua AH 
        INT 21H                  ;ngat 21h

        MOV AH,1                 ;chuc nang so 1 cua AH
        INT 21H                  ;ngat 21h
        SUB AL,30H               ;->luu vao thanh ghi AL -> AL=AL-30h , doi ki tu nhap vao thanh so thap phan tuong ung

        ADD AL,VAL1              ;AL=AL+VAL1 , VAL1 giu nguyen
        MOV VAL1,AL              ;VAL1=VAL1+AL  AL giu nguyen
        LOOP LBL1                ;lap LBL1 khi CX=0

LBL2:                            ;nhan LBL2
        LEA DX,NL3               ;
        MOV AH,9                 ;
        INT 21H
                                 ;AX=0
        MOV AX,00                ;dua gia tri VAL1 vao thanh ghi AL
        MOV AL,VAL1              ;thanh ghi AX : BL (BL duoc luu giu o tren) 
        DIV BL
        ADD AX,3030h             ;dua ve dang ASCII  vd: AL=06 -> AX=3036
        MOV DX,AX                ;dua du lieu DX vao AX
        MOV AH,02h               ;hien thi dang ASCII cua ki tu trong thanh ghi DL
        INT 21H

        MOV AH,4CH
        INT 21H

MAIN    ENDP
        END     MAIN