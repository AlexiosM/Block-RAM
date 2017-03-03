library ieee;
library std;
use ieee.std_logic_1164.all;
use work.components.all;
use ieee.std_logic_arith.all;
use ieee.std_logic_unsigned.all;



entity test_complete_design is
end test_complete_design;


architecture complete_design_behav of test_complete_design is

constant data_width : integer := 4;
constant addr : integer := 4;
constant clk_period : time := 4 ns;

component complete_design is
    generic(    input_size : integer := 4;
                address_bus : integer := 4);
    port(   reset : in std_logic;  
	    clock : in std_logic;
	    input_A_from_outside : in std_logic_vector(input_size-1 downto 0);
            input_X_from_outside : in std_logic_vector(input_size-1 downto 0);
	    input_RAM_address_from_outside : in std_logic_vector(address_bus-1 downto 0);
            initialize_input_RAMs : in std_logic; -- MUX_Sel will be the same as start_FSM
            output_from_RAM : out std_logic_vector(2*input_size-1 downto 0));
end component;


signal clk : std_logic;
signal A : std_logic_vector (data_width-1 downto 0) := (others=>'0');
signal X : std_logic_vector (data_width-1 downto 0) := (others=>'0');
signal Y : std_logic_vector (2*data_width-1 downto 0) := (others=>'0');
signal initialization_phase : std_logic;
signal input_outside_addr : std_logic_vector(addr-1 downto 0);
signal output : std_logic_vector(2*data_width-1 downto 0);
signal reset : std_logic;  

begin

design : complete_design generic map(data_width, addr) port map(reset, clk,A,X,input_outside_addr,initialization_phase,output);
	clk_process : process
	begin
		clk <= '0';
		wait for clk_period/2;
		clk <= '1';
		wait for clk_period/2;
	end process;

	design_proc : process
	begin
		reset <= '0';
		wait for 7 ns;
		reset <= '1';
		wait for 8 ns;
		reset <= '0';
		initialization_phase <= '1';
		wait for 100 ns;
		initialization_phase <= '0';
		wait for 100 ns;
	end process;
end complete_design_behav;