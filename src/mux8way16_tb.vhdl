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

-- File: mux8way16_tb.vhdl
-- Author: Collin J. Doering <collin.doering@rekahsoft.ca>
-- Date: May 22, 2015

library IEEE;
use IEEE.std_logic_1164.all;

--  A testbench has no ports.
entity mux8way16_tb is
end mux8way16_tb;

architecture mux8way16_tb_arch of mux8way16_tb is
   --  Declaration of the component that will be instantiated.
   component mux8way16
     port (a, b, c, d, e, f, g, h : in  std_logic_vector(15 downto 0);
           sel                    : in  std_logic_vector(2 downto 0);
           cout                   : out std_logic_vector(15 downto 0));
   end component;

   --  Specifies which entity is bound with the component.
   for mux8way16_0: mux8way16 use entity work.mux8way16;

   -- Signals
   signal a, b, c, d, e, f, g, h, cout : std_logic_vector(15 downto 0);
   signal sel : std_logic_vector(2 downto 0);
begin
   --  Component instantiation.
   mux8way16_0: mux8way16 port map (a, b, c, d, e, f, g, h, sel, cout);

   --  This process does the real job.
   process
      type pattern_type is record
         --  The inputs of the mux8way16.
        a, b, c, d, e, f, g, h : std_logic_vector(15 downto 0);
        sel                    : std_logic_vector(2 downto 0);
        --  The expected outputs of the mux8way16.
        cout : std_logic_vector(15 downto 0);
      end record;
      --  The patterns to apply.
      type pattern_array is array (natural range <>) of pattern_type;
      constant patterns : pattern_array :=
        (("0000000000000000", "0000000000000000", "0000000000000000", "0000000000000000", "0000000000000000", "0000000000000000", "0000000000000000", "0000000000000000", "000", "0000000000000000"),
         ("0000000000000000", "0000000000000000", "0000000000000000", "0000000000000000", "0000000000000000", "0000000000000000", "0000000000000000", "0000000000000000", "001", "0000000000000000"),
         ("0000000000000000", "0000000000000000", "0000000000000000", "0000000000000000", "0000000000000000", "0000000000000000", "0000000000000000", "0000000000000000", "010", "0000000000000000"),
         ("0000000000000000", "0000000000000000", "0000000000000000", "0000000000000000", "0000000000000000", "0000000000000000", "0000000000000000", "0000000000000000", "011", "0000000000000000"),
         ("0000000000000000", "0000000000000000", "0000000000000000", "0000000000000000", "0000000000000000", "0000000000000000", "0000000000000000", "0000000000000000", "100", "0000000000000000"),
         ("0000000000000000", "0000000000000000", "0000000000000000", "0000000000000000", "0000000000000000", "0000000000000000", "0000000000000000", "0000000000000000", "101", "0000000000000000"),
         ("0000000000000000", "0000000000000000", "0000000000000000", "0000000000000000", "0000000000000000", "0000000000000000", "0000000000000000", "0000000000000000", "110", "0000000000000000"),
         ("0000000000000000", "0000000000000000", "0000000000000000", "0000000000000000", "0000000000000000", "0000000000000000", "0000000000000000", "0000000000000000", "111", "0000000000000000"),
         ("0001001000110100", "0010001101000101", "0011010001010110", "0100010101100111", "0101011001111000", "0110011110001001", "0111100010011010", "1000100110101011", "000", "0001001000110100"),
         ("0001001000110100", "0010001101000101", "0011010001010110", "0100010101100111", "0101011001111000", "0110011110001001", "0111100010011010", "1000100110101011", "001", "0010001101000101"),
         ("0001001000110100", "0010001101000101", "0011010001010110", "0100010101100111", "0101011001111000", "0110011110001001", "0111100010011010", "1000100110101011", "010", "0011010001010110"),
         ("0001001000110100", "0010001101000101", "0011010001010110", "0100010101100111", "0101011001111000", "0110011110001001", "0111100010011010", "1000100110101011", "011", "0100010101100111"),
         ("0001001000110100", "0010001101000101", "0011010001010110", "0100010101100111", "0101011001111000", "0110011110001001", "0111100010011010", "1000100110101011", "100", "0101011001111000"),
         ("0001001000110100", "0010001101000101", "0011010001010110", "0100010101100111", "0101011001111000", "0110011110001001", "0111100010011010", "1000100110101011", "101", "0110011110001001"),
         ("0001001000110100", "0010001101000101", "0011010001010110", "0100010101100111", "0101011001111000", "0110011110001001", "0111100010011010", "1000100110101011", "110", "0111100010011010"),
         ("0001001000110100", "0010001101000101", "0011010001010110", "0100010101100111", "0101011001111000", "0110011110001001", "0111100010011010", "1000100110101011", "111", "1000100110101011"));
   begin
      --  Check each pattern.
      for i in patterns'range loop
         --  Set the inputs.
         a <= patterns(i).a;
         b <= patterns(i).b;
         c <= patterns(i).c;
         d <= patterns(i).d;
         e <= patterns(i).e;
         f <= patterns(i).f;
         g <= patterns(i).g;
         h <= patterns(i).h;
         sel <= patterns(i).sel;
         --  Wait for the results.
         wait for 1 ns;
         --  Check the outputs.
         assert cout = patterns(i).cout
            report "bad mux8way16 output" severity error;
      end loop;
      assert false report "end of test" severity note;
      --  Wait forever; this will finish the simulation.
      wait;
   end process;
end mux8way16_tb_arch;
