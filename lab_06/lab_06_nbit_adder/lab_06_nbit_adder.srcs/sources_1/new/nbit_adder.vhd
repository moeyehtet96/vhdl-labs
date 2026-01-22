----------------------------------------------------------------------------------
--! @file   nbit_adder.vhd
--! @brief  Generic parallel n-bit adder
--! @author Moe Ye Htet (moe-ye.htet@s2025.tu-chemnitz.de)
--! @date   2026-01-22
----------------------------------------------------------------------------------


library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx leaf cells in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity nbit_adder is
    Generic ( BIT_WIDTH : integer := 4 );
    Port ( A,B : in  STD_LOGIC_VECTOR (BIT_WIDTH-1 downto 0);
             Y : out STD_LOGIC_VECTOR (BIT_WIDTH-1 downto 0);
             C : out STD_LOGIC);
end nbit_adder;

architecture Dataflow of nbit_adder is
    signal tmp : unsigned(BIT_WIDTH downto 0);
begin
    tmp <= unsigned('0' & A) + unsigned('0' & B);
    Y <= std_logic_vector(tmp(BIT_WIDTH-1 downto 0));
    C <= std_logic(tmp(BIT_WIDTH));
end Dataflow;
