library ieee;
use ieee.std_logic_1164.all;

package components is

	component bl_ram_write_first is
	        generic ( address_bus : integer := 8;  -- 256 addresses
	                  word_size : integer := 16);
	        port (clock : in std_logic;
	              we : in std_logic;
	              en : in std_logic;
	              addr : in std_logic_vector(address_bus-1 downto 0);
	              di : in std_logic_vector(word_size-1 downto 0);
	              do : out std_logic_vector(word_size-1 downto 0));
	end component;

	component multiply
		generic (n : integer);
		port (	A,X : in std_logic_vector (n-1 downto 0);
			prod : out std_logic_vector (2*n-1 downto 0));
	end component;

	component adder
		generic (n : integer);
		port ( 	Cin : in std_logic;
			A,X : in std_logic_vector (n-1 downto 0);
			S : out std_logic_vector (n-1 downto 0);
			Cout : out std_logic);
	end component;

	component generic_register
		generic (n : integer);
		port (	clock : in std_logic;
			reset : in std_logic;
			enable : in std_logic;
			D : in std_logic_vector (n-1 downto 0);
			Q : out std_logic_vector(n-1 downto 0));
	end component;

end components;
