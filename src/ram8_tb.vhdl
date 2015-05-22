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

-- File: ram8_tb.vhdl
-- Author: Collin J. Doering <collin.doering@rekahsoft.ca>
-- Date: May 22, 2015

library IEEE;
use IEEE.std_logic_1164.all;

--  A testbench has no ports.
entity ram8_tb is
end ram8_tb;

architecture ram8_tb_arch of ram8_tb is
   --  Declaration of the component that will be instantiated.
   component ram8
     port (d       : in  std_logic_vector(15 downto 0);
           load    : in  std_logic;
           address : in  std_logic_vector(2 downto 0);
           clk     : in  std_logic;
           cout    : out std_logic_vector(15 downto 0));
   end component;

   -- Declaration of the clock
   component Clock
     port (finish : in  std_logic;
           cout   : out std_logic);
   end component;

   --  Specifies which entity is bound with the component.
   for ram8_0: ram8 use entity work.ram8;

   -- Signals
   signal d, cout           : std_logic_vector(15 downto 0);
   signal address           : std_logic_vector(2 downto 0);
   signal load, finish, clk : std_logic;
begin
  --  Component instantiation.
  OSC_CLK: Clock port map (finish, clk);
  ram8_0: ram8 port map (d, load, address, clk, cout);

   --  This process does the real job.
   process
      type pattern_type is record
         --  The inputs of the ram8.
        d       : std_logic_vector(15 downto 0);
        load    : std_logic;
        address : std_logic_vector(2 downto 0);
        --  The output of the ram8.
        cout    : std_logic_vector(15 downto 0);
      end record;
      --  The patterns to apply.
      type pattern_array is array (natural range <>) of pattern_type;
      constant patterns : pattern_array :=
        (("0000000000000000", '0', "000", "0000000000000000"),
         ("0000000000000000", '0', "000", "0000000000000000"),
         ("0000000000000000", '1', "000", "0000000000000000"),
         ("0000000000000000", '1', "000", "0000000000000000"),
         ("0010101101100111", '0', "000", "0000000000000000"),
         ("0010101101100111", '0', "000", "0000000000000000"),
         ("0010101101100111", '1', "001", "0000000000000000"),
         ("0010101101100111", '1', "001", "0010101101100111"),
         ("0010101101100111", '0', "000", "0000000000000000"),
         ("0010101101100111", '0', "000", "0000000000000000"),
         ("0000110100000101", '0', "011", "0000000000000000"),
         ("0000110100000101", '0', "011", "0000000000000000"),
         ("0000110100000101", '1', "011", "0000000000000000"),
         ("0000110100000101", '1', "011", "0000110100000101"),
         ("0000110100000101", '0', "011", "0000110100000101"),
         ("0000110100000101", '0', "011", "0000110100000101"),
         ("0000110100000101", '0', "001", "0010101101100111"),
         ("0001111001100001", '0', "001", "0010101101100111"),
         ("0001111001100001", '0', "001", "0010101101100111"),
         ("0001111001100001", '1', "111", "0000000000000000"),
         ("0001111001100001", '1', "111", "0001111001100001"),
         ("0001111001100001", '0', "111", "0001111001100001"),
         ("0001111001100001", '0', "111", "0001111001100001"),
         ("0001111001100001", '0', "011", "0000110100000101"),
         ("0001111001100001", '0', "111", "0001111001100001"),
         ("0001111001100001", '0', "000", "0000000000000000"),
         ("0001111001100001", '0', "000", "0000000000000000"),
         ("0001111001100001", '0', "001", "0010101101100111"),
         ("0001111001100001", '0', "010", "0000000000000000"),
         ("0001111001100001", '0', "011", "0000110100000101"),
         ("0001111001100001", '0', "100", "0000000000000000"),
         ("0001111001100001", '0', "101", "0000000000000000"),
         ("0001111001100001", '0', "110", "0000000000000000"),
         ("0001111001100001", '0', "111", "0001111001100001"),
         ("0101010101010101", '1', "000", "0000000000000000"),
         ("0101010101010101", '1', "000", "0101010101010101"),
         ("0101010101010101", '1', "001", "0010101101100111"),
         ("0101010101010101", '1', "001", "0101010101010101"),
         ("0101010101010101", '1', "010", "0000000000000000"),
         ("0101010101010101", '1', "010", "0101010101010101"),
         ("0101010101010101", '1', "011", "0000110100000101"),
         ("0101010101010101", '1', "011", "0101010101010101"),
         ("0101010101010101", '1', "100", "0000000000000000"),
         ("0101010101010101", '1', "100", "0101010101010101"),
         ("0101010101010101", '1', "101", "0000000000000000"),
         ("0101010101010101", '1', "101", "0101010101010101"),
         ("0101010101010101", '1', "110", "0000000000000000"),
         ("0101010101010101", '1', "110", "0101010101010101"),
         ("0101010101010101", '1', "111", "0001111001100001"),
         ("0101010101010101", '1', "111", "0101010101010101"),
         ("0101010101010101", '0', "000", "0101010101010101"),
         ("0101010101010101", '0', "000", "0101010101010101"),
         ("0101010101010101", '0', "001", "0101010101010101"),
         ("0101010101010101", '0', "010", "0101010101010101"),
         ("0101010101010101", '0', "011", "0101010101010101"),
         ("0101010101010101", '0', "100", "0101010101010101"),
         ("0101010101010101", '0', "101", "0101010101010101"),
         ("0101010101010101", '0', "110", "0101010101010101"),
         ("0101010101010101", '0', "111", "0101010101010101"),
         ("0101010101010110", '1', "000", "0101010101010101"),
         ("0101010101010110", '1', "000", "0101010101010110"),
         ("0101010101010110", '0', "000", "0101010101010110"),
         ("0101010101010110", '0', "000", "0101010101010110"),
         ("0101010101010110", '0', "001", "0101010101010101"),
         ("0101010101010110", '0', "010", "0101010101010101"),
         ("0101010101010110", '0', "011", "0101010101010101"),
         ("0101010101010110", '0', "100", "0101010101010101"),
         ("0101010101010110", '0', "101", "0101010101010101"),
         ("0101010101010110", '0', "110", "0101010101010101"),
         ("0101010101010110", '0', "111", "0101010101010101"),
         ("0101010101010101", '1', "000", "0101010101010110"),
         ("0101010101010101", '1', "000", "0101010101010101"),
         ("0101010101010110", '1', "001", "0101010101010101"),
         ("0101010101010110", '1', "001", "0101010101010110"),
         ("0101010101010110", '0', "000", "0101010101010101"),
         ("0101010101010110", '0', "000", "0101010101010101"),
         ("0101010101010110", '0', "001", "0101010101010110"),
         ("0101010101010110", '0', "010", "0101010101010101"),
         ("0101010101010110", '0', "011", "0101010101010101"),
         ("0101010101010110", '0', "100", "0101010101010101"),
         ("0101010101010110", '0', "101", "0101010101010101"),
         ("0101010101010110", '0', "110", "0101010101010101"),
         ("0101010101010110", '0', "111", "0101010101010101"),
         ("0101010101010101", '1', "001", "0101010101010110"),
         ("0101010101010101", '1', "001", "0101010101010101"),
         ("0101010101010110", '1', "010", "0101010101010101"),
         ("0101010101010110", '1', "010", "0101010101010110"),
         ("0101010101010110", '0', "000", "0101010101010101"),
         ("0101010101010110", '0', "000", "0101010101010101"),
         ("0101010101010110", '0', "001", "0101010101010101"),
         ("0101010101010110", '0', "010", "0101010101010110"),
         ("0101010101010110", '0', "011", "0101010101010101"),
         ("0101010101010110", '0', "100", "0101010101010101"),
         ("0101010101010110", '0', "101", "0101010101010101"),
         ("0101010101010110", '0', "110", "0101010101010101"),
         ("0101010101010110", '0', "111", "0101010101010101"),
         ("0101010101010101", '1', "010", "0101010101010110"),
         ("0101010101010101", '1', "010", "0101010101010101"),
         ("0101010101010110", '1', "011", "0101010101010101"),
         ("0101010101010110", '1', "011", "0101010101010110"),
         ("0101010101010110", '0', "000", "0101010101010101"),
         ("0101010101010110", '0', "000", "0101010101010101"),
         ("0101010101010110", '0', "001", "0101010101010101"),
         ("0101010101010110", '0', "010", "0101010101010101"),
         ("0101010101010110", '0', "011", "0101010101010110"),
         ("0101010101010110", '0', "100", "0101010101010101"),
         ("0101010101010110", '0', "101", "0101010101010101"),
         ("0101010101010110", '0', "110", "0101010101010101"),
         ("0101010101010110", '0', "111", "0101010101010101"),
         ("0101010101010101", '1', "011", "0101010101010110"),
         ("0101010101010101", '1', "011", "0101010101010101"),
         ("0101010101010110", '1', "100", "0101010101010101"),
         ("0101010101010110", '1', "100", "0101010101010110"),
         ("0101010101010110", '0', "000", "0101010101010101"),
         ("0101010101010110", '0', "000", "0101010101010101"),
         ("0101010101010110", '0', "001", "0101010101010101"),
         ("0101010101010110", '0', "010", "0101010101010101"),
         ("0101010101010110", '0', "011", "0101010101010101"),
         ("0101010101010110", '0', "100", "0101010101010110"),
         ("0101010101010110", '0', "101", "0101010101010101"),
         ("0101010101010110", '0', "110", "0101010101010101"),
         ("0101010101010110", '0', "111", "0101010101010101"),
         ("0101010101010101", '1', "100", "0101010101010110"),
         ("0101010101010101", '1', "100", "0101010101010101"),
         ("0101010101010110", '1', "101", "0101010101010101"),
         ("0101010101010110", '1', "101", "0101010101010110"),
         ("0101010101010110", '0', "000", "0101010101010101"),
         ("0101010101010110", '0', "000", "0101010101010101"),
         ("0101010101010110", '0', "001", "0101010101010101"),
         ("0101010101010110", '0', "010", "0101010101010101"),
         ("0101010101010110", '0', "011", "0101010101010101"),
         ("0101010101010110", '0', "100", "0101010101010101"),
         ("0101010101010110", '0', "101", "0101010101010110"),
         ("0101010101010110", '0', "110", "0101010101010101"),
         ("0101010101010110", '0', "111", "0101010101010101"),
         ("0101010101010101", '1', "101", "0101010101010110"),
         ("0101010101010101", '1', "101", "0101010101010101"),
         ("0101010101010110", '1', "110", "0101010101010101"),
         ("0101010101010110", '1', "110", "0101010101010110"),
         ("0101010101010110", '0', "000", "0101010101010101"),
         ("0101010101010110", '0', "000", "0101010101010101"),
         ("0101010101010110", '0', "001", "0101010101010101"),
         ("0101010101010110", '0', "010", "0101010101010101"),
         ("0101010101010110", '0', "011", "0101010101010101"),
         ("0101010101010110", '0', "100", "0101010101010101"),
         ("0101010101010110", '0', "101", "0101010101010101"),
         ("0101010101010110", '0', "110", "0101010101010110"),
         ("0101010101010110", '0', "111", "0101010101010101"),
         ("0101010101010101", '1', "110", "0101010101010110"),
         ("0101010101010101", '1', "110", "0101010101010101"),
         ("0101010101010110", '1', "111", "0101010101010101"),
         ("0101010101010110", '1', "111", "0101010101010110"),
         ("0101010101010110", '0', "000", "0101010101010101"),
         ("0101010101010110", '0', "000", "0101010101010101"),
         ("0101010101010110", '0', "001", "0101010101010101"),
         ("0101010101010110", '0', "010", "0101010101010101"),
         ("0101010101010110", '0', "011", "0101010101010101"),
         ("0101010101010110", '0', "100", "0101010101010101"),
         ("0101010101010110", '0', "101", "0101010101010101"),
         ("0101010101010110", '0', "110", "0101010101010101"),
         ("0101010101010110", '0', "111", "0101010101010110"),
         ("0101010101010101", '1', "111", "0101010101010110"),
         ("0101010101010101", '1', "111", "0101010101010101"),
         ("0101010101010101", '0', "000", "0101010101010101"),
         ("0101010101010101", '0', "000", "0101010101010101"),
         ("0101010101010101", '0', "001", "0101010101010101"),
         ("0101010101010101", '0', "010", "0101010101010101"),
         ("0101010101010101", '0', "011", "0101010101010101"),
         ("0101010101010101", '0', "100", "0101010101010101"),
         ("0101010101010101", '0', "101", "0101010101010101"),
         ("0101010101010101", '0', "110", "0101010101010101"),
         ("0101010101010101", '0', "111", "0101010101010101"));
         
   begin
      --  Check each pattern.
      for i in patterns'range loop
         --  Set the inputs.
        d <= patterns(i).d;
        load <= patterns(i).load;
        address <= patterns(i).address;
        wait for 0.25 ns;
        --  Check the outputs.
        assert cout = patterns(i).cout
          report "bad data, memory problem" severity error;
        wait for 0.75 ns;
     end loop;
     -- End the clock
     finish <= '1';
     assert false report "end of test" severity note;
     --  Wait forever; this will finish the simulation.
     wait;
  end process;
end ram8_tb_arch;
