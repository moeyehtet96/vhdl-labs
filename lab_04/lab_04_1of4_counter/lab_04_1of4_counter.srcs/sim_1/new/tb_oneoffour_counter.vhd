----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 12/17/2025 07:11:15 PM
-- Design Name: 
-- Module Name: tb_oneoffour_counter - Behavioral
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

entity tb_oneoffour_counter is
--  Port ( );
end tb_oneoffour_counter;

architecture Behavioral of tb_oneoffour_counter is

    -- component to test
    component oneoffour_counter is
        generic ( MAX_COUNT : integer := 499999 );
        Port ( RESET  : in  STD_LOGIC;
               CLOCK  : in  STD_LOGIC;
               OUTPUT : out STD_LOGIC_VECTOR(3 downto 0));
    end component;
    
    -- input & output signals
    signal tb_reset, tb_clock : STD_LOGIC := '0';
    signal tb_output : STD_LOGIC_VECTOR(3 downto 0);
    
    -- clock period
    constant CLK_PERIOD : time := 10 ns;
    
begin

    uut: oneoffour_counter
        generic map (MAX_COUNT => 3)
        port map (RESET => tb_reset, 
                  CLOCK => tb_clock, 
                  OUTPUT => tb_output);
    
    clk_process: process
    begin
    
        tb_clock <= '0';
        wait for CLK_PERIOD/2;
        tb_clock <= '1';
        wait for CLK_PERIOD/2;
    
    end process;
    
    test: process
    begin
        
        -- initialize
        tb_reset <= '0';
        wait for 100 ns;
        
        -- Test 1: reset = 1 => output = 1000
        tb_reset <= '1';
        wait for CLK_PERIOD;
        wait for 1 ns;
        -- assert
        assert (tb_output = "1000") report "Failed Reset Check" severity error;
        
        tb_reset <= '0';
        
        -- Test 2: output = 0100
        wait for 4 * CLK_PERIOD;
        wait for 1 ns;
        -- assert
        assert (tb_output = "0100") report "Failed 0100 Check" severity error;
        
        -- Test 3: output = 0010
        wait for 4 * CLK_PERIOD;
        wait for 1 ns;
        -- assert
        assert (tb_output = "0010") report "Failed 0010 Check" severity error;
        
        -- Test 4: output = 0001
        wait for 4 * CLK_PERIOD;
        wait for 1 ns;
        -- assert
        assert (tb_output = "0001") report "Failed 0001 Check" severity error;
        
        -- Test 5: output = 1000
        wait for 4 * CLK_PERIOD;
        wait for 1 ns;
        -- assert
        assert (tb_output = "1000") report "Failed 1000 Check" severity error;
        
        report "1 of 4 Counter Simulation Completed Successfully.";
        wait;
    end process;

end Behavioral;
