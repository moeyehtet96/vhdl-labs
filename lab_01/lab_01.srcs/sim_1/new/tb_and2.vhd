----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 11/14/2025 12:21:01 PM
-- Design Name: 
-- Module Name: tb_and2 - Behavioral
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

entity tb_and2 is
-- Port()
end tb_and2;

architecture Behavioral of tb_and2 is
    -- uuts
    component AND2 is
        port (a : in STD_LOGIC;
              b : in STD_LOGIC;
              y : out STD_LOGIC);
    end component;
    
    -- Inputs
    signal A : STD_LOGIC;
    signal B : STD_LOGIC;
    
    -- Outputs
    signal Y : STD_LOGIC;
begin

    uut_and2: AND2 port map (a=>A, b=>B, y=>Y);
    
    test_process : process is
    begin
        wait for 100ns;
        A <= 'U';
        B <= 'U';
        wait for 10ns;
        A <= 'X';
        B <= 'X';
        wait for 10ns;
        A <= 'X';
        B <= '0';
        wait for 10ns;
        A <= 'X';
        B <= '1';
        wait for 10ns;
        A <= '0';
        B <= '0';
        wait for 10ns;
        A <= '0';
        B <= '1';
        wait for 10ns;
        A <= '1';
        B <= '0';
        wait for 10ns;
        A <= '1';
        B <= '1';
        wait for 10ns;
    end process;

end Behavioral;
