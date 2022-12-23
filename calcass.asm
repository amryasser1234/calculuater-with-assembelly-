
; You may customize this and other start-up templates; 
; The location of this template is c:\emu8086\inc\0_com_template.txt

org 100h      

jmp start

nsg: db "1-Add",0dh,0ah,"2-Multiply",0dh,0ah,"3-Subtract",0dh,0ah,"4-Divide",0dh,0ah,"$"
nsg2: db 0dh,0ah,"Enter First Number: $"
nsg3: db 0dh,0ah,"Enter Secand Number: $"  
nsg4: db 0dh,0ah,"Choise Error : $"
nsg5: db 0dh,0ah,"Result : $"
nsg6: db 0dh,0ah,"Thank you for using the calc Good luck :...! $"


start:  mov ah,9
        mov dx,offset nsg
        int 21h
        mov ah,0
        int 16h
        cmp al,31h 
        je addition
        cmp al,32h 
        je Multiply
        cmp al,33h 
        je Subtract 
        cmp al,34h 
        je Divide
        mov ah,09h
        mov dx,offset nsg4
        int 21h 
        mov ah,0
        int 16h
        jmp start
        

addition: mov ah,09h
          mov dx,offset nsg2
          int 21h  
          mov cx,0
          call InputNumber
          push dx
          mov ah,9
          mov dx,offset nsg3
          int 21h
          mov cx,0
          call InputNumber
          pop bx
          add dx,bx
          push dx
          mov ah,9
          mov dx,offset nsg5
          int 21h
          mov cx,10000
          pop dx        
          call View
          jmp exit
          
          

exit:     mov dx,offset nsg6
          mov ah,09h
          int 21h
          mov ah,0
          int 16h
          ret

          
          
          
          
          
          
View:     mov ax,dx
          mov dx,0
          div cx
          call ViewNumber
          mov bx,dx
          mov dx,0
          mov ax,cx
          mov cx,10
          div cx
          mov dx,bx
          mov cx,ax
          cmp ax,0
          jne View
          ret           
          
          
          
          
          
          
          
InputNumber: mov ah,0
             int 16h
             mov dx,0
             mov bx,1
             cmp al,0dh
             je FornNumber
             sub ax,30h
             call ViewNumber
             mov ah,0
             push ax
             inc cx
             jmp InputNumber
             
             
               
           
FornNumber:  pop ax
             push dx
             mul bx
             pop dx
             add dx,ax
             mov ax,bx
             mov bx,10
             push dx              
             mul bx
             pop dx
             mov bx,ax
             dec cx
             cmp cx,0
             jne FornNumber
              ret
             
             







           
           
           
ViewNumber: push ax
            push dx
            mov dx,ax
            add dl,30h
            mov ah,2
            int 21h
            pop dx
            pop ax
            ret  
           
           
           
           
           
           
           
           


Multiply:  mov ah,09h
            mov dx,offset nsg2
            int 21h  
            mov cx,0
            call InputNumber
            push dx
            mov ah,9
            mov dx,offset nsg3
            int 21h
            mov cx,0
            call InputNumber
            pop bx
            mov ax,dx
            mul bx
            mov dx,ax
            push dx
            mov ah,9
            mov dx,offset nsg5
            int 21h
            mov cx,10000
            pop dx            
            call View
           jmp exit



Subtract:    mov ah,09h
          mov dx,offset nsg2
          int 21h  
          mov cx,0
          call InputNumber
          push dx
          mov ah,9
          mov dx,offset nsg3
          int 21h
          mov cx,0
          call InputNumber
          pop bx
          sub bx,dx 
          mov dx,bx
          push dx
          mov ah,9
          mov dx,offset nsg5
          int 21h
          mov cx,10000
          pop dx        
          call View
          jmp exit





Divide:      
            mov ah,09h
            mov dx,offset nsg2
            int 21h  
            mov cx,0
            call InputNumber
            push dx
            mov ah,9
            mov dx,offset nsg3
            int 21h
            mov cx,0
            call InputNumber
            pop bx
            mov ax,bx
            mov cx,dx
            mov dx,0
            div cx
            mov dx,ax
            push dx
            mov ah,9
            mov dx,offset nsg5
            int 21h
            mov cx,10000
            pop dx            
            call View
           jmp exit
        
ret




