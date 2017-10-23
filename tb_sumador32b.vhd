--------------------------------------------------------------------------------
-- Company: 
-- Engineer:
--
-- Create Date:   17:28:23 09/21/2017
-- Design Name:   
-- Module Name:   E:/progrmcounterysum/tb_sumador32b.vhd
-- Project Name:  progrmcounterysum
-- Target Device:  
-- Tool versions:  
-- Description:   
-- 
-- VHDL Test Bench Created by ISE for module: Sumador32b
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
 
ENTITY tb_sumador32b IS
END tb_sumador32b;
 
ARCHITECTURE behavior OF tb_sumador32b IS 
 
    -- Component Declaration for the Unit Under Test (UUT)
 
    COMPONENT Sumador32b
    PORT(
         Oper1 : IN  std_logic_vector(31 downto 0);
         Oper2 : IN  std_logic_vector(31 downto 0);
         Result : OUT  std_logic_vector(31 downto 0)
        );
    END COMPONENT;
    

   --Inputs
   signal Oper1 : std_logic_vector(31 downto 0) := (others => '0');
   signal Oper2 : std_logic_vector(31 downto 0) := (others => '0');

 	--Outputs
   signal Result : std_logic_vector(31 downto 0);
   -- No clocks detected in port list. Replace <clock> below with 
   -- appropriate port name 
 
 
BEGIN
 
	-- Instantiate the Unit Under Test (UUT)
   uut: Sumador32b PORT MAP (
          Oper1 => Oper1,
          Oper2 => Oper2,
          Result => Result
        );


   -- Stimulus process
   stim_proc: process
   begin		
      -- hold reset state for 100 ns.
      
		
		Oper1<="10101010111111010101101010101011";
		Oper2<="00101010000000000001101010101011";
		wait for 100 ns;	

      

      -- insert stimulus here 

      wait;
   end process;

END;
