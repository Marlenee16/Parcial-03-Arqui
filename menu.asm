org 100h  

section .data  

msjBien db 'Bienvenido al menu de opciones$'
msjPrimero db 'Parcial diferido de arquitectura$'
msj1 db ' Si desea visualizar el triangulo presione: 1 $'
msj2 db ' Si desea visualizar la figura presione: 2$'
msj3 db ' Si desea Salir presione: 3$'
msj4 db ' Ilcia Marlene Huezo Beltran 00233121 : $'
msjMenu db ' Presione "S" para regresar al menu$'
msjUltimo db 'Fin del programa$'

section .text 

main:
    ; Cambiaamos al modo de texto
    call modoTxt  

    MOV BH, 0H  
    MOV CH, 10  
    MOV CL, 10  
    call CentrarCursor  

     ; Mostrar mensaje de bienvenida
    call mensajeBienvenida 
    MOV CH, 12  
    MOV CL, 10  
    call CentrarCursor  

    ; Mostrar el mensaje principal del menu
    call mostrarMenu  
    MOV CH, 14  
    MOV CL, 10  
    call CentrarCursor  

    ; Mostrar la opción 1 del menu
    call mostrarM#1  
    MOV CH, 16  
    MOV CL, 10  
    call CentrarCursor  

    ;Mostrar la opcion 2 del menu
    call mostrarM#2  
    
    MOV CH, 18  
    MOV CL, 10  
    call CentrarCursor  

    ; Mostrar la opción 3 del menu
    call mostrarM#3  
    MOV CH, 25  
    MOV CL, 20  
    call CentrarCursor  

    ; Mostrar nombre y carne
    call mostrarM#4  
    ; Esperar y comparar la tecla presionada
    call ComparacionTecla  
    call esperarTecla  ; Esperar la siguiente tecla
    call modoTxt  ; Volver al modo de texto

modoGrafico:
    mov ah, 00h
    mov al, 12h  
    int 10h
    ret

modoTxt:
    mov ah, 00h
    mov al, 03h  
    int 10h 
    ret

CentrarCursor:
    MOV AH, 02H
    MOV DH, CH  
    MOV DL, CL  
    INT 10H
    RET

mensajeBienvenida:
    MOV AH, 09h
    MOV DX, msjBien  
    int 21h
    ret 

mostrarMenu:
    MOV AH, 09h
    MOV DX, msjPrimero  
    int 21h
    ret
    
mostrarM#1:
    MOV AH, 09h
    MOV DX, msj1  
    int 21h
    ret

mostrarM#2:
    MOV AH, 09h
    MOV DX, msj2  
    int 21h
    ret
  
mostrarM#3:
    MOV AH, 09h
    MOV DX, msj3  
    int 21h
    ret
  
mostrarM#4:
    MOV AH, 09h
    MOV DX, msj4  
    int 21h
    ret

esperarTecla:
    mov ah, 00h
    int 16h  ; Esperar una tecla
    ret

ComparacionTecla:
    mov ah, 00h
    int 16h  ; Esperar una tecla
    cmp al, '1'  
    je triangulo  ; Si elige '1' ir a la etiqueta triangulo
    cmp al, '2'  
    je figura  ; Si es '2' ir a la etiqueta figura
    cmp al, '3'  
    je mensajeFinal  ; Si es '3' va al mensajeFinal
    call ComparacionTecla  ; Repetir la  comparación hasta que ingrese uno valido

triangulo:
    ; Aquí va el código para mostrar el triángulo
    ret

figura:
    ; Aquí va el código para mostrar la figura
    ret

mensajeFinal:
    call modoTxt
    mov cx, 12       ; Fila para el mensaje final 
    mov dx, 40      
    sub dx, 8        
    mov ch, cl       
    mov cl, dl       
    call CentrarCursor
    MOV AH, 09h
    MOV DX, msjUltimo  
    int 21h
    call finalizarPrograma

finalizarPrograma:
    INT 20h  
    ret
