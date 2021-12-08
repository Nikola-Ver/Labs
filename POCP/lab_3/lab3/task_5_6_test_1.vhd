--------------------------------------------------------------------------------
-- Company: 
-- Engineer:
--
-- Create Date:   21:18:17 10/19/2021
-- Design Name:   
-- Module Name:   E:/Xilinx/Labs/lab3/lab3/task_5_6_test_1.vhd
-- Project Name:  lab3
-- Target Device:  
-- Tool versions:  
-- Description:   
-- 
-- VHDL Test Bench Created by ISE for module: task_5_6_struct_1
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
 
ENTITY task_5_6_test_1 IS
END task_5_6_test_1;
 
ARCHITECTURE behavior OF task_5_6_test_1 IS 
 
    -- Component Declaration for the Unit Under Test (UUT)
 
    COMPONENT task_5_6_struct_1
    PORT(
         CLK : IN  std_logic;
         T : IN  std_logic;
         Q : OUT  std_logic;
			nQ : OUT  std_logic
        );
    END COMPONENT;
    

   --Inputs
   signal CLK : std_logic := '0';
   signal T : std_logic := '0';

 	--Outputs
   signal Q : std_logic;
	signal nQ : std_logic;

   -- Clock period definitions
   constant CLK_period : time := 10 ns;
 
BEGIN
 
	-- Instantiate the Unit Under Test (UUT)
   uut: task_5_6_struct_1 PORT MAP (
          CLK => CLK,
          T => T,
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
      wait for 10 ns;

		wait for 3 ns;
		T <= '0';
		wait for 30 ns;
		T <= '1';
		wait for 30 ns;
		T <= '0';
		wait for 30 ns;
		T <= '1';			
		


      wait;
   end process;

END;
