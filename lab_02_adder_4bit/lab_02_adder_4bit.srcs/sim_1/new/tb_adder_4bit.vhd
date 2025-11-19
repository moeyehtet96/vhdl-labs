----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 11/14/2025 01:54:17 PM
-- Design Name: 
-- Module Name: tb_adder_4bit - Behavioral
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

entity tb_adder_4bit is
--  Port ( );
end tb_adder_4bit;

architecture Behavioral of tb_adder_4bit is
    component adder_4bit_structural is
        port (A, B  : in STD_LOGIC_VECTOR(3 downto 0);
              C_in  : in STD_LOGIC;
              Sum   : out STD_LOGIC_VECTOR(3 downto 0);
              C_out : out STD_LOGIC);
    end component;
    
    component adder_4bit_behavioral is
        port (A, B  : in  STD_LOGIC_VECTOR(3 downto 0);
              C_in  : in  STD_LOGIC;
              Y     : out STD_LOGIC_VECTOR(3 downto 0);
              C_out : out STD_LOGIC);
    end component;
    
    -- Inputs
    signal tb_A, tb_B   : STD_LOGIC_VECTOR(3 downto 0);
    signal tb_Cin : STD_LOGIC;
    
    -- Output
    signal tb_Sum  : STD_LOGIC_VECTOR(3 downto 0);
    signal tb_Cout : STD_LOGIC;
begin

    uut_structural: adder_4bit_structural port map (A=>tb_A, B=>tb_B, C_in=>tb_Cin, Sum=>tb_Sum, C_out=>tb_Cout);
    uut_behavioral: adder_4bit_behavioral port map (A=>tb_A, B=>tb_B, C_in=>tb_Cin, Y=>tb_Sum, C_out=>tb_Cout);
    
    test: process is
    begin
        -- hold reset state for 100 ns.
        wait for 100 ns;	

        -- -------------------------------------------------------
        -- CASE 1: The Zero Check (0 + 0 + 0)
        -- -------------------------------------------------------
        tb_A <= "0000"; tb_B <= "0000"; tb_Cin <= '0';
        wait for 10 ns;
        -- Assertions act as automatic checkers. If the condition is false, it prints the message.
        assert (tb_Sum = "0000" and tb_Cout = '0') report "Failed Zero Check" severity error;

        -- -------------------------------------------------------
        -- CASE 2: Simple Addition, No Carry (2 + 3 = 5)
        -- -------------------------------------------------------
        tb_A <= "0010"; tb_B <= "0011"; tb_Cin <= '0';
        wait for 10 ns;
        assert (tb_Sum = "0101" and tb_Cout = '0') report "Failed Simple Add" severity error;

        -- -------------------------------------------------------
        -- CASE 3: Carry Input Check (2 + 3 + 1 = 6)
        -- -------------------------------------------------------
        -- Checks if the Cin port is actually connected internally
        tb_A <= "0010"; tb_B <= "0011"; tb_Cin <= '1';
        wait for 10 ns;
        assert (tb_Sum = "0110" and tb_Cout = '0') report "Failed Cin Check" severity error;

        -- -------------------------------------------------------
        -- CASE 4: Carry Output Generation (15 + 1 = 16)
        -- -------------------------------------------------------
        -- Result should be 0000 with Cout = 1
        tb_A <= "1111"; tb_B <= "0001"; tb_Cin <= '0';
        wait for 10 ns;
        assert (tb_Sum = "0000" and tb_Cout = '1') report "Failed Cout Generation" severity error;

        -- -------------------------------------------------------
        -- CASE 5: Maximum Saturation (15 + 15 + 1 = 31)
        -- -------------------------------------------------------
        -- 1111 + 1111 + 1 = 11111 (Cout=1, Sum=1111)
        tb_A <= "1111"; tb_B <= "1111"; tb_Cin <= '1';
        wait for 10 ns;
        assert (tb_Sum = "1111" and tb_Cout = '1') report "Failed Max Saturation" severity error;

        -- -------------------------------------------------------
        -- CASE 6: Alternating Bits (1010 + 0101 = 1111)
        -- -------------------------------------------------------
        -- Good for checking shorts between adjacent wires
        tb_A <= "1010"; tb_B <= "0101"; tb_Cin <= '0';
        wait for 10 ns;
        assert (tb_Sum = "1111" and tb_Cout = '0') report "Failed Alternating Bits" severity error;

        report "4bit Adder Simulation Finished Successfully";
        wait; -- Stops the simulation process
    end process;

end Behavioral;
