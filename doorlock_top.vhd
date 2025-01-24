----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 05/16/2024 02:40:03 PM
-- Design Name: 
-- Module Name: doorlock_top - Behavioral
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

entity doorlock_top is
--generic (counter0_limit : integer := 50000000 ; counter1_limit : integer := 50000);
    Port ( s_in,r_in,clkh,m   : in STD_LOGIC;
           e                  : in std_logic:='0';
           data               : in STD_LOGIC_VECTOR (11 DOWNTO 0);
           led                : out STD_LOGIC_VECTOR (11 downto 0);
           ssegment           : out std_logic_vector (6 downto 0);
           anode              : out std_logic_vector (3 downto 0);
           clk_out,stop       : out STD_LOGIC
          );
end doorlock_top;

architecture structure of doorlock_top is
component register_top
Port ( clk,clkh,e,s : in STD_LOGIC;
       data         : in std_logic_vector (11 downto 0);
       qs           : out STD_LOGIC
      );
end component;

component clock_divider
Port ( clkh      : in STD_LOGIC:='0';
       clk,clkm  : out std_logic:='0'
      );
end component;

component state_top
    Port ( e,s,r,clk,clkh,bed : in STD_LOGIC;
           m                  : in std_logic;
           data               : in std_logic_vector (11 downto 0);
           out_l              : out STD_LOGIC_vector(11 downto 0);
           stop               : out std_logic:='0';
           ssout              : out std_logic;
           state_out          : out std_logic_vector(3 downto 0);
           run_out            : out std_logic
           );
end component;

component led_decider
    Port ( m,run,ssout,e,clk,clkh,clkm         : in STD_LOGIC;
           stop                                : in std_logic;
           state_in                            : in std_logic_vector(3 downto 0);
           data                                : in std_logic_vector(11 downto 0);
           anode                               : out std_logic_vector (3 downto 0);
           led_out                             : out STD_LOGIC_vector(6 downto 0)
         );
end component;

component b_s
    Port ( b_in,clkh,clk : in STD_LOGIC;
           b_out : out STD_LOGIC);
end component;

signal clock     : std_logic;
signal clockout  : std_logic;
signal database  : std_logic_vector(11 downto 0);
signal bedroom   : std_logic;
signal run_base  : std_logic;
signal ssout_base: std_logic;
signal s         : std_logic;
signal r         : std_logic;
signal stop_base : std_logic;
signal medium    : std_logic;
signal state_base: std_logic_vector(3 downto 0);
signal enable    : std_logic;
begin
--PORT MAP
complete_register:register_top 
port map (e=>enable,
          s=>s,
          data=>database,
          clk=>clockout,
          clkh=>clock,
          qs=>bedroom
          );

clock_slower:clock_divider 
--generic map (counter0_limit => counter0_limit , counter1_limit => counter1_limit)
port map (clkh=>clock,
          clk=>clockout,
          clkm=>medium
         );
complete_state_machine:state_top 
port map (e=>enable,
          bed=>bedroom,
          s=>s,
          r=>r,
          state_out=>state_base,
          data=>database,
          clk=>clockout,
          clkh=>clock,
          out_l=>led,
          ssout=>ssout_base,
          stop=>stop_base,
          m=>m,
          run_out=>run_base
          );

led_compiler:led_decider
port map (m=>m,
          clkm=>medium,
          stop=>stop_base,
          run=>run_base,
          ssout=>ssout_base,
          e=>enable,
          state_in=>state_base,
          clk=>clockout,
          clkh=>clkh,
          data=>database,
          led_out=>ssegment,
          anode=>anode
);

s_sencronize:b_s
port map (b_in=>s_in,
          clk=>clockout,
          clkh=>clock,
          b_out=>s
          );
          
r_sencronize:b_s
port map (b_in=>r_in,
          clk=>clockout,
          clkh=>clock,
          b_out=>r
          );          
clk_out<=clockout;
clock <= clkh;
database<=data;
stop<=stop_base;
enable<=e;
end structure;
