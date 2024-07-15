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
    je dibujarCasa  ; Si es '2' ir a la etiqueta figura
    cmp al, '3'  
    je mensajeFinal  ; Si es '3' va al mensajeFinal
    call ComparacionTecla  ; Repetir la  comparación hasta que ingrese uno valido



triangulo:
  call modoGrafico
    MOV AH, 09H
    MOV DX, msjMenu
    int 21h
; Inicializa la columna
  mov si, 90d         
  ; Inicializa la fila
  mov di, 90d         
  ; Límite
  mov bp, 90d        
  mov ah, 0ch        
  ; Definimos el Color
  mov al, 2     
  mov bh, 0h     


  EncenderPixel:
  mov cx, si        
  mov dx, di  
  ; Interrupción de video       
  int 10h             
  inc si
  cmp si, bp
  jl EncenderPixel    
  inc di             
  inc bp              
  mov si, 90d  
  ; Verifica si la fila alcanzado su límite      
  cmp di, 140d       
  jne EncenderPixel
  call esperarTeclaS

esperarTeclaS:
    mov ah, 00h
    int 16h
    cmp al, 'S'
    je main
    call esperarTeclaS
                

dibujarCasa:
    call modoGrafico


    ; Dibuja el techo (triángulo)
    mov si, 150
    mov di, 50
    mov bp, 150
    

dibujarTechoTriangular:
    mov ah, 0ch
    mov al, 2  ; Color verde
    mov bh, 0h
    mov cx, si
    mov dx, di
    int 10h
    inc si
    cmp si, bp
    jl dibujarTechoTriangular
    inc di
    inc bp
    mov si, 150
    cmp di, 100
    jne dibujarTechoTriangular

    ; Dibuja el cuerpo de la casa (rectángulo)
    mov si, 150
    mov di, 100

dibujarCuerpoCasa:
    mov ah, 0ch
    mov al, 4  ; Color rojo
    mov bh, 0h
    mov cx, si
    mov dx, di
    int 10h
    inc si
    cmp si, 300
    jne dibujarCuerpoCasa
    mov si, 150
    inc di
    cmp di, 250
    jne dibujarCuerpoCasa

    ; Dibuja la puerta (rectángulo)
    mov si, 220
    mov di, 200

dibujarPuerta:
    mov ah, 0ch
    mov al, 0  ; Color negro
    mov bh, 0h
    mov cx, si
    mov dx, di
    int 10h
    inc si
    cmp si, 260
    jne dibujarPuerta
    mov si, 220
    inc di
    cmp di, 250
    jne dibujarPuerta

    ; Dibuja la primera ventana (rectángulo)
    mov si, 170
    mov di, 120

dibujarVentana1:
    mov ah, 0ch
    mov al, 15  ; Color blanco
    mov bh, 0h
    mov cx, si
    mov dx, di
    int 10h
    inc si
    cmp si, 200
    jne dibujarVentana1
    mov si, 170
    inc di
    cmp di, 150
    jne dibujarVentana1

    ; Dibuja la segunda ventana (rectángulo)
    mov si, 250
    mov di, 120

dibujarVentana2:
    mov ah, 0ch
    mov al, 15  ; Color blanco
    mov bh, 0h
    mov cx, si
    mov dx, di
    int 10h
    inc si
    cmp si, 280
    jne dibujarVentana2
    mov si, 250
    inc di
    cmp di, 150
    jne dibujarVentana2
    call esperarTecla




mensajeFinal:
    call modoTxt
    mov cx, 15       ; Fila donde mostrarara mensaje final 
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
