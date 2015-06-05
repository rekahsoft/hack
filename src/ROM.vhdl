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

-- File: ROM.vhdl
-- Author: Collin J. Doering <collin.doering@rekahsoft.ca>
-- Date: May 22, 2015
-- Description: ROM chip which reads a text file containing 16 bit binary cpu
--              instructions per line and emulates a ROM. The first line
--              of the text file correspond to ROM address 0x0, and every line
--              there after refers to one plus the address of the previous line.
--              The file can contain a maxiumum of (2^15 - 1) lines, and if the
--              last line number `n` of the file is less then the maximum,
--              every memory location from (n - 1) to the maximum contains 0x0000.

library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.numeric_std.all;
use std.textio.all;

entity ROM is
  generic (program_file : string := "asm/Fib.hack");
  port (address : in  std_logic_vector(14 downto 0);
        clk     : in  std_logic;
        cout    : out std_logic_vector(15 downto 0));
end ROM;

architecture ROM_arch of ROM is
  type rom_type is array (integer range <>) of std_logic_vector(15 downto 0);
begin
  -- Load rom_data array with program data
  process (clk)
    function to_string (arg : std_logic_vector) return string is
       variable result : string (1 to arg'length);
       variable v : std_logic_vector (result'range) := arg;
    begin
       for i in result'range loop
          case v(i) is
             when 'U' =>
                result(i) := 'U';
             when 'X' =>
                result(i) := 'X';
             when '0' =>
                result(i) := '0';
             when '1' =>
                result(i) := '1';
             when 'Z' =>
                result(i) := 'Z';
             when 'W' =>
                result(i) := 'W';
             when 'L' =>
                result(i) := 'L';
             when 'H' =>
                result(i) := 'H';
             when '-' =>
                result(i) := '-';
          end case;
       end loop;
       return result;
    end;


    variable program_line : line;
    variable program_line_vec : bit_vector(15 downto 0);
    variable program_line_num : integer := 0;
    file program : text is in program_file;

    variable rom_data : rom_type(0 to 65535) := (others => "0000000000000000");
    variable has_not_loaded : boolean := true;
  begin
    while (has_not_loaded and (not endfile(program))) loop
      readline (program, program_line);
      read (program_line, program_line_vec);
      rom_data(program_line_num) := to_stdLogicVector(program_line_vec);
      assert false report ("line " & integer'image(program_line_num) & " containing '" & to_string(rom_data(program_line_num)) & " processed.") severity note;
      program_line_num := program_line_num + 1;
    end loop;
    if has_not_loaded then
      cout <= rom_data(0);
      has_not_loaded := false;
    elsif (falling_edge(clk)) then
      cout <= rom_data(to_integer(unsigned(address)));
    end if;
  end process;
end ROM_arch;
