----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 12/13/2025 06:22:41 PM
-- Design Name: 
-- Module Name: tb_clock_divider - Behavioral
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

entity tb_clock_divider is
--  Port ( );
end tb_clock_divider;

architecture Behavioral of tb_clock_divider is
    -- Component to test
    component clock_divider
        Port ( CLOCK   : in  STD_LOGIC;
               RESET   : in  STD_LOGIC;
               DIVIDED : out STD_LOGIC );
    end component;
    -- input & output signals
    signal tb_clock : STD_LOGIC := '0';
    signal tb_reset : STD_LOGIC := '0';
    signal tb_divided : STD_LOGIC;
    -- input clock period
    constant CLK_PERIOD : time := 10 ns;
begin

    uut: clock_divider port map (CLOCK=>tb_clock, RESET=>tb_reset, DIVIDED=>tb_divided);

    clock_gen: process
    begin
        tb_clock <= '0';
        wait for CLK_PERIOD/2;
        tb_clock <= '1';
        wait for CLK_PERIOD/2;
    end process;
    
    test: process
    begin
        -- reset test
        tb_reset <= '1';
        wait for 100 ns;
        
        -- 1 Hz clock test
        tb_reset <= '0';
        wait for 2 sec;
        
        -- end test
        wait;
        
    end process;


end Behavioral;
