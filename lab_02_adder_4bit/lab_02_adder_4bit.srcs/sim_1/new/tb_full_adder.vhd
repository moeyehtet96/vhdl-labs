----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 11/14/2025 02:25:36 PM
-- Design Name: 
-- Module Name: tb_full_adder - Behavioral
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

entity tb_full_adder is
--  Port ( );
end tb_full_adder;

architecture Behavioral of tb_full_adder is
    
    component full_adder is
        port (A, B  : in  STD_LOGIC;
              C_in  : in  STD_LOGIC;
              Sum   : out STD_LOGIC;
              C_out : out STD_LOGIC);
    end component;
    
    -- Inputs
    signal tb_A   : STD_LOGIC;
    signal tb_B   : STD_LOGIC;
    signal tb_Cin : STD_LOGIC;
    
    -- Outputs
    signal tb_Sum  : STD_LOGIC;
    signal tb_Cout : STD_LOGIC;
    
begin

    uut_full_adder: full_adder port map (A=>tb_A, B=>tb_B, C_in=>tb_Cin, Sum=>tb_Sum, C_out=>tb_Cout);
    
    test_full_adder: process is
    begin
        
        wait for 100ns;
        
        tb_A <= '0'; tb_B <= '0'; tb_Cin <= '0';
        wait for 10ns;
        assert (tb_Sum = '0' and tb_Cout = '0') report "Failed 0+0=0,0" severity error;
        
        tb_A <= '1'; tb_B <= '0'; tb_Cin <= '0';
        wait for 10ns;
        assert (tb_Sum = '1' and tb_Cout = '0') report "Failed 1+0=1,0" severity error;
        
        tb_A <= '0'; tb_B <= '1'; tb_Cin <= '0';
        wait for 10ns;
        assert (tb_Sum = '1' and tb_Cout = '0') report "Failed 0+1=1,0" severity error;
        
        tb_A <= '1'; tb_B <= '1'; tb_Cin <= '0';
        wait for 10ns;
        assert (tb_Sum = '0' and tb_Cout = '1') report "Failed 1+1=0,1" severity error;
        wait for 10ns;
        
        report "Full Adder Simulation Finished Successfully";
        wait; -- Stops the simulation process
        
    end process;

end Behavioral;
