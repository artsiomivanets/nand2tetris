// bootstrap
@256
D=A
@SP
M=D
@300
D=A
@LCL
M=D
@400
D=A
@ARG
M=D
@3000
D=A
@THIS
M=D
@3010
D=A
@THAT
M=D
// function Sys.init 0
(Sys.init)
// push constant 4
@4
D=A
@SP
A=M
M=D
@SP
M=M+1
// call Main.fibonacci 1
// SAVE @RETURN_Main.fibonacci_3
@RETURN_Main.fibonacci_3
D=A
@SP
A=M
M=D
@SP
M=M+1
// SAVE @LCL
@LCL
D=M
@SP
A=M
M=D
@SP
M=M+1
// SAVE @ARG
@ARG
D=M
@SP
A=M
M=D
@SP
M=M+1
// SAVE @THIS
@THIS
D=M
@SP
A=M
M=D
@SP
M=M+1
// SAVE @THAT
@THAT
D=M
@SP
A=M
M=D
@SP
M=M+1
// SET ARG
@1
D=A
@SP
A=M
D=A-D
@5
D=D-A
@ARG
M=D
// SET LCL TO SP
@SP
D=M
@LCL
M=D
// GO TO FUNCTION
@Main.fibonacci
0;JMP
(RETURN_Main.fibonacci_3)
// label WHILE
(WHILE)
// goto WHILE
@WHILE
0;JMP
// function Main.fibonacci 0
(Main.fibonacci)
// push argument 0
@ARG
D=M
@0
A=D+A
D=M
@SP
A=M
M=D
@SP
M=M+1
// push constant 2
@2
D=A
@SP
A=M
M=D
@SP
M=M+1
// lt
@SP
M=M-1
@SP
A=M
D=M
@SP
M=M-1
A=M
D=M-D
@T_9
D;JLT
D=0
@SP
A=M
M=D
@END_9
0;JMP
(T_9)
D=-1
@SP
A=M
M=D
(END_9)
@SP
M=M+1
// if-goto IF_TRUE
@SP
M=M-1
@SP
A=M
D=M
@IF_TRUE
D;JNE
// goto IF_FALSE
@IF_FALSE
0;JMP
// label IF_TRUE
(IF_TRUE)
// push argument 0
@ARG
D=M
@0
A=D+A
D=M
@SP
A=M
M=D
@SP
M=M+1
// return
// SET END FRAME ADDRESS
@LCL
D=M
@Temp5
M=D
// Set  return address
@5
D=A
@Temp5
A=M
D=A-D
@Temp4
M=D
// Put return value to arg
@SP
M=M-1
@SP
A=M
D=M
@ARG
A=M
M=D
// Set SP as ARG
@ARG
A=M
D=A+1
@SP
M=D
// Restore THAT
@1
D=A
@Temp5
A=M
A=A-D
D=M
@THAT
M=D
// Restore THIS
@2
D=A
@Temp5
A=M
A=A-D
D=M
@THIS
M=D
// Restore ARG
@3
D=A
@Temp5
A=M
A=A-D
D=M
@ARG
M=D
// Restore LCL
@4
D=A
@Temp5
A=M
A=A-D
D=M
@LCL
M=D
// Go to return address
@Temp4
A=M
A=M
0;JMP
// label IF_FALSE
(IF_FALSE)
// push argument 0
@ARG
D=M
@0
A=D+A
D=M
@SP
A=M
M=D
@SP
M=M+1
// push constant 2
@2
D=A
@SP
A=M
M=D
@SP
M=M+1
// sub
@SP
M=M-1
@SP
A=M
D=M
@SP
M=M-1
A=M
M=M-D
@SP
M=M+1
// call Main.fibonacci 1
// SAVE @RETURN_Main.fibonacci_19
@RETURN_Main.fibonacci_19
D=A
@SP
A=M
M=D
@SP
M=M+1
// SAVE @LCL
@LCL
D=M
@SP
A=M
M=D
@SP
M=M+1
// SAVE @ARG
@ARG
D=M
@SP
A=M
M=D
@SP
M=M+1
// SAVE @THIS
@THIS
D=M
@SP
A=M
M=D
@SP
M=M+1
// SAVE @THAT
@THAT
D=M
@SP
A=M
M=D
@SP
M=M+1
// SET ARG
@1
D=A
@SP
A=M
D=A-D
@5
D=D-A
@ARG
M=D
// SET LCL TO SP
@SP
D=M
@LCL
M=D
// GO TO FUNCTION
@Main.fibonacci
0;JMP
(RETURN_Main.fibonacci_19)
// push argument 0
@ARG
D=M
@0
A=D+A
D=M
@SP
A=M
M=D
@SP
M=M+1
// push constant 1
@1
D=A
@SP
A=M
M=D
@SP
M=M+1
// sub
@SP
M=M-1
@SP
A=M
D=M
@SP
M=M-1
A=M
M=M-D
@SP
M=M+1
// call Main.fibonacci 1
// SAVE @RETURN_Main.fibonacci_23
@RETURN_Main.fibonacci_23
D=A
@SP
A=M
M=D
@SP
M=M+1
// SAVE @LCL
@LCL
D=M
@SP
A=M
M=D
@SP
M=M+1
// SAVE @ARG
@ARG
D=M
@SP
A=M
M=D
@SP
M=M+1
// SAVE @THIS
@THIS
D=M
@SP
A=M
M=D
@SP
M=M+1
// SAVE @THAT
@THAT
D=M
@SP
A=M
M=D
@SP
M=M+1
// SET ARG
@1
D=A
@SP
A=M
D=A-D
@5
D=D-A
@ARG
M=D
// SET LCL TO SP
@SP
D=M
@LCL
M=D
// GO TO FUNCTION
@Main.fibonacci
0;JMP
(RETURN_Main.fibonacci_23)
// add
@SP
M=M-1
@SP
A=M
D=M
@SP
M=M-1
A=M
M=D+M
@SP
M=M+1
// return
// SET END FRAME ADDRESS
@LCL
D=M
@Temp5
M=D
// Set  return address
@5
D=A
@Temp5
A=M
D=A-D
@Temp4
M=D
// Put return value to arg
@SP
M=M-1
@SP
A=M
D=M
@ARG
A=M
M=D
// Set SP as ARG
@ARG
A=M
D=A+1
@SP
M=D
// Restore THAT
@1
D=A
@Temp5
A=M
A=A-D
D=M
@THAT
M=D
// Restore THIS
@2
D=A
@Temp5
A=M
A=A-D
D=M
@THIS
M=D
// Restore ARG
@3
D=A
@Temp5
A=M
A=A-D
D=M
@ARG
M=D
// Restore LCL
@4
D=A
@Temp5
A=M
A=A-D
D=M
@LCL
M=D
// Go to return address
@Temp4
A=M
A=M
0;JMP
