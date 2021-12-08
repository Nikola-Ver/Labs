--------------------------------------------------------------------------------
-- Company: 
-- Engineer:
--
-- Create Date:   20:30:02 10/19/2021
-- Design Name:   
-- Module Name:   E:/Xilinx/Labs/lab3/lab3/task_5_3_test_1.vhd
-- Project Name:  lab3
-- Target Device:  
-- Tool versions:  
-- Description:   
-- 
-- VHDL Test Bench Created by ISE for module: task_5_3_struct_1
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
 
ENTITY task_5_3_test_1 IS
END task_5_3_test_1;
 
ARCHITECTURE behavior OF task_5_3_test_1 IS 
 
    -- Component Declaration for the Unit Under Test (UUT)
 
    COMPONENT task_5_3_struct_1
    PORT(
         CLK : IN  std_logic;
         R : IN  std_logic;
         D : IN  std_logic;
         Q : OUT  std_logic;
			nQ : OUT  std_logic
        );
    END COMPONENT;
    

   --Inputs
   signal CLK : std_logic := '0';
   signal R : std_logic := '0';
   signal D : std_logic := '0';

 	--Outputs
   signal Q : std_logic;
	signal nQ : std_logic;
	
   -- Clock period definitions
   constant CLK_period : time := 10 ns;
 
BEGIN
 
	-- Instantiate the Unit Under Test (UUT)
   uut: task_5_3_struct_1 PORT MAP (
          CLK => CLK,
          R => R,
          D => D,
          Q => Q,
			 nQ => nQ
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

		wait for 3ns;
		D <= '0'; R <= '0';
		wait for 3ns;
		D <= '1'; R <= '0';
		wait for 6ns;
		D <= '0'; R <= '0';
		wait for 3ns;
		D <= '1'; R <= '0';
		wait for 9ns;
		D <= '1'; R <= '1';
		wait for 13ns;
		D <= '0'; R <= '1';
		
      wait;
   end process;

END;
