// function Sys.init 0
(Sys.init)
// push constant 4000
@4000
D=A
@SP
A=M
M=D
@SP
M=M+1
// pop pointer 0
@SP
M=M-1
@SP
A=M
D=M
@Temp0
M=D
@THIS
D=A
@Temp1
M=D
@Temp0
D=M
@Temp1
A=M
M=D
// push constant 5000
@5000
D=A
@SP
A=M
M=D
@SP
M=M+1
// pop pointer 1
@SP
M=M-1
@SP
A=M
D=M
@Temp0
M=D
@THAT
D=A
@Temp1
M=D
@Temp0
D=M
@Temp1
A=M
M=D
// call Sys.main 0
// SAVE @RETURN_Sys.main_5
@RETURN_Sys.main_5
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
@0
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
@Sys.main
0;JMP
(RETURN_Sys.main_5)
// pop temp 1
@SP
M=M-1
@SP
A=M
D=M
@Temp0
M=D
@6
D=A
@Temp1
M=D
@Temp0
D=M
@Temp1
A=M
M=D
// label LOOP
(LOOP)
// goto LOOP
@LOOP
0;JMP
// function Sys.main 5
(Sys.main)
// push constant 4001
@4001
D=A
@SP
A=M
M=D
@SP
M=M+1
// pop pointer 0
@SP
M=M-1
@SP
A=M
D=M
@Temp0
M=D
@THIS
D=A
@Temp1
M=D
@Temp0
D=M
@Temp1
A=M
M=D
// push constant 5001
@5001
D=A
@SP
A=M
M=D
@SP
M=M+1
// pop pointer 1
@SP
M=M-1
@SP
A=M
D=M
@Temp0
M=D
@THAT
D=A
@Temp1
M=D
@Temp0
D=M
@Temp1
A=M
M=D
// push constant 200
@200
D=A
@SP
A=M
M=D
@SP
M=M+1
// pop local 1
@SP
M=M-1
@SP
A=M
D=M
@Temp0
M=D
@LCL
D=M
@1
A=D+A
D=A
@Temp1
M=D
@Temp0
D=M
@Temp1
A=M
M=D
// push constant 40
@40
D=A
@SP
A=M
M=D
@SP
M=M+1
// pop local 2
@SP
M=M-1
@SP
A=M
D=M
@Temp0
M=D
@LCL
D=M
@2
A=D+A
D=A
@Temp1
M=D
@Temp0
D=M
@Temp1
A=M
M=D
// push constant 6
@6
D=A
@SP
A=M
M=D
@SP
M=M+1
// pop local 3
@SP
M=M-1
@SP
A=M
D=M
@Temp0
M=D
@LCL
D=M
@3
A=D+A
D=A
@Temp1
M=D
@Temp0
D=M
@Temp1
A=M
M=D
// push constant 123
@123
D=A
@SP
A=M
M=D
@SP
M=M+1
// call Sys.add12 1
// SAVE @RETURN_Sys.add12_21
@RETURN_Sys.add12_21
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
@Sys.add12
0;JMP
(RETURN_Sys.add12_21)
// pop temp 0
@SP
M=M-1
@SP
A=M
D=M
@Temp0
M=D
@5
D=A
@Temp1
M=D
@Temp0
D=M
@Temp1
A=M
M=D
// push local 0
@LCL
D=M
@0
A=D+A
D=M
@SP
A=M
M=D
@SP
M=M+1
// push local 1
@LCL
D=M
@1
A=D+A
D=M
@SP
A=M
M=D
@SP
M=M+1
// push local 2
@LCL
D=M
@2
A=D+A
D=M
@SP
A=M
M=D
@SP
M=M+1
// push local 3
@LCL
D=M
@3
A=D+A
D=M
@SP
A=M
M=D
@SP
M=M+1
// push local 4
@LCL
D=M
@4
A=D+A
D=M
@SP
A=M
M=D
@SP
M=M+1
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
// function Sys.add12 0
(Sys.add12)
// push constant 4002
@4002
D=A
@SP
A=M
M=D
@SP
M=M+1
// pop pointer 0
@SP
M=M-1
@SP
A=M
D=M
@Temp0
M=D
@THIS
D=A
@Temp1
M=D
@Temp0
D=M
@Temp1
A=M
M=D
// push constant 5002
@5002
D=A
@SP
A=M
M=D
@SP
M=M+1
// pop pointer 1
@SP
M=M-1
@SP
A=M
D=M
@Temp0
M=D
@THAT
D=A
@Temp1
M=D
@Temp0
D=M
@Temp1
A=M
M=D
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
// push constant 12
@12
D=A
@SP
A=M
M=D
@SP
M=M+1
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
