library IEEE;
use IEEE.std_logic_1164.all;

--  A testbench has no ports.
entity adder_tb is
end adder_tb;

architecture adder_tb_arch of adder_tb is
   --  Declaration of the component that will be instantiated.
   component adder
     port (a, b, ci : in std_logic; s, co : out std_logic);
   end component;
   --  Specifies which entity is bound with the component.
   for adder_0: adder use entity work.adder;
   signal a, b, ci, s, co : std_logic;
begin
   --  Component instantiation.
   adder_0: adder port map (a, b, ci, s, co);

   --  This process does the real job.
   process
      type pattern_type is record
         --  The inputs of the adder.
         a, b, ci : std_logic;
         --  The expected outputs of the adder.
         s, co : std_logic;
      end record;
      --  The patterns to apply.
      type pattern_array is array (natural range <>) of pattern_type;
      constant patterns : pattern_array :=
        (('0', '0', '0', '0', '0'),
         ('0', '0', '1', '1', '0'),
         ('0', '1', '0', '1', '0'),
         ('0', '1', '1', '0', '1'),
         ('1', '0', '0', '1', '0'),
         ('1', '0', '1', '0', '1'),
         ('1', '1', '0', '0', '1'),
         ('1', '1', '1', '1', '1'));
   begin
      --  Check each pattern.
      for i in patterns'range loop
         --  Set the inputs.
         a <= patterns(i).a;
         b <= patterns(i).b;
         ci <= patterns(i).ci;
         --  Wait for the results.
         wait for 1 ns;
         --  Check the outputs.
         assert s = patterns(i).s
            report "bad sum value" severity error;
         assert co = patterns(i).co
            report "bad carray out value" severity error;
      end loop;
      assert false report "end of test" severity note;
      --  Wait forever; this will finish the simulation.
      wait;
   end process;
end adder_tb_arch;
