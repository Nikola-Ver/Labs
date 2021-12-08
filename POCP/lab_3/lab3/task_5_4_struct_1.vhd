----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date:    20:39:34 10/19/2021 
-- Design Name: 
-- Module Name:    task_5_4_struct_1 - Behavioral 
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

-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
--use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx primitives in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity task_5_4_struct_1 is
    Port ( CLK : in  STD_LOGIC;
           R : in  STD_LOGIC;
           S : in  STD_LOGIC;
           Q : out  STD_LOGIC;
			  nQ : out  STD_LOGIC);
end task_5_4_struct_1;

architecture Behavioral of task_5_4_struct_1 is
	signal a: std_logic;
begin

	trig: process (CLK)
	begin
		if	(rising_edge(CLK))then
			if (R = '0' and S = '0') then
				a <= a;
			elsif (R = '0' and S = '1') then
				a <= '1';
			elsif (R = '1' and S = '0') then
				a <= '0';
			else
				a <= 'Z';
			end if;	
		end if;
	end process;

	Q <= a;
	nQ <= not a;

end Behavioral;

