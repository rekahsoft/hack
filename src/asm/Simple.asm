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

// File: Simple.asm
// Author: Collin J. Doering <collin.doering@rekahsoft.ca>
// Date: Jun 4, 2015

// Sets RAM[0] to 0, RAM[1] to 1 and RAM[2] to 2, ending with an infinite loop

        @0
        D=A
        @1
        D=A
        @2
        D=A
        @0
        0;JMP
