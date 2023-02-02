library ieee;
use ieee.std_logic_1164.all;

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
		LEDG : out std_logic_vector(1 downto 0);
		LEDR : out std_logic_vector(7 downto 0)
		);
END lab1_lcd;



ARCHITECTURE behaviour OF lab1_lcd IS

	
BEGIN


		LCD_BLON <= '1'; 
		LCD_ON  <= '1';
		LCD_EN  <= KEY(0);
		LCD_RW <= '0';
		LCD_RS <= SW(8);
		LCD_DATA <= SW(7 downto 0);
		LEDG(0) <= KEY(0);
		LEDR <= SW(7 downto 0);
		
		
END behaviour;
