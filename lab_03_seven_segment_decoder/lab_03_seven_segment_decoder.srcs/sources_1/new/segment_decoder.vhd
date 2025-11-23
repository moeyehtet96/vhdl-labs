----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 11/21/2025 12:38:13 PM
-- Design Name: 
-- Module Name: segment_decoder - Behavioral
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

entity segment_decoder is
    Port ( input  : in  STD_LOGIC_VECTOR(3 downto 0);
           -- abcdefg segments
           output : out STD_LOGIC_VECTOR(0 to 6)
    );
end segment_decoder;

architecture Behavioral of segment_decoder is

begin
    
    decode: process(input) is
    begin
        case input is
            when "0000" => output <= "1111110";
            when "0001" => output <= "0110000";
            when "0010" => output <= "1101101";
            when "0011" => output <= "1111001";
            when "0100" => output <= "0110011";
            when "0101" => output <= "1011011";
            when "0110" => output <= "1011111";
            when "0111" => output <= "1110000";
            when "1000" => output <= "1111111";
            when "1001" => output <= "1111011";
            when "1010" => output <= "1110111";
            when "1011" => output <= "0011111";
            when "1100" => output <= "1001110";
            when "1101" => output <= "0111101";
            when "1110" => output <= "1001111";
            when "1111" => output <= "1000111";
            when others => output <= "0000000";
        end case;
    end process;

end Behavioral;
