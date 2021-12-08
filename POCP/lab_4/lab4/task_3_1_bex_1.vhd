----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date:    20:19:16 11/14/2021 
-- Design Name: 
-- Module Name:    task_3_1_bex_1 - Behavioral 
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

entity task_3_1_bex_1 is
	Generic(i : integer := 3);
    Port ( CLK : in  STD_LOGIC;
           RST : in  STD_LOGIC;
           LS : in  STD_LOGIC;
			  Pin: in std_logic_vector(0 to 2**i-1);
			  Pout: out std_logic_vector(0 to 2**i-1));
end task_3_1_bex_1;

architecture Behavioral of task_3_1_bex_1 is
	signal sreg: std_logic_vector(0 to 2**i-1);
	signal sdata: std_logic_vector(0 to 2**i-1);
begin


	JC: process(CLK, RST, sdata)
	begin
		if	(RST = '1') then
			sreg <= (others => '0');
		elsif rising_edge(CLK) then
			sreg <= sdata;
		end if;
	end process;
	
	Data: process (LS, Pin, sreg)
	begin
		if LS = '0' then
			sdata <= Pin;
		else
			sdata <= not(sreg(2**i-1)) & sreg(0 to 2**i-2);
		end if;
	end process;

Pout <= sdata;

end Behavioral;

