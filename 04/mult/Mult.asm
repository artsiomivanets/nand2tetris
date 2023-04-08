// This file is part of www.nand2tetris.org
// and the book "The Elements of Computing Systems"
// by Nisan and Schocken, MIT Press.
// File name: projects/04/Mult.asm

// Multiplies R0 and R1 and stores the result in R2.
// (R0, R1, R2 refer to RAM[0], RAM[1], and RAM[2], respectively.)
//
// This program only needs to handle arguments that satisfy
// R0 >= 0, R1 >= 0, and R0*R1 < 32768.

// i = R0
// R2 = R1
// loop: 
//   if i > 0
//     R2 = R1 + R2
//     i = R0 - 1
//   else
//     goto end
// end:

// Put your code here.

  @R1
  D=M;
  @ARGUMENTS_EQUAL_ZERO
  D;JEQ
  @R0
  D=M;
  @ARGUMENTS_EQUAL_ZERO
  D;JEQ
  @i
  M=D
  @R2
  M=0
(LOOP)
  @i
  D=M
  M=D-1
  @END
  D;JEQ
  @R1
  D=M
  @R2
  M=M+D
  @LOOP
  0;JMP
(ARGUMENTS_EQUAL_ZERO)
  @R2
  M=0
(END)
  @END
  0;JMP
