library ieee;
use ieee.std_logic_1164.all;

entity test_fsm is
end test_fsm;

architecture tb_behavior of test_fsm is

constant data_width : integer := 4;
constant clk_period : time := 2 ns;

-- We need to use the fsm as a component in order to be visible in our testbench
component control_signal_generator  is
	generic(input_size : integer);
	port (	clock : in std_logic;
		input_A : in std_logic_vector (data_width-1 downto 0);
		input_X : in std_logic_vector (data_width-1 downto 0);
		Y_result : out std_logic_vector (data_width-1 downto 0));
end component;

signal clk : std_logic;
signal A : std_logic_vector (data_width-1 downto 0) := (others=>'0');
signal X : std_logic_vector (data_width-1 downto 0) := (others=>'0');
signal Y : std_logic_vector (data_width-1 downto 0) := (others=>'0');

begin
	fsm_component : control_signal_generator generic map(input_size=>data_width) port map(clock=>clk,input_A=>A,input_X=>X,Y_result=>Y);
	clk_process : process
	begin
		clk <= '0';
		wait for clk_period/2;
		clk <= '1';
		wait for clk_period/2;
	end process;

	stim_proc : process
	begin
		wait for 7 ns;
		A <= "0001";
		X <= "0001";
		wait for clk_period;
		A <= "1010";
		X <= "0010";
		wait for clk_period;
		A <= "0001";
		X <= "0011";
		wait for clk_period;
		A <= "0001";
		X <= "0100";	
		wait for clk_period;
		A <= "0001";
		X <= "0101";
		wait for clk_period;
		A <= "0001";
		X <= "0110";
		wait for clk_period;
		A <= "0001";
		X <= "0111";
		wait for clk_period;
		wait;
	end process;
end tb_behavior;