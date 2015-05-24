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

-- File: cpu.vhdl
-- Author: cpu.vhdl
-- Date: May 22, 2015

library IEEE;
use IEEE.std_logic_1164.all;

entity cpu is
  port (inM, instruction : in  std_logic_vector(15 downto 0);
        reset, clk       : in  std_logic;
        outM             : out std_logic_vector(15 downto 0);
        writeM           : out std_logic;
        addressM, pcOut  : out std_logic_vector(14 downto 0));
end cpu;

architecture cpu_arch of cpu is
   component dregister
     port (d : in std_logic_vector(15 downto 0);
           load, clk : in std_logic;
           cout : out std_logic_vector(15 downto 0));
   end component;

   component pc
     port (d                     : in std_logic_vector(15 downto 0);
           load, inc, reset, clk : in std_logic;
           cout                  : out std_logic_vector(15 downto 0));
   end component;

   component alu
     port (x, y : in std_logic_vector(15 downto 0);
           zx, nx, zy, ny, f, no : in std_logic;
           cout : out std_logic_vector(15 downto 0);
           zr, ng : out std_logic);
   end component;

   component mux16
     port (a, b : in std_logic_vector(15 downto 0);
           sel  : in std_logic;
           cout : out std_logic_vector(15 downto 0));
   end component;

   component mux
     port (a, b, sel : in std_logic;
           cout      : out std_logic);
   end component;

   alias instr     : std_logic is instruction(15);
   alias opOnM     : std_logic is instruction(12);
   alias aluInstr  : std_logic_vector(5 downto 0) is instruction(11 downto 6);
   alias dest      : std_logic_vector(2 downto 0) is instruction(5 downto 3);
   alias jump      : std_logic_vector(2 downto 0) is instruction(2 downto 0);

   signal mux0, aluOut, regAOut, memToALU, regDOut, pctmp : std_logic_vector(15 downto 0);
   signal notInstr, dandc, regALoad, zr, ng, doJump, doJumpNot : std_logic;

begin
  notInstr <= not instr;
  mux16_0: mux16 port map (aluOut, instruction, notInstr, mux0);
  
  mux_0: mux port map (notInstr, dest(2), instr, regALoad);
  regA: dregister port map (mux0, regALoad, clk, regAOut);

  mux16_1: mux16 port map (regAOut, inM, opOnM, memToALU);

  dandc <= instr and dest(1);
  regD: dregister port map (aluOut, dandc, clk, regDOut);

  writeM <= instr and dest(0);
  addressM <= regAOut(14 downto 0);
  
  cpu_alu: alu port map (regDOut, memToALU, aluInstr(5), aluInstr(4), aluInstr(3), aluInstr(2), aluInstr(1), aluInstr(0), aluOut, zr, ng);
  outM <= aluOut;
  
  doJump <= '0'                               when (jump = "000") else
            ((not zr) and (not ng) and instr) when (jump = "001") else
            (zr       and (not ng) and instr) when (jump = "010") else
            ((zr      or (not ng)) and instr) when (jump = "011") else
            ((not zr) and ng       and instr) when (jump = "100") else
            ((not zr)              and instr) when (jump = "101") else
            ((zr or ng)            and instr) when (jump = "110") else
                                       instr  when (jump = "111");
  doJumpNot <= not doJump;
  
  pc_0: pc port map (regAOut, doJump, doJumpNot, reset, clk, pctmp);
  pcOut <= pctmp(14 downto 0);
end cpu_arch;
