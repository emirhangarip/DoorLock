----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 05/26/2024 09:21:48 PM
-- Design Name: 
-- Module Name: complete_register_TB - Behavioral
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
use ieee.numeric_std.all;

-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
--use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx leaf cells in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity complete_register_TB is
end complete_register_TB;

architecture sim of complete_register_TB is

-- Components

component register_top
    Port ( clk,clkh,e,s : in STD_LOGIC;
           data: in std_logic_vector (11 downto 0);
           qs : out STD_LOGIC);    
end component;

-- Clocks

constant high_clock_frequency : integer := 100e6;--100 MHz
constant high_clock_period    : time    := 1000ms/ high_clock_frequency;

constant clock_frequency : integer := 100e5;--10Mhz
constant clock_period    : time    := 1000ms/ clock_frequency;

-- SIGNALS

signal clock      : std_logic:='0';
signal clock_high : std_logic:='0';
signal enable     : std_logic:='0';
signal start      : std_logic:='0';
signal data_input : std_logic_vector(11 downto 0):="100101000000";
signal serial_out : std_logic;

begin
-- Sim Setup
register_TB:register_top
port map (clk=>clock,
          clkh=>clock_high,
          e=>enable,
          s=>start,
          data=>data_input,
          qs=>serial_out
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
-- Start Sim
-- Initial (It will catch enable despite the general rising clock)
process
begin
data_input<="000000101001";
start<='0';
enable<='0';
wait for 50ns;
enable<='1';
wait for 50ns;
enable<='0';
wait for 50ns;
start<='1';
wait for 50ns;
start<='0';
wait;
end process;

end sim;
