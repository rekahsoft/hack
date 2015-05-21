library IEEE;
use IEEE.std_logic_1164.all;

entity mux8way16 is
  port (a, b, c, d, e, f, g, h : in std_logic_vector(15 downto 0);
        sel                    : in std_logic_vector(2 downto 0);
        cout                   : out std_logic_vector(15 downto 0));
end mux8way16;

architecture mux8way16_arch of mux8way16 is
  component mux16
    port (a, b : in std_logic_vector(15 downto 0);
          sel  : in std_logic;
          cout : out std_logic_vector(15 downto 0));
  end component;
  component mux4way16
    port (a, b, c, d : in std_logic_vector(15 downto 0);
          sel        : in std_logic_vector(1 downto 0);
          cout       : out std_logic_vector(15 downto 0));
  end component;
  
  signal mx0, mx1 : std_logic_vector(15 downto 0);
begin
  mux4way16_0: mux4way16 port map (a, b, c, d, sel(1 downto 0), mx0);
  mux4way16_1: mux4way16 port map (e, f, g, h, sel(1 downto 0), mx1);
  mux16_0: mux16 port map (mx0, mx1, sel(2), cout);
end mux8way16_arch;
