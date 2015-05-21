library IEEE;
use IEEE.std_logic_1164.all;

entity DFF is
  port (d, clk : in  std_logic;
        cout   : out std_logic);
end DFF;

architecture DFF_arch of DFF is
  signal coutFst : std_logic := '0';
begin
  cout <= coutFst;
  dff: process(clk)
  begin
    if (rising_edge(clk)) then
      coutFst <= d;
    end if;
  end process dff;
end DFF_arch;
