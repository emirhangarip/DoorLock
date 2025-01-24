----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 05/27/2024 02:42:25 AM
-- Design Name: 
-- Module Name: button_sencronizer_TB - Behavioral
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

entity button_sencronizer_TB is
end button_sencronizer_TB;

architecture Behavioral of button_sencronizer_TB is

-- Compoents

component b_s 
    Port ( b_in,clkh,clk : in STD_LOGIC;
           b_out : out STD_LOGIC);
end component;

-- Clocks

constant high_clock_frequency : integer := 100e6;--100 MHz
constant high_clock_period    : time    := 1000ms/ high_clock_frequency;

constant clock_frequency : integer := 100e5;--10Mhz
constant clock_period    : time    := 1000ms/ clock_frequency;

-- Signals

signal input      : std_logic:='0';
signal clock      : std_logic:='0';
signal clock_high : std_logic:='0';
signal output     : std_logic;

begin
-- Sim Setup
button_sencronizer:b_s
port map (b_in=>input,
          clk=>clock,
          clkh=>clock_high,
          b_out=>output
          );
-- Clock Setup
process is
begin
clock_high<= not clock_high;
wait for high_clock_period/2;
end process;

process is
begin
clock<= not clock;
wait for clock_period/2;
end process;
-- Process
process is
begin
input<='0';
wait for 50ns;
input<='1';
wait for 20ns;
input<='0';
wait;
end process;

end Behavioral;
