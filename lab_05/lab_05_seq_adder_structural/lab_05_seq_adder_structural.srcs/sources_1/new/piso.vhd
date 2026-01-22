----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 01/09/2026 10:00:40 AM
-- Design Name: 
-- Module Name: piso - Behavioral
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

entity piso is
    Port ( D : in STD_LOGIC_VECTOR (7 downto 0);
           LOAD : in STD_LOGIC;
           SHIFT : in STD_LOGIC;
           CLK : in STD_LOGIC;
           RST : in STD_LOGIC;
           Q : out STD_LOGIC);
end piso;

architecture Behavioral of piso is
    signal QT : std_logic_vector(7 downto 0);
begin
    
    ff: process (RST, CLK)
    begin
        if RST = '1' then
            QT <= (others => '0');
        else
            if CLK = '1' and CLK'event then
                if LOAD = '1' then
                    QT <= D; 
                elsif SHIFT = '1' then
                    QT <= '0' & QT(7 downto 1);
                end if;
            end if;
        end if;
    end process;
    
    Q <= QT(0);

end Behavioral;
