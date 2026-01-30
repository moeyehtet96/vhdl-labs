----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 01/23/2026 06:28:06 AM
-- Design Name: 
-- Module Name: tb_calculator - Behavioral
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

entity tb_calculator is
--  Port ( );
end tb_calculator;

architecture Behavioral of tb_calculator is
    -- component
    component calculator
        Port ( RST : in STD_LOGIC;
               CLK : in STD_LOGIC;
--                 A : in STD_LOGIC_VECTOR (15 downto 0);
--                 B : in STD_LOGIC_VECTOR (15 downto 0);
             start : in STD_LOGIC;
          SEG_DATA : out STD_LOGIC_VECTOR (6 downto 0);
            SEG_EN : out STD_LOGIC_VECTOR (3 downto 0));
    end component;
    -- test signals
    signal tb_rst, tb_clk, tb_start : std_logic;
--    signal tb_a, tb_b : std_logic_vector(15 downto 0);
    signal tb_seg_data : std_logic_vector(6 downto 0);
    signal tb_seg_en : std_logic_vector (3 downto 0);
    -- clock period
    constant CLK_PERIOD : time := 10 ns;
begin
    uut: calculator
        port map ( RST => tb_rst,
                   CLK => tb_clk,
--                   A => tb_a,
--                   B => tb_b,
                   start => tb_start,
                   SEG_DATA => tb_seg_data,
                   SEG_EN => tb_seg_en );
    clk_proc: process
    begin
        tb_clk <= '0';
        wait for CLK_PERIOD/2;
        tb_clk <= '1';
        wait for CLK_PERIOD/2;
    end process clk_proc;
                   
    stim_proc: process
    begin
        -- reset and release
        tb_rst <= '1';
        wait for 100 ns;
        tb_rst <= '0';
        wait for CLK_PERIOD;
        
        -- Test 1: Simple Addition
--        tb_a <= x"1234";
--        tb_b <= x"5678";
        
        -- start calculation
        tb_start <= '1';
        wait for CLK_PERIOD*2;
        tb_start <= '0';   
        wait for CLK_PERIOD*2;
        
        report "Simulation Finished";
        wait;
    end process stim_proc;

end Behavioral;
