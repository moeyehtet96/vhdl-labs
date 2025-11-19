----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 11/07/2025 12:19:47 PM
-- Design Name: 
-- Module Name: xor_structural - Behavioral
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

entity xor_structural is
    Port ( A : in STD_LOGIC;
           B : in STD_LOGIC;
           Y : out STD_LOGIC);
end xor_structural;

architecture Structural of xor_structural is
    component and_gate is
        port (A : in std_logic;
              B : in std_logic;
              Y : out std_logic);
    end component;
    component or_gate is
        port (A : in std_logic;
              B : in std_logic;
              Y : out std_logic);
    end component;
    component not_gate is
        port (A : in std_logic;
              Y : out std_logic);
    end component;
    signal TMP1 : std_logic;
    signal TMP2 : std_logic;
    signal TMP3 : std_logic;
    signal TMP4 : std_logic;
begin

    NOT_A: not_gate port map (A=>A, Y=>TMP1);
    NOT_B: not_gate port map (A=>B, Y=>TMP2);
    AND_1: and_gate port map (A=>TMP1, B=>B, Y=>TMP3);
    AND_2: and_gate port map (A=>TMP2, B=>A, Y=>TMP4);
    OR_1: or_gate port map (A=>TMP3, B=>TMP4, Y=>Y); 

end Structural;
