----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 12/12/2025 08:43:12 AM
-- Design Name: 
-- Module Name: shift_register_behavioral - Behavioral
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

entity shift_register_behavioral is
    Port ( SERIAL_IN : in STD_LOGIC;
           SHIFT_ENABLED : in STD_LOGIC;
           PARALLEL_IN : in STD_LOGIC_VECTOR(7 downto 0);
           PARALLEL_ENABLED : in STD_LOGIC;
           RESET : in STD_LOGIC;
           CLOCK: in STD_LOGIC;
           SERIAL_OUT: out STD_LOGIC;
           PARALLEL_OUT: out STD_LOGIC_VECTOR(7 downto 0));
end shift_register_behavioral;

architecture Behavioral of shift_register_behavioral is
    signal QT : STD_LOGIC_VECTOR(7 downto 0);
begin

    ff: process(RESET, CLOCK)
    begin
        if RESET = '1' then
            QT <= (others => '0');
        elsif CLOCK = '1' and CLOCK'event then
            if PARALLEL_ENABLED = '1' then
                QT <= PARALLEL_IN;
            elsif SHIFT_ENABLED = '1' then
                QT <= SERIAL_IN & QT(7 downto 1);
        end if;
        end if;
    end process;
    
    PARALLEL_OUT <= QT;
    SERIAL_OUT <= QT(0);

end Behavioral;
