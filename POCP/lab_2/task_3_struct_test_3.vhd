----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date:    04:44:56 09/30/2021 
-- Design Name: 
-- Module Name:    task_3_struct_test_3 - Behavioral 
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

entity task_3_struct_test_3 is
    Port ( X : in  STD_LOGIC;
           Y : in  STD_LOGIC;
           Z : in  STD_LOGIC;
           F : out  STD_LOGIC;
           G : out  STD_LOGIC;
           H : out  STD_LOGIC;
           I : out  STD_LOGIC);
end task_3_struct_test_3;

architecture Behavioral of task_3_struct_test_3 is
		component task_3_bex_3 port(
			  X : in  STD_LOGIC;
           Y : in  STD_LOGIC;
           Z : in  STD_LOGIC;
           F : out  STD_LOGIC;
           G : out  STD_LOGIC;
           H : out  STD_LOGIC;
           I : out  STD_LOGIC);
	end component;
			component task_3_struct_3 port(
			  X : in  STD_LOGIC;
           Y : in  STD_LOGIC;
           Z : in  STD_LOGIC;
           F : out  STD_LOGIC;
           G : out  STD_LOGIC;
           H : out  STD_LOGIC;
           I : out  STD_LOGIC);
	end component;
	
		signal res1_1, res1_2, res1_3, res1_4, res2_1, res2_2, res2_3, res2_4: STD_LOGIC;
begin

	U1: task_3_bex_3 port map(X => X, Y => Y, Z => Z, F => res1_1, G => res1_2, H => res1_3, I => res1_4);
	U2: task_3_struct_3 port map(X => X, Y => Y, Z => Z, F => res2_1, G => res2_2, H => res2_3, I => res2_4);
	
	F <= res1_1 xnor res2_1;
	G <= res1_2 xnor res2_2;
	H <= res1_3 xnor res2_3;
	I <= res1_4 xnor res2_4;

end Behavioral;

