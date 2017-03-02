-- write first block ram
library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_unsigned.all;

entity bl_ram_write_first is
        generic ( address_bus : integer := 4;
                  word_size : integer := 16);
        port (clock : in std_logic;
              we : in std_logic;
              en : in std_logic;
              addr : in std_logic_vector(address_bus-1 downto 0);
              di : in std_logic_vector(word_size-1 downto 0);
              do : out std_logic_vector(word_size-1 downto 0));
end bl_ram_write_first;

architecture ram_behav of bl_ram_write_first is
        type ram_type is array (2**address_bus-1 downto 0) of std_logic_vector (word_size-1 downto 0);
        signal RAM: ram_type;
begin
        process (clock)
        begin
            if clock'event and clock = '1' then
                if en = '1' then
                    if we = '1' then
                        RAM(conv_integer(addr)) <= di;
                        do <= di;	-- read and write at the same time slases
                    else
                        do <= RAM(conv_integer(addr));
                    end if;
                end if;
            end if;
        end process;
end ram_behav;
