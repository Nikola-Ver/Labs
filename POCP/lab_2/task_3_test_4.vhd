--------------------------------------------------------------------------------
-- Company: 
-- Engineer:
--
-- Create Date:   00:27:32 10/01/2021
-- Design Name:   
-- Module Name:   E:/Xilinx/Labs/lab2/lab2/lab2/task_3_test_4.vhd
-- Project Name:  lab2
-- Target Device:  
-- Tool versions:  
-- Description:   
-- 
-- VHDL Test Bench Created by ISE for module: task_3_struct_test_4
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
 
ENTITY task_3_test_4 IS
END task_3_test_4;
 
ARCHITECTURE behavior OF task_3_test_4 IS 
 
    -- Component Declaration for the Unit Under Test (UUT)
 
    COMPONENT task_3_struct_test_4
    PORT(
         A1 : IN  std_logic;
         A0 : IN  std_logic;
         B1 : IN  std_logic;
         B0 : IN  std_logic;
         R2 : OUT  std_logic;
         R1 : OUT  std_logic;
         R0 : OUT  std_logic
        );
    END COMPONENT;
    

   --Inputs
   signal A1 : std_logic := '0';
   signal A0 : std_logic := '0';
   signal B1 : std_logic := '0';
   signal B0 : std_logic := '0';

 	--Outputs
   signal R2 : std_logic;
   signal R1 : std_logic;
   signal R0 : std_logic;
   -- No clocks detected in port list. Replace <clock> below with 
 
BEGIN
 
	-- Instantiate the Unit Under Test (UUT)
   uut: task_3_struct_test_4 PORT MAP (
          A1 => A1,
          A0 => A0,
          B1 => B1,
          B0 => B0,
          R2 => R2,
          R1 => R1,
          R0 => R0
        );
 
   -- Stimulus process
   stim_proc: process
   begin		

		wait for 1 ps;	
		A1 <= '0'; A0 <= '0'; B1 <= '0'; B0 <= '0';
		wait for 1 ps;	
		A1 <= '0'; A0 <= '0'; B1 <= '0'; B0 <= '1';
		wait for 1 ps;	
		A1 <= '0'; A0 <= '0'; B1 <= '1'; B0 <= '0';
		wait for 1 ps;	
		A1 <= '0'; A0 <= '0'; B1 <= '1'; B0 <= '1';
		wait for 1 ps;	
		A1 <= '0'; A0 <= '1'; B1 <= '0'; B0 <= '0';
		wait for 1 ps;	
		A1 <= '0'; A0 <= '1'; B1 <= '0'; B0 <= '1';
		wait for 1 ps;	
		A1 <= '0'; A0 <= '1'; B1 <= '1'; B0 <= '0';
		wait for 1 ps;	
		A1 <= '0'; A0 <= '1'; B1 <= '1'; B0 <= '1';
		wait for 1 ps;	
		A1 <= '1'; A0 <= '0'; B1 <= '0'; B0 <= '1';
		wait for 1 ps;	
		A1 <= '1'; A0 <= '0'; B1 <= '1'; B0 <= '0';
		wait for 1 ps;	
		A1 <= '1'; A0 <= '0'; B1 <= '1'; B0 <= '1';
		wait for 1 ps;	
		A1 <= '1'; A0 <= '1'; B1 <= '0'; B0 <= '0';
		wait for 1 ps;	
		A1 <= '1'; A0 <= '1'; B1 <= '0'; B0 <= '1';
		wait for 1 ps;	
		A1 <= '1'; A0 <= '1'; B1 <= '1'; B0 <= '0';
		wait for 1 ps;	
		A1 <= '1'; A0 <= '1'; B1 <= '1'; B0 <= '1';

      wait;
   end process;

END;
