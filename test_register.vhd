library ieee;
use ieee.std_logic_1164.all;

entity test_reg is
end test_reg;

architecture reg_behavior of test_reg is
constant data_width : integer := 8;
constant clock_period : time := 2 ns;

component generic_register is
	generic (n : integer);
	port (	clock : in std_logic;
		reset : in std_logic;
		enable : in std_logic;
		D : in std_logic_vector (n-1 downto 0);
		Q : out std_logic_vector(n-1 downto 0));
end component;

signal clk : std_logic;
signal rst : std_logic;
signal en : std_logic;
signal D_in : std_logic_vector (data_width-1 downto 0);
signal Q_out : std_logic_vector(data_width-1 downto 0);

begin
	reg_compon_inst : generic_register generic map(n=>data_width) port map(clock=>clk,reset=>rst,enable=>en,D=>D_in,Q=>Q_out);
	clk_process : process
	begin
		clk <= '0';
		wait for clock_period/2;
		clk <= '1';
		wait for clock_period/2;
	end process;

	stim_proc : process
	begin 
		wait for 1 ns;
		rst <= '0';
		en <= '1';
		D_in <= "00101001";
		wait for clock_period;
		D_in <= "11101101";
		wait for clock_period;
		en <= '0';
		wait for clock_period;
		rst <= '1';
		wait for clock_period;
		rst <= '0';
		wait for clock_period;
		D_in <= "11111111";
		wait for clock_period;
		D_in <= "00000000";
		wait for clock_period;
	end process;
end reg_behavior;