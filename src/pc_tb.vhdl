library IEEE;
use IEEE.std_logic_1164.all;

--  A testbench has no ports.
entity pc_tb is
end pc_tb;

architecture pc_tb_arch of pc_tb is
   --  Declaration of the component that will be instantiated.
   component pc
     port (d                     : in std_logic_vector(15 downto 0);
           load, inc, reset, clk : in std_logic;
           cout                  : out std_logic_vector(15 downto 0));
   end component;
   -- Declaration of the clock
   component Clock
     port (finish : in std_logic;
           cout   : out std_logic);
   end component;
   
   --  Specifies which entity is bound with the component.
   for pc_0: pc use entity work.pc;
   signal d, cout : std_logic_vector(15 downto 0);
   signal load, inc, reset, finish, clk : std_logic;
begin
  --  Component instantiation.
  OSC_CLK: Clock port map (finish, clk);
  pc_0: pc port map (d, load, inc, reset, clk, cout);

   --  This process does the real job.
   process
      type pattern_type is record
         --  The inputs of the pc.
         d : std_logic_vector(15 downto 0);
         reset, load, inc : std_logic;
         --  The output of the pc.
         cout : std_logic_vector(15 downto 0);
      end record;
      --  The patterns to apply.
      type pattern_array is array (natural range <>) of pattern_type;
      constant patterns : pattern_array :=
        (("0000000000000000", '0', '0', '0', "0000000000000000"), -- 0
         ("0000000000000000", '0', '0', '0', "0000000000000000"), -- 1
         ("0000000000000000", '0', '0', '1', "0000000000000000"), -- 2
         ("0000000000000000", '0', '0', '1', "0000000000000001"), -- 3

         ("0111110101111011", '0', '0', '1', "0000000000000010"), -- 4  (revised)
         ("0111110101111011", '0', '0', '1', "0000000000000011"), -- 5  (revised)
         ("0111110101111011", '0', '1', '1', "0000000000000100"), -- 6  (revised)
--         ("0111110101111011", '0', '0', '1', "0000000000000001"), -- 4  (here)
--         ("0111110101111011", '0', '0', '1', "0000000000000010"), -- 5  (here)
--         ("0111110101111011", '0', '1', '1', "0000000000000010"), -- 6  (here)

         ("0111110101111011", '0', '1', '1', "0111110101111011"), -- 7
         ("0111110101111011", '0', '0', '1', "0111110101111011"), -- 8

         ("0111110101111011", '0', '0', '1', "0111110101111100"), -- 9  (revised)
         ("0111110101111011", '0', '0', '1', "0111110101111101"), -- 10 (revised)
         ("0111110101111011", '0', '0', '1', "0111110101111110"), -- 11 (revised)
         ("0011000000111001", '0', '1', '0', "0111110101111111"), -- 12 (revised)
--         ("0111110101111011", '0', '0', '1', "0111110101111010"), -- 9  (here)
--         ("0111110101111011", '0', '0', '1', "0111110101111010"), -- 10 (here)
--         ("0111110101111011", '0', '0', '1', "0111110101111001"), -- 11 (here)
--         ("0011000000111001", '0', '1', '0', "0111110101111001"), -- 12 (here)

         ("0011000000111001", '0', '1', '0', "0011000000111001"), -- 13
         ("0011000000111001", '1', '1', '0', "0011000000111001"), -- 14
         ("0011000000111001", '1', '1', '0', "0000000000000000"), -- 15
         ("0011000000111001", '0', '1', '1', "0000000000000000"), -- 16
         ("0011000000111001", '0', '1', '1', "0011000000111001"), -- 17
         ("0011000000111001", '1', '1', '1', "0011000000111001"), -- 18
         ("0011000000111001", '1', '1', '1', "0000000000000000"), -- 19
         ("0011000000111001", '0', '0', '1', "0000000000000000"), -- 20
         ("0011000000111001", '0', '0', '1', "0000000000000001"), -- 21

         ("0011000000111001", '1', '0', '1', "0000000000000010"), -- 22 (revised)
--         ("0011000000111001", '1', '0', '1', "0000000000000001"), -- 22 (here)

         ("0011000000111001", '1', '0', '1', "0000000000000000"), -- 23
         ("0000000000000000", '0', '1', '1', "0000000000000000"), -- 24
         ("0000000000000000", '0', '1', '1', "0000000000000000"), -- 25
         ("0000000000000000", '0', '0', '1', "0000000000000000"), -- 26
         ("0000000000000000", '0', '0', '1', "0000000000000001"), -- 27

         ("0101011011001110", '1', '0', '0', "0000000000000010"), -- 28 (revised)
--         ("0101011011001110", '1', '0', '0', "0000000000000001"), -- 28 (here)

         ("0101011011001110", '1', '0', '0', "0000000000000000"), -- 29

         ("0000000000000000", '1', '0', '0', "0000000000000000"), -- 30
         ("0000000000000000", '0', '0', '1', "0000000000000000"), -- 31
         ("0000000000000000", '0', '0', '1', "0000000000000001"), -- 32
         ("0000000000000000", '0', '0', '1', "0000000000000010"), -- 33
         ("0000000000000000", '0', '0', '1', "0000000000000011"), -- 34
         ("0000000000000000", '0', '0', '1', "0000000000000100"), -- 35
         ("0000000000000000", '0', '0', '1', "0000000000000101")  -- 36
         );
         
   begin
      --  Check each pattern.
      for i in patterns'range loop
         --  Set the inputs.
         d     <= patterns(i).d;
         reset <= patterns(i).reset;
         load  <= patterns(i).load;
         inc   <= patterns(i).inc;
         wait for 0.25 ns;
         --  Check the outputs.
         assert cout = patterns(i).cout
           report "bad counter" severity error;
         wait for 0.75 ns;
      end loop;
      -- End the clock
      finish <= '1';
      assert false report "end of test" severity note;
      --  Wait forever; this will finish the simulation.
      wait;
   end process;
end pc_tb_arch;
