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

-- File: dregister.vhdl
-- Author: Collin J. Doering <collin.doering@rekahsoft.ca>
-- Date: May 22, 2015

library IEEE;
use IEEE.std_logic_1164.all;

entity dregister is
  port (d         : in std_logic_vector(15 downto 0);
        load, clk : in std_logic;
        cout      : out std_logic_vector(15 downto 0));
end dregister;

architecture dregister_arch of dregister is
  component dbit
    port (d, load, clk : in  std_logic;
          cout         : out std_logic);
  end component;
begin
  reg: for i in 0 to 15 generate
    dbit_i: dbit port map (d(i), load, clk, cout(i));
  end generate;
end dregister_arch;
