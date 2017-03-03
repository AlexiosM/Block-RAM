-- We need a Mux, 3 block RAMs, and the FSM
library ieee;
library std;
use ieee.std_logic_1164.all;
use work.components.all;
use ieee.std_logic_arith.all;
use ieee.std_logic_unsigned.all;


entity complete_design is
    generic(    input_size : integer := 4;
                address_bus : integer := 4);
    port(   reset : in std_logic;
	    clock : in std_logic;
	    input_A_from_outside : in std_logic_vector(input_size-1 downto 0);
            input_X_from_outside : in std_logic_vector(input_size-1 downto 0);
	    input_RAM_address_from_outside : in std_logic_vector(address_bus-1 downto 0);
            initialize_input_RAMs : in std_logic; -- MUX_Sel will be the same as start_FSM
            output_from_RAM : out std_logic_vector(2*input_size-1 downto 0));
end complete_design;

architecture complete_design_behav of complete_design is

signal input_RAM_address_from_FSM, RAM_address_in : std_logic_vector(address_bus-1 downto 0);
signal input_from_ram_A,input_from_ram_X : std_logic_vector(input_size-1 downto 0);
signal output_ram_we : std_logic;
signal fsm_output_result : std_logic_vector (2*input_size-1 downto 0);
signal output_addr_ptr : std_logic_vector(address_bus-1 downto 0);
signal run_fsm : std_logic;

begin
    run_fsm <= not initialize_input_RAMs;
    -- MUX: when initialize = 1 then take address from outside, else from FSM
    mux : mux_2to1 generic map(input_size) port map(initialize_input_RAMs,input_RAM_address_from_outside,input_RAM_address_from_FSM,RAM_address_in);
    -- HERE ADD 3 RAMs for inputs and outputs!!!!!
    input_A_ram : bl_ram_write_first generic map(address_bus,input_size) port map(clock, initialize_input_RAMs,'1', RAM_address_in,input_A_from_outside ,input_from_ram_A);
    input_X_ram : bl_ram_write_first generic map(address_bus,input_size) port map(clock, initialize_input_RAMs,'1', RAM_address_in,input_X_from_outside ,input_from_ram_X);
    fsm : control_signal_generator generic map (input_size,address_bus) port map(reset,run_fsm, clock, input_from_ram_A, input_from_ram_X, output_addr_ptr, input_RAM_address_from_FSM, output_ram_we,fsm_output_result);
    output_ram : bl_ram_write_first generic map(address_bus,2*input_size) port map(clock, output_ram_we ,'1', output_addr_ptr, fsm_output_result, output_from_RAM);

end complete_design_behav;
