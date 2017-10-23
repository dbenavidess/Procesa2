----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date:    17:01:27 09/28/2017 
-- Design Name: 
-- Module Name:    ControlUnit - Behavioral 
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
use ieee.std_logic_unsigned.all;

-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
--use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx primitives in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity ControlUnit is
    Port ( op : in  STD_LOGIC_VECTOR (1 downto 0);
           op3 : in  STD_LOGIC_VECTOR (5 downto 0);
           aluop : out  STD_LOGIC_VECTOR (5 downto 0));
end ControlUnit;

architecture Behavioral of ControlUnit is

begin
process(op,op3)
begin
	if(op = "10")then
		case op3 is
			when "000001" => aluop <= "000001";
			when "000101" => aluop <= "000101";
			when "000010" => aluop <= "000010";
			when "000110" => aluop <= "000110";
			when "000011" => aluop <= "000011";
			when "000111" => aluop <= "000111";
			when "000000" => aluop <= "000000";
			when "000100" => aluop <= "000100";
			when "100101" => aluop <= "100101"; 
			when "100110" => aluop <= "100110"; 
			when "010000" => aluop <= "010000"; 
			when "010100" => aluop <= "010100"; 
			when "010001" => aluop <= "010001"; 
			when "010101" => aluop <= "010101"; 
			when "010010" => aluop <= "010010"; 
			when "010110" => aluop <= "010110"; 
			when "010011" => aluop <= "010011"; 
			when "010111" => aluop <= "010111"; 
			when "001000" => aluop <= "001000"; 
			when "001100" => aluop <= "001100"; 
			when "011000" => aluop <= "011000"; 
			when "011100" => aluop <= "011100"; 
			when "111101" => aluop <= "000000"; 
			when "111100" => aluop <= "000100"; 
			when others => aluop <= "111111";
		end case;
	end if;
end process;		


end Behavioral;

