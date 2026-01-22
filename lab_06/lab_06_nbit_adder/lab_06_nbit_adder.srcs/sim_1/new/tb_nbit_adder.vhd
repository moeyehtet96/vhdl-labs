----------------------------------------------------------------------------------
--! @file   tb_nbit_adder.vhd
--! @brief  Test bench for generic parallel n-bit adder
--! @author Moe Ye Htet (moe-ye.htet@s2025.tu-chemnitz.de)
--! @date   2026-01-22
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

entity tb_nbit_adder is
--  Port ( );
end tb_nbit_adder;

architecture Behavioral of tb_nbit_adder is
    -- component
    component nbit_adder is
        generic (BIT_WIDTH : integer := 4);
        port ( A, B : in  std_logic_vector(BIT_WIDTH-1 downto 0);
                  Y : out std_logic_vector(BIT_WIDTH-1 downto 0);
                  C : out std_logic);
    end component;
    
    -- define bit width to test
    constant BIT_WIDTH : integer := 16;
    
    -- test signals
    signal tb_a, tb_b, tb_y : std_logic_vector(BIT_WIDTH-1 downto 0);
    signal tb_c : std_logic;
begin
    uut: nbit_adder
        generic map ( BIT_WIDTH => BIT_WIDTH )
        port map ( A => tb_a, B => tb_b, Y => tb_y, C => tb_c);
        
    stim_proc: process is
    begin
        wait for 100 ns;
        
        -- Test 1: Both A and B being zero
        tb_a <= x"0000";
        tb_b <= x"0000";
        wait for 10 ns;
        -- assert
        assert (tb_y = x"0000" and tb_c = '0') report "Test 1 Failed" severity error;
        
        -- Test 2: Simple addition with no carry out
        tb_a <= x"1234";
        tb_b <= x"5678";
        wait for 10 ns;
        -- assert
        assert (tb_y = x"68AC" and tb_c = '0') report "Test 2 Failed" severity error;
        
        -- Test 3: Addition with carry out
        tb_a <= x"FFFF";
        tb_b <= x"0001";
        wait for 10 ns;
        -- assert
        assert (tb_y = x"0000" and tb_c = '1') report "Test 3 Failed" severity error;
        
        -- Test 4: Addition of two max inputs
        tb_a <= x"FFFF";
        tb_b <= x"FFFF";
        wait for 10 ns;
        -- assert
        assert (tb_y = x"FFFE" and tb_c = '1') report "Test 4 Failed" severity error;
        
        -- Test 5: Carry propagation
        tb_a <= x"00FF";
        tb_b <= x"0001";
        wait for 10 ns;
        -- assert
        assert (tb_y = x"0100" and tb_c = '0') report "Test 5 Failed" severity error;
        
        report "N-bit Adder Simulation Finished Successfully.";
        wait;
    end process stim_proc;
end Behavioral;
