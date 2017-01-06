library ieee;
use ieee.std_logic_1164.all;
use work.components.all;

Entity control_signal_generator is
generic(input_size : integer := 8);

port ( 	clock : in std_logic;
	input_A : in std_logic_vector (input_size-1 downto 0);
	input_X : in std_logic_vector (input_size-1 downto 0);
	Y_result : out std_logic_vector (input_size-1 downto 0));


end control_signal_generator;

architecture fsm of control_signal_generator is
	type state_type is (s0, s1, s2, s3, s4, s5); -- for fsm
	signal state : state_type; -- for fsm
	signal 	reset_and_recompute : std_logic; -- reset register r3
      	signal  enable_total_output : std_logic; -- enable register

	signal A_mult_in,X_mult_in : std_logic_vector (input_size-1 downto 0);
	signal prod,adder_output,adder_input_from_r3 : std_logic_vector (2*input_size-1 downto 0);
	signal cin,cout : std_logic;
	
begin
	cin <= '0';

	-- ToDo : make clearly the mapping between the ports in order hdl_designer not to complain for violations about positional association
	register_r1 : generic_register generic map (input_size) port map (clock,'0','1',input_A,A_mult_in); -- input register for A
	register_r2 : generic_register generic map (input_size) port map (clock,'0','1',input_X,X_mult_in); -- input register for X
	register_r3 : generic_register generic map (2*input_size) port map (clock, reset_and_recompute,'1',adder_output,adder_input_from_r3); -- intermidiate register for temp results
	register_r4 : generic_register generic map (input_size) port map (clock,'0',enable_total_output,adder_output,Y_result); -- output register
	multiply_unit : multiply generic map (input_size) port map (A_mult_in,X_mult_in,prod);
	addition_unit : adder generic map (2*input_size) port map (cin,prod,adder_input_from_r3,adder_output,cout);

	process(clock)
	begin
		if rising_edge(clock) then
			if(reset_and_recompute = '1') then -- synchronous reset
				state <= s0;
				reset_and_recompute <= '0';
				enable_total_output <= '0';
                        else
			    case state is
				when s0 =>
					state <= s1;
					reset_and_recompute <= '0';
					enable_total_output <= '0';
				when s1 =>
					state <= s2;
				when s2 =>
					state <= s3;
				when s3 =>
					state <= s4;
				when s4 =>
					state <= s5;
				when s5 =>
					state <= s1;
					enable_total_output <= '1';
					reset_and_recompute <= '1';
			    end case;
			end if;
		end if;
	end process;
end fsm;
