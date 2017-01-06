library ieee;
use ieee.std_logic_1164.all;

entity adder is
	generic (n : integer := 16);
	port ( 	Cin : in std_logic;
		A,X : in std_logic_vector (n-1 downto 0);
		S : out std_logic_vector (n-1 downto 0);
		Cout : out std_logic);
end adder;

architecture add_operation of adder is
	signal carries : std_logic_vector (n downto 0); -- #carries = #full adders + 1
begin
	carries(0) <= Cin;
	f_adders: for i in 0 to n-1 generate
	S(i) <= A(i) xor X(i) xor carries(i);
	carries(i+1) <= (A(i) and X(i)) or (carries(i) and A(i)) or (carries(i) and X(i));
	end generate;
        Cout <= carries(n);
end add_operation;