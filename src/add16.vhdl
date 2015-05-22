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

-- File: add16.vhdl
-- Author: Collin J. Doering <collin.doering@rekahsoft.ca>
-- Date: May 22, 2015

library IEEE;
use IEEE.std_logic_1164.all;

entity add16 is
  port (a, b : in std_logic_vector(15 downto 0);
        cout : out std_logic_vector(15 downto 0));
end add16;

architecture add16_arch of add16 is
  component adder
    port (a, b, ci : in std_logic;
          s, co    : out std_logic);
  end component;
  signal co0, co1, co2, co3, co4, co5, co6, co7, co8, co9, co10, co11, co12, co13, co14 : std_logic;
begin
  adder_0: adder port map (a(0), b(0), '0', cout(0), co0);
  adder_1: adder port map (a(1), b(1), co0, cout(1), co1);
  adder_2: adder port map (a(2), b(2), co1, cout(2), co2);
  adder_3: adder port map (a(3), b(3), co2, cout(3), co3);
  adder_4: adder port map (a(4), b(4), co3, cout(4), co4);
  adder_5: adder port map (a(5), b(5), co4, cout(5), co5);
  adder_6: adder port map (a(6), b(6), co5, cout(6), co6);
  adder_7: adder port map (a(7), b(7), co6, cout(7), co7);
  adder_8: adder port map (a(8), b(8), co7, cout(8), co8);
  adder_9: adder port map (a(9), b(9), co8, cout(9), co9);
  adder_10: adder port map (a(10), b(10), co9, cout(10), co10);
  adder_11: adder port map (a(11), b(11), co10, cout(11), co11);
  adder_12: adder port map (a(12), b(12), co11, cout(12), co12);
  adder_13: adder port map (a(13), b(13), co12, cout(13), co13);
  adder_14: adder port map (a(14), b(14), co13, cout(14), co14);
  adder_15: adder port map (a(15), b(15), co14, cout(15), open);
end add16_arch;
