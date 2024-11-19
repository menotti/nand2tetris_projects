//Endereço screen
@16384
D=A
@SCREEN_ADDRESS
M=D

//N linhas
@256
D=A
@TOTAL_LINES
M=D

//N de palavras por linha
@32
D=A
@WORDS_PER_LINE
M=D

//Ciclos de delay(-ciclos -> +rapido)
@20000
D=A
@DELAY_CYCLES
M=D

// Começar ciclo principal
@CLEAR_SCREEN
0;JMP

// Apagar a tela (preto)
(CLEAR_SCREEN)
    @SCREEN_ADDRESS
    D=M
    @address
    M=D       // Reset address
    @TOTAL_LINES
    D=M
    @lineCounter
    M=D       // Reset lineCounter

(OUTER_LOOP_CLEAR)
    @WORDS_PER_LINE
    D=M
    @pixelCounter
    M=D  
    // N palavras por linha(32)

(INNER_LOOP_CLEAR)
    @address
    A=M    
    M=0    // define os 16 bits como 0 (preto)
    @address
    M=M+1  // Prox pixel

    @pixelCounter
    MD=M-1 
    @INNER_LOOP_CLEAR
    D;JGT  // Continua enquanto pixelCounter > 0

    @lineCounter
    MD=M-1
    @OUTER_LOOP_CLEAR
    D;JGT  // Continua enquanto lineCounter > 0

// Delay antes de preencher a tela
@DELAY_FILL
0;JMP

// Preencher a tela (branco)
(FILL_SCREEN)
    @SCREEN_ADDRESS
    D=M
    @address
    M=D       // Reset address
    @TOTAL_LINES
    D=M
    @lineCounter
    M=D       // Reset lineCounter

(OUTER_LOOP)
    @WORDS_PER_LINE
    D=M
    @pixelCounter
    M=D  

(INNER_LOOP)
    @address
    A=M  
    M=-1   // Define os 16 bits como -1 (branco, -1 transforma binario em 1111...)
    @address
    M=M+1  // Prox pixel

    @pixelCounter
    MD=M-1 
    @INNER_LOOP
    D;JGT  

    @lineCounter
    MD=M-1 
    @OUTER_LOOP
    D;JGT  

// Delay antes de apagar a tela
@DELAY_CLEAR
0;JMP

// Delay antes de preencher a tela
(DELAY_FILL)
    @DELAY_CYCLES
    D=M
    @delayCounter
    M=D        // espera o N de ciclos

(DELAY_LOOP_FILL)
    @delayCounter
    MD=M-1 
    @DELAY_LOOP_FILL
    D;JGT  // Continua enquanto delayCounter > 0

    @FILL_SCREEN
    0;JMP

// Delay antes de apagar a tela
(DELAY_CLEAR)
    @DELAY_CYCLES
    D=M
    @delayCounter
    M=D        // espera o N de ciclos

(DELAY_LOOP_CLEAR)
    @delayCounter
    MD=M-1 
    @DELAY_LOOP_CLEAR
    D;JGT  // Continua enquanto delayCounter > 0

    @CLEAR_SCREEN
    0;JMP     

