library ieee;
use ieee.std_logic_1164.all;
use work.VGA_LIB.all;
use ieee.numeric_std.all;

entity top_level is
  port(
          clk: in std_logic; --50 MHz clock
          reset: in std_logic;
          buttons_n: in std_logic_vector(2 downto 0);
          col_enable: in std_logic;
          row_enable: in std_logic; 
          red, green, blue: out std_logic_vector(3 downto 0);
          h_sync, v_sync: out std_logic

  );

end top_level;


architecture BHV of top_level is

signal internal_clk: std_logic; := '0';
signal internal_Hcount: std_logic_vector(9 downto 0);
signal internal_Vcount: std_logic_vector(9 downto 0);
signal Horiz_Sync: std_logic;
signal Vert_Sync: std_logic;
signal Video_On: std_logic;
signal rom_col: std_logic_vector(5 downto 0);
signal rom_row: std_logic_vector(5 downto 0);
signal rom_address: std_logic_vector(11 downto 0);
signal q: std_logic_vector(11 downto 0);



  UU1: entity work.pixelclk
  port map(
    clk => clk,
    reset => reset,
    pixel_clock => internal_clk
  );


  UU2: entity work.vga_sync_gen
  port map(
    clk => internal_clk,
    reset => reset,
    Hcount => internal_Hcount,
    Vcount => internal_Vcount,
    Horiz_Sync => Horiz_Sync,
    Vert_Sync => Vert_Sync,
    Video_On => Video_On
  );


    UU3: entity work.col_cnt
    port map(
      input => internal_Hcount,
      output => rom_col
    );


    UU4: entity work.row_cnt
    port map(
        input => internal_Vcount,
        output => rom_row
    );

    UU5: entity vga_rom
    port map(
        clk => internal_clk,
        input => rom_row  & rom_col,
        q => q
    );



    begin

      process(q)
      begin
