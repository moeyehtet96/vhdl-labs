----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 01/16/2026 11:45:18 AM
-- Design Name: 
-- Module Name: tb_seq_adder_fsm - Behavioral
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

entity tb_seq_adder_fsm is
--  Port ( );
end tb_seq_adder_fsm;

architecture Behavioral of tb_seq_adder_fsm is

    component seq_adder_fsm is
        Port ( A : in STD_LOGIC_VECTOR (7 downto 0);
               B : in STD_LOGIC_VECTOR (7 downto 0);
               START : in STD_LOGIC;
               RST : in STD_LOGIC;
               CLK : in STD_LOGIC;
               Y : out STD_LOGIC_VECTOR (7 downto 0);
               FINISHED : out STD_LOGIC);
    end component;
    
    -- test bench signals
    signal tb_a : STD_LOGIC_VECTOR (7 downto 0);
    signal tb_b : STD_LOGIC_VECTOR (7 downto 0);
    signal tb_start : STD_LOGIC;
    signal tb_rst : STD_LOGIC;
    signal tb_clk : STD_LOGIC;
    signal tb_y : STD_LOGIC_VECTOR (7 downto 0);
    signal tb_finished : STD_LOGIC;
    
    -- clock period
    constant CLK_PERIOD : time := 10 ns;

begin

    uut: seq_adder_fsm
        port map (A => tb_a,
                  B => tb_b,
                  START => tb_start,
                  RST => tb_rst,
                  CLK => tb_clk,
                  Y => tb_y,
                  FINISHED => tb_finished);
                  
    clk_process: process
    begin
    
        tb_clk <= '0';
        wait for CLK_PERIOD/2;
        tb_clk <= '1';
        wait for CLK_PERIOD/2;
        
    end process;
    
    stim_process: process
    begin
        
        -- reset and release
        tb_rst <= '1';
        wait for 100 ns;
        
        tb_rst <= '0';
        wait for CLK_PERIOD;
        
        -- Test 1: Test for addition without carry
        -- provide values to add
        tb_a <= "00000101";
        tb_b <= "00000011";
        
        -- start the sequential adder
        tb_start <= '1';
        wait for CLK_PERIOD;
        tb_start <= '0';
        
        -- wait for the addition to finish
        wait until tb_finished = '1';
        wait for CLK_PERIOD;
        
        -- assert
        assert (tb_y = "00001000") report "Test for addition without carry failed" severity error;
        
        wait for CLK_PERIOD * 2;
        
        -- Test 2: Test for addition with carry
        -- values to add
        tb_a <= "11111111";
        tb_b <= "00000001";
        
        -- start the sequential adder
        tb_start <= '1';
        wait for CLK_PERIOD;
        tb_start <= '0';
        
        -- wait for addition to finish
        wait until tb_finished = '1';
        wait for CLK_PERIOD;
        
        -- assert
        assert (tb_y = "00000000") report "Test for addition with carry failed" severity error;
        
        wait for CLK_PERIOD * 2;
        
        -- Test 3: Test for addition of two zeros
        -- values to add
        tb_a <= "00000000";
        tb_b <= "00000000";
        
        -- start the sequential adder
        tb_start <= '1';
        wait for CLK_PERIOD;
        tb_start <= '0';
        
        -- wait for addition to finish
        wait until tb_finished = '1';
        wait for CLK_PERIOD;
        
        -- assert
        assert (tb_y = "00000000") report "Test for addition of two zeros failed" severity error;
        
        wait for CLK_PERIOD * 2;
        
        -- Test 4: Test for addition of one non-zero and one zero
        -- values to add
        tb_a <= "01101011";
        tb_b <= "00000000";
        
        -- start the sequential adder
        tb_start <= '1';
        wait for CLK_PERIOD;
        tb_start <= '0';
        
        -- wait for addition to finish
        wait until tb_finished = '1';
        wait for CLK_PERIOD;
        
        -- assert
        assert (tb_y = "01101011") report "Test for addition of one non-zero and one zero failed" severity error;
        
        wait for CLK_PERIOD * 2;
        
        -- Test 5: Test for maximum addition value
        -- values to add
        tb_a <= "01101011";
        tb_b <= "10010100";
        
        -- start the sequential adder
        tb_start <= '1';
        wait for CLK_PERIOD;
        tb_start <= '0';
        
        -- wait for addition to finish
        wait until tb_finished = '1';
        wait for CLK_PERIOD;
        
        -- assert
        assert (tb_y = "11111111") report "Test for maximum addition value failed" severity error;
        
        wait for CLK_PERIOD * 2;
        
        -- Test 6: Test for carry chain without overflow
        -- values to add
        tb_a <= "00001111";
        tb_b <= "00000001";
        
        -- start the sequential adder
        tb_start <= '1';
        wait for CLK_PERIOD;
        tb_start <= '0';
        
        -- wait for addition to finish
        wait until tb_finished = '1';
        wait for CLK_PERIOD;
        
        -- assert
        assert (tb_y = "00010000") report "Test for carry chain w/o overflow failed" severity error;
        
        wait for CLK_PERIOD * 2;
        
        -- Test 7: Test for carry chain with overflow
        -- values to add
        tb_a <= "11111111";
        tb_b <= "00000001";
        
        -- start the sequential adder
        tb_start <= '1';
        wait for CLK_PERIOD;
        tb_start <= '0';
        
        -- wait for addition to finish
        wait until tb_finished = '1';
        wait for CLK_PERIOD;
        
        -- assert
        assert (tb_y = "00000000") report "Test for carry chain with overflow failed" severity error;
        
        wait for CLK_PERIOD * 2;
        
        -- Test 8: Test for lsb addition
        -- values to add
        tb_a <= "00000001";
        tb_b <= "00000001";
        
        -- start the sequential adder
        tb_start <= '1';
        wait for CLK_PERIOD;
        tb_start <= '0';
        
        -- wait for addition to finish
        wait until tb_finished = '1';
        wait for CLK_PERIOD;
        
        -- assert
        assert (tb_y = "00000010") report "Test for lsb addition failed" severity error;
        
        wait for CLK_PERIOD * 2;
        
        -- Test 9: Test for msb addition overflow
        -- values to add
        tb_a <= "10000000";
        tb_b <= "10000000";
        
        -- start the sequential adder
        tb_start <= '1';
        wait for CLK_PERIOD;
        tb_start <= '0';
        
        -- wait for addition to finish
        wait until tb_finished = '1';
        wait for CLK_PERIOD;
        
        -- assert
        assert (tb_y = "00000000") report "Test for msb addition value failed" severity error;
        
        wait for CLK_PERIOD * 2;
        
        report "Simulation finished";
        wait;
        
    end process;


end Behavioral;
