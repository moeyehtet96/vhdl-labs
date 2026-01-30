----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 01/23/2026 01:46:31 PM
-- Design Name: 
-- Module Name: input_reg - Behavioral
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

entity input_reg is
    Port ( CLK : in STD_LOGIC;
           RST : in STD_LOGIC;
           SW_IN : in STD_LOGIC_VECTOR (15 downto 0);
           load1 : in STD_LOGIC;
           load2 : in STD_LOGIC;
           REG1 : out STD_LOGIC_VECTOR (15 downto 0);
           REG2 : out STD_LOGIC_VECTOR (15 downto 0));
end input_reg;

architecture Behavioral of input_reg is
    signal reg1_internal, reg2_internal : std_logic_vector (15 downto 0) := (others => '0');
begin
    input_proc: process(CLK,RST)
    begin
        if (RST = '1') then
            reg1_internal <= (others => '0');
            reg2_internal <= (others => '0');
        elsif (rising_edge(CLK)) then
            if (load1 = '1') then
                reg1_internal <= SW_IN;
            elsif (load2 = '1') then
                reg2_internal <= SW_IN;
            end if;
        end if;
    end process input_proc;
    
    REG1 <= reg1_internal;
    REG2 <= reg2_internal;
end Behavioral;
