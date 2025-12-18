----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 12/18/2025 12:12:52 AM
-- Design Name: 
-- Module Name: d_flipflop - Behavioral
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

entity d_flipflop is
    Port ( D     : in  STD_LOGIC;
           CLK   : in  STD_LOGIC;
           RESET : in  STD_LOGIC;
           Q     : out STD_LOGIC;
           Q_bar : out STD_LOGIC);
end d_flipflop;

architecture Behavioral of d_flipflop is
    signal Q_internal : STD_LOGIC := '0';
begin

    dff: process(CLK, RESET)
    begin
        if RESET = '1' then
            Q_internal <= '0';
        elsif CLK = '1' and CLK'event then
            Q_internal <= D;
        end if;
    
    end process;
    
    Q <= Q_internal;
    Q_bar <= not Q_internal;

end Behavioral;
