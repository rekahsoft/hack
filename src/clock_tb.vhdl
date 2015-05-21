library IEEE;
use IEEE.std_logic_1164.all;

--  A testbench has no ports.
entity clock_tb is
end clock_tb;

architecture clock_tb_arch of clock_tb is
   --  Declaration of the component that will be instantiated.
   component clock
     port (finish : in std_logic;
           cout   : out std_logic);
   end component;
   
   --  Specifies which entity is bound with the component.
   for clock_0: clock use entity work.clock;
   signal finish, cout : std_logic;
begin
  --  Component instantiation.
   clock_0: clock port map (finish, cout);

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
      --  Check each pattern.
      for i in patterns'range loop
         --  Set the inputs.
         finish <= patterns(i).finish;
         wait for 0.1 ns;
         --  Check the outputs.
         assert cout = patterns(i).cout
           report "bad clock" severity error;
         wait for 0.4 ns;
      end loop;
      -- End the clock
      finish <= '1';
      assert false report "end of test" severity note;
      --  Wait forever; this will finish the simulation.
      wait;
   end process;
end clock_tb_arch;
