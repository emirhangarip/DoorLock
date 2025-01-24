----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 05/27/2024 11:37:28 AM
-- Design Name: 
-- Module Name: doorlock_TB - Behavioral
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

entity doorlock_TB is
end doorlock_TB;

architecture Behavioral of doorlock_TB is

-- Components
--constant counter0_limit: integer :=50;
--constant counter1_limit: integer :=1;
component doorlock_top 
--generic (counter0_limit : integer := 50000000 ; counter1_limit : integer := 50000);
    Port ( e,s_in,r_in,clkh,m : in STD_LOGIC;
           data               : in STD_LOGIC_VECTOR (11 DOWNTO 0);
           led                : out STD_LOGIC_VECTOR (11 downto 0):=(others=>'0');
           ssegment           : out std_logic_vector (6 downto 0);
           anode              : out std_logic_vector (3 downto 0);
           clk_out            : out STD_LOGIC;
           stop               : out STD_LOGIC
          );
end component;

-- Clocks

constant high_clock_frequency : integer := 100e6;--100 MHz
constant high_clock_period    : time    := 1000ms/ high_clock_frequency;

-- Signals

-- Input Signals

signal clock_high : std_logic:='0';
signal enable     : std_logic:='0';
signal start      : std_logic:='0';
signal reset      : std_logic:='0';
signal mode       : std_logic:='0';
signal data_input : std_logic_vector (11 downto 0):="000000101001";

-- Output Signals

signal sevensegment_out : std_logic_vector (6 downto 0):=(others=>'0');
signal out_led          : std_logic_vector (11 downto 0):=(others=>'0');
signal anode_out        : std_logic_vector (3 downto 0):=(others=>'0');
signal clock_led        : std_logic:='0';
signal stop_led         : std_logic:='0';

begin
-- Sim Setup
doorlock:doorlock_top
--generic map (
 --            counter0_limit =>50,--clk
 --            counter1_limit=>1--clkm
   --          )
port map (e=>enable,
          s_in=>start,
          r_in=>reset,
          clkh=>clock_high,
          m=>mode,
          data=>data_input,
          led=>out_led,
          ssegment=>sevensegment_out,
          anode=>anode_out,
          clk_out=>clock_led,
          stop=>stop_led
          );
-- Clock Setup

process is
begin
clock_high<= not clock_high;
wait for high_clock_period/2;
end process;

-- Start

process is
begin
-- Password Determination
data_input<="000000101001";
start<='0';
reset<='0';
enable<='0';
mode<='0';
wait for 500ns;
enable<='1';
wait for 500ns;
enable<='0';
wait for 500ns;
-- Password Cheking
mode<='1';
wait for 500ns;
-- Holding same data this is for the correct password
data_input<="000000101001";
wait for 500ns;
enable<='1';
wait for 500ns;
enable<='0';
wait for 500ns;
start<='1';
wait for 500ns;
start<='0';
wait for 15000ns;

--------------------------------------
reset<='1';
wait for 1000 ns;
reset<='0';
wait for 10000 ns;
-- Press the reset before work not done 
start<='1';
wait for 500ns;
start<='0';
wait for 8000ns;
reset<='1';
wait for 1000ns;
reset<='0';
wait for 15000ns;
------------------------------------------------    
-- Wrong Password at 7th bit
data_input<="000001101001";
wait for 1500ns;
enable<='1';
wait for 500ns;
enable<='0';
wait for 500 ns;
start<='1';
wait for 1000ns;
start<='0';
wait for 15000ns;
-------------------------------------------------
reset<='1';
wait for 5000ns;
reset<='0'; 
wait;    
end process;
end Behavioral;
