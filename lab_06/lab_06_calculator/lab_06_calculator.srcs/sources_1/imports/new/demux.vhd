----------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 01/23/2026 04:51:02 AM
-- Design Name: 
-- Module Name: demux - Dataflow
-- Project Name: 
-- Target Devices: 
-- Tool Versions: 
-- Description: 
-- 
-- Dependencies: 
--  
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

entity demux is
    Port ( X_IN : in STD_LOGIC_VECTOR (15 downto 0);
           SEL : in STD_LOGIC_VECTOR (3 downto 0);
           Y_OUT : out STD_LOGIC_VECTOR (3 downto 0));
end demux;

architecture Dataflow of demux is

begin
    with SEL select
        Y_OUT <= X_IN(15 downto 12) when "0111", -- 1st digit
                  X_IN(11 downto 8) when "1011", -- 2nd digit
                  X_IN(7 downto 4)  when "1101", -- 3rd digit
                  X_IN(3 downto 0)  when "1110", -- 4th digit
                  (others => '0')   when others;

end Dataflow;
