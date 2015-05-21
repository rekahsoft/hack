library IEEE;
use IEEE.std_logic_1164.all;

entity adder is
  -- i0, i1 and the carry-in ci are inputs of the adder.
  -- s is the sum output, co is the carry-out.
  port (a, b, ci : in  std_logic;
        s, co    : out std_logic);
end adder;

architecture adder_arch of adder is
begin
  --  Compute the sum.
  s <= a xor b xor ci;
  --  Compute the carry.
  co <= (a and b) or (a and ci) or (b and ci);
end adder_arch;
