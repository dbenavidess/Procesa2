----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date:    17:20:29 10/10/2017 
-- Design Name: 
-- Module Name:    ALU - Behavioral 
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
use IEEE.NUMERIC_STD.all;
use ieee.std_logic_unsigned.all;

-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
--use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx primitives in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity ALU is
    Port ( op_code : in  STD_LOGIC_VECTOR (5 downto 0);
           op1 : in  STD_LOGIC_VECTOR (31 downto 0);
           op2 : in  STD_LOGIC_VECTOR (31 downto 0);
           result : out  STD_LOGIC_VECTOR (31 downto 0);
			  c: in STD_LOGIC
			  );
end ALU;

architecture Behavioral of ALU is
signal resulta: STD_LOGIC_VECTOR (31 downto 0);
begin

process(op_code,op1,op2)
begin
	--report"opecode: "&integer'image(conv_integer(op_code));
	case op_code is
		--add
		when "000000" => result<= std_logic_vector(SIGNED(op1) + SIGNED(op2));
		--sub
		when "000100" => result<= std_logic_vector(SIGNED(op1) - SIGNED(op2));
		--and
		when "000001" => result<= op1 and op2;
		--andn
		when "000101" => result<= op1 and NOT op2;
		--or
		when "000010" => result<= op1 or op2;
		--orn
		when "000110" => result<= op1 or NOT op2;
		--xor
		when "000011" => result<= op1 xor op2;
		--xnor
		when "000111" => result<= op1 xnor op2;
		
		
			when "010000" => -- addcc
				result <= std_logic_vector(SIGNED(op1) + SIGNED(op2));
			when "001000" => 
				result <= std_logic_vector((op1) + (op2)+c); 					  --ADDX
			when "001100" => 
				result <= std_logic_vector((op1) - (op2)-c); 					  --SUBx
			when "011000" => 
				result <= std_logic_vector((op1) + (op2)+c); 					  --ADDxcc
			when "011100" => 
				result <= std_logic_vector((op1) - (op2)-c); 					  --SUBxcc

			when "010001" => -- andcc
				result <= op1 AND op2 ;
			when "010101" => -- andncc
				result <= op1 and NOT op2;
			when "010010" => -- orcc
				result <= op1 or op2;
			when "010110" => -- orncc
				result <= op1 or NOT op2;
			when "010011" => -- xorcc
				result <= op1 xor op2 ;
			when "010111" => -- xnorcc
				result <= op1 xnor op2;

			when "100101" => -- sll
				result <= to_stdlogicvector((to_bitvector(op1)) sll conv_integer (op2));
				--aluresult <= crs1 + CRS2mux  ;
			when "100110" => -- srl
				result <= to_stdlogicvector((to_bitvector(op1)) srl conv_integer (op2));
				--aluresult <= crs1 + CRS2mux  ;
			when "111100" =>                                                 --save
				result <= op1 + op2;
						
			when "111101" =>                                                 --restore
				result <= op1 + op2;	

			
		when others =>   result<= "11111111111111111111111111111111";
	end case;
		
end process;


end Behavioral;

