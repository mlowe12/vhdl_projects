--MICHAEL LOWE 
--EEL 4712 LAB 2 PART 2

library ieee; 
use ieee.std_logic_1164.all;
use ieee.std_logic_arith.all;
use ieee.std_logic_unsigned.all;  

 



entity alu_sla is
	
	
	generic(
		
			WIDTH: positive := 16
	);
	
	
	
	port(
			input1: in std_logic_vector(WIDTH-1 downto 0); 
			input2: in std_logic_vector(WIDTH-1 downto 0);
			sel: in std_logic_vector(3 downto 0);
			output: out std_logic_vector(WIDTH-1 downto 0);
			overflow: out std_logic
	);	 
	
end alu_sla; 


architecture ALU2 of alu_sla is
	
	--Declare mux select lines as constants for the duration of process
	
	constant C_ADD: std_logic_vector(3 downto 0) := "0000";
	constant C_SUB: std_logic_vector(3 downto 0) := "0001"; 
	constant C_MULT: std_logic_vector(3 downto 0) := "0010"; 
	constant C_AND: std_logic_vector(3 downto 0) := "0011"; 
	constant C_OR: std_logic_vector(3 downto 0) := "0100"; 
	constant C_XOR: std_logic_vector(3 downto 0) := "0101"; 
	constant C_NOR: std_logic_vector(3 downto 0) := "0110"; 
	constant C_NOT: std_logic_vector(3 downto 0) := "0111"; 
	constant C_shift_left: std_logic_vector(3 downto 0) := "1000"; 
	constant C_shift_right: std_logic_vector(3 downto 0) := "1001"; 
	constant C_swap_bits: std_logic_vector(3 downto 0) := "1010";
	constant C_reverse_bits: std_logic_vector(3 downto 0) := "1011"; 
	--constant cnt: std_logic_vector(1 downto 0) := (others=> '0'); 
	
begin
	
	--BEGIN short circuit evaluation 
	process(sel, input1, input2)
		
		variable temp : unsigned(WIDTH-1 downto 0) := (others => '0'); 
		variable temp_vec : std_logic_vector(WIDTH-1 downto 0) := (others => '0');
		variable operation_res : unsigned(2*WIDTH -1 downto 0) := (others=> '0');
		variable count1: unsigned(1 downto 0) := (others => '0');
		variable countN: unsigned(WIDTH/2 -1 downto 0):= (others => '0'); 
		variable operation_res_vec: std_logic_vector(2*WIDTH-1 downto 0) := (others => '0'); 
		 
			
	begin
		
		case sel is
			
		--ADDITION 		
		when C_ADD => 
			
			temp_vec := (input1) + (input2);
			for i in (WIDTH -1) to (WIDTH*2 -1) loop
			
				if(operation_res_vec(i) = '1')
					then overflow <= '1'; 
				end if; 
				
		end loop; 
			 
			
		--SUBTRACTION 
		when C_SUB =>
			
			temp_vec := (input1) - (input2); 
			
			for i in (WIDTH -1) to (WIDTH*2 -1) loop
			
				if(operation_res_vec(i) = '1')
					then overflow <= '1'; 
				end if; 
				
		end loop; 
			
			
		
		--MULTIPLICATION
				
	when C_MULT =>
		operation_res_vec := (input1) * (input2);
		for i in (WIDTH -1) to (WIDTH*2 -1) loop
		
			if(operation_res_vec(i) = '1')
				then overflow <= '1'; 
			end if;
			 
		end loop; 
		
		temp_vec := operation_res_vec(WIDTH-1 downto 0); 
		
	when C_AND =>
		temp_vec := (input1) AND (input2);  
		
	when C_OR =>
		temp_vec := (input1) OR (input2); 
		
	when C_XOR =>
		temp_vec := (input1) XOR (input2);
		 
	when C_NOR =>
		temp_vec := (input1) NOR (input2);
		 
	when C_NOT =>
		temp_vec := not ((input1)); 

		
	when C_shift_left => 
		
		count1 := conv_unsigned(1, count1'length);   
		temp_vec := std_logic_vector(SHL(unsigned(input1), count1));
		
		if(input1(WIDTH-1) = '1')
			then overflow <= '1';	
		end if;
		
		
	when C_shift_right =>
		
		count1 := conv_unsigned(1, count1'length);   
		temp_vec := std_logic_vector(SHR(unsigned(input1), count1));
		
	when C_swap_bits =>
		
		if(WIDTH mod 2 = 0)
			then 
				 countN := conv_unsigned((width/2),countN'length); 
				temp_vec := std_logic_vector(SHR(unsigned(input1), countN)) OR std_logic_vector(SHL(unsigned(input2),countN)); 
				
		else
			countN := conv_unsigned((width/2),countN'length);
			temp_vec:= std_logic_vector(SHR(unsigned(input1), countN +1)) OR std_logic_vector(SHL(unsigned(input2), countN-1));
		end if; 
	
	
	
	
	--Iterates from vector of size length backwards and assigns to temp forwards. 
	when C_reverse_bits =>
		for i in 0 to WIDTH-1 loop
			temp_vec(i) := input1((WIDTH-1) - i);
		end loop; 
	
	
	
	--TBA when other functions are needed  
	when others => null;
		
		
		end case;
		
		overflow <= '0';
		
		output <= std_logic_vector(temp_vec); 
		 

	end process; 
end ALU2;

	