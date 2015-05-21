library IEEE;
use IEEE.std_logic_1164.all;

entity mux4way16 is
  port (a, b, c, d : in std_logic_vector(15 downto 0);
        sel        : in std_logic_vector(1 downto 0);
        cout       : out std_logic_vector(15 downto 0));
end mux4way16;

architecture mux4way16_arch of mux4way16 is
  component mux16
    port (a, b : in std_logic_vector(15 downto 0);
          sel  : in std_logic;
          cout : out std_logic_vector(15 downto 0));
  end component;

  signal mx0, mx1 : std_logic_vector(15 downto 0);
begin
  mux16_0: mux16 port map (a, b, sel(0), mx0);
  mux16_1: mux16 port map (c, d, sel(0), mx1);
  mux16_2: mux16 port map (mx0, mx1, sel(1), cout);
end mux4way16_arch;
