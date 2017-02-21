library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;
use ieee.std_logic_unsigned.all; 
use ieee.std_logic_arith.all; 

--creation of 1-bit full adder
--takes port @param: x,y, cin
--output ports s and cout


entity fa is
    port(
            x, y, cin : in  std_logic;
            s, cout :  out std_logic     
        ); end fa; 


architecture FA_BHV of fa is
begin

    s <= (x xor y xor cin);
    cout <= (x and y) or (cin and (x xor y));

end FA_BHV;
