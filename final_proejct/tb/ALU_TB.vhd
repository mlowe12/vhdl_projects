--MICHAEL LOWE
--EEL 4712 MIPS MICROPROCESSOR FINAL PROJECT
--EXTRA CREDIT TEST BENCH




library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_arith.all;
use ieee.std_logic_unsigned.all;
use ieee.numeric_std.all;



entity ALU_TB is
end ALU_TB;



--architecture allows for creation of an ALU compoent that then interates through an array of select line values
--each select line will exaughstively test inputs of size input(?)'length bits
--working on assertions

architecture TB of ALU_TB is

    constant WIDTH: positive:= 8;

    signal input1: std_logic_vector(WIDTH-1 downto 0) := (others => '0');
    signal input2: std_logic_vector(WIDTH-1 downto 0) := (others => '0');
    signal sel_line: std_logic_vector(5 downto 0) := (others => '0');
    signal output: std_logic_vector(WIDTH-1 downto 0);
    signal u_constant: std_logic_vector(5 downto 0);

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
    constant SLTU: std_logic_vector(5 downto 0) := "101010"; --double check


    type container is array (0 to 15) of std_logic_vector(5 downto 0);
    -- signal my_array: container := ("100001","100011" ,"011001", "100100" , "100101" , "100110","100111" ,
    --                   "000000"  ,"000010" , "000011");

    signal my_array: container := (ADD_U, SUB_U, MULT_U, C_AND, C_OR, C_XOR, C_NOR,
                        L_SHIFT, R_SHIFT, AR_SHIFT_RIGHT, BEQ, BNE, BEZ, BNEZ, BGEZ, SLTU);


begin  -- TB

    UUT : entity work.ALU
        generic map (WIDTH => WIDTH)
        port map (
            input1   => input1,
            input2   => input2,
            sel_line => sel_line,
            output   => output
            );
    process

      variable observed: integer;
      variable actual: integer;

    begin

      for i in 0 to 9 loop
        sel_line <= my_array(i);
        for j in 0 to 255 loop
          input1 <= conv_std_logic_vector(j, input1'length);
          for k in 0 to 255 loop
            --input1 <= conv_std_logic_vector(j, input1'length);
            input2 <= conv_std_logic_vector(k, input2'length);
            wait for 40 ns;

            if(my_array(i) = ADD_U)
            then assert output = (conv_std_logic_vector((j+k), output'length)) report  "Error: output is" &integer'image(conv_integer(output)) & "instead of " &integer'image(conv_integer(input1+input2));
            elsif(my_array(i) = SUB_U)
            then assert output = conv_std_logic_vector((k-j), output'length) report  "Error: output is" &integer'image(conv_integer(output)) & "instead of " &integer'image(conv_integer(input2-input1));
            elsif(my_array(i) = MULT_U)
            then assert output =(conv_std_logic_vector((j*k), output'length)) report  "Error: output is" &integer'image(conv_integer(output)) & "instead of " &integer'image(conv_integer(input1*input2));

          end if;
          end loop;
        end loop;
      end loop;

      --   -- test 2+6 (no overflow)
      --   sel_line    <= "100001";
      --   --input1 <= conv_std_logic_vector(2, input1'length);
      --   --input2 <= conv_std_logic_vector(6, input2'length);
      -- --  wait for 40 ns;
      -- --  assert(output = conv_std_logic_vector(8, output'length)) report "Error : 2+6 = " & integer'image(conv_integer(output)) & " instead of 8" severity warning;
      --
      --   for i in 0 to  255 loop
      --     for j in 0 to 255 loop
      --       input1 <= conv_std_logic_vector(i, input1'length);
      --       input2 <= conv_std_logic_vector(j, input2'length);
      --       wait for 40 ns;
      --     end loop;
      --   end loop;
      --
      --
      --   -- test 250+50 (with overflow)
      --   sel_line    <= "100011";
      --   --input1 <= conv_std_logic_vector(250, input1'length);
      --   --input2 <= conv_std_logic_vector(50, input2'length);
      --   --wait for 40 ns;
      --   --assert(output = conv_std_logic_vector(200, output'length)) report "Error : 250+50 = " & integer'image(conv_integer(output)) & " instead of 44" severity warning;
      --
      --   for i in 0 to 255 loop
      --     for j in 0 to 255 loop
      --       input1 <= conv_std_logic_vector(i, input1'length);
      --       input2 <= conv_std_logic_vector(j, input2'length);
      --       wait for 40 ns;
      --     end loop;
      --   end loop;
      --
      --   -- test 5*6
      --   sel_line    <= "011001";
      --   --input1 <= conv_std_logic_vector(5, input1'length);
      --   --input2 <= conv_std_logic_vector(6, input2'length);
      --   --wait for 40 ns;
      --   --assert(output = conv_std_logic_vector(30, output'length)) report "Error : 5*6 = " & integer'image(conv_integer(output)) & " instead of 30" severity warning;
      --
      --   for i in 0 to 255 loop
      --     for j in 0 to 255 loop
      --       input1 <= conv_std_logic_vector(i, input1'length);
      --       input2 <= conv_std_logic_vector(j, input2'length);
      --       wait for 40 ns;
      --     end loop;
      --   end loop;
      --
      --   -- test 1+1
      --   sel_line    <= "100001";
      --   --input1 <= conv_std_logic_vector(10, input1'length);
      --   --input2 <= conv_std_logic_vector(6, input2'length);
      --   --wait for 40 ns;
      --   --assert(output = conv_std_logic_vector(16, output'length)) report "Error : 10+6 = " & integer'image(conv_integer(output)) & " instead of 16" severity warning;
      --   -- test 50*60
      --   for i in 0 to  255 loop
      --     for j in 0 to 255 loop
      --       input1 <= conv_std_logic_vector(i, input1'length);
      --       input2 <= conv_std_logic_vector(j, input2'length);
      --       wait for 40 ns;
      --     end loop;
      --   end loop;
      --
      --
      --   sel_line    <= "011001";
      --   -- input1 <= conv_std_logic_vector(1, input1'length);
      --   -- input2 <= conv_std_logic_vector(2, input2'length);
      --   -- wait for 40 ns;
      --   -- assert(output = conv_std_logic_vector(2, output'length)) report "Error : 2*1 = " & integer'image(conv_integer(output)) & " instead of 2" severity warning;
      --   for i in 0 to  255 loop
      --     for j in 0 to 255 loop
      --       input1 <= conv_std_logic_vector(i, input1'length);
      --       input2 <= conv_std_logic_vector(j, input2'length);
      --       wait for 40 ns;
      --     end loop;
      --   end loop;
      --
      --   sel_line    <= "100111";
      --   -- input1 <= conv_std_logic_vector(2, input1'length);
      --   -- input2 <= conv_std_logic_vector(6, input2'length);
      --   -- wait for 40 ns;
      --   -- assert(output = conv_std_logic_vector(249, output'length)) report "Error : 2 NOR 6 = " & integer'image(conv_integer(output)) & " instead of 249" severity warning;
      --   for i in 0 to  255 loop
      --     for j in 0 to 255 loop
      --       input1 <= conv_std_logic_vector(i, input1'length);
      --       input2 <= conv_std_logic_vector(j, input2'length);
      --       wait for 40 ns;
      --     end loop;
      --   end loop;
      --
      --
      --   sel_line    <= "100110";
      --   -- input1 <= conv_std_logic_vector(2, input1'length);
      --   -- input2 <= conv_std_logic_vector(6, input2'length);
      --   -- wait for 40 ns;
      --   -- assert(output = conv_std_logic_vector(4, output'length)) report "Error : 2 XOR 6 = " & integer'image(conv_integer(output)) & " instead of 4" severity warning;
      --   for i in 0 to  255 loop
      --     for j in 0 to 255 loop
      --       input1 <= conv_std_logic_vector(i, input1'length);
      --       input2 <= conv_std_logic_vector(j, input2'length);
      --       wait for 40 ns;
      --     end loop;
      --   end loop;
      --
      --    sel_line <= "100100";
      --   -- input1 <= conv_std_logic_vector(8, input1'length);
      --   -- input2 <= conv_std_logic_vector(8, input2'length);
      --   -- wait for 40 ns;
      --   for i in 0 to  255 loop
      --     for j in 0 to 255 loop
      --       input1 <= conv_std_logic_vector(i, input1'length);
      --       input2 <= conv_std_logic_vector(j, input2'length);
      --       wait for 40 ns;
      --     end loop;
      --   end loop;
      --
      --   sel_line <= "000011";
      --   -- input1 <= conv_std_logic_vector(-1,input1'length);
      --   -- input2 <= conv_std_logic_vector(2, input2'length);
      --   -- wait for 40 ns;
      --   --
      --   for i in 0 to  255 loop
      --     for j in 0 to 255 loop
      --       input1 <= conv_std_logic_vector(i, input1'length);
      --       input2 <= conv_std_logic_vector(j, input2'length);
      --       wait for 40 ns;
      --     end loop;
      --   end loop;
      --
      --   sel_line <= "000011";
      --   -- input1 <= conv_std_logic_vector(-44, input1'length);
      --   -- input2 <= conv_std_logic_vector(2, input2'length);
      --   -- wait for 40 ns;
      --   -- add many more tests
      --
      --   for i in 0 to  255 loop
      --     for j in 0 to 255 loop
      --       input1 <= conv_std_logic_vector(i, input1'length);
      --       input2 <= conv_std_logic_vector(j, input2'length);
      --       wait for 40 ns;
      --     end loop;
      --   end loop;


        wait;

    end process;



end TB;
