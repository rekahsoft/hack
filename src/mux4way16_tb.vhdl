library IEEE;
use IEEE.std_logic_1164.all;

--  A testbench has no ports.
entity mux4way16_tb is
end mux4way16_tb;

architecture mux4way16_tb_arch of mux4way16_tb is
   --  Declaration of the component that will be instantiated.
   component mux4way16
     port (a, b, c, d : in std_logic_vector(15 downto 0);
           sel        : in std_logic_vector(1 downto 0);
           cout       : out std_logic_vector(15 downto 0));
   end component;
   --  Specifies which entity is bound with the component.
   for mux4way16_0: mux4way16 use entity work.mux4way16;
   signal a, b, c, d, cout : std_logic_vector(15 downto 0);
   signal sel : std_logic_vector(1 downto 0);
begin
   --  Component instantiation.
   mux4way16_0: mux4way16 port map (a, b, c, d, sel, cout);

   --  This process does the real job.
   process
      type pattern_type is record
         --  The inputs of the mux4way16.
        a, b, c, d : std_logic_vector(15 downto 0);
        sel        : std_logic_vector(1 downto 0);
        --  The expected outputs of the mux4way16.
        cout : std_logic_vector(15 downto 0);
      end record;
      --  The patterns to apply.
      type pattern_array is array (natural range <>) of pattern_type;
      constant patterns : pattern_array :=
        (("0000000000000000", "0000000000000000", "0000000000000000", "0000000000000000", "00", "0000000000000000"),
         ("0000000000000000", "0000000000000000", "0000000000000000", "0000000000000000", "01", "0000000000000000"),
         ("0000000000000000", "0000000000000000", "0000000000000000", "0000000000000000", "10", "0000000000000000"),
         ("0000000000000000", "0000000000000000", "0000000000000000", "0000000000000000", "11", "0000000000000000"),
         ("0001001000110100", "1001100001110110", "1010101010101010", "0101010101010101", "00", "0001001000110100"),
         ("0001001000110100", "1001100001110110", "1010101010101010", "0101010101010101", "01", "1001100001110110"),
         ("0001001000110100", "1001100001110110", "1010101010101010", "0101010101010101", "10", "1010101010101010"),
         ("0001001000110100", "1001100001110110", "1010101010101010", "0101010101010101", "11", "0101010101010101"));
   begin
      --  Check each pattern.
      for i in patterns'range loop
         --  Set the inputs.
         a <= patterns(i).a;
         b <= patterns(i).b;
         c <= patterns(i).c;
         d <= patterns(i).d;
         sel <= patterns(i).sel;
         --  Wait for the results.
         wait for 1 ns;
         --  Check the outputs.
         assert cout = patterns(i).cout
            report "bad mux4way16 output" severity error;
      end loop;
      assert false report "end of test" severity note;
      --  Wait forever; this will finish the simulation.
      wait;
   end process;
end mux4way16_tb_arch;
