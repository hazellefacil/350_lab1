library ieee;
use ieee.std_logic_1164.all;

ENTITY lab1_lcd is
	PORT(
		clk : in std_logic := '0';
		lcd_ON : out std_logic := '1'; 
		lcd_BLON : out std_logic := '1'; 
		lcd_RW : out std_logic := '0'; 
		lcd_E : out std_logic := '0'; 
		lcd_RS : out std_logic := '0';
		DB : out std_logic_vector(7 downto 0)
	);
END lab1_lcd;

ARCHITECTURE behaviour OF lab1_lcd IS

	CONSTANT send_char : STD_LOGIC := '1';
	CONSTANT send_inst : STD_LOGIC := '0';
	SIGNAL counter : INTEGER range 0 to 5 := 0;

	BEGIN
	PROCESS(clk)
	BEGIN
	
		-- start first cycle
		lcd_E <= '1';
		
		CASE counter IS
			WHEN 0 =>
				lcd_RS <= send_inst;
				DB <= "00111000";
				
			WHEN 1 =>
				lcd_RS <= send_inst;
				DB <= "00001100";
				
			WHEN 2 =>
				lcd_RS <= send_inst;
				DB <= "00000001";
				
			WHEN 3 =>
				lcd_RS <= send_inst;
				DB <= "00000110";
				
			WHEN 4 =>
				lcd_RS <= send_inst;
				DB <= "10000000";
				
			WHEN 5 =>
				lcd_RS <= send_char;
				DB <= "01000001"; -- A
				
		END CASE;	
			
		lcd_E <= '0';
		counter <= counter + 1;
		--wait for 15ms;

		-- clear display 
		-- RS = 0, RW = 0, DB0 = 1 
		-- do some sort of process and enable the pin

	END PROCESS;

END behaviour;