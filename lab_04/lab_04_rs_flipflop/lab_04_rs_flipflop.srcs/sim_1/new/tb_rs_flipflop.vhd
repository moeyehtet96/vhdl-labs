----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 12/05/2025 01:15:46 PM
-- Design Name: 
-- Module Name: tb_rs_flipflop - Behavioral
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

entity tb_rs_flipflop is
--  Port ( );
end tb_rs_flipflop;

architecture Behavioral of tb_rs_flipflop is

    component rs_flipflop_behavioral is
        Port (R, S : in  STD_LOGIC;
              Q    : out STD_LOGIC);
    end component;
    
    component rs_flipflop_structural is
        Port (R, S     : in  STD_LOGIC;
              Q, Q_not : out STD_LOGIC);
    end component;
    
    -- test signals
    signal tb_R, tb_S : STD_LOGIC;
    signal tb_Q, tb_Q_not : STD_LOGIC;

begin

    uut_behavioral: rs_flipflop_behavioral port map (R=>tb_R, S=>tb_S, Q=>tb_Q);
    uut_structural: rs_flipflop_structural port map (R=>tb_R, S=>tb_S, Q=>tb_Q, Q_not=>tb_Q_not);

    test: process
    begin
    
        wait for 100 ns;
        
        tb_R <= '0'; tb_S <= '0';
        wait for 10 ns;
--        assert (tb_Q = '1') report "Failed Set = 1 Check" severity error;
        
        tb_R <= '0'; tb_S <= '1';
        wait for 10 ns;
        
        tb_R <= '1'; tb_S <= '0';
        wait for 10 ns;
        
        tb_R <= '1'; tb_S <= '1';
        wait for 10 ns;
        
        report "RS-FlipFlop Simulation Finished Successfully";
        wait; -- Stops the simulation process
    
    end process;

end Behavioral;
