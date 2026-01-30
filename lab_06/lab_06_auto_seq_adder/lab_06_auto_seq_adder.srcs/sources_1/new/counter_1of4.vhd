----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 01/23/2026 04:51:02 AM
-- Design Name: 
-- Module Name: counter_1of4 - Behavioral
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

entity counter_1of4 is
    port ( RST, CLK : in std_logic;
                 EN : in std_logic;
                  Y : out std_logic_vector(3 downto 0));
end counter_1of4;

architecture Behavioral of counter_1of4 is
    signal y_internal : std_logic_vector(3 downto 0) := "1000";
begin
    counter: process(CLK,RST)
    begin
        if (RST = '1') then
            y_internal <= "1000";
        elsif (rising_edge(CLK)) then
            if (EN = '1') then
                y_internal <= y_internal(0) & y_internal(3 downto 1);
            end if;
        end if;
    end process counter;
    
    Y <= y_internal when EN = '1' else "0000";
end Behavioral;
