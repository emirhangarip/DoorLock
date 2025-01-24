----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 05/27/2024 09:55:38 AM
-- Design Name: 
-- Module Name: sevensegment_TB - Behavioral
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

entity sevensegment_TB is
end sevensegment_TB;

architecture Behavioral of sevensegment_TB is

-- Components

component led_decider 
    Port ( m,run,ssout,e,clk,clkh,clkm          : in STD_LOGIC;
           stop                                 : in std_logic;
           state_in                             : in std_logic_vector(3 downto 0);
           data                                 : in std_logic_vector(11 downto 0);
           anode                                : out std_logic_vector (3 downto 0);
           led_out                              : out STD_LOGIC_vector(6 downto 0)
        );
end component;

-- Clocks

constant high_clock_frequency   : integer := 100e6;--100 MHz
constant high_clock_period      : time    := 1000ms/ high_clock_frequency;

constant medium_clock_frequency : integer := 250e6;--25Mhz
constant medium_clock_period    : time    := 1000ms/ medium_clock_frequency;

constant clock_frequency        : integer := 100e5;--10Mhz
constant clock_period           : time    := 1000ms/ clock_frequency;

-- Signals

-- Input Signals

signal clock        : std_logic:='0';
signal clock_high   : std_logic:='0';
signal clock_medium : std_logic:='0';
signal mode         : std_logic:='0';
signal runner       : std_logic:='0';
signal ssout        : std_logic:='0';
signal enable       : std_logic:='0';
signal stop_led     : std_logic:='0';
signal state_input  : std_logic_vector(3 downto 0);
signal data_input   : std_logic_vector(11 downto 0):="000000101001";

-- Output Signals

signal anode_signal : std_logic_vector (3 downto 0);
signal sevensegment : STD_LOGIC_vector(6 downto 0);

begin

-- Sim Setup

led_compiler:led_decider
port map (clk=>clock,
          clkh=>clock_high,
          clkm=>clock_medium,
          m=>mode,
          run=>runner,
          ssout=>ssout,
          e=>enable,
          stop=>stop_led,
          state_in=>state_input,
          data=>data_input,
          anode=>anode_signal,
          led_out=>sevensegment
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

process is
begin
clock_medium<= not clock_medium;
wait for medium_clock_period/2;
end process;

-- Start Sim

process is
begin
mode<='0';
enable<='0';
state_input<="0000";
wait for 200ns;
mode<='0';
enable<='1';
state_input<="0000";
wait for 200ns;
mode<='1';
enable<='0';
state_input<="0000";
wait for 200ns;
mode<='1';
enable<='1';
state_input<="0000";
wait for 200ns;
mode<='1';
enable<='0';
state_input<="0000";
wait for 200ns;
mode<='1';
runner<='0';
stop_led<='0';
ssout<='0';
wait for 200ns;
mode<='1';
runner<='1';
stop_led<='0';
ssout<='0';
wait for 200ns;
mode<='1';
runner<='0';
stop_led<='0';
ssout<='0';
wait for 200ns;
mode<='1';
ssout<='1';
wait for 200ns;
mode<='1';
ssout<='0';
wait for 200ns;
mode<='1';
stop_led<='1';
wait for 200ns;
mode<='1';
stop_led<='0';
wait;
end process;

end Behavioral;
