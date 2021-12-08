----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date:    00:18:19 10/01/2021 
-- Design Name: 
-- Module Name:    task_3_struct_4 - Behavioral 
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

entity task_3_struct_4 is
    Port ( A1 : in  STD_LOGIC;
           A0 : in  STD_LOGIC;
           B1 : in  STD_LOGIC;
           B0 : in  STD_LOGIC;
           R2 : out  STD_LOGIC;
           R1 : out  STD_LOGIC;
           R0 : out  STD_LOGIC);
end task_3_struct_4;

architecture Behavioral of task_3_struct_4 is
		component task_3_bex_4 port(
			  A1 : in  STD_LOGIC;
           A0 : in  STD_LOGIC;
           B1 : in  STD_LOGIC;
           B0 : in  STD_LOGIC;
           R2 : out  STD_LOGIC;
           R1 : out  STD_LOGIC;
           R0 : out  STD_LOGIC		
	);
	end component;
begin

U1: task_3_bex_4 port map(A1 => A1, A0 => A0, B1 => B1, B0 => B0, R2 => R2, R1 => R1, R0 => R0);

end Behavioral;

