--------------------------------------------------------------------------------
-- Company: 
-- Engineer:
--
-- Create Date:   20:49:29 09/07/2021
-- Design Name:   
-- Module Name:   C:/Users/zaben/Lab1/LogicExprBTest.vhd
-- Project Name:  Lab1
-- Target Device:  
-- Tool versions:  
-- Description:   
-- 
-- VHDL Test Bench Created by ISE for module: LogicExprB
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
 
ENTITY LogicExprBTest IS
END LogicExprBTest;
 
ARCHITECTURE behavior OF LogicExprBTest IS 
 
    -- Component Declaration for the Unit Under Test (UUT)
 
    COMPONENT LogicExprB
    PORT(
         in1 : IN  std_logic;
         in2 : IN  std_logic;
         in3 : IN  std_logic;
         in4 : IN  std_logic;
         Q : OUT  std_logic
        );
    END COMPONENT;
    

   --Inputs
   signal in1 : std_logic := '0';
   signal in2 : std_logic := '0';
   signal in3 : std_logic := '0';
   signal in4 : std_logic := '0';

 	--Outputs
   signal Q : std_logic;
   -- No clocks detected in port list. Replace <clock> below with 
   -- appropriate port name 
 
BEGIN
 
	-- Instantiate the Unit Under Test (UUT)
   uut: LogicExprB PORT MAP (
          in1 => in1,
          in2 => in2,
          in3 => in3,
          in4 => in4,
          Q => Q
        ); 

   -- Stimulus process
   stim_proc: process
   begin		
      -- hold reset state for 100 ns.
      wait for 1 ps;	
		in1<='0'; in2<='0'; in3<='0'; in4<='0';
		
		wait for 1 ps;	
		in1<='0'; in2<='0'; in3<='0'; in4<='1';
		
		wait for 1 ps;	
		in1<='0'; in2<='0'; in3<='1'; in4<='0';
		
		wait for 1 ps;	
		in1<='0'; in2<='0'; in3<='1'; in4<='1';
		
		wait for 1 ps;	
		in1<='0'; in2<='1'; in3<='0'; in4<='0';
		
		wait for 1 ps;	
		in1<='0'; in2<='1'; in3<='0'; in4<='1';
		
		wait for 1 ps;	
		in1<='0'; in2<='1'; in3<='1'; in4<='0';
		
		wait for 1 ps;	
		in1<='0'; in2<='1'; in3<='1'; in4<='1';
		
		wait for 1 ps;	
		in1<='1'; in2<='0'; in3<='0'; in4<='0';
		
		wait for 1 ps;	
		in1<='1'; in2<='0'; in3<='0'; in4<='1';
		
		wait for 1 ps;	
		in1<='1'; in2<='0'; in3<='1'; in4<='0';
		
		wait for 1 ps;	
		in1<='1'; in2<='0'; in3<='1'; in4<='1';
		
		wait for 1 ps;	
		in1<='1'; in2<='1'; in3<='0'; in4<='0';
		
		wait for 1 ps;	
		in1<='1'; in2<='1'; in3<='0'; in4<='1';
		
		wait for 1 ps;	
		in1<='1'; in2<='1'; in3<='1'; in4<='0';
		
		wait for 1 ps;	
		in1<='1'; in2<='1'; in3<='1'; in4<='1';

      -- insert stimulus here 

      wait;
   end process;

END;
