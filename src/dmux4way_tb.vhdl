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

-- File: dmux4way_tb.vhdl
-- Author: Collin J. Doering <collin.doering@rekahsoft.ca>
-- Date: May 22, 2015

library IEEE;
use IEEE.std_logic_1164.all;

--  A testbench has no ports.
entity dmux4way_tb is
end dmux4way_tb;

architecture dmux4way_tb_arch of dmux4way_tb is
   --  Declaration of the component that will be instantiated.
   component dmux4way
     port (cin        : in std_logic;
           sel        : in std_logic_vector(1 downto 0);
           a, b, c, d : out std_logic);
   end component;

   --  Specifies which entity is bound with the component.
   for dmux4way_0: dmux4way use entity work.dmux4way;

   -- Signals
   signal cin, a, b, c, d : std_logic;
   signal sel : std_logic_vector(1 downto 0);
begin
   --  Component instantiation.
   dmux4way_0: dmux4way port map (cin, sel, a, b, c, d);

   --  This process does the real job.
   process
      type pattern_type is record
         --  The inputs of the dmux4way.
         cin : std_logic;
         sel : std_logic_vector(1 downto 0);
         --  The expected outputs of the dmux4way.
         a, b, c, d : std_logic;
      end record;
      --  The patterns to apply.
      type pattern_array is array (natural range <>) of pattern_type;
      constant patterns : pattern_array :=
        (('0', "00", '0', '0', '0', '0'),
         ('0', "01", '0', '0', '0', '0'),
         ('0', "10", '0', '0', '0', '0'),
         ('0', "11", '0', '0', '0', '0'),
         ('1', "00", '1', '0', '0', '0'),
         ('1', "01", '0', '1', '0', '0'),
         ('1', "10", '0', '0', '1', '0'),
         ('1', "11", '0', '0', '0', '1'));
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
            report "bad dmux4way" severity error;
         assert b = patterns(i).b
           report "bad dmux4way" severity error;
         assert c = patterns(i).c
           report "bad dmux4way" severity error;
         assert d = patterns(i).d
            report "bad dmux4way" severity error;         
      end loop;
      assert false report "end of test" severity note;
      --  Wait forever; this will finish the simulation.
      wait;
   end process;
end dmux4way_tb_arch;
