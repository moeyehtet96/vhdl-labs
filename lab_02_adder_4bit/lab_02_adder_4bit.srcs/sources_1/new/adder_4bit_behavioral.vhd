----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 11/14/2025 08:51:40 AM
-- Design Name: 
-- Module Name: adder_4bit_behavioral - Behavioral
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

entity adder_4bit_behavioral is
    Port ( A : in STD_LOGIC_VECTOR(3 downto 0);
           B : in STD_LOGIC_VECTOR(3 downto 0);
           C_in : in STD_LOGIC;
           Y : out STD_LOGIC_VECTOR(3 downto 0);
           C_out : out STD_LOGIC);
end adder_4bit_behavioral;

architecture Behavioral of adder_4bit_behavioral is

begin

    add : process(A, B, C_in)
        variable carry_temp : STD_LOGIC_VECTOR(4 downto 0);
    begin
        
        carry_temp(0) := C_in;
        for i in 0 to 3 loop
            Y(i) <= A(i) xor B(i) xor carry_temp(i);
            carry_temp(i+1) := ((A(i) xor B(i)) and carry_temp(i)) or (A(i) and B(i));
        end loop;
        C_out <= carry_temp(4);
    end process;

end Behavioral;
