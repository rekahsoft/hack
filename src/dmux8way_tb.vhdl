library IEEE;
use IEEE.std_logic_1164.all;

--  A testbench has no ports.
entity dmux8way_tb is
end dmux8way_tb;

architecture dmux8way_tb_arch of dmux8way_tb is
   --  Declaration of the component that will be instantiated.
   component dmux8way
     port (cin : in std_logic; sel : in std_logic_vector(2 downto 0); a, b, c, d, e, f, g, h : out std_logic);
   end component;
   --  Specifies which entity is bound with the component.
   for dmux8way_0: dmux8way use entity work.dmux8way;
   signal cin, a, b, c, d, e, f, g, h : std_logic;
   signal sel : std_logic_vector(2 downto 0);
begin
   --  Component instantiation.
   dmux8way_0: dmux8way port map (cin, sel, a, b, c, d, e, f, g, h);

   --  This process does the real job.
   process
      type pattern_type is record
         --  The inputs of the dmux8way.
         cin : std_logic;
         sel : std_logic_vector(2 downto 0);
         --  The expected outputs of the dmux8way.
         a, b, c, d, e, f, g, h : std_logic;
      end record;
      --  The patterns to apply.
      type pattern_array is array (natural range <>) of pattern_type;
      constant patterns : pattern_array :=
        (('0', "000", '0', '0', '0', '0', '0', '0', '0', '0'),
         ('0', "001", '0', '0', '0', '0', '0', '0', '0', '0'),
         ('0', "010", '0', '0', '0', '0', '0', '0', '0', '0'),
         ('0', "011", '0', '0', '0', '0', '0', '0', '0', '0'),
         ('0', "100", '0', '0', '0', '0', '0', '0', '0', '0'),
         ('0', "101", '0', '0', '0', '0', '0', '0', '0', '0'),
         ('0', "110", '0', '0', '0', '0', '0', '0', '0', '0'),
         ('0', "111", '0', '0', '0', '0', '0', '0', '0', '0'),
         ('1', "000", '1', '0', '0', '0', '0', '0', '0', '0'),
         ('1', "001", '0', '1', '0', '0', '0', '0', '0', '0'),
         ('1', "010", '0', '0', '1', '0', '0', '0', '0', '0'),
         ('1', "011", '0', '0', '0', '1', '0', '0', '0', '0'),
         ('1', "100", '0', '0', '0', '0', '1', '0', '0', '0'),
         ('1', "101", '0', '0', '0', '0', '0', '1', '0', '0'),
         ('1', "110", '0', '0', '0', '0', '0', '0', '1', '0'),
         ('1', "111", '0', '0', '0', '0', '0', '0', '0', '1'));
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
            report "bad dmux8way" severity error;
         assert b = patterns(i).b
           report "bad dmux8way" severity error;
         assert c = patterns(i).c
           report "bad dmux8way" severity error;
         assert d = patterns(i).d
            report "bad dmux8way" severity error;
         assert e = patterns(i).e
            report "bad dmux8way" severity error;
         assert f = patterns(i).f
            report "bad dmux8way" severity error;
         assert g = patterns(i).g
            report "bad dmux8way" severity error;
         assert h = patterns(i).h
            report "bad dmux8way" severity error;
      end loop;
      assert false report "end of test" severity note;
      --  Wait forever; this will finish the simulation.
      wait;
   end process;
end dmux8way_tb_arch;
