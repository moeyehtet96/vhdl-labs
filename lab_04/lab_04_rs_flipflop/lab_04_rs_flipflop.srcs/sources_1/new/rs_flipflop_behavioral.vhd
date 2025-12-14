----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 12/05/2025 12:45:57 PM
-- Design Name: 
-- Module Name: rs_flipflop_behavioral - Behavioral
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

entity rs_flipflop_behavioral is
    Port ( R, S : in  STD_LOGIC;
           Q    : out STD_LOGIC);
end rs_flipflop_behavioral;

architecture Behavioral of rs_flipflop_behavioral is

begin

    b: process(R, S)
    begin
        
        if (R = '1' and S  = '0') then Q <= '0';
        elsif (R = '0' and S = '1') then Q <= '1';
        elsif (S = '1' and R = '1') then Q <= 'X';
        end if;
        
    end process;

end Behavioral;
