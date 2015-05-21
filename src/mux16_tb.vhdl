library IEEE;
use IEEE.std_logic_1164.all;

--  A testbench has no ports.
entity mux16_tb is
end mux16_tb;

architecture mux16_tb_arch of mux16_tb is
   --  Declaration of the component that will be instantiated.
   component mux16
     port (a, b : in std_logic_vector(15 downto 0);
           sel  : in std_logic;
           cout : out std_logic_vector(15 downto 0));
   end component;
   --  Specifies which entity is bound with the component.
   for mux16_0: mux16 use entity work.mux16;
   signal a, b, cout : std_logic_vector(15 downto 0);
   signal sel : std_logic;
begin
   --  Component instantiation.
   mux16_0: mux16 port map (a => a, b => b, sel => sel, cout => cout);

   --  This process does the real job.
   process
      type pattern_type is record
         --  The inputs of the mux16.
        a, b : std_logic_vector(15 downto 0);
        sel  : std_logic;
        --  The expected outputs of the mux16.
        cout : std_logic_vector(15 downto 0);
      end record;
      --  The patterns to apply.
      type pattern_array is array (natural range <>) of pattern_type;
      constant patterns : pattern_array :=
        (("0000000000000000", "0000000000000001", '0', "0000000000000000"),
         ("0000000000000001", "0000000000000000", '1', "0000000000000000"),
         ("0000000000000000", "1111111111111111", '0', "0000000000000000"),
         ("0000000000000000", "1111111111111111", '1', "1111111111111111"),
         ("1111111111111111", "0000000000000000", '0', "1111111111111111"),
         ("1111111111111111", "0000000000000000", '1', "0000000000000000"),
         ("1111111111111111", "1111111111111110", '0', "1111111111111111"),
         ("1111111111111110", "1111111111111111", '1', "1111111111111111"));
   begin
      --  Check each pattern.
      for i in patterns'range loop
         --  Set the inputs.
         a <= patterns(i).a;
         b <= patterns(i).b;
         sel <= patterns(i).sel;
         --  Wait for the results.
         wait for 1 ns;
         --  Check the outputs.
         assert cout = patterns(i).cout
            report "bad mux16 output" severity error;
      end loop;
      assert false report "end of test" severity note;
      --  Wait forever; this will finish the simulation.
      wait;
   end process;
end mux16_tb_arch;
