-- Greg Stitt
-- University of Florida

-- Exhaustive testbench for the adder. Be aware that increasing the TEST_WIDTH
-- constant could make the simulation take a very long time.

library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;
use ieee.std_logic_unsigned.all; 
use ieee.std_logic_arith.all; 



entity reversed_tb is
end reversed_tb;

architecture TB of reversed_tb is

  constant TEST_WIDTH : positive := 4; 
  constant TEST_WIDTH2 : positive := 8; 

  signal a    : std_logic_vector(TEST_WIDTH-1 downto 0) := (others => '0');
  signal b    : std_logic_vector(TEST_WIDTH-1 downto 0) := (others => '0');
  signal sum    : std_logic_vector(TEST_WIDTH-1 downto 0) := (others => '0');
  signal ccin  : std_logic := '0';
  signal ccout : std_logic;

begin  -- TB

  UUT : entity work.reversed
    port map (
      x     => a,
      y     => b,
      s     => sum,
      cin   => ccin,
      cout  => ccout);

  process
    variable temp         : std_logic_vector(TEST_WIDTH downto 0);
    variable correct_sum  : std_logic_vector(TEST_WIDTH-1 downto 0);
    variable correct_cout : std_logic;
    
  begin

    -- test all input combinations
    for i in 0 to 2**TEST_WIDTH-1 loop
      for j in 0 to 2**TEST_WIDTH-1 loop
        for k in 0 to 1 loop

          a   <= conv_std_logic_vector(i, 4);
          b   <= conv_std_logic_vector(j, 4);
          ccin <= conv_std_logic_vector(k, 1)(0);
          wait for 10 ns;

          -- check for correct outputs
          --temp         := conv_std_logic_vector((i, TEST_WIDTH+1)+(j, TEST_WIDTH+1)+(k, TEST_WIDTH+1));
          --correct_sum  := temp(TEST_WIDTH-1 downto 0);
          --correct_cout := temp(TEST_WIDTH);
          --assert(sum = correct_sum) report "Sum incorrect";
         -- assert(ccout = correct_cout) report "Carry out incorrect";

        end loop;  -- k
      end loop;  -- j
    end loop;  -- i

    report "SIMULATION DONE!";
    wait;

  end process;

end TB;
