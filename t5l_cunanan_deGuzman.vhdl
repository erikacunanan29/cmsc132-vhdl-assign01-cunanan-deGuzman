-- Behavioral Design of Farm Storages Alarm
-- Author: Cunanan, Maria Erika Dominique C. ; De Guzman, Alyssa Joi A.

-- Library Statements
library IEEE; use IEEE.std_logic_1164.all;

-- Entity Definition
entity t5l_cunanan_deGuzman is
	port(alarm: out std_logic; -- alarm on if alarm=1
	buzzers: in std_logic_vector(5 downto 0)); -- input for the buzzers (5-3 for the in buzzers; 2-0 for the out buzzers);
end entity t5l_cunanan_deGuzman; -- priority order: buzzers(5) -> buzzers(0)

-- Architecture Definition
architecture behavioral of t5l_cunanan_deGuzman is
begin
	process (buzzers(5), buzzers(4), buzzers(3), buzzers(2), buzzers(1), buzzers(0)) is -- activate when any input changes
	begin
		if (((buzzers(5)='1') or (buzzers(4)='1') or (buzzers(3)='1')) and ((buzzers(2)='1') or (buzzers(1)='1') or (buzzers(0)='1'))) -- check if there is an in buzzer and out buzzer that is on (different storage)
			then alarm <='1';	-- if true, alarm is activated
		else	
			alarm <='0';	-- else, alarm is not activated
		end if;
	end process;
end architecture behavioral;