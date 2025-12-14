----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 12/05/2025 12:45:57 PM
-- Design Name: 
-- Module Name: rs_flipflop_structural - Behavioral
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

entity rs_flipflop_structural is
    Port ( R, S     : in  STD_LOGIC;
           Q, Q_not : out STD_LOGIC);
end rs_flipflop_structural;

architecture Structural of rs_flipflop_structural is

    component nor_gate is
        Port ( A, B : in  STD_LOGIC;
               Y    : out STD_LOGIC);
    end component;
    
    signal Q_internal, Q_not_internal : STD_LOGIC; -- internal signals for feedback

begin

    NOR1: nor_gate port map (A => S, B => Q_internal, Y => Q_not_internal);
    NOR2: nor_gate port map (A => R, B => Q_not_internal, Y => Q_internal);
    
    Q <= Q_internal;
    Q_not <= Q_not_internal;

end Structural;
