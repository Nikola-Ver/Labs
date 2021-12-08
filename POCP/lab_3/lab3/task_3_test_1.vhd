--------------------------------------------------------------------------------
-- Company: 
-- Engineer:
--
-- Create Date:   03:10:59 10/18/2021
-- Design Name:   
-- Module Name:   E:/Xilinx/Labs/lab3/lab3/task_3_test_1.vhd
-- Project Name:  lab3
-- Target Device:  
-- Tool versions:  
-- Description:   
-- 
-- VHDL Test Bench Created by ISE for module: task_3_struct_1
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
 
ENTITY task_3_test_1 IS
END task_3_test_1;
 
ARCHITECTURE behavior OF task_3_test_1 IS 
 
    -- Component Declaration for the Unit Under Test (UUT)
 
    COMPONENT task_3_struct_1
    PORT(
         D : IN  std_logic;
         Q : OUT  std_logic;
         nQ : OUT  std_logic
        );
    END COMPONENT;
    

   --Inputs
   signal D : std_logic := '0';

 	--Outputs
   signal Q : std_logic;
   signal nQ : std_logic;
   -- No clocks detected in port list. Replace <clock> below with 
   -- appropriate port name 
 
BEGIN
 
	-- Instantiate the Unit Under Test (UUT)
   uut: task_3_struct_1 PORT MAP (
          D => D,
          Q => Q,
          nQ => nQ
        );
 

   -- Stimulus process
   stim_proc: process
   begin	
	
      wait for 1 ps;	
		D <= '0';
		wait for 1 ps;	
		D <= '1';
		wait for 1 ps;	
		D <= '0';
		

      wait;
   end process;

END;
