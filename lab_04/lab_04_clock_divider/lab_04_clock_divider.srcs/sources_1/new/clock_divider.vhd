----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 12/12/2025 01:12:49 PM
-- Design Name: 
-- Module Name: clock_divider - Behavioral
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

entity clock_divider is
    Port ( CLOCK : in STD_LOGIC;
           RESET : in STD_LOGIC;
           DIVIDED : out STD_LOGIC);
end clock_divider;

architecture Behavioral of clock_divider is
    signal divided_internal : STD_LOGIC := '0';
begin

    counter: process(CLOCK, RESET)
        variable count : integer := 0;
    begin
        if RESET = '1' then
            count := 0;
            divided_internal <= '0';
        elsif CLOCK = '1' and CLOCK'event then
            if count = 49999999 then
                divided_internal <= not divided_internal;
                count := 0;
            else
                count := count + 1;
            end if;
        end if;
    end process;
    
    DIVIDED <= divided_internal;

end Behavioral;
