library ieee;
library std;
use ieee.std_logic_1164.all;
use work.components.all;
use ieee.std_logic_arith.all;
use ieee.std_logic_unsigned.all;


entity complete_design is
    generic(    input_size : integer;
                address_bus : integer
           );
    port(   input_A_from_outside : in std_logic_vector(input_size-1 downto 0);
            input_RAM_A_address_from_outside : in std_logic_vector(address_bus-1 downto 0);
            input_X_from_outside : in std_logic_vector(input_size-1 downto 0);
            input_RAM_X_address_from_outside : in std_logic_vector(address_bus-1 downto 0);
            MUX_Sel : in std_logic; -- MUX_Sel will be the same as start_FSM
            output_from_RAM : out std_logic_vector(2*input_size-1 downto 0)
        );














    fsm : control_signal_generator generic map () port map();
    mux : mux_2to1 generic map() port map();

    -- HERE ADD 3 RAMs for inputs and outputs!!!!!
    input_A_ram : bl_ram_write_first generic map(address_bus,input_size) port map(clock, input_ram_we ,'1', input_addr_ptr, input_from_ram_A, input_A);
    input_X_ram : bl_ram_write_first generic map(address_bus,input_size) port map(clock, input_ram_we ,'1', input_addr_ptr, input_from_ram_X, input_X);
    output_ram : bl_ram_write_first generic map(address_bus,2*input_size) port map(clock, output_ram_we ,'1', output_addr_ptr, Y_result, ram_output_result);
