--------------------------------------------------------------------------------
-- Company: 
-- Engineer:
--
-- Create Date:   03:46:23 11/14/2021
-- Design Name:   
-- Module Name:   E:/Xilinx/Labs/lab4/lab4/task_1_test_1.vhd
-- Project Name:  lab4
-- Target Device:  
-- Tool versions:  
-- Description:   
-- 
-- VHDL Test Bench Created by ISE for module: task_1_bex_1
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
 
ENTITY task_1_test_1 IS
END task_1_test_1;
 
ARCHITECTURE behavior OF task_1_test_1 IS 
 
    -- Component Declaration for the Unit Under Test (UUT)
 
    COMPONENT task_1_bex_1
    PORT(
         Din : IN  std_logic_vector(3 downto 0);
         EN : IN  std_logic;
         Dout : OUT  std_logic_vector(3 downto 0)
        );
    END COMPONENT;
    

   --Inputs
   signal Din : std_logic_vector(3 downto 0) := (others => '0');
   signal EN : std_logic := '0';

 	--Outputs
   signal Dout : std_logic_vector(3 downto 0);
   -- No clocks detected in port list. Replace <clock> below with 
   -- appropriate port name 
 
 
BEGIN
 
	-- Instantiate the Unit Under Test (UUT)
   uut: task_1_bex_1 PORT MAP (
          Din => Din,
          EN => EN,
          Dout => Dout
        );

 

   -- Stimulus process
   stim_proc: process
   begin		
      -- hold reset state for 100 ns.
      wait for 100 ns;	
	
		wait for 10ps;
		Din <= "0001";
		wait for 10ps;
		EN <= '1';
		wait for 10ps;
		Din <= "1111";
		wait for 10ps;
		Din <= "0000";
		wait for 10ps;
		EN <= '0';
		wait for 10ps;
		Din <= "1111";

      -- insert stimulus here 

      wait;
   end process;

END;
