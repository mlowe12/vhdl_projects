
library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_arith.all;
use ieee.std_logic_unsigned.all;
use ieee.numeric_std.all;
use work.libary_project.all;



entity demo_tb is
end demo_tb;



--architecture allows for creation of an ALU compoent that then interates through an array of select line values
--each select line will exaughstively test inputs of size input(?)'length bits
--working on assertions

architecture TB of demo_tb is

    constant WIDTH: positive:= 16;

    signal input1: std_logic_vector(WIDTH-1 downto 0) := (others => '0');
    signal input2: std_logic_vector(WIDTH-1 downto 0) := (others => '0');
    signal sel_line: std_logic_vector(5 downto 0) := (others => '0');
    signal output: std_logic_vector(WIDTH-1 downto 0);
    signal u_constant: std_logic_vector(5 downto 0);
    signal high_reg: std_logic_vector(WIDTH-1 downto 0);
    signal branch: std_logic;

    constant ADD_U: std_logic_vector(5 downto 0) := "100001";
    constant SUB_U: std_logic_vector(5 downto 0) := "100011";
    constant MULT_U: std_logic_vector(5 downto 0) := "011001";
    constant C_AND: std_logic_vector(5 downto 0) := "100100";
    constant C_OR: std_logic_vector(5 downto 0) := "100101";
    constant C_XOR: std_logic_vector(5 downto 0) :=  "100110";
    constant C_NOR: std_logic_vector(5 downto 0):= "100111";
    constant L_SHIFT: std_logic_vector(5 downto 0) := "000000";
    constant R_SHIFT: std_logic_vector(5 downto 0) := "000010";
    constant AR_SHIFT_RIGHT: std_logic_vector(5 downto 0) := "000011";
    constant BEQ: std_logic_vector(5 downto 0) := "000100";  -- double check
    constant BNE: std_logic_vector(5 downto 0) := "000101";  -- double check
    constant BEZ: std_logic_vector(5 downto 0) := "111111";  -- double check
    constant BNEZ: std_logic_vector(5 downto 0) := "111110";  --double check
    constant BGEZ: std_logic_vector(5 downto 0) := "000001";  -- double check


    type container is array (0 to 14) of std_logic_vector(5 downto 0);
    -- signal my_array: container := ("100001","100011" ,"011001", "100100" , "100101" , "100110","100111" ,
    --                   "000000"  ,"000010" , "000011");

    signal my_array: container := (ADD_U, SUB_U, MULT_U, C_AND, C_OR, C_XOR, C_NOR,
                        L_SHIFT, R_SHIFT, AR_SHIFT_RIGHT, BEQ, BNE, BEZ, BNEZ, BGEZ);


begin  -- TB

    UUT : entity work.ALU
        generic map (WIDTH => WIDTH)
        port map (
            input1   => input1,
            input2   => input2,
            sel_line => sel_line,
            output   => output,
            high_reg => high_reg,
            branch  => branch
            );
    process


    begin

      sel_line <= "000000";
      input1 <= x"8800";
      input2 <= x"0003";

      wait for 40 ns;

      sel_line <= "000100";
      for i in 0 to 2 loop
        input1 <= conv_std_logic_vector(i, input1'length);
        for j in 0 to 2 loop
          input2 <= conv_std_logic_vector(j, input2'length);
          wait for 40 ns;
        end loop;
      end loop;





      sel_line <= "011001";
      input1 <= conv_std_logic_vector(2, input1'length);
      input2 <= conv_std_logic_vector(1073741823, input2'length);
      wait for 40 ns;



      wait;









    end process;

  end TB;
