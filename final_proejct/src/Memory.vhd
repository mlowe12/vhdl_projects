LIBRARY ieee;
USE ieee.std_logic_1164.all;


entity Memory is

  generic(WIDTH: positive := 32);

  port(
        pc_addr: in std_logic_vector(WIDTH-1 downto 0); -- data from PC
        REGB_OUT: in std_logic_vector(WIDTH-1 downto 0); --output from REGISTER B
        clk: in std_logic; --drives memory device
        rst: in std_logic; --button resets memory device access
        mem_write: in std_logic; -- allows for data to be written to memory
        mem_read: in std_logic;
        InPort1: in std_logic_vector(15 downto 0); -- switches + 10 bit extension
        InPort2: in std_logic_vector(15 downto 0); -- switches + 10 bit extension
        InPort1_en: in std_logic; -- button
        InPort2_en: in std_logic; -- button


        data_out_to_IR: out std_logic_vector(WIDTH-1 downto 0); --output to RegisterFile
        OutPort: out std_logic_vector(WIDTH-1 downto 0) --output to LED's
        --out_en: out std_logic
        );

end Memory;


architecture struct of Memory is

--REGISTERS CREATED DURING PROCESS
  signal InPort1_REG: std_logic_vector(15 downto 0);
  signal InPort2_REG: std_logic_vector(15 downto 0);
  signal OUTREG: std_logic_vector(WIDTH-1 downto 0);


--DECODER SIGNALS
  signal addr: std_logic_vector(WIDTH-1 downto 0);
  signal MemWrite: std_logic;
  signal RAM_enable: std_logic;
  signal OUTPUT_enable: std_logic_vector(1 downto 0);
  signal LED_OUTPUT_enable: std_logic;

  --RAM SIGNALS
  signal short_address: std_logic_vector(7 downto 0);
  signal notClk: std_logic;
  signal data: std_logic_vector(WIDTH-1 downto 0);
  signal decoder_ram_enable: std_logic;
  signal RAM_output: std_logic_vector(WIDTH-1 downto 0);

--MUX SIGNALS
  signal q_out_from_RAM: std_logic_vector(WIDTH-1 downto 0);
  signal InPort1_REG_to_MUX: std_logic_vector(WIDTH-1 downto 0);
  signal InPort2_REG_to_Mux: std_logic_vector(WIDTH-1 downto 0);
  signal MUX_OUTPUT: std_logic_vector(WIDTH-1 downto 0);
  signal DEC_TO_MUX: std_logic_vector(1 downto 0);
  signal MUX_ZERO_INPUT: std_logic_vector(WIDTH-1 downto 0);



  --signal data_out_REG: std_logic_vector(WIDTH-1 downto 0);
  signal REGB_temp: std_logic_vector(WIDTH-1 downto 0);
  signal OUTPORT_en: std_logic; --OUTPORT enable
  --signal data_to_IR_temp: std_logic_vector(WIDTH-1 downto 0);
  signal sel_line_temp: std_logic_vector(1 downto 0);


begin

  U_DECODER: entity work.decoder
    port map(
          address => addr,
          MemWrite => MemWrite,
          RAM_enable => RAM_enable,
          OUTPUT_enable => OUTPUT_enable,
          LED_OUTPUT_enable => LED_OUTPUT_enable
  );

  addr <= pc_addr;
  MemWrite <= MemWrite;
  short_address <= pc_addr(7 downto 0);
  data <= REGB_OUT;


  U_INPORT_REG1: entity work.REG
    port map(
          clk => clk,
          rst => rst,
          en => InPort1_en,
          input => InPort1,
          output => InPort1_REG

    );

    U_INPORT_REG2: entity work.REG
    port map(
        clk => clk,
        rst => rst,
        en => InPort2_en,
        input => InPort2,
        output => InPort2_REG
    );



  U_RAM: entity work.RAM
    port map(
            address => short_address,
            clock => clk,
            data => data,
            wren => decoder_ram_enable,
            q => RAM_output
    );

    decoder_ram_enable <= RAM_enable;
    sel_line_temp <= OUTPUT_enable;

    q_out_from_RAM <= RAM_output;
    MUX_ZERO_INPUT <= (others => '0');
    InPort1_REG_to_MUX <= InPort1_REG;
    InPort2_REG_to_MUX <= InPort2_REG;
    OUTPORT_en <= LED_OUTPUT_enable;

    U_OUTPUT_REG: entity work.REG
      port map(
          clk => clk,
          rst => rst,
          en => OUTPORT_en,
          input => data,
          output => OUTREG
      );



  U_OUT_MUX: entity work.four_one_mux
    port map(
            input1 => q_out_from_RAM,
            input2 => MUX_ZERO_INPUT,
            input3 => InPort1_REG_to_MUX,
            input4 => InPort2_REG_to_MUX,
            sel_line =>  sel_line_temp, --select line is determined by the decoder entity
            output => MUX_OUTPUT
    );




end struct;
