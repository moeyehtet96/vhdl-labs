----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 01/09/2026 09:35:33 AM
-- Design Name: 
-- Module Name: seq_adder_structural - Behavioral
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

entity seq_adder_structural is
    Port ( RST : in STD_LOGIC;
           CLK : in STD_LOGIC;
           A : in STD_LOGIC_VECTOR (7 downto 0);
           B : in STD_LOGIC_VECTOR (7 downto 0);
           LOAD : in STD_LOGIC;
           SHIFT : in STD_LOGIC;
           Y : out STD_LOGIC_VECTOR (7 downto 0));
end seq_adder_structural;

architecture Behavioral of seq_adder_structural is

    component piso is
        Port ( D : in STD_LOGIC_VECTOR (7 downto 0);
               LOAD : in STD_LOGIC;
               SHIFT : in STD_LOGIC;
               CLK : in STD_LOGIC;
               RST : in STD_LOGIC;
               Q : out STD_LOGIC);
    end component;
    
    component full_adder is
        Port ( A : in STD_LOGIC;
               B : in STD_LOGIC;
               C_in : in STD_LOGIC;
               Sum : out STD_LOGIC;
               C_out : out STD_LOGIC);
    end component;
    
    component d_flipflop is
        Port ( D     : in  STD_LOGIC;
               CLK   : in  STD_LOGIC;
               RESET : in  STD_LOGIC;
               Q     : out STD_LOGIC;
               Q_bar : out STD_LOGIC);
    end component;
    
    component sipo is
        Port ( S_IN : in STD_LOGIC;
               SHIFT : in STD_LOGIC;
               CLK : in STD_LOGIC;
               RST : in STD_LOGIC;
               Q : out STD_LOGIC_VECTOR (7 downto 0));
    end component;
    
    -- signals
    signal Q_A_temp  : STD_LOGIC;
    signal Q_B_temp  : STD_LOGIC;
    signal Cin_temp  : STD_LOGIC;
    signal Cin_bar_temp : STD_LOGIC;
    signal Cout_temp : STD_LOGIC;
    signal Sum_temp: STD_LOGIC;
    signal Res_temp : STD_LOGIC_VECTOR(7 downto 0);
    
begin

    piso_a: piso port map (D => A, LOAD => LOAD, SHIFT => SHIFT, CLK => CLK, RST => RST, Q => Q_A_temp);
    piso_b: piso port map (D => B, LOAD => LOAD, SHIFT => SHIFT, CLK => CLK, RST => RST, Q => Q_B_temp);
    dff: d_flipflop port map (D => Cout_temp, CLK => CLK, RESET => RST, Q => Cin_temp, Q_bar => Cin_bar_temp);
    adder: full_adder port map (A => Q_A_temp, B => Q_B_temp, C_in => Cin_temp, Sum => Sum_temp, C_out => Cout_temp);
    sipo_out: sipo port map (S_IN => Sum_temp, SHIFT => SHIFT, CLK => CLK, RST => RST, Q => Y);

end Behavioral;
