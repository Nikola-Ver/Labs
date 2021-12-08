----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date:    21:53:07 10/19/2021 
-- Design Name: 
-- Module Name:    task_5_7_struct_1 - Behavioral 
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

entity task_5_7_struct_1 is
    Port ( CLK : in  STD_LOGIC;
           D : in  STD_LOGIC;
           Q : out  STD_LOGIC;
           nQ : out  STD_LOGIC);
end task_5_7_struct_1;

architecture Behavioral of task_5_7_struct_1 is

	component task_5_1_struct_1 port(
		CLK : in STD_LOGIC;
      D : in  STD_LOGIC;
      Q : out  STD_LOGIC;
		nQ : out  STD_LOGIC);
	end component;
	signal a: std_logic;
begin

	U1: task_5_1_struct_1 port map(CLK => CLK, D => D, Q => a);
	U2: task_5_1_struct_1 port map(CLK => not CLK, D => a, Q => Q, nQ => nQ);

end Behavioral;

