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

-- File: dmux4way.vhdl
-- Author: Collin J. Doering <collin.doering@rekahsoft.ca>
-- Date: May 22, 2015

library IEEE;
use IEEE.std_logic_1164.all;

entity dmux4way is
  port (cin        : in  std_logic;
        sel        : in  std_logic_vector(1 downto 0);
        a, b, c, d : out std_logic);
end dmux4way;

architecture dmux4way_arch of dmux4way is
  component dmux
    port (cin, sel : in  std_logic;
          a, b     : out std_logic);
  end component;

  signal dm1, dm2 : std_logic;
begin
  dmux_0: dmux port map (cin, sel(1), dm1, dm2);
  dmux_1: dmux port map (dm1, sel(0), a, b);
  dmux_2: dmux port map (dm2, sel(0), c, d);
end dmux4way_arch;
