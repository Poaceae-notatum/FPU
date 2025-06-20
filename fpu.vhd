library IEEE;
use IEEE.STD_logic_1164.all;
use IEEE.numeric_STD.all;

entity Logic is port(
clock : in STD_LOGIC;
num_1 : in STD_LOGIC_VECTOR(31 downto 0) := (others => '0');
num_2 : in STD_LOGIC_VECTOR(31 downto 0) := (others => '0');
reset : in STD_LOGIC := '1';

data_out	: out STD_LOGIC_VECTOR(31 downto 0);
status_out	: out STD_LOGIC_VECTOR(3 downto 0)
);
end entity;
-- minha matricula eh 24107981-3
-- 8 + (3 = impar) (24107981-3 = 35) % 4
-- 8 + 3 = 11 
-- [1 = 31] - [11 = 30 downto 20] - [20 = 19 downto 0]
-- x = 11;
-- y = 20;

architecture logic of Logic is

-- _a = numero 1 (num_1)
signal den_a : std_logic := '0';
--0 = positivo, 1 = negativo
signal exp_a : signed(10 downto 0) := (others => '0');
-- expoente do numero - 1023
signal man_a : unsigned(20 downto 0) := (others => '0');
-- numero em si

-- _b = numero 2 (num_2)
signal den_b : std_logic := '0';
--0 = positivo, 1 = negativo
signal exp_b : signed(10 downto 0) := (others => '0');
-- expoente do numero - 1023
signal man_b : unsigned(20 downto 0) := (others => '0');
-- o numero em si

signal status: STD_LOGIC_VECTOR(2 downto 0):= (others => '0');

begin
main : process (clock,reset)
variable man_temp   : unsigned(20 downto 0) := (others => '0');
variable den_temp   : std_logic := '0';
variable exp_temp   : signed(10 downto 0) := (others => '0');
variable outpstatus : std_logic_vector(3 downto 0) := (others => '0');
 begin
if ( reset = '0') then
den_a <= '0';
exp_a <= (others => '0');
man_a <= (others => '0');

den_b <= '0';
exp_b <= (others => '0');
man_b <= (others => '0');

man_temp   := (others => '0');
den_temp   := '0';
exp_temp   := (others => '0');
outpstatus := (others => '0');

status <= "000";

elsif (rising_edge(clock)) then
case status is

	when "000" =>
	 den_a <= num_1(31);
	 exp_a <= signed(unsigned(num_1(30 downto 20)));
	 man_a <= '0' & unsigned(num_1(19 downto 0));

	 den_b <= num_2(31);
	 exp_b <= signed(unsigned(num_2(30 downto 20)));
	 man_b <= '0' & unsigned(num_2(19 downto 0));
	
	 status <= "001";

	when "001" =>
	 if(exp_a - exp_b > 7) then
		man_temp   := man_a;
		den_temp   := den_a;
		exp_temp   := exp_a;
	  status <= "100";
	 elsif (exp_b - exp_a > 7) then
		man_temp   := man_b;
		den_temp   := den_b;
		exp_temp   := exp_b;
	  status <= "100";
	 else
	  status <= "010";
	  exp_b <= exp_b - 1027;
	  exp_a <= exp_a - 1027;
	 end if;

	when "010" =>
	 if(exp_a > exp_b) then
	  exp_b <= exp_b + 1;
	   if (man_b(0) = '1') then
	    outpstatus(0) := '1';
	   end if;----------------------------------------------------------------------
	  man_b <= '0' & man_b(20 downto 1);
	 elsif(exp_b > exp_a) then
	  exp_a <= exp_a + 1;
	   if (man_a(0) = '1') then
	    outpstatus(0) := '1';
	   end if;
	  man_a <= '0' & man_a(20 downto 1);
	 elsif (exp_b = exp_a) then
	   status <= "011";
	   exp_temp := exp_a + 1027;
	 end if;
	when "011" =>

		if(man_a > man_b)then
		 if(den_a = '1') then
		  if(den_b = '1') then
		   man_temp := man_a + man_b;
		   den_temp := '1';
		  else
		   man_temp := man_a - man_b;
		   den_temp := '1';
		  end if;
		 elsif(den_a = '0') then
		  if(den_b = '1') then
		   man_temp := man_a - man_b;
		   den_temp := '0';
		  else
		   man_temp := man_a + man_b;
		   den_temp := '0';
		  end if;
		 end if;
		elsif(man_b > man_a) then
		 if(den_a = '1') then
		  if(den_b = '1') then
		   man_temp := man_b + man_a;
		   den_temp := '1';
		  else
		   man_temp := man_b - man_a;
		   den_temp := '0';
		  end if;
		 elsif(den_a = '0') then
		  if(den_b = '1') then
		   man_temp := man_b - man_a;
		   den_temp := '1';
		  else
		   man_temp := man_b + man_a;
		   den_temp := '0';
		  end if;
		 end if;
		 
		elsif(man_b = man_a) then
		 if((den_a = '1' and den_b = '0') or (den_b = '1' and den_a = '0')) then
		  man_temp := (others => '0');
		 else
		  man_temp := man_b + man_a;
		  den_temp := '0';
		 end if;
		end if;
		status <= "100";
when "100" =>
  if ((man_temp(20 downto 19) = "00") and (man_temp /= 0)) then
	exp_temp := exp_temp - 1;
	man_temp := man_temp(19 downto 0) & '0';
  else
	if( man_temp(20) = '1') then
	 data_out(31) <= den_temp;
	 data_out(30 downto 20) <= std_logic_vector(exp_temp + 1);
	 data_out(19 downto 0) <= std_logic_vector(man_temp(20 downto 1));
	else
	 data_out <= den_temp & std_logic_vector(exp_temp) & std_logic_vector(man_temp(19 downto 0));
	end if;
  end if;
when others =>
 end case;
end if;
end process;
end architecture;
