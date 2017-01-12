library ieee;
use ieee.std_logic_1164.all;
use work.components.all;

entity test_multi is
end test_multi;

architecture tb_multi_behavior of test_multi is

constant data_width : integer := 4;


component multiply is
        generic (n : integer := 8);
	port (	A,X : in std_logic_vector (data_width-1 downto 0);
		prod : out std_logic_vector (2*data_width-1 downto 0));
end component;

signal A,X : std_logic_vector (data_width-1 downto 0) := (others=>'0');
signal prod : std_logic_vector (2*data_width-1 downto 0) := (others=>'0');

begin
	mul_comp_mapping : multiply generic map (n=>data_width) port map(A=>A,X=>X,prod=>prod);
	process
	begin
	wait for 5 ns;
	A <="0010";
	X <="0010";
	wait for 5 ns;
	A <="0100";
	X <="0010";
	wait for 5 ns;
	A <="1001";
	X <="0011";
	wait for 5 ns;
	A <= "0001";
	X <= "0001";
	wait for 5 ns;
	A <= "1110";
	X <= "0011";
	wait for 5 ns;
	A <= "0001";
	X <= "0011";
	wait for 5 ns;
	A <= "0011";
	X <= "0100";	
	wait for 5 ns;
	A <= "0101";
	X <= "0101";
	wait for 5 ns;
	A <= "0001";
	X <= "0110";
	wait for 5 ns;
	A <= "0001";
	X <= "0111";
	wait for 5 ns;
	end process;
end tb_multi_behavior;