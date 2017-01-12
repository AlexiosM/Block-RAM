library ieee;
use ieee.std_logic_1164.all;

entity generic_register is
	generic (n : integer);
	port (	clock : in std_logic;
		reset : in std_logic;
		enable : in std_logic;
		D : in std_logic_vector (n-1 downto 0);
		Q : out std_logic_vector(n-1 downto 0));
end generic_register;

architecture reg_behavior of generic_register is
begin
process(clock)
	begin
	if (clock'event and clock =  '1') then
		if (reset = '1') then
			Q <= (others => '0');
		elsif (enable = '1') then
			Q <= D;
		end if;
	end if;
end process;
end reg_behavior;