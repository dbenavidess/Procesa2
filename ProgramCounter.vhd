----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date:    16:29:07 09/21/2017 
-- Design Name: 
-- Module Name:    ProgramCounter - Behavioral 
-- Project Name: 
-- Target Devices: 
-- Tool versions: 
-- Description: 
--
-- Dependencies: 
--
-- Revision: 
-- Revision 0.01 - File Created
-- Additional Comments: 
--
----------------------------------------------------------------------------------
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
--use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx primitives in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity ProgramCounter is
    Port ( rst : in  STD_LOGIC;
           dataIn : in  STD_LOGIC_VECTOR (31 downto 0);
           clk : in  STD_LOGIC;
           DataOut : out  STD_LOGIC_VECTOR (31 downto 0));
end ProgramCounter;

architecture Behavioral of ProgramCounter is


signal memo : std_logic_vector (31 downto 0) := x"00000000";
	 

begin

process(clk,dataIn,memo)
	begin
	if (rst = '0') then
			if (clk'event and clk='1') then
				memo<=DataIn;
				--DataOut<=memo;
			end if;
	
	else
		memo<="00000000000000000000000000000000";
	end if;
	
	DataOut<=memo;
end process;
end Behavioral;

