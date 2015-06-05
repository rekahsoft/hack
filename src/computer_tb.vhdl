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

-- File: computer_tb.vhdl
-- Author: Collin J. Doering <collin.doering@rekahsoft.ca>
-- Date: May 22, 2015

library IEEE;
use IEEE.std_logic_1164.all;
use std.textio.all;

entity computer_tb is
  generic (program_file : string := "asm/Fib.hack");
end computer_tb;

architecture computer_tb_arch of computer_tb is
   component clock
     generic (freq : real := 1000000000.0);
     port (finish : in  std_logic;
           cout   : out std_logic);
   end component;

   component ROM
     generic (program_file : string := program_file);
     port (address : in  std_logic_vector(14 downto 0);
           clk     : in  std_logic;
           cout    : out std_logic_vector(15 downto 0));
   end component;

   component ram16k
     port (d       : in  std_logic_vector(15 downto 0);
           load    : in  std_logic;
           address : in  std_logic_vector(14 downto 0);
           clk     : in  std_logic;
           cout    : out std_logic_vector(15 downto 0));
   end component;

   component cpu
     port (inM, instruction : in  std_logic_vector(15 downto 0);
           reset, clk       : in  std_logic;
           outM             : out std_logic_vector(15 downto 0);
           writeM           : out std_logic;
           addressM, pcOut  : out std_logic_vector(14 downto 0));
   end component;

   signal clk_fin, clk, reset, writeM : std_logic;
   signal ramIn, ramOut, romOut : std_logic_vector(15 downto 0);
   signal addressM, pcOut       : std_logic_vector(14 downto 0);
   
begin
  reset <= '0';
  clk_fin <= '0';

  OSC_CLK: clock port map (clk_fin, clk);
  INSR_ROM: ROM port map (pcOut, clk, romOut);
  MEMORY: ram16k port map (ramIn, writeM, addressM, clk, ramOut);
  THE_CPU: cpu port map (ramOut, romOut, reset, clk, ramIn, writeM, addressM, pcOut);

  process
  begin
    loop
      wait for 1 ns;
      assert false report "1 ns passed" severity note;
    end loop;
  end process;
end computer_tb_arch;
