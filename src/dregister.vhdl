library IEEE;
use IEEE.std_logic_1164.all;

entity dregister is
  port (d         : in std_logic_vector(15 downto 0);
        load, clk : in std_logic;
        cout      : out std_logic_vector(15 downto 0));
end dregister;

architecture dregister_arch of dregister is
  component dbit
    port (d, load, clk : in std_logic; cout : out std_logic);
  end component;
begin
  reg: for i in 0 to 15 generate
    dbit_i: dbit port map (d(i), load, clk, cout(i));
  end generate;
end dregister_arch;
