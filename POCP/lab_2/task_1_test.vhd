--------------------------------------------------------------------------------
-- Company: 
-- Engineer:
--
-- Create Date:   21:54:01 09/26/2021
-- Design Name:   
-- Module Name:   E:/Xilinx/Labs/lab2/lab2/lab2/task_1_test.vhd
-- Project Name:  lab2
-- Target Device:  
-- Tool versions:  
-- Description:   
-- 
-- VHDL Test Bench Created by ISE for module: task_1_struct
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
 
ENTITY task_1_test IS
END task_1_test;
 
ARCHITECTURE behavior OF task_1_test IS 
 
    -- Component Declaration for the Unit Under Test (UUT)
 
    COMPONENT task_1_struct
    PORT(
         A : IN  std_logic;
         B : IN  std_logic;
         S : IN  std_logic;
         Z : OUT  std_logic
        );
    END COMPONENT;
    

   --Inputs
   signal A : std_logic := '0';
   signal B : std_logic := '0';
   signal S : std_logic := '0';

 	--Outputs
   signal Z : std_logic;
   -- No clocks detected in port list. Replace <clock> below with 
   -- appropriate port name 
 
BEGIN
 
	-- Instantiate the Unit Under Test (UUT)
   uut: task_1_struct PORT MAP (
          A => A,
          B => B,
          S => S,
          Z => Z
        );
 

   -- Stimulus process
   stim_proc: process
   begin		

      wait for 1 ps;	
		A <= '0'; B <= '0'; S <= '0';
		wait for 1 ps;	
		A <= '0'; B <= '0'; S <= '1';
		wait for 1 ps;	
		A <= '0'; B <= '1'; S <= '0';
		wait for 1 ps;	
		A <= '0'; B <= '1'; S <= '1';
		wait for 1 ps;	
		A <= '1'; B <= '0'; S <= '0';
		wait for 1 ps;	
		A <= '1'; B <= '0'; S <= '1';
		wait for 1 ps;	
		A <= '1'; B <= '1'; S <= '0';
		wait for 1 ps;	
		A <= '1'; B <= '1'; S <= '1';
		
      

      -- insert stimulus here 

      wait;
   end process;

END;
