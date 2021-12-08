----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date:    04:28:43 09/30/2021 
-- Design Name: 
-- Module Name:    task_3_bex_3 - Behavioral 
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

entity task_3_bex_3 is
    Port ( X : in  STD_LOGIC;
           Y : in  STD_LOGIC;
           Z : in  STD_LOGIC;
           F : out  STD_LOGIC;
			  G : out  STD_LOGIC;
			  H : out  STD_LOGIC;
			  I : out  STD_LOGIC);
end task_3_bex_3;

architecture Behavioral of task_3_bex_3 is

begin

F <= (not X nand not Y) nand not Z;
G <= (not X nand Y) nand not Z;
H <= (not X nand not Y) nand Z;
I <= (not X nand Y) nand Z;

--F <= not (not X and not Y and not Z);
--G <= not (not X and Y and not Z);
--H <= not (not X and not Y and Z);
--I <= not (not X and Y and Z);

end Behavioral;

