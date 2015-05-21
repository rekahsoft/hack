library IEEE;
use IEEE.std_logic_1164.all;

entity alu is
  port (x, y                  : in std_logic_vector(15 downto 0);
        zx, nx, zy, ny, f, no : in std_logic;
        cout                  : out std_logic_vector(15 downto 0);
        zr, ng                : out std_logic);
end alu;

architecture alu_arch of alu is
  component mux16
    port (a, b : in std_logic_vector(15 downto 0); sel : in std_logic; cout : out std_logic_vector(15 downto 0));
  end component;
  component add16
    port (a, b : in std_logic_vector(15 downto 0); cout : out std_logic_vector(15 downto 0));
  end component;

  signal zeroX, zeroXNot, negateX, zeroY, zeroYNot, negateY, negateXAndnegateY, bitwiseAnd, addition, whichF, whichFNot, negateOut : std_logic_vector(15 downto 0);
  constant zeros : std_logic_vector(15 downto 0) := "0000000000000000";
begin
  zeroXMux: mux16 port map (x, zeros, zx, zeroX);
  zeroXNot <= not zeroX;
  negateXMux: mux16 port map (zeroX, zeroXNot, nx, negateX);

  zeroYMux: mux16 port map (y, zeros, zy, zeroY);
  zeroYNot <= not zeroY;
  negateYMux: mux16 port map (zeroY, zeroYNot, ny, negateY);

  fAdd: add16 port map (negateX, negateY, addition);
  negateXAndNegateY <= negateX and negateY;
  whichFMux: mux16 port map (negateXAndNegateY, addition, f, whichF);

  whichFNot <= not whichF;
  negateOutMux: mux16 port map (whichF, whichFNot, no, negateOut);

  cout <= negateOut;
  zr <= '1' when negateOut = zeros else '0';
  ng <= negateOut(15);
end alu_arch;
