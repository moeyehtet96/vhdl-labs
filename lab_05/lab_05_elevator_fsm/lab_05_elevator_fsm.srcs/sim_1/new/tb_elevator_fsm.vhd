----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 12/19/2025 01:55:38 PM
-- Design Name: 
-- Module Name: tb_elevator_fsm - Behavioral
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

entity tb_elevator_fsm is
--  Port ( );
end tb_elevator_fsm;

architecture Behavioral of tb_elevator_fsm is

    -- component to test
    component elevator_fsm
        Port ( reset   : in  STD_LOGIC;
               clock   : in  STD_LOGIC;
               bt_f1   : in  STD_LOGIC;
               bt_f2   : in  STD_LOGIC;
               bt_f3   : in  STD_LOGIC;
               arvd_f1 : in  STD_LOGIC;
               arvd_f2 : in  STD_LOGIC;
               arvd_f3 : in  STD_LOGIC;
               dr_up   : out STD_LOGIC;
               dr_dwn  : out STD_LOGIC;
               led_f1  : out STD_LOGIC;
               led_f2  : out STD_LOGIC;
               led_f3  : out STD_LOGIC );
    end component;
    
    -- test signals
    signal tb_reset   : STD_LOGIC := '0';
    signal tb_clock   : STD_LOGIC := '0';
    signal tb_bt_f1   : STD_LOGIC;
    signal tb_bt_f2   : STD_LOGIC;
    signal tb_bt_f3   : STD_LOGIC;
    signal tb_arvd_f1 : STD_LOGIC;
    signal tb_arvd_f2 : STD_LOGIC;
    signal tb_arvd_f3 : STD_LOGIC;
    signal tb_dr_up   : STD_LOGIC;
    signal tb_dr_dwn  : STD_LOGIC;
    signal tb_led_f1  : STD_LOGIC;
    signal tb_led_f2  : STD_LOGIC;
    signal tb_led_f3  : STD_LOGIC;
    
    -- clock period
    constant CLK_PERIOD : time := 10 ns;
    
    -- Helper Procedures
    procedure press_button(
        signal btn : out STD_LOGIC
    ) is
    begin
        btn <= '1';
        wait for CLK_PERIOD;
        btn <= '0';
        wait for CLK_PERIOD;
    end procedure;
    
    procedure arrived(
        signal arvd : out STD_LOGIC
    ) is
    begin
        arvd <= '1';
        wait for CLK_PERIOD;
        arvd <= '0';
        wait for CLK_PERIOD;
    end procedure;
    
    procedure test_transition(
        constant test_name : string;
        signal btn : out STD_LOGIC;
        signal arvd : out STD_LOGIC
    ) is
    begin
        report "Testing: " & test_name;
        press_button(btn);
        wait for 5 * CLK_PERIOD;
        arrived(arvd);
    end procedure;
    
begin

    uut: elevator_fsm
        port map ( reset   => tb_reset,
                   clock   => tb_clock,
                   bt_f1   => tb_bt_f1,
                   bt_f2   => tb_bt_f2,
                   bt_f3   => tb_bt_f3,
                   arvd_f1 => tb_arvd_f1,
                   arvd_f2 => tb_arvd_f2,
                   arvd_f3 => tb_arvd_f3,
                   dr_up   => tb_dr_up,
                   dr_dwn  => tb_dr_dwn,
                   led_f1  => tb_led_f1,
                   led_f2  => tb_led_f2,
                   led_f3  => tb_led_f3 );
                   
    clk_process: process
    begin
    
        tb_clock <= '0';
        wait for CLK_PERIOD/2;
        tb_clock <= '1';
        wait for CLK_PERIOD/2; 
    
    end process;
    
    test: process
    begin
        
        -- Test: initial reset
        tb_reset <= '1';
        wait for CLK_PERIOD * 2;
        
        tb_reset <= '0'; -- clear reset
        wait for CLK_PERIOD;
        
        -- Tests
        test_transition("F1 -> F2", tb_bt_f2, tb_arvd_f2);
        test_transition("F2 -> F3", tb_bt_f3, tb_arvd_f3);
        test_transition("F3 -> F1", tb_bt_f1, tb_arvd_f1);
        test_transition("F1 -> F3", tb_bt_f3, tb_arvd_f3);
        test_transition("F3 -> F2", tb_bt_f2, tb_arvd_f2);
        test_transition("F2 -> F1", tb_bt_f1, tb_arvd_f1);
        
        report "Elevator FSM Simulation Completed";
        wait;
    
    end process;

end Behavioral;
