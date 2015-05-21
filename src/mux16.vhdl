library IEEE;
use IEEE.std_logic_1164.all;

entity mux16 is
  port (a, b : in std_logic_vector(15 downto 0);
        sel  : in std_logic;
        cout : out std_logic_vector(15 downto 0));
end mux16;

architecture mux16_arch of mux16 is
begin
  cout <= a when sel='0' else b;
end mux16_arch;
