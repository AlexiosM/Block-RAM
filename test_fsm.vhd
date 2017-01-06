library ieee;
use ieee.std_logic_1164.all;

entity tb_test is
end tb_test;

architecture tb_behavior of tb_test is

constant data_width : integer := 4;
constant clk_period : time := 2 ns;

-- We need to use the fsm as a component in order to be visible in our testbench
component control_signal_generator  is
	port(	clk : in std_logic;
		A : in std_logic_vector (data_width-1 downto 0);
		X : in std_logic_vector (data_width-1 downto 0);
		Y : out std_logic_vector (data_width-1 downto 0));
end component;

signal clk : std_logic;
signal A : std_logic_vector (data_width-1 downto 0) := (others=>'0');
signal X : std_logic_vector (data_width-1 downto 0) := (others=>'0');
signal Y : std_logic_vector (data_width-1 downto 0) := (others=>'0');


begin
	fsm_component : control_signal_generator port map(clk=>clk,A=>A,X=>X,Y=>Y);
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
		X <= "0010";
		wait for clk_period;
		A <= "0010";
		X <= "0010";
		wait for clk_period;
		A <= "0001";
		X <= "0010";
		wait for clk_period;
		A <= "0001";
		X <= "0010";	
		wait for clk_period;
		A <= "0001";
		X <= "0010";
		wait for clk_period;
		A <= "0001";
		X <= "0010";
		wait for clk_period;
		A <= "0001";
		X <= "0010";
		wait for clk_period;
		wait;
	end process;
end tb_behavior;