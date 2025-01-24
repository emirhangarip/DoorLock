----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 05/27/2024 04:01:40 AM
-- Design Name: 
-- Module Name: complete_state_machine_TB - Behavioral
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

entity complete_state_machine_TB is
end complete_state_machine_TB;

architecture Behavioral of complete_state_machine_TB is

-- Components

component state_top 
    Port ( e,s,r,clk,clkh,bed,m : in STD_LOGIC;
           data                 : in std_logic_vector (11 downto 0);
           out_l                : out STD_LOGIC_vector(11 downto 0):=(others=>'0');
           stop                 : out std_logic;
           ssout                : out std_logic;
           run_out              : out std_logic;
           state_out            : out std_logic_vector(3 downto 0)
           );
end component;

component b_s 
    Port ( b_in,clkh,clk : in STD_LOGIC;
           b_out : out STD_LOGIC);
end component;

-- Clocks
constant high_clock_frequency : integer := 100e6;--100 MHz
constant high_clock_period    : time    := 1000ms/ high_clock_frequency;

constant clock_frequency : integer := 100e5;--10Mhz
constant clock_period    : time    := 1000ms/ clock_frequency;

-- Input Signals
signal clock      : std_logic:='0';
signal clock_high : std_logic:='0';
signal enable     : std_logic:='0';
signal start      : std_logic:='0';
signal s_start    : std_logic:='0';
signal reset      : std_logic:='0';
signal s_reset    : std_logic:='0';
signal mode       : std_logic:='0';
signal singlebit  : std_logic:='0';
signal data_input : std_logic_vector(11 downto 0):="000000101001";
-- Output Signals
signal led_outputs        : std_logic_vector(11 downto 0):=(others=>'0');
signal stop_led           : std_logic:='0';
signal sevensegment_output: std_logic:='0';
signal runner_signal      : std_logic:='0';
signal state              : std_logic_vector(3 downto 0):=(others=>'0');


begin

-- Sim Setup

state_machine:state_top
port map (e=>enable,
          s=>s_start,
          r=>s_reset,
          clk=>clock,
          out_l=>led_outputs,
          data=>data_input,
          clkh=>clock_high,
          bed=>singlebit,
          m=>mode,
          stop=>stop_led,
          state_out=>state,
          ssout=>sevensegment_output,
          run_out=>runner_signal
          );

reset_sencronizer:b_s
port map (b_in=>reset,
          clk=>clock,
          clkh=>clock_high,
          b_out=>s_reset
          );
          
start_sencronizer:b_s
port map (b_in=>start,
          clk=>clock,
          clkh=>clock_high,
          b_out=>s_start
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
-- Start
process is
begin
-- Password Determination
data_input<="000000101001";
start<='0';
reset<='0';
enable<='0';
mode<='0';
wait for 50ns;
data_input<="000000101001";
wait for 50ns;
enable<='1';
wait for 50ns;
enable<='0';
wait for 50ns;
-- Password Cheking
mode<='1';
wait for 50ns;
-- Holding same data this is for the correct password
data_input<="000000101001";
wait for 50ns;
enable<='1';
wait for 50ns;
enable<='0';
wait for 50ns;
start<='1';
wait for 50ns;
start<='0';
wait for 150ns;
    for i in 11 downto 0 loop
    singlebit<=data_input(i);
    wait for clock_period;
    end loop;
reset<='1';
wait for 50 ns;
reset<='0';
wait for 50 ns;
-- Press the reset before work not done 
start<='1';
wait for 50ns;
start<='0';
wait for 150ns;
    for i in 11 downto 0 loop
    singlebit<=data_input(i);
        if i=5 then
            reset<='1';
            wait for 50ns;
            reset<='0';
            wait for 50ns;
        end if;
    wait for clock_period;
    end loop;
-- Wrong Password at 7th bit
data_input<="000001101001";
wait for 50ns;
enable<='1';
wait for 50ns;
enable<='0';
wait for 50 ns;
start<='1';
wait for 50ns;
start<='0';
wait for 100ns;
    for i in 11 downto 0 loop
    singlebit<=data_input(i);
    wait for clock_period;
    end loop;
reset<='1';
wait for 50ns;
reset<='0'; 
wait;    
end process;
end Behavioral;
