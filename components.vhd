library ieee;
use ieee.std_logic_1164.all;

package components is

    
    component control_signal_generator is
        generic(input_size : integer;
        address_bus : integer);
        port (  start_running : in std_logic; -- After writting every data inside input RAMs, then FSM should start running
                input_ram_we : in std_logic; -- Set it only to write data inside input RAMs, afterwards just unset it
                clock : in std_logic;
                input_from_ram_A : in std_logic_vector (input_size-1 downto 0);
                input_from_ram_X : in std_logic_vector (input_size-1 downto 0);

                next_input_address_ptr : out std_logic_vector(address_bus-1 downto 0); -- it is the next address of the input ram. It will be input for the multiplexer
                output_ram_we : out std_logic;
                ram_output_result : out std_logic_vector (2*input_size-1 downto 0) );
    end component;


    component mux_2to1 is
        generic (n : integer);
        port ( sel : in  std_logic;
               A   : in  std_logic_vector (n-1 downto 0);
               B   : in  std_logic_vector (n-1 downto 0);
               X   : out std_logic_vector (n-1 downto 0)  );
    end component;

	component bl_ram_write_first is
	        generic ( address_bus : integer;
	                  word_size : integer);
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
