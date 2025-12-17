----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 12/14/2025 08:25:08 PM
-- Design Name: 
-- Module Name: oneoffour_counter - Behavioral
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

entity oneoffour_counter is
    generic ( MAX_COUNT : integer := 499999 ); -- default for hardware
    Port ( RESET : in STD_LOGIC;
           CLOCK : in STD_LOGIC;
           OUTPUT : out STD_LOGIC_VECTOR(3 downto 0));
end oneoffour_counter;

architecture Behavioral of oneoffour_counter is
    signal output_internal : STD_LOGIC_VECTOR(3 downto 0) := "1000";
begin
    
    counter: process(RESET, CLOCK)
        variable count : integer := 0;
    begin
        if RESET = '1' then
            count := 0;
            output_internal <= "1000";
        elsif CLOCK = '1' and CLOCK'event then
            if count = MAX_COUNT then
                output_internal <= output_internal(0) & output_internal(3 downto 1);
                count := 0;
            else
                count := count + 1;
            end if;
        end if;
    end process;
    
    OUTPUT <= output_internal;
    
end Behavioral;
