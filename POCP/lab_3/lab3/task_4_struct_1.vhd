----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date:    03:13:14 10/18/2021 
-- Design Name: 
-- Module Name:    task_4_struct_1 - Behavioral 
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

entity task_4_struct_1 is
    Port ( E : in  STD_LOGIC;
           D : in  STD_LOGIC;
           Q : out  STD_LOGIC;
           nQ : out  STD_LOGIC);
end task_4_struct_1;

architecture Behavioral of task_4_struct_1 is

	component task_2_struct_1 port(
		S : in STD_LOGIC;
      R : in  STD_LOGIC;
      Q : out  STD_LOGIC;
      nQ : out  STD_LOGIC);
	end component;

signal s, r: std_logic;

begin

	s <= E and D;
	r <= E and not D;

	U1: task_2_struct_1 port map(S => s, R => r, Q => Q, nQ => nQ);

end Behavioral;

