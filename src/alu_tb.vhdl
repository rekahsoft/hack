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

-- File: alu_tb.vhdl
-- Author: Collin J. Doering <collin.doering@rekahsoft.ca>
-- Date: May 22, 2015

library IEEE;
use IEEE.std_logic_1164.all;

--  A testbench has no ports.
entity alu_tb is
end alu_tb;

architecture alu_tb_arch of alu_tb is
   --  Declaration of the component that will be instantiated.
   component alu
     port (x, y                  : in  std_logic_vector(15 downto 0);
           zx, nx, zy, ny, f, no : in  std_logic;
           cout                  : out std_logic_vector(15 downto 0);
           zr, ng                : out std_logic);
   end component;

   --  Specifies which entity is bound with the component.
   for alu_0: alu use entity work.alu;

   -- Signals
   signal x, y, cout : std_logic_vector(15 downto 0);
   signal zx, nx, zy, ny, f, no, zr, ng : std_logic;
begin
   --  Component instantiation.
   alu_0: alu port map (x, y, zx, nx, zy, ny, f, no, cout, zr, ng);

   --  This process does the real job.
   process
      type pattern_type is record
        --  The inputs of the alu.
        x, y                  : std_logic_vector(15 downto 0);
        zx, nx, zy, ny, f, no : std_logic;
        --  The expected outputs of the alu.
        cout                  : std_logic_vector(15 downto 0);
        zr, ng                : std_logic;
      end record;
      --  The patterns to apply.
      type pattern_array is array (natural range <>) of pattern_type;
      constant patterns : pattern_array :=
        (("0000000000000000", "1111111111111111", '1', '0', '1', '0', '1', '0', "0000000000000000", '1', '0'),
         ("0000000000000000", "1111111111111111", '1', '1', '1', '1', '1', '1', "0000000000000001", '0', '0'),
         ("0000000000000000", "1111111111111111", '1', '1', '1', '0', '1', '0', "1111111111111111", '0', '1'),
         ("0000000000000000", "1111111111111111", '0', '0', '1', '1', '0', '0', "0000000000000000", '1', '0'),
         ("0000000000000000", "1111111111111111", '1', '1', '0', '0', '0', '0', "1111111111111111", '0', '1'),
         ("0000000000000000", "1111111111111111", '0', '0', '1', '1', '0', '1', "1111111111111111", '0', '1'),
         ("0000000000000000", "1111111111111111", '1', '1', '0', '0', '0', '1', "0000000000000000", '1', '0'),
         ("0000000000000000", "1111111111111111", '0', '0', '1', '1', '1', '1', "0000000000000000", '1', '0'),
         ("0000000000000000", "1111111111111111", '1', '1', '0', '0', '1', '1', "0000000000000001", '0', '0'),
         ("0000000000000000", "1111111111111111", '0', '1', '1', '1', '1', '1', "0000000000000001", '0', '0'),
         ("0000000000000000", "1111111111111111", '1', '1', '0', '1', '1', '1', "0000000000000000", '1', '0'),
         ("0000000000000000", "1111111111111111", '0', '0', '1', '1', '1', '0', "1111111111111111", '0', '1'),
         ("0000000000000000", "1111111111111111", '1', '1', '0', '0', '1', '0', "1111111111111110", '0', '1'),
         ("0000000000000000", "1111111111111111", '0', '0', '0', '0', '1', '0', "1111111111111111", '0', '1'),
         ("0000000000000000", "1111111111111111", '0', '1', '0', '0', '1', '1', "0000000000000001", '0', '0'),
         ("0000000000000000", "1111111111111111", '0', '0', '0', '1', '1', '1', "1111111111111111", '0', '1'),
         ("0000000000000000", "1111111111111111", '0', '0', '0', '0', '0', '0', "0000000000000000", '1', '0'),
         ("0000000000000000", "1111111111111111", '0', '1', '0', '1', '0', '1', "1111111111111111", '0', '1'),
         ("0000000000010001", "0000000000000011", '1', '0', '1', '0', '1', '0', "0000000000000000", '1', '0'),
         ("0000000000010001", "0000000000000011", '1', '1', '1', '1', '1', '1', "0000000000000001", '0', '0'),
         ("0000000000010001", "0000000000000011", '1', '1', '1', '0', '1', '0', "1111111111111111", '0', '1'),
         ("0000000000010001", "0000000000000011", '0', '0', '1', '1', '0', '0', "0000000000010001", '0', '0'),
         ("0000000000010001", "0000000000000011", '1', '1', '0', '0', '0', '0', "0000000000000011", '0', '0'),
         ("0000000000010001", "0000000000000011", '0', '0', '1', '1', '0', '1', "1111111111101110", '0', '1'),
         ("0000000000010001", "0000000000000011", '1', '1', '0', '0', '0', '1', "1111111111111100", '0', '1'),
         ("0000000000010001", "0000000000000011", '0', '0', '1', '1', '1', '1', "1111111111101111", '0', '1'),
         ("0000000000010001", "0000000000000011", '1', '1', '0', '0', '1', '1', "1111111111111101", '0', '1'),
         ("0000000000010001", "0000000000000011", '0', '1', '1', '1', '1', '1', "0000000000010010", '0', '0'),
         ("0000000000010001", "0000000000000011", '1', '1', '0', '1', '1', '1', "0000000000000100", '0', '0'),
         ("0000000000010001", "0000000000000011", '0', '0', '1', '1', '1', '0', "0000000000010000", '0', '0'),
         ("0000000000010001", "0000000000000011", '1', '1', '0', '0', '1', '0', "0000000000000010", '0', '0'),
         ("0000000000010001", "0000000000000011", '0', '0', '0', '0', '1', '0', "0000000000010100", '0', '0'),
         ("0000000000010001", "0000000000000011", '0', '1', '0', '0', '1', '1', "0000000000001110", '0', '0'),
         ("0000000000010001", "0000000000000011", '0', '0', '0', '1', '1', '1', "1111111111110010", '0', '1'),
         ("0000000000010001", "0000000000000011", '0', '0', '0', '0', '0', '0', "0000000000000001", '0', '0'),
         ("0000000000010001", "0000000000000011", '0', '1', '0', '1', '0', '1', "0000000000010011", '0', '0'));
   begin
      --  Check each pattern.
      for i in patterns'range loop
         --  Set the inputs.
         x <= patterns(i).x;
         y <= patterns(i).y;
         zx <= patterns(i).zx;
         nx <= patterns(i).nx;
         zy <= patterns(i).zy;
         ny <= patterns(i).ny;
         f <= patterns(i).f;
         no <= patterns(i).no;
         --  Wait for the results.
         wait for 1 ns;
         --  Check the outputs.
         assert cout = patterns(i).cout
           report "bad alu output" severity error;
         assert zr = patterns(i).zr
           report "bad alu zr control bit output" severity error;
         assert ng = patterns(i).ng
            report "bad alu ng control bit output" severity error;
      end loop;
      assert false report "end of test" severity note;
      --  Wait forever; this will finish the simulation.
      wait;
   end process;
end alu_tb_arch;
