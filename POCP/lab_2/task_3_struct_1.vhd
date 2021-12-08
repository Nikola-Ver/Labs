----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date:    03:08:45 09/30/2021 
-- Design Name: 
-- Module Name:    task_3_struct_1 - Behavioral 
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

entity task_3_struct_1 is
    Port ( X : in  STD_LOGIC;
           Y : in  STD_LOGIC;
           Z : in  STD_LOGIC;
           F : out  STD_LOGIC);
end task_3_struct_1;

architecture Behavioral of task_3_struct_1 is
		component task_3_bex_1 port(
		X : in STD_LOGIC;
      Y : in  STD_LOGIC;
      Z : in  STD_LOGIC;
      F : out  STD_LOGIC		
	);
	end component;
begin

	U1: task_3_bex_1 port map(X => X, Y => Y, Z => Z, F => F);

end Behavioral;

