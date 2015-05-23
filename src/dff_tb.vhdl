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

-- File: dff_tb.vhdl
-- Author: Collin J. Doering <collin.doering@rekahsoft.ca>
-- Date: May 22, 2015

library IEEE;
use IEEE.std_logic_1164.all;

--  A testbench has no ports.
entity dff_tb is
end dff_tb;

architecture dff_tb_arch of dff_tb is
   --  Declaration of the component that will be instantiated.
   component dff
     port (d, clk : in  std_logic;
           cout   : out std_logic);
   end component;

   -- Declaration of the clock
   component Clock
     port (finish : in  std_logic;
           cout   : out std_logic);
   end component;

   --  Specifies which entity is bound with the component.
   for dff_0: dff use entity work.dff;

   -- Signals
   signal d, finish, clk, cout : std_logic;
begin
  --  Component instantiation.
  OSC_CLK: Clock port map (finish, clk);
  dff_0: dff port map (d, clk, cout);

   --  This process does the real job.
   process
      type pattern_type is record
         --  The inputs of the dff.
         d : std_logic;
         --  The output of the dff.
         cout : std_logic;
      end record;
      --  The patterns to apply.
      type pattern_array is array (natural range <>) of pattern_type;
      constant patterns : pattern_array :=
        (('0', '0'),
         ('1', '0'),
         ('1', '1'),
         ('0', '1'),
         ('0', '0'),
         ('1', '0'),
         ('0', '1'));
         
   begin
      --  Check each pattern.
      for i in patterns'range loop
         --  Set the inputs.
         d <= patterns(i).d;
         wait for 0.25 ns;
         --  Check the outputs.
         assert cout = patterns(i).cout
           report "bad data; nothing remembered" severity error;
         wait for 0.75 ns;
      end loop;
      -- End the clock
      finish <= '1';
      assert false report "end of test" severity note;
      --  Wait forever; this will finish the simulation.
      wait;
   end process;
end dff_tb_arch;
