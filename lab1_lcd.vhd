LIBRARY ieee;
USE ieee.std_logic_1164.all;
USE Ieee.numeric_std.all;

-----------------------------------------------------

ENTITY lab1_lcd is
	PORT(
		KEY : in std_logic_vector(3 downto 0);
		clk : in std_logic := '0';
		LCD_ON : out std_logic := '1'; 
		LCD_BLON : out std_logic := '1'; 
		LCD_RW : out std_logic := '0'; 
		LCD_EN : out std_logic := '0'; 
		LCD_RS : out std_logic := '0';
		SW : in std_logic_vector(8 downto 0);
		LCD_DATA : out std_logic_vector(7 downto 0);
		LEDG : out std_logic_vector(3 downto 0);
		LEDR : out std_logic_vector(7 downto 0)
		);
END lab1_lcd;

-----------------------------------------------------

ARCHITECTURE behaviour OF lab1_lcd IS

Type State_type is (SETUP, FORWARD,BACKWARD);
SIGNAL	STATE : State_type;

	
BEGIN

	PROCESS(KEY(0), KEY(3))
	BEGIN

	--to display with LEDs--
		LEDG(3) <= KEY(3);
		LEDG(0) <= KEY(0);

	--reset--
		IF(KEY(3) = '0') THEN
		
			STATE <= SETUP;
		
	--"clock edge" with button--
	ELSIF(falling_edge(KEY(0))) THEN
		
			
		--always this value--
			LCD_BLON <= '1';
			LCD_ON <= '1';
			LCD_RW <= '0';
	
		--state machine cases--
			CASE STATE IS
			
				WHEN SETUP => 		
					--logic for set up here
					LCD_RS <= '0';
					LCD_EN <= KEY(0);
					LCD_DATA <= "00111000";
					LEDR <= "00111000";
					
					
					STATE <= FORWARD;
				
				WHEN FORWARD => 
					--logic here for letters
				
					IF(SW(0) = '0') THEN
						STATE <= BACKWARD;
					END IF;
					
					LCD_RS <= '1';
					LEDR <= "00000001";
				
				WHEN BACKWARD => 
					--logic here for letters
					
					LCD_RS <= '1';
					LEDR <= "00000010";
			
			END CASE;
		END IF;
		
	END PROCESS;
		
		
END behaviour;
