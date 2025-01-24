----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 05/16/2024 02:55:02 PM
-- Design Name: 
-- Module Name: reg - Behavioral
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

entity reg is 
    Port (  s,e,d,clk,clkh: in STD_LOGIC;
            data          : in std_logic;
            q             : out std_logic       
          );
end reg;

architecture structure of reg is
component d_c
port(data_in,e,clkh : in STD_LOGIC;
     data_out       : out STD_LOGIC
    );
end component;

component r
port(in0,in1,god,clk : in STD_LOGIC;
     q               : out STD_LOGIC
    );
end component;
signal data_l:std_logic;
begin
data_collector    :d_c port map(data_in=>data,e=>e,clkh=>clkh,data_out=>data_l);
reg               :r   port map(in0=>d,in1=>data_l,god=>s,clk=>clk,q=>q);

end structure;
