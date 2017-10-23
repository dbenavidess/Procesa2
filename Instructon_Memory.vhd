----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date:    16:25:36 09/26/2017 
-- Design Name: 
-- Module Name:    Instructon_Memory - Behavioral 
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
use IEEE.STD_LOGIC_ARITH.ALL;	
use IEEE.NUMERIC_STD.ALL; 
use IEEE.STD_LOGIC_UNSIGNED.ALL; 

-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
--use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx primitives in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity Instructon_Memory is
    Port ( address : in  STD_LOGIC_VECTOR (31 downto 0);
           rst : in  STD_LOGIC;
           instruction : out  STD_LOGIC_VECTOR (31 downto 0));
end Instructon_Memory;

architecture Behavioral of Instructon_Memory is
type rom_type is array (0 to 63) of std_logic_vector (31 downto 0); 
                
    signal ROM : rom_type:= ("10000010000100000010000000000101", "10100000000100000011111111111000",
									  "10100010000100000010000000000100", "10110001001010000110000000000010",
									  "10110011001101000110000000000001", "10000001111010000010000000000000",
                             "10100000000000000110000000000011", "10000001111000000010000000000000",
									  "10000000101000000010000000000100", "10000100010000000000000000000001",
									  "10010000000100000000000000010000", others =>X"00000000");                        

--										 X"0000200A", X"00000300", X"00008101", X"04000000", X"08000601", X"0000233A",
--                             X"00300000", X"08000602", X"02000310", X"0200003B", X"00008300", X"04000002",
--                             X"00008201", X"00500000", X"00004001", X"02500000", X"00300040", X"00000241",
--                             X"04000002", X"08300000", X"00008201", X"00500000", X"08000101", X"00600002",
--                             X"04000003", X"0000241E", X"00000301", X"00000102", X"02000122", X"00002021",
--                             X"00000301", X"00000102", X"02220002", X"04000001", X"00000342", X"0200032B",
--                             X"00900000", X"00000302", X"00000102", X"04000002", X"00900000", X"00008201",
--                             X"00002023", X"00300003", X"02000433", X"00000301", X"04000004", X"00000301",
--                             X"00100002", X"02137000", X"02000036", X"00000301", X"00000102", X"02200037",
--                             X"04000004", X"00300004", X"04000040", X"02000500", X"02500000", X"00002500",
--                             X"0030000D", X"02300000", X"08200001", X"0400000D"

begin
process(address)
	begin
	if (rst = '0') then
		instruction<=ROM(conv_integer(address));
	else
		instruction<=x"00000000";
	end if;
end process;

end Behavioral;

