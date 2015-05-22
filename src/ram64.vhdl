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

-- File: ram64.vhdl
-- Author: Collin J. Doering <collin.doering@rekahsoft.ca>
-- Date: May 22, 2015

library IEEE;
use IEEE.std_logic_1164.all;

entity ram64 is
  port (d       : in  std_logic_vector(15 downto 0);
        load    : in  std_logic;
        address : in  std_logic_vector(5 downto 0);
        clk     : in  std_logic;
        cout    : out std_logic_vector(15 downto 0));
end ram64;

architecture ram64_arch of ram64 is
  component ram8
    port (d       : in  std_logic_vector(15 downto 0);
          load    : in  std_logic;
          address : in  std_logic_vector(2 downto 0);
          clk     : in  std_logic;
          cout    : out std_logic_vector(15 downto 0));
  end component;

  component dmux8way
    port (cin                    : in  std_logic;
          sel                    : in  std_logic_vector(2 downto 0);
          a, b, c, d, e, f, g, h : out std_logic);
  end component;

  component mux8way16
    port (a, b, c, d, e, f, g, h : in  std_logic_vector(15 downto 0);
          sel                    : in  std_logic_vector(2 downto 0);
          cout                   : out std_logic_vector(15 downto 0));
  end component;

  signal ramLoad : std_logic_vector(7 downto 0);
  type ramoutT is array (7 downto 0) of std_logic_vector(15 downto 0);
  signal ramOut : ramoutT;
begin
  dmux8way_0: dmux8way port map (load, address(2 downto 0), ramLoad(0), ramLoad(1), ramLoad(2), ramLoad(3), ramLoad(4), ramLoad(5), ramLoad(6), ramLoad(7));

  ram: for i in ramLoad'range generate
    ram8_i: ram8 port map (d, ramLoad(i), address(5 downto 3), clk, ramOut(i));
  end generate;

  mux8way16_0: mux8way16 port map (ramOut(0), ramOut(1), ramOut(2), ramOut(3), ramOut(4), ramOut(5), ramOut(6), ramOut(7), address(2 downto 0), cout);
end ram64_arch;
