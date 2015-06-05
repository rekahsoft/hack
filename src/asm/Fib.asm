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

// File: Fib.asm
// Author: Collin J. Doering <collin.doering@rekahsoft.ca>
// Date: Jun 4, 2015

// Fill RAM[3] to RAM[28] with the first 25 Fibonacci numbers

        // Use R0 and R1 as pointers to the last two Fibonacci numbers locations
        @3
        D=A
        @R0
        M=D

        @4
        D=A
        @R1
        M=D

        // Use R2 as pointer the current Fibonacci number write location
        @5
        D=A
        @R2
        M=D
        
        // Put 0 and 1 in R3 and R4 respectively
        @R3
        M=0
        @R4
        M=1

(LOOP)
        @R0
        A=M
        D=M
        @R2
        A=M
        M=D

        @R1
        A=M
        D=M
        @R2
        A=M
        M=D+M

        @R1
        AD=M
        @R0
        M=D
        @R1
        M=D+1
        @R2
        M=M+1
(LOOPCOND)
        @27
        D=A
        @R2
        D=D-M
        @LOOP
        D;JGE        
(END)
        @END
        0;JMP
