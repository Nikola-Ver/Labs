----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date:    21:14:49 10/19/2021 
-- Design Name: 
-- Module Name:    task_5_6_struct_1 - Behavioral 
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

entity task_5_6_struct_1 is
    Port ( CLK : in  STD_LOGIC;
           T : in  STD_LOGIC;
           Q : out  STD_LOGIC;
			  nQ : out  STD_LOGIC);
end task_5_6_struct_1;

architecture Behavioral of task_5_6_struct_1 is

	component task_5_5_struct_1 port(
		CLK : in STD_LOGIC;
      J : in  STD_LOGIC;
      K : in  STD_LOGIC;
      Q : out  STD_LOGIC;
		nQ : out  STD_LOGIC);
	end component;

--signal a:STD_LOGIC;

begin

	U1: task_5_5_struct_1 port map(CLK => CLK, J => T, K => T, Q => Q, nQ => nQ);

end Behavioral;

