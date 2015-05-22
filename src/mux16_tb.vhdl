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

-- File: mux16_tb.vhdl
-- Author: Collin J. Doering <collin.doering@rekahsoft.ca>
-- Date: May 22, 2015

library IEEE;
use IEEE.std_logic_1164.all;

--  A testbench has no ports.
entity mux16_tb is
end mux16_tb;

architecture mux16_tb_arch of mux16_tb is
   --  Declaration of the component that will be instantiated.
   component mux16
     port (a, b : in  std_logic_vector(15 downto 0);
           sel  : in  std_logic;
           cout : out std_logic_vector(15 downto 0));
   end component;

   --  Specifies which entity is bound with the component.
   for mux16_0: mux16 use entity work.mux16;

   -- Signals
   signal a, b, cout : std_logic_vector(15 downto 0);
   signal sel : std_logic;
begin
   --  Component instantiation.
   mux16_0: mux16 port map (a => a, b => b, sel => sel, cout => cout);

   --  This process does the real job.
   process
      type pattern_type is record
         --  The inputs of the mux16.
        a, b : std_logic_vector(15 downto 0);
        sel  : std_logic;
        --  The expected outputs of the mux16.
        cout : std_logic_vector(15 downto 0);
      end record;
      --  The patterns to apply.
      type pattern_array is array (natural range <>) of pattern_type;
      constant patterns : pattern_array :=
        (("0000000000000000", "0000000000000001", '0', "0000000000000000"),
         ("0000000000000001", "0000000000000000", '1', "0000000000000000"),
         ("0000000000000000", "1111111111111111", '0', "0000000000000000"),
         ("0000000000000000", "1111111111111111", '1', "1111111111111111"),
         ("1111111111111111", "0000000000000000", '0', "1111111111111111"),
         ("1111111111111111", "0000000000000000", '1', "0000000000000000"),
         ("1111111111111111", "1111111111111110", '0', "1111111111111111"),
         ("1111111111111110", "1111111111111111", '1', "1111111111111111"));
   begin
      --  Check each pattern.
      for i in patterns'range loop
         --  Set the inputs.
         a <= patterns(i).a;
         b <= patterns(i).b;
         sel <= patterns(i).sel;
         --  Wait for the results.
         wait for 1 ns;
         --  Check the outputs.
         assert cout = patterns(i).cout
            report "bad mux16 output" severity error;
      end loop;
      assert false report "end of test" severity note;
      --  Wait forever; this will finish the simulation.
      wait;
   end process;
end mux16_tb_arch;
