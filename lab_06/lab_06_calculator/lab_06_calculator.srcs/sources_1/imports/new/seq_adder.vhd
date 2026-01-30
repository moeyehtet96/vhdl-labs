----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 01/23/2026 12:43:06 AM
-- Design Name: 
-- Module Name: seq_adder - Behavioral
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

entity seq_adder is
    generic (BIT_WIDTH : integer := 8);
    Port ( RST : in STD_LOGIC;
           CLK : in STD_LOGIC;
           A : in STD_LOGIC_VECTOR (BIT_WIDTH-1 downto 0);
           B : in STD_LOGIC_VECTOR (BIT_WIDTH-1 downto 0);
           load : in STD_LOGIC;
           shift : in STD_LOGIC;
           Y : out STD_LOGIC_VECTOR (BIT_WIDTH-1 downto 0));
end seq_adder;

architecture Behavioral of seq_adder is
    signal a_q, b_q, y_q : std_logic_vector (BIT_WIDTH-1 downto 0);
    signal sum, c_in, c_out : std_logic;
begin

    add: process(RST,CLK,load,shift,a_q,b_q,y_q,sum,c_in,c_out) is
    begin
        if (RST = '1') then
            a_q <= (others => '0');
            b_q <= (others => '0');
            y_q <= (others => '0');
            c_in <= '0';
        elsif (rising_edge(CLK)) then
            if (load = '1') then
                a_q <= A; -- load into piso a
                b_q <= B; -- load into piso b
                c_in <= '0'; -- d flipflop reset
            elsif (shift = '1') then
                a_q <= '0' & a_q(BIT_WIDTH-1 downto 1); -- shift a
                b_q <= '0' & b_q(BIT_WIDTH-1 downto 1); -- shift b
                y_q <= sum & y_q(BIT_WIDTH-1 downto 1); -- shift in add sum
                c_in <= c_out; -- d flipflop enable
            end if;
        end if;
    end process add;
    
    sum <= a_q(0) xor b_q(0) xor c_in;
    c_out <= (a_q(0) and b_q(0)) or (c_in and (a_q(0) xor b_q(0)));
    y <= y_q; 

end Behavioral;
