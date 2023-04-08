// This file is part of www.nand2tetris.org
// and the book "The Elements of Computing Systems"
// by Nisan and Schocken, MIT Press.
// File name: projects/04/Fill.asm

// Runs an infinite loop that listens to the keyboard input.
// When a key is pressed (any key), the program blackens the screen,
// i.e. writes "black" in every pixel;
// the screen should remain fully black as long as the key is pressed. 
// When no key is pressed, the program clears the screen, i.e. writes
// "white" in every pixel;
// the screen should remain fully clear as long as no key is pressed.

// Put your code here.

// loop
//   if keyboard = 0
//     put zeros in screen
//   else
//     puts 1's in screen
// go to loop



(LOOP)
  @SCREEN
  D=A
  @CUR_POS_PTR
  M=D
  @8191
  D=D+A
  @END_OF_SCREEN_PTR
  M=D
  @KBD
  D=M
  @BLACKENS
  D;JNE
  @CLEAN
  D;JEQ

(CLEAN)
  @CUR_POS_PTR
  A=M
  M=0
  D=A+1
  @CUR_POS_PTR
  M=D
  @END_OF_SCREEN_PTR
  D=M-D
  @CLEAN
  D;JGT
  @LOOP
  0;JMP

(BLACKENS)
  @CUR_POS_PTR
  A=M
  M=-1
  D=A+1
  @CUR_POS_PTR
  M=D
  @END_OF_SCREEN_PTR
  D=M-D
  @BLACKENS
  D;JGT
  @LOOP
  0;JMP

