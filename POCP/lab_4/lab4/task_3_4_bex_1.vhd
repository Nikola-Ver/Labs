----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date:    20:54:48 11/14/2021 
-- Design Name: 
-- Module Name:    task_3_6_bex_1 - Behavioral 
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

entity task_3_4_bex_1 is
	 Generic(n : integer := 4);
    Port ( CLK : in  STD_LOGIC;
           RST : in  STD_LOGIC;
			  Pout: out std_logic_vector(0 to n-1));
end task_3_4_bex_1;

architecture Behavioral of task_3_4_bex_1 is
	signal sreg: std_logic_vector (0 to n-1);
	signal sdata: std_logic_vector (0 to n-1);
begin

	MainProc: process (CLK, RST, sdata)
	begin
		if RST = '1' then
			sreg(0) <= '1';
			sreg(1 to n-1) <= (others => '0');
		elsif rising_edge (CLK) then
			sreg <= sdata;
		end if ;
	end process;
	
	sdata <= (sreg(0) xor sreg(n-1)) & sreg(0 to n-2);
	Pout <= sdata;

end Behavioral;

