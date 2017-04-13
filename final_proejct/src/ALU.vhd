--MICHAEL LOWE
--EEL 4712 MIPS MICROPROCESSOR FINAL PROJECT
--DELIVERABLE 1



library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity ALU is

  generic(
    WIDTH: positive := 16
  );


  port(
          input1:   in std_logic_vector(WIDTH-1 downto 0);
          input2:   in std_logic_vector(WIDTH-1 downto 0);
          sel_line: in std_logic_vector(5 downto 0); --6 bit control
          output:   out std_logic_vector(WIDTH-1 downto 0);
          high_reg: out std_logic_vector(WIDTH-1 downto 0);
          --less_than_flag: out std_logic;
          branch: out std_logic
  );


end ALU;



architecture BHV of ALU is

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






--template function to continuously call a shift right. Logic will be byypassed through this function instead of through the process directly
-- fuction takes in @Param X and returns the number shifted once
  function ARITHMETIC_SHIFT_RIGHT(X: unsigned)
    return unsigned is
      begin
        return SHIFT_RIGHT(X, 1);
  end ARITHMETIC_SHIFT_RIGHT;

--end function declaration


  --continue list of ALU functionality


  begin

    process(sel_line,input1,input2)

    variable  temp: unsigned(WIDTH-1 downto 0);
    variable  mult_result: unsigned(2*WIDTH-1 downto 0) := (others => '0');
    variable high: unsigned(WIDTH-1 downto 0) := (others => '0');


    begin
      case sel_line is
        when ADD_U =>
            temp :=  unsigned(input1) + unsigned(input2);
            high := (others => '0');
            branch <= '0';


        when SUB_U =>
            temp := unsigned(input1) - unsigned(input2);
            high := (others => '0');
              branch <= '0';

        when MULT_U =>
            mult_result := unsigned(input1) * unsigned(input2);
            high := mult_result(2*WIDTH-1 downto WIDTH);
            temp:= mult_result(WIDTH-1 downto 0);
              branch <= '0';


        when C_AND =>
          	temp := unsigned((input1) AND (input2));
            high := (others => '0');
              branch <= '0';

        when C_OR =>
          	temp := unsigned((input1) OR (input2));
            high := (others => '0');
              branch <= '0';

        when C_XOR =>
          	temp := unsigned((input1) XOR (input2));
            high := (others => '0');
              branch <= '0';

        when C_NOR =>
          	temp := unsigned((input1) NOR (input2));
            high := (others => '0');
              branch <= '0';

        when L_SHIFT =>
            temp := SHIFT_LEFT(unsigned(input1), to_integer(unsigned(input2)));
            high := (others => '0');
              branch <= '0';

        when R_SHIFT =>
            temp := SHIFT_RIGHT(unsigned(input1), to_integer(unsigned(input2)));
            high := (others => '0');
              branch <= '0';


        when BEQ =>
            if(unsigned(input1) = unsigned(input2)) then
              temp := to_unsigned(0,input1'length);
              high := (others => '0');
              branch <= '1';
            else
              temp := to_unsigned(0, input2'length);
              high := (others => '0');
              branch <= '0';
            end if;

        when BNE =>
            if(unsigned(input1) /= unsigned(input2)) then
              temp := to_unsigned(0, input1'length);
              high := (others => '0');
              branch <= '1';
            else
                temp := to_unsigned(0, input1'length);
                high := (others => '0');
                branch <= '0';
            end if;

        when BEZ =>
            if(unsigned(input1)  = 0) then
              temp := to_unsigned(0, input1'length);
              high := (others => '0');
              branch <= '1';
            else
                temp := to_unsigned(0, input1'length);
                high := (others => '0');
                branch <= '0';
            end if;

        when BNEZ =>
          if(unsigned(input1) /= unsigned(input2)) then
            temp := to_unsigned(0, input1'length);
            high := (others => '0');
            branch <= '1';
          else
              temp := to_unsigned(0, input1'length);
              high := (others => '0');
              branch <= '0';
          end if;

        -- when SLTU =>
        --   if(input1 > input2) then
        --     less_than_flag <= '0';
        --   else
        --     less_than_flag <= '1';
        --   end if;



        --calls the function ARITHMETIC_SHIFT_RIGHT and runs for input2'length interations
        when AR_SHIFT_RIGHT =>
              for i in 0 to (to_integer(unsigned(input2)) - 1) loop
                    temp := ARITHMETIC_SHIFT_RIGHT(unsigned(input1));
                    if(temp(WIDTH-2) = '1')
                      then temp(WIDTH-1) := '1';
                      high := (others => '0');
                    else
                        temp(WIDTH-1) := '0';
                        high := (others => '0');
                    end if;

              end loop;

              branch <= '0';

        when others => null;


      end case;

      output <= std_logic_vector(temp);
      high_reg <= std_logic_vector(high);

    end process;
  end BHV;
