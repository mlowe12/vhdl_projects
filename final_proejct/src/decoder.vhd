library ieee;
use ieee.std_logic_1164.all;


entity decoder is
  generic(WIDTH: positive := 32);


  port(
        address: in std_logic_vector(WIDTH-1 downto 0);
        MemWrite: in std_logic; -- top level writeEnable from controller
        --MemRead, MemWrite: in std_logic;
        RAM_enable: out std_logic; -- RAM component enable to write
        OUTPUT_enable: out std_logic_vector(1 downto 0); -- MEMORY TOP LEVEL mux  output enable
        LED_OUTPUT_enable: out std_logic -- DATA FROM REGB output enable
  );
end decoder;


architecture BHV of decoder is
  signal TOP_address: std_logic_vector(5 downto 0); -- load/store bits
  signal BOTTOM_address: std_logic_vector(5 downto 0);  -- logic/ arithmetic bits
  signal RAM_WRITE: std_logic; -- outputs an enable for the RAM component
  signal OUTPUT_en_tmep: std_logic;
  signal LED_OUTPUT_enable_temp: std_logic;

  begin
    process(address)
      TOP_address <= address(WIDTH-1 downto WIDTH-6); -- assign TOP address bits to signal
      BOTTOM_address <= address(5 downto 0); -- assign BOTTOM to signals
      if(MemWrite = '1') then
        if(TOP_address(3) = '1') then
          RAM_WRITE <= '1';
        elsif(TOP_address(3) = '0') then
          RAM_WRITE <= '0';
        end if;
      else
        RAM_WRITE <= '0';
        if(TOP_address(WIDTH-1 downto WIDTH-6 = "000000")) then
            LED_OUTPUT_enable_temp <= '1';
        else
            LED_OUTPUT_enable_temp <= '0';
        end if;

        if(TOP_address = "100011") then --load word from RAM
            OUTPUT_en_tmep <= "00";
        elsif(TOP_address = "101011" AND BOTTOM_address = X"FFF8") then  -- store inport1 word in RAM
            OUTPUT_en_tmep <= "10";
        elsif(TOP_address = "101011" AND BOTTOM_address = X"FFFC") then --store inport2 word in RAM
            OUTPUT_en_tmep <= "11";
        else
            OUTPUT_en_tmep <= "01"; --zero output case

        end if;

      end if;
    end process;

    RAM_enable <= RAM_WRITE;

  end BHV;
