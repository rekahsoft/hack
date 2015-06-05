// (C) Copyright Collin J. Doering 2015
//
// This program is free software: you can redistribute it and/or
// modify it under the terms of the GNU General Public License as
// published by the Free Software Foundation, either version 3 of
// the License, or (at your option) any later version.
//
// This program is distributed in the hope that it will be useful,
// but WITHOUT ANY WARRANTY; without even the implied warranty of
// MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE. See the GNU
// General Public License for more details.
//
// You should have received a copy of the GNU General Public License
// along with this program. If not, see <http://www.gnu.org/licenses/>.

// File: Max.asm
// Author: Collin J. Doering <collin.doering@rekahsoft.ca>
// Date: Jun 4, 2015

// Adaption of the ComputerMax.tst and Max.hack provided by the
// Nand-to-Tetris course. This was done because the test script sets
// the value of various locations in RAM before running some number
// of cycles, checking the output at each cycle and then repeating.
// Pre-imaging the RAM, would allow this to be done in VHDLl thought
// this is not hard, is not immediately beneficial for this project,
// as its goal is to create a physical implementation on FPGA. So
// instead, we dissemble the Max.hack program and make slight
// modifications to set the values needed in RAM. We then can run
// the program using the computer_tb unit and ghdl, and assess the
// wave output.

(DATA1)
        @3
        D=A
        @0
        M=D
        @5
        D=A
        @1
        M=D

        @DATA2
        D=A
        @2
        M=D
        
        @PROC
        0;JMP
(DATA2)
        @23456
        D=A
        @0
        M=D
        @12345
        D=A
        @1
        M=D

        @DATA3
        D=A
        @2
        M=D

        @PROC
        0;JMP
(DATA3)
        @65432
        D=A
        @0
        M=D
        @54321
        D=A
        @1
        M=D

        @END
        D=A
        @2
        M=D

        @PROC
        0;JMP

(PROC)
        @0
        D=M
        @1
        D=D-M
        @LARGER
        D;JGT
        @SMALLEROREQUAL
        0;JMP
(LARGER)
        @3
        M=1

        @0
        D=M
        @4
        M=D

        @2
        A=M
        0;JMP
(SMALLEROREQUAL)
        @3
        M=0

        @1
        D=M
        @4
        M=D

        @2
        A=M
        0;JMP

(END)
        @END
        0;JMP
