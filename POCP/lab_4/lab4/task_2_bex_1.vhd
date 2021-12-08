----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date:    03:57:03 11/14/2021 
-- Design Name: 
-- Module Name:    task_2_bex_1 - Behavioral 
-- Project Name: 
-- Target Devices: 
-- Tool versions: 
-- Description: 
--
-- Dependencies: 
--
-- Revision: 
-- Revision 0.01 - File Created
-- Additional Comments: 
--
----------------------------------------------------------------------------------
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
library UNISIM;
use UNISIM.vcomponents.ALL;

-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
--use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx primitives in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity task_2_bex_1 is
	Generic(n : integer := 4);
    Port ( CLK : in  STD_LOGIC;
           RST : in  STD_LOGIC;
           SE : in  STD_LOGIC;
           Sin : in  STD_LOGIC;
			  Pout: out std_logic_vector(0 to n-1));
end task_2_bex_1;

architecture Behavioral of task_2_bex_1 is
	signal sreg: std_logic_vector(0 to n-1);
begin

	FDFF: FDCE port map( sreg(0), CLK, SE, RST, Sin);
	
	Dffs: for i in 1 to n-1 generate
		DFFi: FDCE port map( sreg(i), CLK, SE, RST, sreg(i-1));
	end generate;

	Pout <= sreg;

end Behavioral;

