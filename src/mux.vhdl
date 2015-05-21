library IEEE;
use IEEE.std_logic_1164.all;

entity mux is
  port (a, b, sel : in std_logic;
        cout      : out std_logic);
end mux;

architecture mux_arch of mux is
begin
  cout <= a when sel='0' else b;
end mux_arch;
