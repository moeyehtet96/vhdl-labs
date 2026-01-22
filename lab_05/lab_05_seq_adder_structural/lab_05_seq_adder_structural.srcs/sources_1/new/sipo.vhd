----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 01/09/2026 10:22:26 AM
-- Design Name: 
-- Module Name: sipo - Behavioral
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

entity sipo is
    Port ( S_IN : in STD_LOGIC;
           SHIFT : in STD_LOGIC;
           CLK : in STD_LOGIC;
           RST : in STD_LOGIC;
           Q : out STD_LOGIC_VECTOR (7 downto 0));
end sipo;

architecture Behavioral of sipo is
    signal QT : STD_LOGIC_VECTOR(7 downto 0);
begin

    ff: process(RST, CLK)
    begin
        
        if RST = '1' then
            QT <= (others => '0');
        elsif CLK = '1' and CLK'event then
            if SHIFT = '1' then
                QT <= S_IN & QT(7 downto 1);
            end if;
        end if;
        
    end process;
    
    Q <= QT;

end Behavioral;
