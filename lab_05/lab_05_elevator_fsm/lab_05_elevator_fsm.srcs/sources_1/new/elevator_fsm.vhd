----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 12/19/2025 01:06:38 PM
-- Design Name: 
-- Module Name: elevator_fsm - Behavioral
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

entity elevator_fsm is
    Port ( reset : in STD_LOGIC;
           clock : in STD_LOGIC;
           bt_f1 : in STD_LOGIC;
           bt_f2 : in STD_LOGIC;
           bt_f3 : in STD_LOGIC;
           arvd_f1 : in STD_LOGIC;
           arvd_f2 : in STD_LOGIC;
           arvd_f3 : in STD_LOGIC;
           dr_up : out STD_LOGIC;
           dr_dwn : out STD_LOGIC;
           led_f1 : out STD_LOGIC;
           led_f2 : out STD_LOGIC;
           led_f3 : out STD_LOGIC);
end elevator_fsm;

architecture Behavioral of elevator_fsm is
    type   states is (on_f1, on_f2, on_f3, to_f1, f1_to_f2, f3_to_f2, to_f3);
    signal current_state, next_state: states;
begin

    -- determine next state
    g: process (current_state, bt_f1, bt_f2, bt_f3, arvd_f1, arvd_f2, arvd_f3)
    begin
        -- stay in current state if the conditions are not met
        next_state <= current_state; 
        
        case current_state is
            when on_f1    => if    (bt_f2 = '1')   then next_state <= f1_to_f2;
                             elsif (bt_f3 = '1')   then next_state <= to_f3;
                             end if;
            when on_f2    => if    (bt_f1 = '1')   then next_state <= to_f1;
                             elsif (bt_f3 = '1')   then next_state <= to_f3;
                             end if;
            when on_f3    => if    (bt_f1 = '1')   then next_state <= to_f1;
                             elsif (bt_f2 = '1')   then next_state <= f3_to_f2;
                             end if;
            when to_f1    => if    (arvd_f1 = '1') then next_state <= on_f1;
                             end if;
            when f1_to_f2 => if    (arvd_f2 = '1') then next_state <= on_f2;
                             end if;
            when f3_to_f2 => if    (arvd_f2 = '1') then next_state <= on_f2;
                             end if;
            when to_f3    => if    (arvd_f3 = '1') then next_state <= on_f3;
                             end if;
            when others   => next_state <= to_f1;
        end case;
        
    end process;
    
    -- determine output
    f: process (current_state)
    begin
        
        case current_state is
            when on_f1    => dr_up  <= '0';
                             dr_dwn <= '0';
                             led_f1 <= '1';
                             led_f2 <= '0';
                             led_f3 <= '0';
            when on_f2    => dr_up  <= '0';
                             dr_dwn <= '0';
                             led_f1 <= '0';
                             led_f2 <= '1';
                             led_f3 <= '0';
            when on_f3    => dr_up  <= '0';
                             dr_dwn <= '0';
                             led_f1 <= '0';
                             led_f2 <= '0';
                             led_f3 <= '1';
            when to_f1    => dr_up  <= '0';
                             dr_dwn <= '1';
                             led_f1 <= '0';
                             led_f2 <= '0';
                             led_f3 <= '0';
            when f1_to_f2 => dr_up  <= '1';
                             dr_dwn <= '0';
                             led_f1 <= '0';
                             led_f2 <= '0';
                             led_f3 <= '0';
            when f3_to_f2 => dr_up  <= '0';
                             dr_dwn <= '1';
                             led_f1 <= '0';
                             led_f2 <= '0';
                             led_f3 <= '0';
            when to_f3    => dr_up  <= '1';
                             dr_dwn <= '0';
                             led_f1 <= '0';
                             led_f2 <= '0';
                             led_f3 <= '0';
            when others   => dr_up  <= '0';
                             dr_dwn <= '0';
                             led_f1 <= '0';
                             led_f2 <= '0';
                             led_f3 <= '0';
        end case;
        
    end process;
    
    -- state register
    s: process (reset, clock)
    begin
    
        if (reset = '1') then
            current_state <= to_f1;
        elsif clock'event and clock = '1' then
            current_state <= next_state;
        end if;
    
    end process;

end Behavioral;
