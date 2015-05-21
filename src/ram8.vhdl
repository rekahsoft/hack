library IEEE;
use IEEE.std_logic_1164.all;

entity ram8 is
  port (d       : in std_logic_vector(15 downto 0);
        load    : in std_logic;
        address : in std_logic_vector(2 downto 0);
        clk     : in std_logic;
        cout    : out std_logic_vector(15 downto 0));
end ram8;

architecture ram8_arch of ram8 is
  component dregister
    port (d         : in std_logic_vector(15 downto 0);
          load, clk : in std_logic;
          cout      : out std_logic_vector(15 downto 0));
  end component;
  component dmux8way
    port (cin : in std_logic; sel : in std_logic_vector(2 downto 0); a, b, c, d, e, f, g, h : out std_logic);
  end component;
  component mux8way16
    port (a, b, c, d, e, f, g, h : in std_logic_vector(15 downto 0);
          sel                    : in std_logic_vector(2 downto 0);
          cout                   : out std_logic_vector(15 downto 0));
  end component;

  signal regLoad : std_logic_vector(7 downto 0);
  type regoutT is array (7 downto 0) of std_logic_vector(15 downto 0);
  signal regOut : regoutT;
begin
  dmux8way_0: dmux8way port map (load, address, regLoad(0), regLoad(1), regLoad(2), regLoad(3), regLoad(4), regLoad(5), regLoad(6), regLoad(7));

  reg: for i in regLoad'range generate
    dregister_i: dregister port map (d, regLoad(i), clk, regOut(i));
  end generate;

  mux8way16_0: mux8way16 port map (regOut(0), regOut(1), regOut(2), regOut(3), regOut(4), regOut(5), regOut(6), regOut(7), address, cout);
end ram8_arch;
