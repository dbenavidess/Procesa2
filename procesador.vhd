----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date:    16:57:38 09/26/2017 
-- Design Name: 
-- Module Name:    procesador - Behavioral 
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

entity procesador is
    Port ( rst : in  STD_LOGIC;
           clk : in  STD_LOGIC;
           asd : out  STD_LOGIC_VECTOR (31 downto 0));
end procesador;


architecture Behavioral of procesador is

component ProgramCounter
	port(
			dataIn : in std_logic_vector(31 downto 0);
			clk : in std_logic;
			rst : in std_logic;
			dataOut : out std_logic_vector(31 downto 0)
	);
end component;
component Sumador32b
	port(
			Oper1 : in  STD_LOGIC_VECTOR (31 downto 0);
         Oper2 : in  STD_LOGIC_VECTOR (31 downto 0);
         Result : out  STD_LOGIC_VECTOR (31 downto 0)
	);
end component;
component Instructon_Memory
	port(
			address : in  STD_LOGIC_VECTOR (31 downto 0);
         rst : in  STD_LOGIC;
         instruction : out  STD_LOGIC_VECTOR (31 downto 0)
	);
end component;
COMPONENT ControlUnit
	PORT(
		op : IN std_logic_vector(1 downto 0);
		op3 : IN std_logic_vector(5 downto 0);          
		aluop : OUT std_logic_vector(5 downto 0)
		);
	END COMPONENT;
COMPONENT SEU
	PORT(
		imm13 : IN std_logic_vector(12 downto 0);          
		seuimm : OUT std_logic_vector(31 downto 0)
		);
	END COMPONENT;
COMPONENT RegisterFile
	PORT(
		rs1 : IN std_logic_vector(5 downto 0);
		rs2 : IN std_logic_vector(5 downto 0);
		rd : IN std_logic_vector(5 downto 0);
		rst : IN std_logic;
		dwr : IN std_logic_vector(31 downto 0);          
		crs1 : OUT std_logic_vector(31 downto 0);
		crs2 : OUT std_logic_vector(31 downto 0)
		);
	END COMPONENT;
COMPONENT Multiplexor
	PORT(
		A : IN std_logic_vector(31 downto 0);
		B : IN std_logic_vector(31 downto 0);
		Sel : IN std_logic;          
		Salida : OUT std_logic_vector(31 downto 0)
		);
	END COMPONENT;
COMPONENT ALU
	PORT(
		op_code : IN std_logic_vector(5 downto 0);
		op1 : IN std_logic_vector(31 downto 0);
		op2 : IN std_logic_vector(31 downto 0);          
		result : OUT std_logic_vector(31 downto 0);
		c: in STD_LOGIC
		);
	END COMPONENT;
COMPONENT PSR_modifier
	PORT(
		ALUOP : IN std_logic_vector(5 downto 0);
		RESULT : IN std_logic_vector(31 downto 0);
		RS1 : IN std_logic_vector(31 downto 0);
		RS2 : IN std_logic_vector(31 downto 0);          
		NZVC : OUT std_logic_vector(3 downto 0)
		);
	END COMPONENT;
COMPONENT psr
	PORT(
		clk : IN std_logic;
		rst : IN std_logic;
		nzvc : IN std_logic_vector(3 downto 0);
		ncwp : IN std_logic_vector(4 downto 0);          
		cwp : OUT std_logic_vector(4 downto 0);
		c : OUT std_logic
		);
	END COMPONENT;
COMPONENT windowsManager
	PORT(
		RS1 : IN std_logic_vector(4 downto 0);
		RS2 : IN std_logic_vector(4 downto 0);
		RD : IN std_logic_vector(4 downto 0);
		OP : IN std_logic_vector(1 downto 0);
		OP3 : IN std_logic_vector(5 downto 0);
		CWP : IN std_logic_vector(4 downto 0);          
		NCWP : OUT std_logic_vector(4 downto 0);
		NRS1 : OUT std_logic_vector(5 downto 0);
		NRS2 : OUT std_logic_vector(5 downto 0);
		NRD : OUT std_logic_vector(5 downto 0)
		);
	END COMPONENT;

signal add : std_logic_vector(31 downto 0);
signal add_aux : std_logic_vector(31 downto 0);
signal sum : std_logic_vector(31 downto 0);
signal ins : std_logic_vector(31 downto 0);
signal ALUinstr : std_logic_vector(5 downto 0);
signal imm13 : std_logic_vector(12 downto 0);
signal extended : std_logic_vector(31 downto 0);
signal mux2 : std_logic_vector(31 downto 0);
signal OP1 : std_logic_vector(31 downto 0);
signal OP2 : std_logic_vector(31 downto 0);
signal ALUout : std_logic_vector(31 downto 0);
signal auxNZVC: std_logic_vector(3 downto 0);
signal nCWP: std_logic_vector(4 downto 0);
signal CWP1: std_logic_vector(4 downto 0);
signal nRS1: std_logic_vector(5 downto 0);
signal nRS2: std_logic_vector(5 downto 0);
signal nRD: std_logic_vector(5 downto 0);
signal acarreo: std_logic;
begin

imm13<= ins(12 downto 0);
asd<=ALUout;



Inst_NProgramCounter: ProgramCounter PORT MAP(
		rst => rst,
		dataIn => sum,
		clk => clk,
		DataOut => add_aux
	);
Inst_ProgramCounter: ProgramCounter PORT MAP(
		rst => rst,
		dataIn => add_aux,
		clk => clk,
		DataOut => add
	);
Inst_Sumador32b: Sumador32b PORT MAP(
		Oper1 => add,
		Oper2 => "00000000000000000000000000000001",
		Result => sum
	);
Inst_Instructon_Memory: Instructon_Memory PORT MAP(
		address => add,
		rst => rst,
		instruction => ins
	);

Inst_ControlUnit: ControlUnit PORT MAP(
	op => ins(31 downto 30),
	op3 => ins(24 downto 19),
	aluop => ALUinstr
);
Inst_SEU: SEU PORT MAP(
		imm13 => imm13,
		seuimm => extended
	);

Inst_RegisterFile: RegisterFile PORT MAP(
		rs1 => nRS1,
		rs2 => nRS2,
		rd => nRD,
		rst => rst,
		dwr => ALUout,
		crs1 => OP1,
		crs2 => mux2
	);
Inst_Multiplexor: Multiplexor PORT MAP(
		A => mux2,
		B => extended,
		Sel => ins(13),
		Salida => OP2
	);
Inst_ALU: ALU PORT MAP(
		op_code => ALUinstr,
		op1 => OP1,
		op2 => OP2,
		result => ALUout,
		c => acarreo
		);
Inst_PSR_modifier: PSR_modifier PORT MAP(
		ALUOP => ALUinstr,
		RESULT => ALUout,
		RS1 => OP1,
		RS2 => OP2,
		NZVC =>auxNZVC
	);
Inst_psr: psr PORT MAP(
		clk => clk,
		rst => rst,
		nzvc => auxNZVC,
		ncwp => nCWP,
		cwp => CWP1,
		c => acarreo
	);
Inst_windowsManager: windowsManager PORT MAP(
		RS1 => ins(18 downto 14),
		RS2 => ins(4 downto 0),
		RD => ins(29 downto 25),
		OP => ins(31 downto 30),
		OP3 => ins(24 downto 19),
		CWP => CWP1,
		NCWP => nCWP,
		NRS1 => nRS1,
		NRS2 => nRS2,
		NRD => nRD
	);

	
end Behavioral;

