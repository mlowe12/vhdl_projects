library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity RegisterFile is
  generic(

    WORD_WIDTH: positive;
    ADDR_WIDTH: positive
  );

  port(
      readReg1: in std_logic_vector(ADDR_WIDTH downto 0);
      readReg2: in std_logic_vector(ADDR_WIDTH downto 0);
      writeRegister: in std_logic_vector(ADDR_WIDTH downto 0);
      writeData: in std_logic_vector(WORD_WIDTH-1 downto 0);
      writeEn: in std_logic;
      clk: in std_logic;
      rst: in std_logic;
      readData1: out std_logic_vector(WORD_WIDTH-1 downto 0);
      readData2: out std_logic_vector(WORD_WIDTH-1 downto 0)
  );

end RegisterFile;


architecture BHV of RegisterFile is

  type register_File_structure is array(0 to 31) of std_logic_vector(31 downto 0);
  signal registers: register_File_structure;
  --signal readData1Reg: std_logic_vector(WIDTH-1 downto 0);
  --signal readData2Reg: std_logic_vector(WIDTH-1 downto 0);



begin
    process(clk, rst ,readReg1,readReg2,writeEn,writeRegister,writeData)
    begin
      if(rst = '1') then
        readData1<= (others => '0');
        readData2 <= (others => '0');

    elsif(clk'event and clk = '1') then
          if(writeEn = '1') then
              registers(to_integer(unsigned(writeRegister))) <= writeData;
          end if;
      end if;
      readData1 <= registers(to_integer(unsigned(readReg1)));
      readData2 <= registers(to_integer(unsigned(readReg2)));
    end process;
end BHV;
