@0
(LOOP)
@100
D=A
@0
M=D
(WAIT2)
D=0
(WAIT)
@WAIT
D=D+1
D;JNE
@0
MD=M-1
@WAIT2
D;JNE

@8204		//write both LED and HEX display
M=M+1

@LOOP
0;JMP
