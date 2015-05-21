library IEEE;
use IEEE.std_logic_1164.all;

--  A testbench has no ports.
entity mux_tb is
end mux_tb;

architecture mux_tb_arch of mux_tb is
   --  Declaration of the component that will be instantiated.
   component mux
     port (a, b, sel : in std_logic; cout : out std_logic);
   end component;
   --  Specifies which entity is bound with the component.
   for mux_0: mux use entity work.mux;
   signal a, b, sel, cout : std_logic;
begin
   --  Component instantiation.
   mux_0: mux port map (a => a, b => b, sel => sel, cout => cout);

   --  This process does the real job.
   process
      type pattern_type is record
         --  The inputs of the mux.
         a, b, sel : std_logic;
         --  The expected outputs of the mux.
         cout : std_logic;
      end record;
      --  The patterns to apply.
      type pattern_array is array (natural range <>) of pattern_type;
      constant patterns : pattern_array :=
        (('0', '0', '0', '0'),
         ('0', '0', '1', '0'),
         ('0', '1', '0', '0'),
         ('0', '1', '1', '1'),
         ('1', '0', '0', '1'),
         ('1', '0', '1', '0'),
         ('1', '1', '0', '1'),
         ('1', '1', '1', '1'));
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
            report "bad mux output" severity error;
      end loop;
      assert false report "end of test" severity note;
      --  Wait forever; this will finish the simulation.
      wait;
   end process;
end mux_tb_arch;
