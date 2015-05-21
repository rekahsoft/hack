library IEEE;
use IEEE.std_logic_1164.all;

entity ram4k is
  port (d       : in std_logic_vector(15 downto 0);
        load    : in std_logic;
        address : in std_logic_vector(11 downto 0);
        clk     : in std_logic;
        cout    : out std_logic_vector(15 downto 0));
end ram4k;

architecture ram4k_arch of ram4k is
  component ram512
    port (d       : in std_logic_vector(15 downto 0);
          load    : in std_logic;
          address : in std_logic_vector(8 downto 0);
          clk     : in std_logic;
          cout    : out std_logic_vector(15 downto 0));
  end component;
  component dmux8way
    port (cin : in std_logic; sel : in std_logic_vector(2 downto 0); a, b, c, d, e, f, g, h : out std_logic);
  end component;
  component mux8way16
    port (a, b, c, d, e, f, g, h : in std_logic_vector(15 downto 0);
          sel                    : in std_logic_vector(2 downto 0);
          cout                   : out std_logic_vector(15 downto 0));
  end component;

  signal ramLoad : std_logic_vector(7 downto 0);
  type ramoutT is array (7 downto 0) of std_logic_vector(15 downto 0);
  signal ramOut : ramoutT;
begin
  dmux8way_0: dmux8way port map (load, address(2 downto 0), ramLoad(0), ramLoad(1), ramLoad(2), ramLoad(3), ramLoad(4), ramLoad(5), ramLoad(6), ramLoad(7));

  ram: for i in ramLoad'range generate
    ram512_i: ram512 port map (d, ramLoad(i), address(11 downto 3), clk, ramOut(i));
  end generate;

  mux8way16_0: mux8way16 port map (ramOut(0), ramOut(1), ramOut(2), ramOut(3), ramOut(4), ramOut(5), ramOut(6), ramOut(7), address(2 downto 0), cout);
end ram4k_arch;
