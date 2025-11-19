----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 11/14/2025 08:30:12 AM
-- Design Name: 
-- Module Name: AND2 - Behavioral
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

entity AND2 is
    Port ( a : in STD_LOGIC;
           b : in STD_LOGIC;
           y : out STD_LOGIC);
end AND2;

architecture Behavioral of AND2 is
begin

    t: process(a, b)
        variable y2 : STD_LOGIC;
    begin
        if (a = '1') and (b = '1') then y2 := '1';
        else                            y2 := '0';
        end if;
        
        y <= '0';
        
        if (y2 = '1') then y <= '1';
        end if;
    end process;

end Behavioral;
