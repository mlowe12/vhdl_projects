library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;


entity col_cnt is
  port(
        input: in std_logic_vector(9 downto 0);
        output: out std_logic_vector( 5 downto 0)

   );

 end col_cnt;


 architecture BHV of col_cnt is

   signal temp: std_logic_vector(5 downto 0) := std_logic_vector(to_unsigned(0,6));
   signal cnt: std_logic_vector(6 downto 0) := std_logic_vector(to_unsigned(0,7));
   signal temp_in: unsigned(9 downto 0);


   begin

     temp_in <= unsigned(input);
     process(temp_in)
     begin
       cnt <= std_logic_vector(unsigned(cnt) +1);
       if(unsigned(cnt) > 0 and  (unsigned(cnt) mod 2 = 0)) then
          temp <= std_logic_vector(unsigned(temp) + 1);
        end if;

        if(temp_in mod 128 = 0) then
          temp <= std_logic_vector(to_unsigned(0,6));
        end if;

      end process;

    end BHV;
