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

-- File: pc.vhdl
-- Author: Collin J. Doering <collin.doering@rekahsoft.ca>
-- Date: May 22, 2015

library IEEE;
use IEEE.std_logic_1164.all;
use ieee.numeric_std.all;

entity pc is
  port (d                     : in  std_logic_vector(15 downto 0);
        load, inc, reset, clk : in  std_logic;
        cout                  : out std_logic_vector(15 downto 0));
end pc;

architecture pc_arch of pc is
   component dregister
     port (d         : in  std_logic_vector(15 downto 0);
           load, clk : in  std_logic;
           cout      : out std_logic_vector(15 downto 0));
   end component;

   component mux8way16
     port (a, b, c, d, e, f, g, h : in  std_logic_vector(15 downto 0);
           sel                    : in  std_logic_vector(2 downto 0);
           cout                   : out std_logic_vector(15 downto 0));
   end component;

   component add16
     port (a, b : std_logic_vector(15 downto 0); cout : out std_logic_vector(15 downto 0));
   end component;
   
   signal regLoad                  : std_logic;
   signal regOut, regOutInc, coutT : std_logic_vector(15 downto 0);
   signal muxsel                   : std_logic_vector(2 downto 0);

   constant zeroes : std_logic_vector(15 downto 0) := "0000000000000000";
begin
  muxsel <= reset & load & inc;
  regLoad <= load or inc or reset;
  add16_0: add16 port map ("0000000000000001", regOut, regOutInc);

  -- regOutInc <= std_logic_vector(unsigned(regOut) + 1);
  --coutT <= "0000000000000000" when (reset = '1') else
  --         d                  when (load = '1') else
  --         regOutInc          when (inc = '1') else
  --         regOut;

  mux8way16_0: mux8way16 port map (regOut, regOutInc, d, d, zeroes, zeroes, zeroes, zeroes, muxsel, coutT);
  reg_0: dregister port map (coutT, regLoad, clk, regOut);
  
  cout <= regOut;
end pc_arch;
