----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 05/27/2024 03:27:04 AM
-- Design Name: 
-- Module Name: clock_slower_TB - Behavioral
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

entity clock_slower_TB is
end clock_slower_TB;

architecture Behavioral of clock_slower_TB is
-- Components
component clock_divider 
    Port ( clkh : in STD_LOGIC:= '0';
           clk  : out std_logic:='0';
           clkm : out std_logic:='0'
           );
end component;

-- Clocks

constant high_clock_frequency : integer := 100e6;--100 MHz
constant high_clock_period    : time    := 1000ms/ high_clock_frequency;

-- Signals

signal input_clock : std_logic:='0';
signal medium_clock: std_logic:='0';
signal clock       : std_logic:='0';

begin

-- Sim Setup

clock_slower:clock_divider
port map (clkh=>input_clock,
          clk=>clock,
          clkm=>medium_clock
          );

-- Clock Setup

process is
begin
input_clock<= not input_clock;
wait for high_clock_period/2;
end process;

-- Start Sim

end Behavioral;
