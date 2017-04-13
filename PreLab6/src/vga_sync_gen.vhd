library ieee;
use ieee.std_logic_1164.all;
use work.VGA_LIB.all;
use ieee.numeric_std.all;

entity vga_sync_gen is
  port(
        clk: in std_logic;
        reset: in std_logic;
        Hcount, Vcount :out std_logic_vector(9 downto 0);  -- 10 bit std_logic_vevtor
        Horiz_Sync, Vert_Sync, Video_On: out std_logic
  );

end vga_sync_gen;



architecture BHV  of vga_sync_gen is

  signal H_temp, V_temp: std_logic_vector(9 downto 0) := std_logic_vector(to_unsigned(0,10));

  begin

    process(clk, reset)
    begin

      --if reset is true, reset both counts, video and syncs

      if(reset = '1') then
        H_temp <= (others => '0');
        V_temp <= (others => '0');
        Horiz_Sync <= '0';
        Vert_Sync <= '0';
        Video_On <= '0';
      elsif(clk'event and clk = '1') then

        if(unsigned(H_temp) = H_MAX) then
          H_temp <= std_logic_vector(to_unsigned(0,10));
        else
          H_temp <= std_Logic_vector(unsigned(H_temp) + 1);
        end if;

        if(unsigned(V_temp) = V_MAX) then
          V_temp <= std_Logic_vector(to_unsigned(0,10));
        else
          V_temp <= std_Logic_vector(unsigned(V_temp) + 1);
        end if;


        Video_On <= '1';


--conditional logic for incomplete projectiion of H and V synch
--video will be on
        if(unsigned(V_temp) > V_DISPLAY_END or unsigned(H_temp) > H_DISPLAY_END) then
          Video_On <= '0';
        end if;

        Horiz_Sync <= '1';

        if(HSYNC_BEGIN <= unsigned(H_temp) and unsigned(H_temp) <= HSYNC_END) then
            Horiz_Sync <= '0';
          end if;

          Vert_Sync <= '1';

        if(VSYNC_BEGIN <= unsigned(V_temp) and unsigned(V_temp) <= VSYNC_END) then
          Vert_Sync  <= '0';
        end if;


      end if;
    end process;

    Hcount <= H_temp;
    Vcount <= V_temp;


end BHV;
