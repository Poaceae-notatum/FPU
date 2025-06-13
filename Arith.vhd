library IEEE;
use IEEE.STD_logic_1164.all
use IEEE.numeric.all;

entity Logic is port(
clock : in STD_LOGIC;
num_1 : in STD_LOGIC_VECTOR(31 downto 0) := (others => '0');
num_2 : in STD_LOGIC_VECTOR(31 downto 0) := (others => '0');
reset : in STD_LOGIC := '1';

data_out	: out STD_LOGIC_VECTOR(31 downto 0);
status_out	: out STD_LOGIC_VECTOR(3 downto 0);
);
end entity;
-- [1 = 31] - [11 = 30 downto 20] - [20 = 19 downto 0]
-- x = 11;
-- y = 20;

architecture logic of Logic is

-- _a = numero 1 (num_1)
signal den_a : std_logic := num_1(31);
--0 = positivo, 1 = negativo
signal exp_a : integer := to_integer(num_1(30 downto 20));
-- expoente do numero - 1023
signal man_a : STD_LOGIC_VECTOR(19 downto 0) := num_1(19 downto 0);
-- numero em si

-- _b = numero 2 (num_2)
signal den_b : std_logic := num_2(31);
--0 = positivo, 1 = negativo
signal exp_b : integer := to_integer(num_2(30 downto 20));
-- expoente do numero - 1023
signal man_b : STD_LOGIC_VECTOR(19 downto 0) := num_2(19 downto 0);
-- o numero em si

signal status : 

begin
main : process (clock,reset)
variable man_temp : std_logic_vector(19 downto 0) := (others => '0');
variable den_temp : std_logic;
variable exp_temp : std_logic_vector(10 downto 0);
 begin
if ( reset = '0') then

elsif (rising_edge(clock)) then
if(exp_a - exp_b > 7 or exp_b - exp_b > 7) then

elsif (exp_b /= exp_a) then
	if(exp_a > exp_b) then
	 exp_b <= exp_b + 1;
	 man_b <= '0' & man_b(19 downto 1);
	else --exp_b > exp_a
	 exp_a <= exp_a + 1;
	 man_a <= '0' & man_a(19 downto 1);
	end if;
elsif( exp_b = exp_a ) then
	if(man_a > man_b)
	 if(den_a = '1')
	  man_temp = man_a - man_b;
	 elsif(den_a = '0')
	  man_temp = man_a + man_b;
	if(man_b > man_a)
	 if(den_b = '1')
	  man_temp = man_b - man_a;
	 elsif(den_b = '0')
	  man_temp = man_b + man_a;

end if;
