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

-- File: clock.vhdl
-- Author: Collin J. Doering <collin.doering@rekahsoft.ca>
-- Date: May 22, 2015
-- Description: A clock entity for use for simulation only!

library IEEE;
use IEEE.std_logic_1164.all;

entity clock is
  generic (freq : real := 1000000000.0);
  port (finish : in  std_logic;
        cout   : out std_logic);
end clock;

architecture clock_arch of clock is
  signal clk: std_logic := '0';
  constant period : time := 1 sec / freq;
  constant half_period : time := period / 2;
begin
  clk <= not clk after half_period when finish /= '1' else '0';
  cout <= clk;
end clock_arch;
