library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;
use IEEE.std_logic_unsigned.all;
use IEEE.STD_LOGIC_ARITH.ALL;

-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
--use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx primitives in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity windowsManager is
    Port ( rs1 : in  STD_LOGIC_VECTOR (4 downto 0);
           rs2 : in  STD_LOGIC_VECTOR (4 downto 0);
           rd : in  STD_LOGIC_VECTOR (4 downto 0);
           op : in  STD_LOGIC_VECTOR (1 downto 0);
           op3 : in  STD_LOGIC_VECTOR (5 downto 0);
           cwp : in  STD_LOGIC_VECTOR (4 downto 0);
		     ncwp: out STD_LOGIC_VECTOR (4 downto 0);
           nrs1 : out  STD_LOGIC_VECTOR (5 downto 0);
           nrs2 : out  STD_LOGIC_VECTOR (5 downto 0);
           nrd : out  STD_LOGIC_VECTOR (5 downto 0));
end windowsManager;

architecture Behavioral of windowsManager is
begin
     process(rs1,rs2,rd,op,op3,cwp)
     begin 
         
			if(op ="10" and OP3 ="111100") then   --SAVE 
			     ncwp <="00000";
         elsif(op = "10" and op3 ="111101") then  --RESTORE
              ncwp <="00001";
         end if;
			
			--RS1
			if(rs1 >= "10000" and rs1 <="10111") then 
                nrs1 <= conv_std_logic_vector(( conv_integer(rs1) + conv_integer(cwp) * 16),6);  --local 			
			
			elsif(rs1 >= "11000" and rs1 <= "11111") then
                nrs1 <= conv_std_logic_vector(( conv_integer(rs1) - conv_integer(cwp) * 16),6);  --input			
            
			elsif (rs1 >= "01000" and RS1 <= "01111") then
				nrs1 <=conv_std_logic_vector(( conv_integer(rs1) + conv_integer(cwp) * 16),6);   --output

			elsif (RS1 >= "00000" and RS1 <= "00111") then 
				nrs1 <= conv_std_logic_vector(( conv_integer(rs1)),6);  
            
            end if;
 
			-- RS2
			if (rs2 >= "10000" and rs2 <= "10111") then
				nrs2 <=conv_std_logic_vector(( conv_integer(rs2) + conv_integer(cwp) * 16),6); --local 
			
			elsif (rs2 >= "11000" and rs2 <= "11111") then
				nrs2 <=conv_std_logic_vector(( conv_integer(rs2) - conv_integer(cwp) * 16),6);  --input
			
			elsif (rs2 >= "01000" and RS2 <= "01111") then
				nrs2 <=conv_std_logic_vector(( conv_integer(rs2) + conv_integer(cwp) * 16),6);  --output
				
			elsif (rs2 >= "00000" and rs2 <= "00111") then 
				nrs2 <= conv_std_logic_vector(( conv_integer(rs2)),6);	
			
			end if;
	
	
			--RD
			if (rd >= "10000" and rd <= "10111") then
				nrd <= conv_std_logic_vector(( conv_integer(rd) + conv_integer(cwp) * 16),6);   --local 
			
			elsif (rd >= "11000" and RD<= "11111") then
				nrd <= conv_std_logic_vector(( conv_integer(RD) - conv_integer(cwp) * 16),6);   --input
			
			elsif (rd >= "01000" and rd <= "01111") then
				nrd <=conv_std_logic_vector(( conv_integer(rd) + conv_integer(cwp) * 16),6);    --output
			
			elsif (rd >= "00000" and RD <= "00111") then 
				nrd <= conv_std_logic_vector((conv_integer(rd)),6);	
			end if;
			

end process;
end Behavioral;			
