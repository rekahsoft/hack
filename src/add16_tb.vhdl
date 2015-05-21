library IEEE;
use IEEE.std_logic_1164.all;

--  A testbench has no ports.
entity add16_tb is
end add16_tb;

architecture add16_tb_arch of add16_tb is
   --  Declaration of the component that will be instantiated.
   component add16
     port (a, b : std_logic_vector(15 downto 0); cout : out std_logic_vector(15 downto 0));
   end component;
   --  Specifies which entity is bound with the component.
   for add16_0: add16 use entity work.add16;
   signal a, b, cout : std_logic_vector(15 downto 0);
begin
   --  Component instantiation.
   add16_0: add16 port map (a, b, cout);

   --  This process does the real job.
   process
      type pattern_type is record
         --  The inputs of the add16.
         a, b : std_logic_vector(15 downto 0);
         --  The expected output of the add16.
         cout : std_logic_vector(15 downto 0);
      end record;
      --  The patterns to apply.
      type pattern_array is array (natural range <>) of pattern_type;
      constant patterns : pattern_array :=
        (("0000000000000000", "0000000000000000", "0000000000000000"),
         ("0000000000000001", "0000000000000000", "0000000000000001"),
         ("0000000000000001", "0000000000000001", "0000000000000010"),
         ("0000000000000010", "0000000000000001", "0000000000000011"),
         ("0000000000000011", "0000000000000001", "0000000000000100"),
         ("0000000000000010", "0000000000000100", "0000000000000110"),
         ("1000000000000000", "1000000000000000", "0000000000000000"),
         ("1100000000000011", "1100000000000111", "1000000000001010"),

         -- Tests given by Nand to tetris course
         ("0000000000000000", "0000000000000000", "0000000000000000"),
         ("0000000000000000", "1111111111111111", "1111111111111111"),
         ("1111111111111111", "1111111111111111", "1111111111111110"),
         ("1010101010101010", "0101010101010101", "1111111111111111"),
         ("0011110011000011", "0000111111110000", "0100110010110011"),
         ("0001001000110100", "1001100001110110", "1010101010101010"));
   begin
      --  Check each pattern.
      for i in patterns'range loop
         --  Set the inputs.
         a <= patterns(i).a;
         b <= patterns(i).b;
         cout <= patterns(i).cout;
         --  Wait for the results.
         wait for 1 ns;
         --  Check the outputs.
         assert cout = patterns(i).cout
            report "incorrect addition" severity error;
      end loop;
      assert false report "end of test" severity note;
      --  Wait forever; this will finish the simulation.
      wait;
   end process;
end add16_tb_arch;
