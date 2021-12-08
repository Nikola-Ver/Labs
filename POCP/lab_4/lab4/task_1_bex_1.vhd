----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date:    03:35:13 11/14/2021 
-- Design Name: 
-- Module Name:    task_1_bex_1 - Behavioral 
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

entity task_1_bex_1 is
	Generic(n : integer := 4);
    Port ( Din: in std_logic_vector(n-1 downto 0);
	 EN : in  STD_LOGIC;
	 Dout: out std_logic_vector(n-1 downto 0));
end task_1_bex_1;

architecture Behavioral of task_1_bex_1 is
	signal reg: std_logic_vector(n-1 downto 0);
begin

	Proc: process(Din, EN)
		begin
		if	EN = '1' then
			reg <= Din;
		end if;
	end process;
	
Dout <= reg;

end Behavioral;

