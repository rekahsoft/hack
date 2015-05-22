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

-- File: dmux_tb.vhdl
-- Author: Collin J. Doering <collin.doering@rekahsoft.ca>
-- Date: May 22, 2015

library IEEE;
use IEEE.std_logic_1164.all;

--  A testbench has no ports.
entity dmux_tb is
end dmux_tb;

architecture dmux_tb_arch of dmux_tb is
   --  Declaration of the component that will be instantiated.
   component dmux
     port (cin, sel : in  std_logic;
           a, b     : out std_logic);
   end component;

   --  Specifies which entity is bound with the component.
   for dmux_0: dmux use entity work.dmux;

   -- Signals
   signal cin, sel, a, b : std_logic;
begin
   --  Component instantiation.
   dmux_0: dmux port map (cin, sel, a, b);

   --  This process does the real job.
   process
      type pattern_type is record
         --  The inputs of the dmux.
         cin, sel : std_logic;
         --  The expected outputs of the dmux.
         a, b : std_logic;
      end record;
      --  The patterns to apply.
      type pattern_array is array (natural range <>) of pattern_type;
      constant patterns : pattern_array :=
        (('0', '0', '0', '0'),
         ('0', '1', '0', '0'),
         ('1', '0', '1', '0'),
         ('1', '1', '0', '1'));
   begin
      --  Check each pattern.
      for i in patterns'range loop
         --  Set the inputs.
         cin <= patterns(i).cin;
         sel <= patterns(i).sel;
         --  Wait for the results.
         wait for 1 ns;
         --  Check the outputs.
         assert a = patterns(i).a
            report "bad dmux" severity error;
         assert b = patterns(i).b
            report "bad dmux" severity error;
      end loop;
      assert false report "end of test" severity note;
      --  Wait forever; this will finish the simulation.
      wait;
   end process;
end dmux_tb_arch;
