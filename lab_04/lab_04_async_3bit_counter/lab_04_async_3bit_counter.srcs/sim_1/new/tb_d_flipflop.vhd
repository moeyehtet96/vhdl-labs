----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 12/18/2025 04:40:31 PM
-- Design Name: 
-- Module Name: tb_d_flipflop - Behavioral
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

entity tb_d_flipflop is
--  Port ( );
end tb_d_flipflop;

architecture Behavioral of tb_d_flipflop is

    -- component to test
    component d_flipflop is
        Port ( D     : in  STD_LOGIC;
               CLK   : in  STD_LOGIC;
               RESET : in  STD_LOGIC;
               Q     : out STD_LOGIC;
               Q_bar : out STD_LOGIC);
    end component;
    
    -- test signals
    signal tb_d : STD_LOGIC := '0';
    signal tb_clk : STD_LOGIC := '0';
    signal tb_reset : STD_LOGIC := '0';
    signal tb_q : STD_LOGIC;
    signal tb_qb : STD_LOGIC;
    
    -- clock period
    constant CLK_PERIOD : time := 10 ns;

begin

    uut: d_flipflop port map (D => tb_d, CLK => tb_clk, RESET => tb_reset, Q => tb_q, Q_bar => tb_qb);
    
    clk_process: process
    begin
    
        tb_clk <= '0';
        wait for CLK_PERIOD/2;
        tb_clk <= '1';
        wait for CLK_PERIOD/2;
    
    end process;
    
    test: process
    begin
        
        -- set reset
        tb_reset <= '1';
        wait for 20 ns;
        -- assert
        assert (tb_q = '0' and tb_qb = '1') report "Initial Reset Test Failed" severity error;
        
        -- clear reset
        tb_reset <= '0';
        wait for 20 ns;
        
        -- if d = 1 and clk rising edge => q = 1 
        tb_d <= '1';
        wait for CLK_PERIOD;
        -- assert
        assert (tb_q = '1' and tb_qb = '0') report "Data input 1 Test Failed" severity error;
        
        -- if d = 0 and clk rising edge => q = 0 
        tb_d <= '0';
        wait for CLK_PERIOD;
        -- assert
        assert (tb_q = '0' and tb_qb = '1') report "Data input 0 Test Failed" severity error;
        
        -- reset during running => q = 0
        tb_d <= '1';
        wait for CLK_PERIOD;
        
        tb_reset <= '1'; -- reset while output should be 1
        wait for 1 ns;
        --assert
        assert (tb_q = '0' and tb_qb = '1') report "Reset while running Test Failed" severity error;
        
        wait for 20ns;
        tb_reset <= '0';
    
        report "D Flip-Flop Simulation Complete";
        wait;
    
    end process;

end Behavioral;
