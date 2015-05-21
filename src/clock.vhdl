library IEEE;
use IEEE.std_logic_1164.all;

entity clock is
  port (finish : in std_logic;
        cout : out std_logic);
end clock;

architecture clock_arch of clock is
  signal clk: std_logic := '0';
begin
  clk <= '0' when finish = '1' else
         '1' after 0.5 ns when clk = '0' else
         '0' after 0.5 ns when clk = '1';
  cout <= clk;
end clock_arch;
