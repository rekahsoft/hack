library IEEE;
use IEEE.std_logic_1164.all;

entity dmux8way is
  port (cin                    : in  std_logic;
        sel                    : in  std_logic_vector(2 downto 0);
        a, b, c, d, e, f, g, h : out std_logic);
end dmux8way;

architecture dmux8way_arch of dmux8way is
   component dmux
     port (cin, sel : in std_logic; a, b : out std_logic);
   end component;
   component dmux4way
     port (cin : in std_logic; sel : in std_logic_vector(1 downto 0); a, b, c, d : out std_logic);
   end component;

   signal dm0, dm1 : std_logic;
begin
  dmux_0: dmux port map (cin, sel(2), dm0, dm1);
  dmux4way_0: dmux4way port map (dm0, sel(1 downto 0), a, b, c, d);
  dmux4way_1: dmux4way port map (dm1, sel(1 downto 0), e, f, g, h);
end dmux8way_arch;
