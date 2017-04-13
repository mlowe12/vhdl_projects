library ieee;
use ieee.std_logic_1164.all;

entity Controller is
    port(
      clk: in std_logic;
      rst: in std_logic;
      IR_intput: in std_logic_vector(4 downto 0);

      JumpAndLink: out std_logic;
      isSigned: out std_logic;
      PCSource: out std_logic_vector(1 downto 0);
      ALUOp: out std_logic_vector(1 downto 0);
      ALUSrcB: out std_logic_vector(1 downto 0);
      ALUSrcA: out std_logic;
      RegWrite: out std_logic;
      RegDst: out std_logic;
      PCWrite: out std_logic;
      PCWriteCond: out std_logic;
      IorD: out std_logic;
      MemRead: out std_logic;
      MemToReg: out std_logic;
      IRWrite: out std_logic
    );

  end Controller;


    architecture struct of Controller is

      type STATE_TYPE is (RESET, FETCH, DECODE, MEM_ADDR_COMP, MEM_ACCESS_RD, MEM_ACCESS_WR,
                          MEM_READ_COMP, EXECUTION, R_TYPE, I_TYPE );
      signal state: STATE_TYPE;
      signal next_state: STATE_TYPE;

      begin

          process(clk, rst)
            if(rst = '1') then
              state <= RESET;
            elsif(clk'event and clk = '1') then
              state <= next_state;
            end if;
          end process;

          process(state)
            case state is
                when RESET =>
                JumpAndLink = '0';
                isSigned = '0';
                PCSource = "00";
                ALUOp = "00";
                ALUSrcA = '0';
                ALUSrcB = "00";
                RegWrite = '0';
                RegDst '0';
                PCWriteCond = '0';
                PCWrite = '0';
                IorD = '0';
                MemRead = '0';
                MemToReg = '0';
                IRWrite = '0';

                next_state <= FETCH;

                when FETCH =>
                  MemRead = '1';
                  ALUSrcA = '0';
                  IorD = '0';
                  IRWrite = '1';
                  ALUSrcB = "01";
                  ALUOp = "00";
                  PCWrite = '1';
                  PCSource = "00";

                  next_state <= DECODE; 
