----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 01/09/2026 01:42:41 PM
-- Design Name: 
-- Module Name: tb_seq_adder_structural - Behavioral
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

entity tb_seq_adder_structural is
--  Port ( );
end tb_seq_adder_structural;

architecture Behavioral of tb_seq_adder_structural is

    component seq_adder_structural is
        Port ( RST : in STD_LOGIC;
               CLK : in STD_LOGIC;
               A : in STD_LOGIC_VECTOR (7 downto 0);
               B : in STD_LOGIC_VECTOR (7 downto 0);
               LOAD : in STD_LOGIC;
               SHIFT : in STD_LOGIC;
               Y : out STD_LOGIC_VECTOR (7 downto 0));
    end component;
    
    -- signals
    signal tb_reset : STD_LOGIC;
    signal tb_clock : STD_LOGIC;
    signal tb_A : STD_LOGIC_VECTOR (7 downto 0);
    signal tb_B : STD_LOGIC_VECTOR (7 downto 0);
    signal tb_load : STD_LOGIC := '0';
    signal tb_shift : STD_LOGIC := '0';
    signal tb_Y : STD_LOGIC_VECTOR (7 downto 0);
    
    -- constants
    constant CLK_PERIOD : time := 10 ns;

begin
    
    uut: seq_adder_structural port map (RST => tb_reset, CLK => tb_clock, 
                                        A => tb_A, B => tb_B, 
                                        LOAD => tb_load, SHIFT => tb_shift, 
                                        Y => tb_Y);
                                        
    clk_process: process
    begin
    
        tb_clock <= '0';
        wait for CLK_PERIOD/2;
        tb_clock <= '1';
        wait for CLK_PERIOD/2;
    
    end process;
    
    test: process
    begin
    
        tb_reset <= '1';
        wait for CLK_PERIOD * 2;
        
        tb_reset <= '0';
        wait for CLK_PERIOD;
        
        tb_A <= "11111111"; tb_B <= "10110110";
        
        tb_load <= '1';
        wait for CLK_PERIOD;
        
        tb_load <= '0';
        tb_shift <= '1';
        wait for CLK_PERIOD;
        
        tb_shift <= '1';
        wait for CLK_PERIOD;
        
        tb_shift <= '1';
        wait for CLK_PERIOD;
        
        tb_shift <= '1';
        wait for CLK_PERIOD;
        
        tb_shift <= '1';
        wait for CLK_PERIOD;
        
        tb_shift <= '1';
        wait for CLK_PERIOD;
        
        tb_shift <= '1';
        wait for CLK_PERIOD;
        
        tb_shift <= '1';
        wait for CLK_PERIOD;
        
        tb_shift <= '0';
        wait for CLK_PERIOD;
        
        report "Sequential Adder Structural Test Completed Successfully.";
        wait;
        
    end process;

end Behavioral;
