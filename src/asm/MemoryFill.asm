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

// File: MemoryFill.asm
// Author: Collin J. Doering <collin.doering@rekahsoft.ca>
// Date: Jun 4, 2015

// Labels RAM[0] through RAM[16383] with 0, 1, 2, ..., 16383

        @0
        M=1
(LOOP)
        @16383
        D=A
        @0
        D=D-M
        @END
        D;JEQ

        @0
        AD=M
        M=D

        @0
        M=D+1
        @LOOP
        0;JMP
(END)
        @END
        0;JMP
