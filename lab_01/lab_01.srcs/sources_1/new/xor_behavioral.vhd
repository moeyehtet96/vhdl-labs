----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 11/07/2025 12:19:47 PM
-- Design Name: 
-- Module Name: xor_behavioral - Behavioral
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

entity xor_behavioral is
    Port ( A : in STD_LOGIC;
           B : in STD_LOGIC;
           Y : out STD_LOGIC);
end xor_behavioral;

architecture Behavioral of xor_behavioral is

begin
    
    xor_process : process(A, B)
    begin
        if (A = 'U' or B = 'U') then
            Y <= 'U';
        elsif (A = 'X' or B = 'X') then
            Y <= 'X';
        elsif (A = '1' and B = '0') or (A = '0' and B = '1') then
            Y <= '1';
        else
            Y <= '0';
        end if;
    end process xor_process;

end Behavioral;
