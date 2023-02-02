LIBRARY ieee;
USE ieee.std_logic_1164.all;
USE Ieee.numeric_std.all;

-----------------------------------------------------

ENTITY lab1_lcd is
	PORT(
		KEY : in std_logic_vector(3 downto 0);
		CLOCK_50 : in std_logic := '0';
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

TYPE State_type is (SETUP_0,SETUP_1,SETUP_2,SETUP_3,SETUP_4,SETUP_5,FORWARD,BACKWARD);
SIGNAL	STATE, NEXT_STATE : State_type;
TYPE arr_type is array (0 to 4) of std_logic_vector(7 downto 0);
SIGNAL name : arr_type;
SIGNAL letter : INTEGER range 0 to 4 := 0;
	
BEGIN	

	PROCESS(STATE)
	BEGIN
	
	--initialize name array--
	name(0) <= "01001100"; -- L
	name(1) <= "01000001"; -- A
	name(2) <= "01010101"; -- U
	name(3) <= "01010010"; -- R
	name(4) <= "01000001"; -- A

	--to display with LEDs--
		LEDG(3) <= KEY(3);
		LEDG(0) <= KEY(0);
		
	--always this value--
		LCD_BLON <= '1';
		LCD_ON <= '1';
		LCD_RW <= '0';	
		
	--state machine cases--
		CASE STATE IS
			WHEN SETUP_0 => 		
				LCD_RS <= '0';
				LCD_DATA <= "00111000";
				LEDR <= "00111000";
				NEXT_STATE <= SETUP_1;
					
			WHEN SETUP_1 => 		
				--logic for set up here
				LCD_RS <= '0';
				LCD_DATA <= "00111000";
				LEDR <= "00111000";
				NEXT_STATE <= SETUP_2;
				
			WHEN SETUP_2 => 		
				--logic for set up here
				LCD_RS <= '0';
				LCD_DATA <= "00001100";
				LEDR <= "00001100";
				NEXT_STATE <= SETUP_3;
				
			WHEN SETUP_3 => 		
				--logic for set up here
				LCD_RS <= '0';
				LCD_DATA <= "00000001";
				LEDR <= "00000001";
				NEXT_STATE <= SETUP_4;
				
			WHEN SETUP_4 => 		
				--logic for set up here
				LCD_RS <= '0';
				LCD_DATA <= "00000110";
				LEDR <= "00000110";
				NEXT_STATE <= SETUP_5;
				
			WHEN SETUP_5 => 		
				--logic for set up here
				LCD_RS <= '0';
				LCD_DATA <= "10000000";
				LEDR <= "10000000";
				
				IF (SW(0) = '0') THEN
					NEXT_STATE <= FORWARD;
				ELSE -- SW(0) = '1'
					NEXT_STATE <= BACKWARD;
				END IF;
				
			WHEN FORWARD => 
				--logic here for letters
				LCD_RS <= '1';
				LCD_DATA <= name(letter);
				LEDR <= name(letter);
				NEXT_STATE <= FORWARD;
			
			WHEN BACKWARD => 
				--logic here for letters
				LCD_RS <= '1';
				LCD_DATA <= name(letter);
				LEDR <= name(letter);
				NEXT_STATE <= BACKWARD;
				
		END CASE;
					
	END PROCESS;	

  -- process to control clock and change states
	PROCESS(KEY(0), KEY(3))
	BEGIN
		LCD_EN <= KEY(0);
		
		IF(KEY(3) = '0') THEN --reset--
				STATE <= SETUP_0;
				letter <= 0;
		ELSIF (Rising_Edge(KEY(0))) THEN --"clock edge" with button--
			
			-- switching between forward and reverse in one button press --
			IF ((NEXT_STATE = FORWARD) AND (SW(0) = '1')) THEN
				STATE <= BACKWARD;
				IF (letter = 0) THEN
					letter <= 4;
				ELSE
					letter <= letter - 1;
				END IF;
				
			ELSIF ((NEXT_STATE = BACKWARD) AND (SW(0) = '0')) THEN
				STATE <= FORWARD;
				
				IF (letter = 4) THEN
					letter <= 0;
				ELSE
					letter <= letter + 1;
				END IF;
				
			ELSE
				STATE <= NEXT_STATE;
				IF (NEXT_STATE = FORWARD) THEN
					IF (letter = 4) THEN
						letter <= 0;
					ELSE
						letter <= letter + 1;
					END IF;
					
				ELSIF (NEXT_STATE = BACKWARD) THEN 
					IF (letter = 0) THEN
						letter <= 4;
					ELSE
						letter <= letter - 1;
					END IF;
					
				END IF;
			END IF;
			
		END IF;
	END PROCESS;
	
END behaviour;