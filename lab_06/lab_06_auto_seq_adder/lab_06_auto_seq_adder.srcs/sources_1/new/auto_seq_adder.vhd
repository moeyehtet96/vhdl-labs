----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 01/23/2026 12:36:07 AM
-- Design Name: 
-- Module Name: auto_seq_adder - Behavioral
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

entity auto_seq_adder is
    generic ( BIT_WIDTH : integer := 8 );
    Port ( RST : in STD_LOGIC;
           CLK : in STD_LOGIC;
             A : in STD_LOGIC_VECTOR (BIT_WIDTH-1 downto 0);
             B : in STD_LOGIC_VECTOR (BIT_WIDTH-1 downto 0);
         start : in STD_LOGIC;
             Y : out STD_LOGIC_VECTOR (BIT_WIDTH-1 downto 0);
      finished : out STD_LOGIC);
end auto_seq_adder;

architecture Behavioral of auto_seq_adder is 
    -- sequential adder
    component seq_adder is
        generic ( BIT_WIDTH : integer := 8 );
        Port ( RST : in  STD_LOGIC;
               CLK : in  STD_LOGIC;
                 A : in  STD_LOGIC_VECTOR (BIT_WIDTH-1 downto 0);
                 B : in  STD_LOGIC_VECTOR (BIT_WIDTH-1 downto 0);
              load : in  STD_LOGIC;
             shift : in  STD_LOGIC;
                 Y : out STD_LOGIC_VECTOR (BIT_WIDTH-1 downto 0));
    end component;
    -- control signals
    signal load_internal, shift_internal : std_logic;
    -- states
    type states is (IDLE,LOAD,SHIFT,DONE);
    signal current_state, next_state : states;
    -- bit counter
    signal bit_count, bit_count_next : integer range 0 to BIT_WIDTH-1;
begin
    -- instantiate sequential adder
    seq_adder1: seq_adder
        generic map ( BIT_WIDTH => BIT_WIDTH)
        port map ( RST => RST,
                   CLK => CLK,
                     A => A,
                     B => B,
                  load => load_internal,
                 shift => shift_internal,
                     Y => Y);
    
    -- g: determine next state
    g: process(start, current_state, bit_count)
    begin
        case current_state is
            when IDLE =>
                if (start = '1') then
                    next_state <= LOAD;
                    bit_count_next <= 0;
                else
                    next_state <= IDLE;
                    bit_count_next <= 0;
                end if;
            when LOAD =>
                next_state <= SHIFT;
                bit_count_next <= 0;
            when SHIFT =>
                if (bit_count < BIT_WIDTH-1) then
                    next_state <= SHIFT;
                    bit_count_next <= bit_count + 1;
                else
                    next_state <= DONE;
                    bit_count_next <= bit_count;
                end if;
            when DONE =>
                next_state <= DONE;
                bit_count_next <= bit_count;
            when others =>
                next_state <= IDLE;
                bit_count_next <= 0;
        end case;
    end process g;
    
    -- f: determine outputs
    f: process(current_state)
    begin
        finished <= '0'; 
        load_internal <= '0';
        shift_internal <= '0';
        
        case current_state is 
            when IDLE =>
                finished <= '0';
                load_internal <= '0';
                shift_internal <= '0';
            when LOAD =>
                finished <= '0';
                load_internal <= '1';
                shift_internal <= '0';
            when SHIFT =>
                finished <= '0';
                load_internal <= '0';
                shift_internal <= '1';
            when DONE =>
                finished <= '1';
                load_internal <= '0';
                shift_internal <= '0';
            when others =>
                finished <= '0';
                load_internal <= '0';
                shift_internal <= '0';
        end case;
    end process f;
                    
    -- state register
    s: process(RST,CLK)
    begin
        if (RST = '1') then
            current_state <= IDLE;
            bit_count <= 0;
        elsif (rising_edge(CLK)) then
            current_state <= next_state;
            bit_count <= bit_count_next;
        end if;
    end process s;

end Behavioral;
