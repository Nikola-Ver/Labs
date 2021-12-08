--------------------------------------------------------------------------------
-- Company: 
-- Engineer:
--
-- Create Date:   20:31:18 11/14/2021
-- Design Name:   
-- Module Name:   E:/Xilinx/Labs/lab4/lab4/task_3_1_test_1.vhd
-- Project Name:  lab4
-- Target Device:  
-- Tool versions:  
-- Description:   
-- 
-- VHDL Test Bench Created by ISE for module: task_3_1_bex_1
-- 
-- Dependencies:
-- 
-- Revision:
-- Revision 0.01 - File Created
-- Additional Comments:
--
-- Notes: 
-- This testbench has been automatically generated using types std_logic and
-- std_logic_vector for the ports of the unit under test.  Xilinx recommends
-- that these types always be used for the top-level I/O of a design in order
-- to guarantee that the testbench will bind correctly to the post-implementation 
-- simulation model.
--------------------------------------------------------------------------------
LIBRARY ieee;
USE ieee.std_logic_1164.ALL;
 
-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
--USE ieee.numeric_std.ALL;
 
ENTITY task_3_1_test_1 IS
END task_3_1_test_1;
 
ARCHITECTURE behavior OF task_3_1_test_1 IS 
 
    -- Component Declaration for the Unit Under Test (UUT)
 
    COMPONENT task_3_1_bex_1
    PORT(
         CLK : IN  std_logic;
         RST : IN  std_logic;
         LS : IN  std_logic;
         Pin : IN  std_logic_vector(0 to 7);
         Pout : OUT  std_logic_vector(0 to 7)
        );
    END COMPONENT;
    

   --Inputs
   signal CLK : std_logic := '0';
   signal RST : std_logic := '0';
   signal LS : std_logic := '0';
   signal Pin : std_logic_vector(0 to 7) := (others => '0');

 	--Outputs
   signal Pout : std_logic_vector(0 to 7);

   -- Clock period definitions
   constant CLK_period : time := 10 ns;
 
BEGIN
 
	-- Instantiate the Unit Under Test (UUT)
   uut: task_3_1_bex_1 PORT MAP (
          CLK => CLK,
          RST => RST,
          LS => LS,
          Pin => Pin,
          Pout => Pout
        );

   -- Clock process definitions
   CLK_process :process
   begin
		CLK <= '0';
		wait for CLK_period/2;
		CLK <= '1';
		wait for CLK_period/2;
   end process;
 

   -- Stimulus process
   stim_proc: process
   begin		
      -- hold reset state for 100 ns.
      wait for 100 ns;	
		
		wait for 10 ns;
		LS <= '0'; Pin <= "00000001";
		wait for 20ns;
		LS <= '1';
		wait for 30ns;
		RST <= '1';
		wait for 20ns;
		RST <= '0';
		
		
      -- insert stimulus here 

      wait;
   end process;

END;
