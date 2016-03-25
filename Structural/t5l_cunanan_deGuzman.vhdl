-- Structural Design of Farm Storages Alarm
-- Author: Cunanan, Maria Erika Dominique C. ; De Guzman, Alyssa Joi A.

------------------------------------------------------------
-- Library Statements
library IEEE; use IEEE.std_logic_1164.all;

-- 2 INPUT AND GATE: andGate

entity andGate is
	port(c: out std_logic; a, b: in std_logic);
end andGate;

architecture and2 of andGate is
	begin
		c <= a and b;
end and2;
------------------------------------------------------------
library IEEE; use IEEE.std_logic_1164.all;

-- 2 INPUT OR GATE: orGate

entity orGate is 
	port(c: out std_logic; a, b: in std_logic);
end orGate;

architecture or2 of orGate is
	begin
		c <= a or b;
end or2;

------------------------------------------------------------
-- Structural Code: 
-- alarm = buzzer(5)*buzzer(2) + buzzer(5)*buzzer(1) + buzzer(5)*buzzer(1) 
				-- + buzzer(4)*buzzer(2) + buzzer(4)*buzzer(1) + buzzer(4)*buzzer(0) 
				-- + buzzer(3)*buzzer(2) + buzzer(3)*buzzer(1) + buzzer(3)*buzzer(0)
				
library IEEE; use IEEE.std_logic_1164.all;

entity t5l_cunanan_deGuzman is
	port (alarm: out std_logic; 
	buzzers: in std_logic_vector(5 downto 0));
end t5l_cunanan_deGuzman;

architecture structural of t5l_cunanan_deGuzman is
	-- signals that outputs the results of the gates
	signal a, b, c, d, e, f, g, h, i, orOut1, orOut2, orOut3, orOut4, orOut5, orOut6, orOut7, orOut8: std_logic;
	
	-- import andGate component needed
	component andGate is
		port (c: out std_logic; a, b: in std_logic);
	end component;
	
	-- import orGate component needed
	component orGate is
		port (c: out std_logic; a, b: in std_logic);
	end component;
	
	-- connect previous logic gates
	begin
		a0: component andGate port map(a, buzzers(5), buzzers(2)); -- andGate the value of first in buzzer and first out buzzer
		a1: component andGate port map(b, buzzers(5), buzzers(1)); -- andGate the value of first in buzzer and second out buzzer
		a2: component andGate port map(c, buzzers(5), buzzers(0)); -- andGate the value of first in buzzer and first third buzzer
		
		a3: component andGate port map(d, buzzers(4), buzzers(2)); -- andGate the value of second in buzzer and first out buzzer
		a4: component andGate port map(e, buzzers(4), buzzers(1)); -- andGate the value of second in buzzer and second out buzzer
		a5: component andGate port map(f, buzzers(4), buzzers(0)); -- andGate the value of second in buzzer and third out buzzer
		
		a6: component andGate port map(g, buzzers(3), buzzers(2)); -- andGate the value of third in buzzer and first out buzzer
		a7: component andGate port map(h, buzzers(3), buzzers(1)); -- andGate the value of third in buzzer and second out buzzer
		a8: component andGate port map(i, buzzers(3), buzzers(0)); -- andGate the value of third in buzzer and third out buzzer
		
		o1: component orGate port map(orOut1, a,b); -- andGate the value of third in buzzer and first out buzzer
		o2: component orGate port map(orOut2, c,d); 
		o3: component orGate port map(orOut3, e,f); 
		o4: component orGate port map(orOut4, g,h); 
		o5: component orGate port map(orOut5, orOut1,orOut2); 
		o6: component orGate port map(orOut6, orOut3,orOut4); 
		o7: component orGate port map(orOut7, orOut5,orOut6); 
		final: component orGate port map(alarm, orOut7, i); 
		
end architecture structural;