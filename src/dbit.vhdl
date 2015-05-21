library IEEE;
use IEEE.std_logic_1164.all;

entity dbit is
  port (d, load, clk : in  std_logic;
        cout         : out std_logic);
end dbit;

architecture dbit_arch of dbit is
  component mux
    port (a, b, sel : in std_logic; cout : out std_logic);
  end component;
  component dff
    port (d, clk : in std_logic; cout : out std_logic);
  end component;

  signal dffOut, muxOut : std_logic;
begin
  MUX_0: mux port map (dffOut, d, load, muxOut);
  DFF_0: dff port map (muxOut, clk, dffOut);
  cout <= dffOut;
end dbit_arch;
