library ieee;
use ieee.std_logic_1164.all;
use numeric_std.all;

entity datapath is
    generic(
        WIDTH: positive := 32
    );

    port(

          --INTERFACE to INPUT
          clk: in std_logic;
          rst: in std_logic;

          InPort1: in std_logic_vector(WIDTH-1 downto 0);
          InPort2: in std_logic_vector(WIDTH-1 downto 0);
          InPort1_en: in std_logic;
          InPort2_en: in std_logic;



          -- FROM THE CONTROLLER
          PC_Write: in std_logic;
          PC_Write_Cond: in std_logic;
          I_or_D: in std_logic;
          Mem_Read: in std_logic;
          Mem_to_Reg: in std_logic;
          Mem_Write: in std_logic;
          IR_Write: in std_logic;
          Jump_and_Link: in std_logic;
          Is_Signed: in std_logic;
          PC_Soruce: in std_logic_vector(1 downto 0);

          --ALU CONTROLLER

          ALU_low_hi: in std_logic_vector(1 downto 0);
          high_en: in std_logic;
          low_en: in std_logic;
          OpSelect: in alu_ins;

          ALUSrcA: in std_logic;
          ALUSrcB: in std_logic_vector(1 downto 0);
          Reg_Write: in std_logic;
          Reg_Dst: in std_logic
    );

  end datapath;

  architecture struct of datapath is

    component register
      generic(width: positive := 32);
      port(
            clk: in std_logic;
            rst: in std_logic;
            en: in std_logic;

            input: in std_logic_vector(WIDTH-1 downto 0);
            output: out std_logic_vector(WIDTH-1 downto 0)
      );
    end component;


    component ResisterFile
      generic( ADDR_WIDTH: positive; WORD_WIDTH: positive);
      port(
            clk: in std_logic;
            rst: in std_logic;
            write_en: in std_logic;
            Jump_and_Link: in std_logic;
            readReg1: in std_logic_vector(ADDR_WIDTH-1 downto 0);
            readReg2: in std_logic_vector(ADDR_WIDTH-1 downto 0);
            writeRegister: in std_logic_vector(ADDR_WIDTH-1 downto 0);
            wr_data: in std_logic_vector(WORD_WIDTH-1 downto 0);
            readData1: out std_logic_vector(WORD_WIDTH-1 downto 0);
            readData2: out std_logic_vector(WORD_WIDTH-1 downto 0)
      );
    end component;


    component ALU
      generic(WIDTH: positive := 32);
      port(
            input1: in std_logic_vector(WIDTH-1 downto 0);
            input2: in std_logic_vector(WIDTH-1 downto 0);
            sel_line: in alu_ins;
            branch: out std_logic;
            output: std_logic_vector(WIDTH-1 downto 0);
            high_reg: out std_logic_vector(WIDTH-1 downto 0)
      );
    end component;


    component two_one_mux
      generic(WIDTH: positive := 32);
      port(
            input1: in std_logic_vector(WIDTH-1 downto 0);
            input2: in std_logic_vector(WIDTH-1 downto 0);
            sel_line in std_Logic;
            output: out std_logic_vector(WIDTH-1 downto 0)
      );
    end component;


    component four_one_mux
      generic(WIDTH: positive := 32);
      port(
            input1: in std_logic_vector(WIDTH-1 downto 0);
            input2: in std_logic_vector(WIDTH-1 downto 0);
            input3: in std_logic_vector(WIDTH-1 downto 0);
            input4: in std_logic_vector(WIDTH-1 downto 0);
            sel_line: in std_logic_vector(1 downto 0);
            output: out std_logic_vector(WIDTH-1 downto 0)
      );
    end component;



    component Memory
    generic(WIDTH: positive := 32);
    port(
        clk: in std_logic;
        rst: in std_logic;
        mem_read: in std_logic;
        mem_write: in std_logic;
        InPort1_en: in std_logic;
        InPort2_en: in std_logic;
        pc_addr: in std_logic_vector(WIDTH-1 downto 0);
        REGB_OUT: in std_logic_vector(WIDTH-1 downto 0);
        InPort1: in std_logic_vector(WIDTH-1 downto 0);
        InPort2: in std_logic_vector(WIDTH-1 downto 0);
        OutPort: out std_logic_vector(WIDTH-1 downto 0);
        data_out_to_IR: out std_logic_vector(WIDTH-1 downto 0)

    );
  end component;


-- DELCARE SIGNALS TO TIE COMPONENTS TOGETHER FOR DATAPATH ARCHITECTURE

-- REGISTER SIGNALS
signal reg_PC_cnt: std_logic_vector(WIDTH-1 downto 0);
signal reg_A_out: std_logic_vector(WIDTH-1 downto 0);
signal reg_B_out: std_logic_vector(WIDTH-1 downto 0);
signal reg_ALU_out: std_logic_vector(WIDTH-1 downto 0);
signal reg_ALU_low: std_logic_vector(WIDTH-1 downto 0);
signal reg_ALU_high: std_logic_vector(WIDTH-1 downto 0);
signal reg_MEM_out: std_logic_vector(WIDTH-1 downto 0);
signal reg_instruct_out: std_logic_vector(WIDTH-1 downto 0);

--REGISTERFILE SIGNALS

signal read_data1: std_logic_vector(WIDTH-1 downto 0);
signal read_data2: std_logic_vector(WIDTH-1 downto 0);



-- MUX SIGNALS

signal mux_addr_out: std_logic_vector(WIDTH-1 downto 0);
signal mux_reg_dst_out: std_logic_vector(4 downto 0);
signal mux_mem_reg_out: std_logic_vector(WIDTH-1 downto 0);
signal mux_reg_A_out: std_logic_vector(WIDTH-1 downto 0);
signal mux_reg_B_out: std_logic_vector(WIDTH-1 downto 0);
signal mux_pc_src_out: std_logic_vector(WIDTH-1 downto 0);
signal mux_low_high_out: std_logic_vector(WIDTH-1 downto 0);


-- ALU SIGNALS

signal ALU_branch: std_logic;
signal ALU_high: std_logic_vector(WIDTH-1 downto 0);
signal ALU_output: std_logic_vector(WIDTH-1 downt0 0);


-- MEMORY SIGNALS

signal pc_cnt_en: std_logic;
signal MEM_out: std_logic_vector(WIDTH-1 downto 0);
signal sign_Extend: std_logic_vector(WIDTH-1 downto 0);
signal shiftLeft: std_logic_vector(WIDTH-1 downto 0);
signal ir_out_TB_SL: std_logic_vector(27 downto 0);
signal concat: std_logic_vector(WIDTH-1 downto 0);

signal DISP_4: std_logic_vector(WIDTH-1 downto 0) := std_logic_vector(to_unsigned(4, WIDTH));

signal not_clk: std_logic;



begin


  not_clk <= not (clk);
  pc_cnt_en <= PC_Write OR ( PC_Write_Cond AND ALU_branch);
  op_out <= reg_instruct_out(WIDTH-1 downto 26);
  ALU_sel <= reg_instruct_out(5 downto 0);

  ir_out_TB_SL <= std_logic_vector(resize(unsigned(reg_instruct_out(25 downto 0), reg_instruct_out'length ));
  concat <= std_logic_vector(reg_PC_cnt(31 downto 28) & ir_out_TB_SL);


--instantiate and assign components of datapath

U_ALU: entity work.ALU generic map(WIDTH) port map(mux_reg_A_out, mux_reg_B_out, OpSelect, reg_instruct_out(10 downto 6), ALU_brach, ALU_output, ALU_high);


--U_MUX_REG_DST: entity work.two_one_mux generic map(5) port map(Reg_Dst, reg_instruct_out(20 downto 16), reg_instruct_out(15 downto 11), mux_reg_dst_out);
--U_MUX_MEM_REG: entity work.two_one_mux generic map(WIDTH) port map(Mem_to_Reg, mux_low_high_out, reg_mem_reg_out,
