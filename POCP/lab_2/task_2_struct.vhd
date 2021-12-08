----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date:    00:23:09 09/30/2021 
-- Design Name: 
-- Module Name:    task_2_struct - Behavioral 
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

entity task_2_struct is
    Port ( A : in  STD_LOGIC;
           B : in  STD_LOGIC;
			  A1 : in  STD_LOGIC;
			  B1 : in  STD_LOGIC;
           S : in  STD_LOGIC;
           Z : out  STD_LOGIC;
			  Z1 : out STD_LOGIC);
end task_2_struct;

architecture Behavioral of task_2_struct is
		component task_1_struct port(
		A : in STD_LOGIC;
      B : in  STD_LOGIC;
      S : in  STD_LOGIC;
      Z : out  STD_LOGIC		
	);
	end component;
begin

	U1: task_1_struct port map(A => A, B => B, S => S, Z => Z);
	U2: task_1_struct port map(A => A1, B => B1, S => S, Z => Z1);

end Behavioral;

