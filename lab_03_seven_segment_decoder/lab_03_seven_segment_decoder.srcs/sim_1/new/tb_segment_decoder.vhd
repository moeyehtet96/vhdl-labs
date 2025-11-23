----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 11/21/2025 12:52:26 PM
-- Design Name: 
-- Module Name: tb_segment_decoder - Behavioral
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
use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
--use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx leaf cells in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity tb_segment_decoder is
--  Port ( );
end tb_segment_decoder;

architecture Behavioral of tb_segment_decoder is
    
    component segment_decoder is
        Port ( input  : in STD_LOGIC_VECTOR(3 downto 0);
               output : out STD_LOGIC_VECTOR(0 to 6)
        );
    end component;
    
    component segment_decoder_lut is
        Port ( input  : in STD_LOGIC_VECTOR(3 downto 0);
               output : out STD_LOGIC_VECTOR(0 to 6)
        );
    end component;
    
    -- input and output signals
    signal tb_in  : STD_LOGIC_VECTOR(3 downto 0);
    signal tb_out : STD_LOGIC_VECTOR(0 to 6);
    
begin

    uut1: segment_decoder port map (input=>tb_in, output=>tb_out);
    uut2: segment_decoder_lut port map (input=>tb_in, output=>tb_out);
    
    test: process is
    begin
        wait for 100 ns;
        
        tb_in <= std_logic_vector(TO_UNSIGNED(5,4));
        
        -- Test: 0
        tb_in <= "0000";
        wait for 10 ns;
        -- assert
        assert (tb_out = "1111110") report "Failed '0' Check" severity error;
        
        -- Test: 1
        tb_in <= "0001";
        wait for 10 ns;
        -- assert
        assert (tb_out = "0110000") report "Failed '1' Check" severity error;
        
        -- Test: 2
        tb_in <= "0010";
        wait for 10 ns;
        -- assert
        assert (tb_out = "1101101") report "Failed '2' Check" severity error;
        
        -- Test: 3
        tb_in <= "0011";
        wait for 10 ns;
        -- assert
        assert (tb_out = "1111001") report "Failed '3' Check" severity error;
        
        -- Test: 4
        tb_in <= "0100";
        wait for 10 ns;
        -- assert
        assert (tb_out = "0110011") report "Failed '4' Check" severity error;
        
        -- Test: 5
        tb_in <= "0101";
        wait for 10 ns;
        -- assert
        assert (tb_out = "1011011") report "Failed '5' Check" severity error;
        
        -- Test: 6
        tb_in <= "0110";
        wait for 10 ns;
        -- assert
        assert (tb_out = "1011111") report "Failed '6' Check" severity error;
        
        -- Test: 7
        tb_in <= "0111";
        wait for 10 ns;
        -- assert
        assert (tb_out = "1110000") report "Failed '7' Check" severity error;
        
        -- Test: 8
        tb_in <= "1000";
        wait for 10 ns;
        -- assert
        assert (tb_out = "1111111") report "Failed '8' Check" severity error;
        
        -- Test: 9
        tb_in <= "1001";
        wait for 10 ns;
        -- assert
        assert (tb_out = "1111011") report "Failed '9' Check" severity error;
        
        -- Test: 10
        tb_in <= "1010";
        wait for 10 ns;
        -- assert
        assert (tb_out = "1110111") report "Failed 'A' Check" severity error;
        
        -- Test: 11
        tb_in <= "1011";
        wait for 10 ns;
        -- assert
        assert (tb_out = "0011111") report "Failed 'B' Check" severity error;
        
        -- Test: 12
        tb_in <= "1100";
        wait for 10 ns;
        -- assert
        assert (tb_out = "1001110") report "Failed 'C' Check" severity error;
        
        -- Test: 13
        tb_in <= "1101";
        wait for 10 ns;
        -- assert
        assert (tb_out = "0111101") report "Failed 'D' Check" severity error;
        
        -- Test: 14
        tb_in <= "1110";
        wait for 10 ns;
        -- assert
        assert (tb_out = "1001111") report "Failed 'E' Check" severity error;
        
        -- Test: 15
        tb_in <= "1111";
        wait for 10 ns;
        -- assert
        assert (tb_out = "1000111") report "Failed 'F' Check" severity error;
        
        report "7 Segment Decoder Test Finished Successfully";
        wait; -- Stops the simulation process
        
    end process;

end Behavioral;
