library ieee;
use ieee.std_logic_1164.all;

entity mux_2to1 is
    generic (n : integer);
    port ( sel : in  std_logic;
           A   : in  std_logic_vector (n-1 downto 0);
           B   : in  std_logic_vector (n-1 downto 0);
           X   : out std_logic_vector (n-1 downto 0) );
end mux_2to1;

architecture behavioral of mux_2to1 is
begin
    X <= A when (sel = '1') else B;
end behavioral;

