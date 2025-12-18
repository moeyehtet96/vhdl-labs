----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 12/18/2025 03:11:23 PM
-- Design Name: 
-- Module Name: tb_counter_async - Behavioral
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

entity tb_counter_async is
--  Port ( );
end tb_counter_async;

architecture Behavioral of tb_counter_async is
    
    -- component to test
    component counter_async is
        Port ( CLK   : in STD_LOGIC;
               RESET : in STD_LOGIC;
               Q     : out STD_LOGIC_VECTOR(2 downto 0) );
    end component;
    
    -- signals
    signal tb_clock : STD_LOGIC := '0';
    signal tb_reset : STD_LOGIC := '0';
    signal tb_q : STD_LOGIC_VECTOR(2 downto 0);
    
    -- clock period
    constant CLK_PERIOD : time := 10 ns;
    
begin

    uut: counter_async port map (CLK => tb_clock, RESET => tb_reset, Q => tb_q);
    
    clk_process: process
    begin
        
        tb_clock <= '0';
        wait for CLK_PERIOD/2;
        tb_clock <= '1';
        wait for CLK_PERIOD/2;
        
    end process;
    
    test: process
    begin
        
        -- reset
        tb_reset <= '1';
        wait for 20 ns;
        
        -- clear reset
        tb_reset <= '0';
        
        -- observe outputs
        -- should increment from 0 to 7
        -- should wrap around
        wait for 200 ns;
        
        -- check if reset works during running
        tb_reset <= '1';
        wait for 20 ns;
        tb_reset <= '0'; -- clear reset again
        
        report "Asynchronous Counter Simulation Completed Successfully.";
        wait;
    
    end process;

end Behavioral;
