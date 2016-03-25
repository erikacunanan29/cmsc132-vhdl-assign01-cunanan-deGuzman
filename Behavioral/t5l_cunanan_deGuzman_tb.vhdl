-- Test Bench for a Farm Storages Alarm
-- Author: Cunanan, Maria Erika Dominique C. ; De Guzman, Alyssa Joi A.

-- Library Statements
library IEEE; use IEEE.std_logic_1164.all;
use IEEE.numeric_std.all;

-- Entity Definition
entity t5l_cunanan_deGuzman_tb is -- constants are defined here
	constant MAX_COMB: integer:=64; -- number of input combinations (6 bits)
	constant DELAY: time:=10 ns; -- delay value in testing
end entity t5l_cunanan_deGuzman_tb;

architecture tb of t5l_cunanan_deGuzman_tb is
	signal alarm: std_logic; -- alarm output from the UUT
	signal buzzers: std_logic_vector(5 downto 0); -- inputs to UUT
	
	-- Component Declaration
	component t5l_cunanan_deGuzman is
		port(alarm: out std_logic; -- 1 if the alarm is activated based on the conditions
		buzzers: in std_logic_vector(5 downto 0)); -- ix (0 <= x <= 5) indicates decimal value x;
	end component t5l_cunanan_deGuzman;
	
begin -- begin main body of the tb architecture
	-- instantiate the unit under test
	UUT: component t5l_cunanan_deGuzman port map(alarm, buzzers);
	
	-- main processes: generate test vectors and check results
	main: process is
		variable temp: unsigned (5 downto 0); -- used in calculations
		variable expected_alarm: std_logic;
		variable error_count: integer := 0; -- number of simulations error
		
	begin
		report "Start simulations.";
		
		-- generate all possible input values, since max=63
		for count in 0 to 63 loop
			temp:=TO_UNSIGNED(count, 6);
			buzzers(5) <= std_logic(temp(5)); -- 6th bit
			buzzers(4) <= std_logic(temp(4)); -- 5th bit
			buzzers(3) <= std_logic(temp(3)); -- 4th bit
			buzzers(2) <= std_logic(temp(2)); -- 3rd bit
			buzzers(1) <= std_logic(temp(1)); -- 2nd bit
			buzzers(0) <= std_logic(temp(0)); -- 1st bit
			
			-- compute expected values
			if (count=0) then
				expected_alarm:='0';
			else
				if (((temp(5)='1') or (temp(4)='1') or (temp(3)='1')) and ((temp(2)='1') or (temp(1)='1') or (temp(0)='1'))) then
					expected_alarm:='1';
				else
					expected_alarm:='0';
				end if;
			end if; 
			wait for DELAY; -- wait, and then compare with UUT outputs
			
			-- check if output of circuit is the same as the expected value 	
			assert (expected_alarm = alarm)
				report "ERROR: Expected alarm" &
					std_logic'image(expected_alarm) &
					" at time" & time'image(now);
					
			-- increment number of errors
			if(expected_alarm/=alarm) then
				error_count:=error_count+1;
			end if;
		end loop;
		
		wait for DELAY;
		
		-- report errors
		assert(error_count=0)
			report "ERROR: There were " &
				integer'image(error_count) & "errors!";
		
		-- there are no errors
		if (error_count=0) then
			report "Simulation completed with NO errors.";
		end if;
		
		wait; -- terminate the simulation
	end process;
end architecture tb;