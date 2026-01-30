----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 01/23/2026 05:54:58 AM
-- Design Name: 
-- Module Name: calculator - Behavioral
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

entity calculator is
    Port ( RST : in STD_LOGIC;
           CLK : in STD_LOGIC;
         SW_IN : in STD_LOGIC_VECTOR (15 downto 0);
         load1 : in STD_LOGIC;
         load2 : in STD_LOGIC;
--           A : in STD_LOGIC_VECTOR (15 downto 0);
--           B : in STD_LOGIC_VECTOR (15 downto 0);
           start : in STD_LOGIC;
           SEG_DATA : out STD_LOGIC_VECTOR (6 downto 0);
           SEG_EN : out STD_LOGIC_VECTOR (3 downto 0));
end calculator;

architecture Structural of calculator is
    -- bit width
    constant BIT_WIDTH : integer := 16;
    
    -- components
    -- automatic sequential adder
    component auto_seq_adder
        generic ( BIT_WIDTH : integer := 8 );
        port ( RST : in STD_LOGIC;
               CLK : in STD_LOGIC;
                 A : in STD_LOGIC_VECTOR (BIT_WIDTH-1 downto 0);
                 B : in STD_LOGIC_VECTOR (BIT_WIDTH-1 downto 0);
             start : in STD_LOGIC;
                 Y : out STD_LOGIC_VECTOR (BIT_WIDTH-1 downto 0);
          finished : out STD_LOGIC);
    end component;
    -- input registers
    component input_reg
        port ( RST, CLK : in  std_logic;
                  SW_IN : in  std_logic_vector (15 downto 0);
           load1, load2 : in  std_logic;
             REG1, REG2 : out std_logic_vector (15 downto 0));
    end component;
    -- 1-of-4 counter
    component counter_1of4
        port ( RST, CLK : in std_logic;
                     EN : in std_logic;
                       Y : out std_logic_vector(3 downto 0));
    end component;
    -- demux
    component demux
        port ( X_IN : in STD_LOGIC_VECTOR (15 downto 0);
                SEL : in STD_LOGIC_VECTOR (3 downto 0);
              Y_OUT : out STD_LOGIC_VECTOR (3 downto 0));
    end component;
    -- seven segment decoder
    component sevseg_decoder
        port ( BCD : in STD_LOGIC_VECTOR (3 downto 0);
               SSEG : out STD_LOGIC_VECTOR (6 downto 0));
    end component;
    
    -- intermediate signals
    signal y_internal : std_logic_vector(BIT_WIDTH-1 downto 0);
    signal finished_internal : std_logic;
    signal seg_enable : std_logic_vector(3 downto 0);
    signal decoder_in : std_logic_vector(3 downto 0);
    signal reg1_internal : std_logic_vector (15 downto 0);
    signal reg2_internal : std_logic_vector (15 downto 0);
    
    -- test inputs
    signal a_test : std_logic_vector(15 downto 0) := x"1234";
    signal b_test : std_logic_vector(15 downto 0) := x"5678";
begin
    regin: input_reg
        port map ( RST => RST,
                   CLK => CLK,
                   SW_IN => SW_IN,
                   load1 => load1,
                   load2 => load2,
                   REG1 => reg1_internal,
                   REG2 => reg2_internal);
    adder1: auto_seq_adder
        generic map ( BIT_WIDTH => BIT_WIDTH )
        port map ( RST => RST,
                   CLK => CLK,
                   A => reg1_internal,
                   B => reg2_internal,
                   start => start,
                   Y => y_internal,
                   finished => finished_internal);
    counter1: counter_1of4
        port map ( RST => RST,
                   CLK => CLK,
                   EN => finished_internal,
                   Y => seg_enable );
    demux1: demux
        port map ( X_IN => y_internal,
                   SEL => seg_enable,
                   Y_OUT => decoder_in );
    decoder1: sevseg_decoder
        port map ( BCD => decoder_in,
                   SSEG => SEG_DATA );
    SEG_EN <= seg_enable;
end Structural;