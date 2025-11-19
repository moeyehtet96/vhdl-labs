----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 11/14/2025 08:51:40 AM
-- Design Name: 
-- Module Name: adder_4bit_structural - Behavioral
-- Project Name: 
-- Target Devices: 
-- Tool Versions: 
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
-- any Xilinx leaf cells in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity adder_4bit_structural is
    Port ( A, B  : in  STD_LOGIC_VECTOR(3 downto 0);
           C_in  : in  STD_LOGIC;
           Sum   : out STD_LOGIC_VECTOR(3 downto 0);
           C_out : out STD_LOGIC);
end adder_4bit_structural;

architecture Structural of adder_4bit_structural is
    
    component full_adder is
        port (A, B  : in  STD_LOGIC;
              C_in  : in  STD_LOGIC;
              Sum   : out STD_LOGIC;
              C_out : out STD_LOGIC);
    end component; 
    signal C_tmp1, C_tmp2, C_tmp3 : STD_LOGIC;
begin

    ADDER_BIT0: full_adder port map (A=>A(0), B=>B(0), C_in=>C_in, Sum=>Sum(0), C_out=>C_tmp1);
    ADDER_BIT1: full_adder port map (A=>A(1), B=>B(1), C_in=>C_tmp1, Sum=>Sum(1), C_out=>C_tmp2);
    ADDER_BIT2: full_adder port map (A=>A(2), B=>B(2), C_in=>C_tmp2, Sum=>Sum(2), C_out=>C_tmp3);
    ADDER_BIT3: full_adder port map (A=>A(3), B=>B(3), C_in=>C_tmp3, Sum=>Sum(3), C_out=>C_out);

end Structural;
