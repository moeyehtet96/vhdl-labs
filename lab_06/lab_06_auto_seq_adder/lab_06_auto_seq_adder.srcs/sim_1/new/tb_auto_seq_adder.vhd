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

entity tb_auto_seq_adder is
--  Port ( );
end tb_auto_seq_adder;

architecture Behavioral of tb_auto_seq_adder is
    -- define bit width
    constant BIT_WIDTH : integer := 16;
    
    -- component
    component auto_seq_adder is
        generic ( BIT_WIDTH : integer := 8 );
        Port ( A : in STD_LOGIC_VECTOR (BIT_WIDTH-1 downto 0);
               B : in STD_LOGIC_VECTOR (BIT_WIDTH-1 downto 0);
               start : in STD_LOGIC;
               RST : in STD_LOGIC;
               CLK : in STD_LOGIC;
               Y : out STD_LOGIC_VECTOR (BIT_WIDTH-1 downto 0);
               finished : out STD_LOGIC);
    end component;
    
    -- test bench signals
    signal tb_a : STD_LOGIC_VECTOR (BIT_WIDTH-1 downto 0);
    signal tb_b : STD_LOGIC_VECTOR (BIT_WIDTH-1 downto 0);
    signal tb_start : STD_LOGIC;
    signal tb_rst : STD_LOGIC;
    signal tb_clk : STD_LOGIC;
    signal tb_y : STD_LOGIC_VECTOR (BIT_WIDTH-1 downto 0);
    signal tb_finished : STD_LOGIC;
    
    -- clock period
    constant CLK_PERIOD : time := 10 ns;

begin

    uut: auto_seq_adder
        generic map ( BIT_WIDTH => BIT_WIDTH )
        port map (A => tb_a,
                  B => tb_b,
                  start => tb_start,
                  RST => tb_rst,
                  CLK => tb_clk,
                  Y => tb_y,
                  finished => tb_finished);
                  
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
        
        -- Test 1: Both inputs zero
        -- provide values to add
        tb_a <= x"0000";
        tb_b <= x"0000";
        
        -- start the sequential adder
        tb_start <= '1';
        wait for 3*CLK_PERIOD;
        tb_start <= '0';
        
        -- wait for the addition to finish
        wait until tb_finished = '1';
        wait for CLK_PERIOD;
        
        -- assert
        assert (tb_y = x"0000") report "Test 1 Failed" severity error;
        
        wait for CLK_PERIOD * 2;
        
        -- reset
        tb_rst <= '1';
        wait for CLK_PERIOD;
        
        tb_rst <= '0';
        wait for CLK_PERIOD;
        
        -- Test 2: Simple addition with no carry
        -- values to add
        tb_a <= x"1234";
        tb_b <= x"5678";
        
        -- start the sequential adder
        tb_start <= '1';
        wait for CLK_PERIOD;
        tb_start <= '0';
        
        -- wait for addition to finish
        wait until tb_finished = '1';
        wait for CLK_PERIOD;
        
        -- assert
        assert (tb_y = x"68AC") report "Test 2 failed" severity error;
        
        wait for CLK_PERIOD * 2;
        
        -- reset
        tb_rst <= '1';
        wait for CLK_PERIOD;
        
        tb_rst <= '0';
        wait for CLK_PERIOD;
        
        -- Test 3: addition with carry out
        -- values to add
        tb_a <= x"A8C5";
        tb_b <= x"B6D3";
        
        -- start the sequential adder
        tb_start <= '1';
        wait for CLK_PERIOD;
        tb_start <= '0';
        
        -- wait for addition to finish
        wait until tb_finished = '1';
        wait for CLK_PERIOD;
        
        -- assert
        assert (tb_y = x"5F98") report "Test 3 failed" severity error;
        
        wait for CLK_PERIOD * 2;
        
        -- reset
        tb_rst <= '1';
        wait for CLK_PERIOD;
        
        tb_rst <= '0';
        wait for CLK_PERIOD;
        
        -- Test 4: Addition of two max inputs
        -- values to add
        tb_a <= x"FFFF";
        tb_b <= x"FFFF";
        
        -- start the sequential adder
        tb_start <= '1';
        wait for CLK_PERIOD;
        tb_start <= '0';
        
        -- wait for addition to finish
        wait until tb_finished = '1';
        wait for CLK_PERIOD;
        
        -- assert
        assert (tb_y = x"FFFE") report "Test 4 failed" severity error;
        
        wait for CLK_PERIOD * 2;
        
        -- reset
        tb_rst <= '1';
        wait for CLK_PERIOD;
        
        tb_rst <= '0';
        wait for CLK_PERIOD;
        
        -- Test 5: carry propagation
        -- values to add
        tb_a <= x"00FF";
        tb_b <= x"0001";
        
        -- start the sequential adder
        tb_start <= '1';
        wait for CLK_PERIOD;
        tb_start <= '0';
        
        -- wait for addition to finish
        wait until tb_finished = '1';
        wait for CLK_PERIOD;
        
        -- assert
        assert (tb_y = x"0100") report "Test 5 failed" severity error;
        
        wait for CLK_PERIOD * 2;
        
        report "Simulation finished";
        wait;
        
    end process;


end Behavioral;