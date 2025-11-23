----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 11/21/2025 04:24:15 PM
-- Design Name: 
-- Module Name: segment_decoder_lut - Behavioral
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
use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
--use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx leaf cells in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity segment_decoder_lut is
    Port ( input  : in  STD_LOGIC_VECTOR(3 downto 0);
           output : out STD_LOGIC_VECTOR(0 to 6)
    );
end segment_decoder_lut;

architecture Behavioral of segment_decoder_lut is

    type rom_t is array (0 to 15) of STD_LOGIC_VECTOR(0 to 6);
    
    constant SEGMENT_ROM : rom_t := (
        "1111110",  -- 0
        "0110000",  -- 1
        "1101101",  -- 2
        "1111001",  -- 3
        "0110011",  -- 4
        "1011011",  -- 5
        "1011111",  -- 6
        "1110000",  -- 7
        "1111111",  -- 8
        "1111011",  -- 9
        "1110111",  -- A
        "0011111",  -- b
        "1001110",  -- C
        "0111101",  -- d
        "1001111",  -- E
        "1000111"   -- F
    );

begin
    
    output <= SEGMENT_ROM(to_integer(unsigned(input)));

end Behavioral;
