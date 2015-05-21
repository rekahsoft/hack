library IEEE;
use IEEE.std_logic_1164.all;

entity dmux is
  port (cin, sel : in  std_logic;
        a, b     : out std_logic);
end dmux;

architecture dmux_arch of dmux is
begin
  a <= cin and (not sel);
  b <= cin and sel;
end dmux_arch;
