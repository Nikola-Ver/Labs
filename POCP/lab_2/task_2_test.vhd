--------------------------------------------------------------------------------
-- Company: 
-- Engineer:
--
-- Create Date:   00:32:03 09/30/2021
-- Design Name:   
-- Module Name:   E:/Xilinx/Labs/lab2/lab2/lab2/task_2_test.vhd
-- Project Name:  lab2
-- Target Device:  
-- Tool versions:  
-- Description:   
-- 
-- VHDL Test Bench Created by ISE for module: task_2_struct
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
 
ENTITY task_2_test IS
END task_2_test;
 
ARCHITECTURE behavior OF task_2_test IS 
 
    -- Component Declaration for the Unit Under Test (UUT)
 
    COMPONENT task_2_struct
    PORT(
         A : IN  std_logic;
         B : IN  std_logic;
         A1 : IN  std_logic;
         B1 : IN  std_logic;
         S : IN  std_logic;
         Z : OUT  std_logic;
         Z1 : OUT  std_logic
        );
    END COMPONENT;
    

   --Inputs
   signal A : std_logic := '0';
   signal B : std_logic := '0';
   signal A1 : std_logic := '0';
   signal B1 : std_logic := '0';
   signal S : std_logic := '0';

 	--Outputs
   signal Z : std_logic;
   signal Z1 : std_logic;
   -- No clocks detected in port list. Replace <clock> below with 
 
BEGIN
 
	-- Instantiate the Unit Under Test (UUT)
   uut: task_2_struct PORT MAP (
          A => A,
          B => B,
          A1 => A1,
          B1 => B1,
          S => S,
          Z => Z,
          Z1 => Z1
        );

   -- Stimulus process
   stim_proc: process
   begin		

   		wait for 1 ps;	
		A <= '0'; A1 <= '0'; B <= '0'; B1 <= '0'; S <= '0';
   		wait for 1 ps;	
		A <= '0'; A1 <= '0'; B <= '0'; B1 <= '0'; S <= '1';
   		wait for 1 ps;	
		A <= '0'; A1 <= '0'; B <= '0'; B1 <= '1'; S <= '0';
   		wait for 1 ps;	
		A <= '0'; A1 <= '0'; B <= '0'; B1 <= '1'; S <= '1';
   		wait for 1 ps;	
		A <= '0'; A1 <= '0'; B <= '1'; B1 <= '0'; S <= '0';
   		wait for 1 ps;	
		A <= '0'; A1 <= '0'; B <= '1'; B1 <= '0'; S <= '1';
   		wait for 1 ps;	
		A <= '0'; A1 <= '0'; B <= '1'; B1 <= '1'; S <= '0';
   		wait for 1 ps;	
		A <= '0'; A1 <= '0'; B <= '1'; B1 <= '1'; S <= '1';
   		wait for 1 ps;	
		A <= '0'; A1 <= '1'; B <= '0'; B1 <= '0'; S <= '0';
   		wait for 1 ps;	
		A <= '0'; A1 <= '1'; B <= '0'; B1 <= '0'; S <= '1';
   		wait for 1 ps;	
		A <= '0'; A1 <= '1'; B <= '0'; B1 <= '1'; S <= '0';
   		wait for 1 ps;	
		A <= '0'; A1 <= '1'; B <= '0'; B1 <= '1'; S <= '1';
   		wait for 1 ps;	
		A <= '0'; A1 <= '1'; B <= '1'; B1 <= '0'; S <= '0';
   		wait for 1 ps;	
		A <= '0'; A1 <= '1'; B <= '1'; B1 <= '0'; S <= '1';
   		wait for 1 ps;	
		A <= '0'; A1 <= '1'; B <= '1'; B1 <= '1'; S <= '0';
   		wait for 1 ps;	
		A <= '0'; A1 <= '1'; B <= '1'; B1 <= '1'; S <= '1';
   		wait for 1 ps;	
		A <= '1'; A1 <= '0'; B <= '0'; B1 <= '0'; S <= '0';
   		wait for 1 ps;	
		A <= '1'; A1 <= '0'; B <= '0'; B1 <= '0'; S <= '1';
   		wait for 1 ps;	
		A <= '1'; A1 <= '0'; B <= '0'; B1 <= '1'; S <= '0';
   		wait for 1 ps;	
		A <= '1'; A1 <= '0'; B <= '0'; B1 <= '1'; S <= '1';
   		wait for 1 ps;	
		A <= '1'; A1 <= '0'; B <= '1'; B1 <= '0'; S <= '0';
   		wait for 1 ps;	
		A <= '1'; A1 <= '0'; B <= '1'; B1 <= '0'; S <= '1';
   		wait for 1 ps;	
		A <= '1'; A1 <= '0'; B <= '1'; B1 <= '1'; S <= '0';
   		wait for 1 ps;	
		A <= '1'; A1 <= '0'; B <= '1'; B1 <= '1'; S <= '1';
   		wait for 1 ps;	
		A <= '1'; A1 <= '1'; B <= '0'; B1 <= '0'; S <= '0';
   		wait for 1 ps;	
		A <= '1'; A1 <= '1'; B <= '0'; B1 <= '0'; S <= '1';
   		wait for 1 ps;	
		A <= '1'; A1 <= '1'; B <= '0'; B1 <= '1'; S <= '0';
   		wait for 1 ps;	
		A <= '1'; A1 <= '1'; B <= '0'; B1 <= '1'; S <= '1';
   		wait for 1 ps;	
		A <= '1'; A1 <= '1'; B <= '1'; B1 <= '0'; S <= '0';
   		wait for 1 ps;	
		A <= '1'; A1 <= '1'; B <= '1'; B1 <= '0'; S <= '1';
   		wait for 1 ps;	
		A <= '1'; A1 <= '1'; B <= '1'; B1 <= '1'; S <= '0';
   		wait for 1 ps;	
		A <= '1'; A1 <= '1'; B <= '1'; B1 <= '1'; S <= '1';

      wait;
   end process;

END;
