----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 12/17/2025 11:22:11 PM
-- Design Name: 
-- Module Name: counter_async - Behavioral
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

entity counter_async is
    Port ( CLK   : in STD_LOGIC;
           RESET : in STD_LOGIC;
           Q     : out STD_LOGIC_VECTOR (2 downto 0));
end counter_async;

architecture Behavioral of counter_async is
    
    component d_flipflop is
        Port ( D     : in  STD_LOGIC;
               CLK   : in  STD_LOGIC;
               RESET : in  STD_LOGIC;
               Q     : out STD_LOGIC;
               Q_bar : out STD_LOGIC );
    end component;
    
    -- temp signals
    signal Q0_temp : STD_LOGIC := '0';
    signal Q0b_temp : STD_LOGIC;
    signal Q1_temp : STD_LOGIC := '0';
    signal Q1b_temp : STD_LOGIC;
    signal Q2_temp : STD_LOGIC := '0';
    signal Q2b_temp : STD_LOGIC;
    
begin

    dff1: d_flipflop port map ( D => Q0b_temp, CLK => CLK, RESET => RESET, Q => Q0_temp, Q_bar => Q0b_temp );
    dff2: d_flipflop port map ( D => Q1b_temp, CLK => Q0b_temp, RESET => RESET, Q => Q1_temp, Q_bar => Q1b_temp );
    dff3: d_flipflop port map ( D => Q2b_temp, CLK => Q1b_temp, RESET => RESET, Q => Q2_temp, Q_bar => Q2b_temp );
    
    Q <= Q2_temp & Q1_temp & Q0_temp;

end Behavioral;
