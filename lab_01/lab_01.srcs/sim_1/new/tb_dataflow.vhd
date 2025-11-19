----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 11/07/2025 08:52:33 PM
-- Design Name: 
-- Module Name: tb_dataflow - Behavioral
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

entity tb_dataflow is
--  Port ( );
end tb_dataflow;

architecture Behavioral of tb_dataflow is
    -- UUTs
    component xor_dataflow is
        port (A : IN  std_logic;
              B : IN  std_logic;
              Y : OUT std_logic);
    end component;
    
    component xor_behavioral is
        port (A : IN  std_logic;
              B : IN  std_logic;
              Y : OUT std_logic);
    end component;
    
    component xor_structural is
        port (A : IN  std_logic;
              B : IN  std_logic;
              Y : OUT std_logic);
    end component;
    
    -- Inputs
    signal A_input : std_logic;
    signal B_input : std_logic;
    
    -- Outputs
    signal Y_dataflow   : std_logic;
    signal Y_behavioral : std_logic;
    signal Y_structural : std_logic;
begin

    uut_dataflow   : xor_dataflow   port map (A=>A_input, B=>B_input, Y=>Y_dataflow);
    uut_behavioral : xor_behavioral port map (A=>A_input, B=>B_input, Y=>Y_behavioral);
    uut_structural : xor_structural port map (A=>A_input, B=>B_input, Y=>Y_structural);
    
    test_process : process is
    begin
        wait for 100ns;
        A_input <= 'U';
        B_input <= 'U';
        wait for 10ns;
        A_input <= 'X';
        B_input <= 'X';
        wait for 10ns;
        A_input <= 'X';
        B_input <= '0';
        wait for 10ns;
        A_input <= 'X';
        B_input <= '1';
        wait for 10ns;
        A_input <= '0';
        B_input <= '0';
        wait for 10ns;
        A_input <= '0';
        B_input <= '1';
        wait for 10ns;
        A_input <= '1';
        B_input <= '0';
        wait for 10ns;
        A_input <= '1';
        B_input <= '1';
        wait for 10ns;
    end process;

end Behavioral;
