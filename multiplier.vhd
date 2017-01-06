library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity multiply is
	generic (n : integer := 8);
	port (	A,X : in std_logic_vector (n-1 downto 0);
		prod : out std_logic_vector (2*n-1 downto 0));
end multiply;

architecture mult_operation of multiply is
	signal a_s,x_s : signed(n-1 downto 0);
	signal prod_s : signed(2*n-1 downto 0);
	begin
		a_s <= signed(A);
		x_s <= signed(X);
		prod_s <= a_s * x_s;
		prod <= std_logic_vector(prod_s);
end mult_operation;