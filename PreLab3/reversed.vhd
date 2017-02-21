library ieee; 
use ieee.std_logic_1164.all; 
use ieee.numeric_std.all;
use ieee.std_logic_unsigned.all; 
use ieee.std_logic_arith.all; 

entity reversed is 
    generic( WIDTH: positive := 4); 
    port(
        x, y: in std_logic_vector(WIDTH-1 downto 0);
        cin: in std_logic; 
        cout: out std_logic;
        s: out std_logic_vector(WIDTH-1 downto 0)
    );end reversed; 


architecture RIPPLE_CARRY_REVERSED of reversed is

signal carry: std_logic_vector(WIDTH downto 0); 

    begin

        U_ADD: for i in 0 to (WIDTH-1)
            generate
                U_FA: entity work.fa port map(
                        x => x(i), 
                        y => y(i), 
                        s => s(i), 
                        cin => carry(i+1), 
                        cout => carry(i) 

                    ); 

                end generate U_ADD; 

                carry(WIDTH) <= cin; 
                cout <= carry(0); 

end RIPPLE_CARRY_REVERSED; 



