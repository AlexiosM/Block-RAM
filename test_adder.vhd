library ieee;
use ieee.std_logic_1164.all;
use work.components.all;

entity test_adder is
end test_adder;

architecture tb_adder_behavior of test_adder is

constant data_width : integer := 4;


component adder is
        generic (n : integer := data_width);
	port ( 	Cin : in std_logic;
		A,X : in std_logic_vector (n-1 downto 0);
		S : out std_logic_vector (n-1 downto 0);
		Cout : out std_logic);
end component;

signal A,X : std_logic_vector (data_width-1 downto 0) := (others=>'0');
signal Sum : std_logic_vector (data_width-1 downto 0) := (others=>'0');
signal Cin,Cout : std_logic;

begin
	adder_comp_mapping : adder generic map (n=>data_width) port map('0',A=>A,X=>X,S=>Sum,Cout=>Cout);
	process
	begin
	Cin <= '0';
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
end tb_adder_behavior;
