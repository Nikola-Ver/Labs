----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date:    21:39:26 09/26/2021 
-- Design Name: 
-- Module Name:    task_1_struct - Behavioral 
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

entity task_1_struct is
    Port ( A : in  STD_LOGIC;
           B : in  STD_LOGIC;
           S : in  STD_LOGIC;
           Z : out  STD_LOGIC);
end task_1_struct;

architecture Behavioral of task_1_struct is
	component task_1_bex_1 port(
		A : in STD_LOGIC;
      B : in  STD_LOGIC;
      S : in  STD_LOGIC;
      Z : out  STD_LOGIC		
	);
	end component;
	
begin
	U1: task_1_bex_1 port map(A => A, B => B, S => S, Z => Z);
end Behavioral;	

