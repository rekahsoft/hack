library IEEE;
use IEEE.std_logic_1164.all;

entity dmux4way is
  port (cin        : in  std_logic;
        sel        : in  std_logic_vector(1 downto 0);
        a, b, c, d : out std_logic);
end dmux4way;

architecture dmux4way_arch of dmux4way is
  component dmux
    port (cin, sel : in std_logic;
          a, b     : out std_logic);
  end component;

  signal dm1, dm2 : std_logic;
begin
  dmux_0: dmux port map (cin, sel(1), dm1, dm2);
  dmux_1: dmux port map (dm1, sel(0), a, b);
  dmux_2: dmux port map (dm2, sel(0), c, d);
end dmux4way_arch;
