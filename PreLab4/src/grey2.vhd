library ieee;
use ieee.std_logic_1164.all;

entity gray2 is
    port (
        clk    : in  std_logic;
        rst    : in  std_logic;
        output : out std_logic_vector(3 downto 0));
end gray2;



architecture logic of gray2 is

type STATE_TYPE is (STATE_0, STATE_1, STATE_2, STATE_3, STATE_4, STATE_5, STATE_6,
					STATE_7, STATE_8, STATE_9, STATE_A, STATE_B, STATE_C, STATE_D, STATE_E, STATE_F);

signal state: STATE_TYPE; 
signal next_state : STATE_TYPE; 


begin

process(clk, rst)
begin

    if (rst = '1') 
    then
      state <= STATE_0;

    elsif(clk'event and clk = '1') 
    then
      state <= next_state;

    end if;

  end process;



	process(state)
	begin


			case state is

				when STATE_0 =>

					output <= "0000"; 
					next_state <= STATE_1; 

				when STATE_1 =>

					output <= "0001"; 
					next_state <= STATE_3;

				when STATE_2 =>
					output <= "0010";
					next_state <= STATE_6; 

				when STATE_3 => 
					output <= "0011";
					next_state <= STATE_2;

				when STATE_4 => 
					output <= "0100";
					next_state <= STATE_C;  

				when STATE_5 =>
					output <= "0101"; 
					next_state <= STATE_4;

				when STATE_6 =>
					output <= "0110";
					next_state <= STATE_7;

				when STATE_7=>
					output <= "0111";
					next_state <=  STATE_5;
				when STATE_8 =>
					output <= "1000"; 
					next_state <= STATE_0;

				when STATE_9 => 
					output <= "1001";
					next_state <= STATE_8;

				when STATE_A =>
					output <= "1010";
					next_state <= STATE_B; 

				when STATE_B =>
					output <= "1011"; 
					next_state <= STATE_9;

				when STATE_C =>
					output <= "1100"; 
					next_state <= STATE_D; 

				when STATE_D =>
					output <= "1101";
					next_state <= STATE_F;

				when STATE_E =>
					output <= "1110";
					next_state <= STATE_A;

				when STATE_F =>
					output <= "1111";
					next_state <= STATE_E; 

				when others => null; 

			end case; 


	end process; 
	
end logic; 