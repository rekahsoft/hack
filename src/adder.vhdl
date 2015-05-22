-- (C) Copyright Collin J. Doering 2015
--
-- This program is free software: you can redistribute it and/or modify
-- it under the terms of the GNU General Public License as published by
-- the Free Software Foundation, either version 3 of the License, or
-- (at your option) any later version.
--
-- This program is distributed in the hope that it will be useful,
-- but WITHOUT ANY WARRANTY; without even the implied warranty of
-- MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
-- GNU General Public License for more details.
--
-- You should have received a copy of the GNU General Public License
-- along with this program.  If not, see <http://www.gnu.org/licenses/>.

-- File: adder.vhdl
-- Author: Collin J. Doering <collin.doering@rekahsoft.ca>
-- Date: May 22, 2015

library IEEE;
use IEEE.std_logic_1164.all;

entity adder is
  -- i0, i1 and the carry-in ci are inputs of the adder.
  -- s is the sum output, co is the carry-out.
  port (a, b, ci : in  std_logic;
        s, co    : out std_logic);
end adder;

architecture adder_arch of adder is
begin
  --  Compute the sum.
  s <= a xor b xor ci;
  --  Compute the carry.
  co <= (a and b) or (a and ci) or (b and ci);
end adder_arch;
