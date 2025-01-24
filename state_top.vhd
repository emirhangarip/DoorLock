----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 05/22/2024 06:20:00 AM
-- Design Name: 
-- Module Name: state_top - Behavioral
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

entity state_top is
    Port ( e,s,r,clk,clkh,bed,m : in STD_LOGIC;
           data                 : in std_logic_vector (11 downto 0);
           out_l                : out STD_LOGIC_vector(11 downto 0);
           stop                 : out std_logic;
           ssout                : out std_logic:='0';
           run_out              : out std_logic;
           state_out            : out std_logic_vector(3 downto 0)
           );
end state_top;

architecture structure of state_top is

component password_holder 
    Port ( e,clkh         : in STD_LOGIC;
           m              : in std_logic;
           data_in        : in std_logic_vector(11 downto 0);
           data_out       : out STD_LOGIC_vector(11 downto 0)
          );
end component;

component comparor 
    Port ( c0           : in STD_LOGIC;
           state        : in std_logic_vector(3 downto 0);
           data         : in std_logic_vector(11 downto 0);
           c            : out STD_LOGIC:='0'
          );
end component;
component state_machine 
    Port ( in0         : in STD_LOGIC;
           clk,s,r     : in STD_LOGIC:='0';
           stop        : out std_logic:='0';
           out0        : out STD_LOGIC_vector(11 downto 0);
           state_out_i : out std_logic_vector(3 downto 0);
           ssout       : out std_logic:='0';
           run_out     : out std_logic
           );
end component;
signal dc2p  : std_logic_vector(11 downto 0);
signal bath  : std_logic;
signal carpet: std_logic_vector(3 downto 0);
signal clock : std_logic;
signal seven : std_logic;



begin
--data to d_c
temp_passsword:password_holder
    port map (e=>e,
              clkh=>clkh,
              m=>m,
              data_in=>data,
              data_out=>dc2p
    );
-- d_c to password
compare: comparor 
    port map(c0=>bed,
            state=>carpet,
            data=>dc2p,
            c=>bath
            );
--- password to state_machine
state_machine_core: state_machine 
    port map (in0=>bath,
              clk=>clock,
              s=>s,
              r=>r,
              out0=>out_l,
              state_out_i=>carpet,
              ssout=>ssout,
              stop=>stop,
              run_out=>run_out
              );
clock<=clk;
state_out<=carpet;
end structure;
