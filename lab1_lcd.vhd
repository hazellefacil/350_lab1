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

Type State_type is (SETUP_0,SETUP_1,SETUP_2,SETUP_3,SETUP_4,SETUP_5,FORWARD,BACKWARD);
SIGNAL	STATE : State_type;


	
BEGIN

	PROCESS(KEY(0), KEY(3))
	BEGIN

	--to display with LEDs--
		LEDG(3) <= KEY(3);
		LEDG(0) <= KEY(0);
		
	--always this value--
		LCD_BLON <= '1';
		LCD_ON <= '1';
		LCD_RW <= '0';

	--reset--
	IF(KEY(3) = '0') THEN
		
			STATE <= SETUP_0;
		
	--"clock edge" with button--
	ELSIF(falling_edge(KEY(0))) THEN
		
		
		--state machine cases--
			CASE STATE IS
			
				WHEN SETUP_0 => 		
					LCD_EN <= NOT KEY(0);
					LCD_RS <= '0';
					LCD_EN <= KEY(0);
					LCD_DATA <= "00111000";
					LEDR <= "00111000";
					STATE <= SETUP_1;
						
					WHEN SETUP_1 => 		
						--logic for set up here
						LCD_RS <= '0';
						LCD_EN <= NOT KEY(0);
						LCD_DATA <= "00111000";
						LEDR <= "00111000";
						STATE <= SETUP_2;
						
					WHEN SETUP_2 => 		
						--logic for set up here
						LCD_RS <= '0';
						LCD_EN <= NOT KEY(0);
						LCD_DATA <= "00001100";
						LEDR <= "00001100";
						STATE <= SETUP_3;

						
					WHEN SETUP_3 => 		
						--logic for set up here
						LCD_RS <= '0';
						LCD_EN <= NOT KEY(0);
						LCD_DATA <= "00000001";
						LEDR <= "00000001";
						STATE <= SETUP_4;
						
					WHEN SETUP_4 => 		
						--logic for set up here
						LCD_RS <= '0';
						LCD_EN <= NOT KEY(0);
						LCD_DATA <= "00000110";
						LEDR <= "00000110";
						STATE <= SETUP_5;
						
					WHEN SETUP_5 => 		
						--logic for set up here
						LCD_RS <= '0';
						LCD_EN <= NOT KEY(0);
						LCD_DATA <= "10000000";
						LEDR <= "10000000";
						STATE <= FORWARD;
						
				WHEN FORWARD => 
					--logic here for letters
				
					IF(SW(0) = '1') THEN
						STATE <= BACKWARD;
					END IF;
					
					LCD_RS <= '1';
					LCD_EN <= NOT KEY(0);
					LCD_DATA <= "01001100";
					LEDR <= "01001100";
				
				WHEN BACKWARD => 
					--logic here for letters
					
					LCD_RS <= '1';
					LCD_EN <= NOT KEY(0);
					LCD_DATA <= "01000001";
					LEDR <= "01000001";
					
			END CASE;
		END IF;
		
	END PROCESS;
		
		
END behaviour;
