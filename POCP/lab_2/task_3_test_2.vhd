--------------------------------------------------------------------------------
-- Company: 
-- Engineer:
--
-- Create Date:   04:02:43 09/30/2021
-- Design Name:   
-- Module Name:   E:/Xilinx/Labs/lab2/lab2/lab2/task_3_test_2.vhd
-- Project Name:  lab2
-- Target Device:  
-- Tool versions:  
-- Description:   
-- 
-- VHDL Test Bench Created by ISE for module: task_3_struct_test_2
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
 
ENTITY task_3_test_2 IS
END task_3_test_2;
 
ARCHITECTURE behavior OF task_3_test_2 IS 
 
    -- Component Declaration for the Unit Under Test (UUT)
 
    COMPONENT task_3_struct_test_2
    PORT(
         X : IN  std_logic;
         Y : IN  std_logic;
         Z : IN  std_logic;
         F : OUT  std_logic
        );
    END COMPONENT;
    

   --Inputs
   signal X : std_logic := '0';
   signal Y : std_logic := '0';
   signal Z : std_logic := '0';

 	--Outputs
   signal F : std_logic;

 
BEGIN
 
	-- Instantiate the Unit Under Test (UUT)
   uut: task_3_struct_test_2 PORT MAP (
          X => X,
          Y => Y,
          Z => Z,
          F => F
        );


   -- Stimulus process
   stim_proc: process
   begin		
	
      wait for 1 ps;	
		X <= '0'; Y <= '0'; Z <= '0';
		wait for 1 ps;	
		X <= '0'; Y <= '0'; Z <= '1';
		wait for 1 ps;	
		X <= '0'; Y <= '1'; Z <= '0';
		wait for 1 ps;	
		X <= '0'; Y <= '1'; Z <= '1';
		wait for 1 ps;	
		X <= '1'; Y <= '0'; Z <= '0';
		wait for 1 ps;	
		X <= '1'; Y <= '0'; Z <= '1';
		wait for 1 ps;	
		X <= '1'; Y <= '1'; Z <= '0';
		wait for 1 ps;	
		X <= '1'; Y <= '1'; Z <= '1';

      wait;
   end process;

END;
