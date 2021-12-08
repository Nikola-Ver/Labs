--------------------------------------------------------------------------------
-- Company: 
-- Engineer:
--
-- Create Date:   02:57:37 10/18/2021
-- Design Name:   
-- Module Name:   E:/Xilinx/Labs/lab3/lab3/task_2_test_1.vhd
-- Project Name:  lab3
-- Target Device:  
-- Tool versions:  
-- Description:   
-- 
-- VHDL Test Bench Created by ISE for module: task_2_struct_1
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
 
ENTITY task_2_test_1 IS
END task_2_test_1;
 
ARCHITECTURE behavior OF task_2_test_1 IS 
 
    -- Component Declaration for the Unit Under Test (UUT)
 
    COMPONENT task_2_struct_1
    PORT(
         S : IN  std_logic;
         R : IN  std_logic;
         Q : OUT  std_logic;
         nQ : OUT  std_logic
        );
    END COMPONENT;
    

   --Inputs
   signal S : std_logic := '0';
   signal R : std_logic := '0';

 	--Outputs
   signal Q : std_logic;
   signal nQ : std_logic;
   -- No clocks detected in port list. Replace <clock> below with 
   -- appropriate port name 
 
BEGIN
 
	-- Instantiate the Unit Under Test (UUT)
   uut: task_2_struct_1 PORT MAP (
          S => S,
          R => R,
          Q => Q,
          nQ => nQ
        );
 

   -- Stimulus process
   stim_proc: process
   begin		

		wait for 1 ps;
		S <= '0'; R <= '0';
		wait for 1 ps;
		S <= '1'; R <= '0';
		wait for 1 ps;
		S <= '0'; R <= '1';
		

      wait;
   end process;

END;
