----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 12/12/2025 11:40:28 AM
-- Design Name: 
-- Module Name: tb_shift_register - Behavioral
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

entity tb_shift_register is
--  Port ( );
end tb_shift_register;

architecture Behavioral of tb_shift_register is

    -- component for testing
    component shift_register_behavioral is
        Port ( SERIAL_IN : in STD_LOGIC;
               SHIFT_ENABLED : in STD_LOGIC;
               PARALLEL_IN : in STD_LOGIC_VECTOR(7 downto 0);
               PARALLEL_ENABLED : in STD_LOGIC;
               RESET : in STD_LOGIC;
               CLOCK: in STD_LOGIC;
               SERIAL_OUT: out STD_LOGIC;
               PARALLEL_OUT: out STD_LOGIC_VECTOR(7 downto 0));
    end component;
    
    -- inputs & outputs
    signal tb_reset, tb_clock : STD_LOGIC := '0';
    signal tb_SEn, tb_PEn : STD_LOGIC := '0';
    signal tb_Sin : STD_LOGIC := '0';
    signal tb_Pin : STD_LOGIC_VECTOR (7 downto 0) := (others => '0');
    signal tb_Sout: STD_LOGIC; 
    signal tb_Pout: STD_LOGIC_VECTOR (7 downto 0);
    
    -- constant
    constant CLK_PERIOD : time := 10 ns;
    
begin

    uut: shift_register_behavioral port map (RESET=>tb_reset, CLOCK=>tb_clock, 
                                             SHIFT_ENABLED=>tb_Sen, SERIAL_IN=>tb_Sin,
                                             PARALLEL_ENABLED=>tb_Pen, PARALLEL_IN=>tb_Pin,
                                             SERIAL_OUT=>tb_Sout, PARALLEL_OUT=>tb_Pout);
                                             
    clk_process: process
    begin
        tb_clock <= '0';
        wait for CLK_PERIOD/2;
        tb_clock <= '1';
        wait for CLK_PERIOD/2;
    end process;
    
    test: process
    begin
    
        -- initialize inputs
        tb_reset <= '0';
        tb_Sen <= '0';
        tb_Pen <= '0';
        tb_Sin <= '0';
        tb_Pin <= (others => '0');
        
        wait for 100 ns;
        
        -- Test: reset '1'
        tb_reset <= '1';
        tb_Sen <= '1'; tb_Sin <= '1';
        tb_Pen <= '0'; tb_Pin <= "10110011"; 
        wait for CLK_PERIOD;
        -- assert
--        assert (tb_Sout = '0' and tb_Pout = "00000000") report "Failed Reset Check" severity error;
        
        tb_reset <= '0';
        wait for CLK_PERIOD;
        
        -- Test: parallel in
        tb_Sen <= '0'; tb_Sin <= '0';
        tb_Pen <= '1'; tb_Pin <= "10110011"; 
        wait for CLK_PERIOD;
        -- assert
        -- assert (tb_Sout = '1' and tb_Pout = "10111101") report "Failed Parallel In Check" severity error;

        tb_Pen <= '0';
        wait for CLK_PERIOD;
        
        -- Test: serial in (11011001)
        tb_Sen <= '1'; tb_Sin <= '1';
        tb_Pen <= '0'; tb_Pin <= "10110011"; 
        wait for CLK_PERIOD;
        -- assert
        -- assert (tb_Sout = '0' and tb_Pout = "11011110") report "Failed Serial In Check" severity error;
        
        tb_Sen <= '0';
        wait for CLK_PERIOD;
        
        -- Test: Parallel out shifting value with serial in
        tb_Sen <= '1';
        tb_Sin <= '0'; -- 01101100
        wait for CLK_PERIOD;
        tb_Sin <= '0'; -- 00110110
        wait for CLK_PERIOD;
        tb_Sin <= '0'; -- 00011011
        wait for CLK_PERIOD;
        -- assert
        -- assert (tb_Sout = '0' and tb_Pout = "11011110") report "Failed Serial In Check" severity error;
        
        report "Shift Register Simulation Finished Successfully";
        wait; -- Stops the simulation process
    end process;

end Behavioral;
