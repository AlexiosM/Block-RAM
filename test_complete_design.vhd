library ieee;
library std;
use ieee.std_logic_1164.all;
use work.components.all;
use ieee.std_logic_arith.all;
use ieee.std_logic_unsigned.all;

entity control_signal_generator is
end control_signal_generator;

architecture complete_design_behav of control_signal_generator is

constant data_width : integer := 4;
constant addr : integer := 3;
constant clk_period : time := 4 ns;

component control_signal_generator is
    generic(input_size : integer;
	    address_bus : integer);
    port (  start_running : in std_logic; -- After writting every data inside input RAMs, then FSM should start running
            input_ram_we : in std_logic; -- Set it only to write data inside input RAMs, afterwards just unset it
            clock : in std_logic;
            ram_input_A : in std_logic_vector (data_width-1 downto 0);
            ram_input_X : in std_logic_vector (data_width-1 downto 0);
            ram_output_result : out std_logic_vector (2*data_width-1 downto 0));
end component control_signal_generator;


signal clk : std_logic;
signal A : std_logic_vector (data_width-1 downto 0) := (others=>'0');
signal X : std_logic_vector (data_width-1 downto 0) := (others=>'0');
signal Y : std_logic_vector (2*data_width-1 downto 0) := (others=>'0');
signal input_write_enable, start_fsm : std_logic;


begin
	design_component : control_signal_generator generic map(input_size=>data_width, address_bus=>addr) port map(start_running=>start_fsm,input_ram_we=>input_write_enable,clock=>clk,ram_input_A=>A,ram_input_X=>X,ram_output_result=>Y);
	clk_process : process
	begin
		clk <= '0';
		wait for clk_period/2;
		clk <= '1';
		wait for clk_period/2;
	end process;

	stimul_proc : process
	begin

	end process;





end complete_design_behav;