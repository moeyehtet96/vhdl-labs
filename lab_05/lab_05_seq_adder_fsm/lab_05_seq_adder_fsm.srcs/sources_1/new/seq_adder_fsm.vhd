----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 01/09/2026 02:37:19 PM
-- Design Name: 
-- Module Name: seq_adder_fsm - Behavioral
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

entity seq_adder_fsm is
    Port ( A : in STD_LOGIC_VECTOR (7 downto 0);
           B : in STD_LOGIC_VECTOR (7 downto 0);
           START : in STD_LOGIC;
           RST : in STD_LOGIC;
           CLK : in STD_LOGIC;
           Y : out STD_LOGIC_VECTOR (7 downto 0);
           FINISHED : out STD_LOGIC);
end seq_adder_fsm;

architecture Behavioral of seq_adder_fsm is
    -- sequential adder component
    component seq_adder_structural is
        Port ( RST : in STD_LOGIC;
               CLK : in STD_LOGIC;
               A : in STD_LOGIC_VECTOR (7 downto 0);
               B : in STD_LOGIC_VECTOR (7 downto 0);
               LOAD : in STD_LOGIC;
               SHIFT : in STD_LOGIC;
               Y : out STD_LOGIC_VECTOR (7 downto 0));
    end component;
    
    -- control signals
    signal load_internal : STD_LOGIC;
    signal shift_internal : STD_LOGIC;
    
    -- counter
    signal bit_counter, bit_counter_next : integer range 0 to 7;
    
    -- states
    type   states is (IDLE, LOAD, SHIFT, DONE);
    signal current_state, next_state: states;

begin
    -- sequential adder component instantiation
    seq_adder: seq_adder_structural
        port map (RST   => RST,
                  CLK   => CLK,
                  A     => A,
                  B     => B,
                  LOAD  => load_internal,
                  SHIFT => shift_internal,
                  Y     => Y);
                  
    -- transition (g): determine next state
    g: process(current_state, START, bit_counter)
    begin
        
        -- stay in current state if the switch cases are not matched
        next_state <= current_state;
        bit_counter_next <= bit_counter;
        
        case current_state is
            when IDLE => 
                if (start = '1') then
                    next_state <= LOAD;
                    bit_counter_next <= 0;
                end if;
                
            when LOAD =>
                next_state <= SHIFT;
                
            when SHIFT =>
                if bit_counter < 7 then
                    bit_counter_next <= bit_counter + 1;
                else
                    next_state <= DONE;
                end if;
                
            when DONE =>
                next_state <= IDLE;
                
            when others =>
                next_state <= IDLE;
        end case;
    
    end process;
    
    -- output (f): determine output
    f: process(current_state)
    begin
        
        load_internal <= '0';
        shift_internal <= '0';
        FINISHED <= '0';
    
        case current_state is
            when IDLE =>
                FINISHED <= '0';
            
            when LOAD =>
                load_internal <= '1';
                shift_internal <= '0';
            
            when SHIFT =>
                load_internal <= '0';  
                shift_internal <= '1';
            
            when DONE =>
                FINISHED <= '1';
            
            when others =>
                FINISHED <= '0';
        end case;
    
    end process;

    -- state register
    s: process (CLK, RST)
    begin
    
        if (RST = '1') then
            current_state <= IDLE;
        elsif rising_edge(CLK) then
            current_state <= next_state;
        end if;
    
    end process;
    
    -- counter register
    c: process(CLK, RST)
    begin
        
        if (RST = '1') then
            bit_counter <= 0;
        elsif rising_edge(CLK) then
            bit_counter <= bit_counter_next;
        end if;
        
    end process;

end Behavioral;
