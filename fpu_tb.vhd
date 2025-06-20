
library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity tb is
end entity;

architecture tb of tb is
  signal reset      : std_logic := '0';
  signal clk_100kHz : std_logic := '0';
  signal op_a       : std_logic_vector(31 downto 0);
  signal op_b       : std_logic_vector(31 downto 0);
  signal data_out   : std_logic_vector(31 downto 0);
  signal status_out : std_logic_vector(3 downto 0);
	
  constant clk_period : time := 10 ns;

begin

  -- Instância da FPU (Device Under Test)
  dut: entity work.logic
    port map (
      reset      => reset,
      clock => clk_100kHz,
      num_1       => op_a,
      num_2       => op_b,
      data_out   => data_out,
      status_out => status_out
    );


  clk_process : process
  begin
    while true loop
      clk_100kHz <= not clk_100kHz;
      wait for clk_period / 2;
    end loop;
  end process;

  -- Estímulos de teste
  teste : process
  begin
    reset <= '1';

op_a <= "001111111111" & "10000000000000000000"; -- +1.0
op_b <= "001110001110" & "11000000000000000000"; -- +1.0
wait for 1000 ns;
reset <= '0';
wait for clk_period;
reset <= '1';

op_a <= "001111111111" & "10000000000000000000"; -- +1.0
op_b <= "001111111110" & "11000000000000000000"; -- +1.0
wait for 1000 ns;
reset <= '0';
wait for clk_period;
reset <= '1';

op_a <= "001111111111" & "10000000000000000000"; -- +1.0
op_b <= "101111111110" & "11000000000000000000"; -- +1.0
wait for 1000 ns;
reset <= '0';
wait for clk_period;
reset <= '1';

  end process;
end architecture;

