library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_unsigned.all;
use work.components.all;

entity tb_block_ram is
end tb_block_ram;

architecture tb_arch of tb_block_ram is

constant addr_bus : integer := 3;
constant word_s : integer := 16;
constant clk_period : time := 4 ns;

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

signal clk,write_enable : std_logic;
signal A_in,A_out : std_logic_vector(word_s-1 downto 0);
signal address : std_logic_vector(addr_bus-1 downto 0);


begin
	bram_mapping : bl_ram_write_first generic map (address_bus=>addr_bus,word_size=>word_s) port map(clock=>clk,we=>write_enable,en=>'1',addr=>address,di=>A_in,do=>A_out);
	clk_process : process
	begin
		clk <= '0';
		wait for clk_period/2;
		clk <= '1';
		wait for clk_period/2;
	end process;
	stim_process : process
	begin
		write_enable <= '1'; -- let's write all memory
		A_in <= "0000000000000001";
		address <= "000";
		wait for clk_period;
		A_in <= "0000000000001000";
		address <= "001";
		wait for clk_period;
		A_in <= "0000000001000000";
		address <= "010";
		wait for clk_period;
		A_in <= "0000000001000000";
		address <= "011";
		wait for clk_period;
		A_in <= "0000000000000011";
		address <= "100";
		wait for clk_period;
		A_in <= "0000000000000101";
		address <= "101";
		wait for clk_period;
		A_in <= "0000000000000001";
		address <= "110";
		wait for clk_period;
		A_in <= "0000000000000001";
		address <= "111";


	end process;
end tb_arch;
