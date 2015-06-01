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

-- File: clock_tb.vhdl
-- Author: Collin J. Doering <collin.doering@rekahsoft.ca>
-- Date: May 22, 2015

library IEEE;
use IEEE.std_logic_1164.all;

--  A testbench has no ports.
entity clock_tb is
end clock_tb;

architecture clock_tb_arch of clock_tb is
   --  Declaration of the component that will be instantiated.
   component clock
     generic (freq : real := 1000000000.0);
     port (finish : in  std_logic;
           cout   : out std_logic);
   end component;

   --  Specifies which entity is bound with the component.
   for clock_0: clock use entity work.clock;

   -- Signals
   signal finish, finish_1, cout, cout_1 : std_logic;
begin
  --  Component instantiation.
   clock_0: clock port map (finish, cout);
   clock_1: clock generic map (freq => 1000000.0)
                  port map (finish_1, cout_1);

   --  This process does the real job.
   process
      type pattern_type is record
         --  The inputs of the clock.
         finish : std_logic;
         --  The output of the clock.
         cout : std_logic;
      end record;
      --  The patterns to apply.
      type pattern_array is array (natural range <>) of pattern_type;
      constant patterns : pattern_array :=
        (('0', '0'),
         ('0', '1'),
         ('0', '0'),
         ('0', '1'),
         ('0', '0'),
         ('0', '1'),
         ('0', '0'),
         ('0', '1'),

         ('1', '0'),
         ('1', '0'),
         ('1', '0'),
         ('1', '0'),
         ('1', '0'),
         ('1', '0'),
         ('1', '0'),
         ('1', '0'),
         ('0', '0'),
         ('0', '1'),
         ('0', '0'),
         ('0', '1'),

         ('0', '0'),
         ('0', '1'),
         ('0', '0'),
         ('0', '1'),
         ('0', '0'),
         ('0', '1'),
         ('0', '0'),
         
         ('1', '0'),
         ('1', '0'),
         ('1', '0'),
         ('1', '0'),
         ('1', '0'),
         ('1', '0'),
         ('1', '0'),
         ('1', '0'),
         ('0', '0'),
         ('0', '1'),
         ('0', '0'),
         ('0', '1'));
         
   begin
      -- Set 1 MHz clock 'on'
      finish_1 <= '0';

      --  Check each pattern. Tests whether the finish bit works correctly.
      for i in patterns'range loop
         --  Set the inputs.
         finish <= patterns(i).finish;
         wait for 0.1 ns;
         --  Check the outputs.
         assert cout = patterns(i).cout
           report "bad clock" severity error;
         wait for 0.4 ns;
      end loop;

      -- Wait for an additional 1 ms
      wait for 1 ms;

      -- End the clocks
      finish <= '1';
      finish_1 <= '1';

      assert false report "end of test" severity note;
      --  Wait forever; this will finish the simulation.
      wait;
   end process;
end clock_tb_arch;
