----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 05/18/2024 11:25:21 PM
-- Design Name: 
-- Module Name: register - Behavioral
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

entity register_top is
    Port ( clk,clkh,e,s : in STD_LOGIC;
           data: in std_logic_vector (11 downto 0);
           qs : out STD_LOGIC);
end register_top;

architecture structure of register_top is
component reg
port(
s,e,clk,clkh,d: in STD_LOGIC;
          data: in std_logic;
             q: out std_logic 
);
end component;
signal dtoq:std_logic_vector (11 downto 0);
begin
    register0 :reg port map(s=>s, e=>e ,clk=>clk,clkh=>clkh ,data=>data(0) ,d=>dtoq(0),q=>dtoq(1));
    register1 :reg port map(s=>s, e=>e ,clk=>clk,clkh=>clkh ,data=>data(1) ,d=>dtoq(1),q=>dtoq(2));
    register2 :reg port map(s=>s, e=>e ,clk=>clk,clkh=>clkh ,data=>data(2) ,d=>dtoq(2),q=>dtoq(3));
    register3 :reg port map(s=>s, e=>e ,clk=>clk,clkh=>clkh ,data=>data(3) ,d=>dtoq(3),q=>dtoq(4));
    register4 :reg port map(s=>s, e=>e ,clk=>clk,clkh=>clkh ,data=>data(4) ,d=>dtoq(4),q=>dtoq(5));
    register5 :reg port map(s=>s, e=>e ,clk=>clk,clkh=>clkh ,data=>data(5) ,d=>dtoq(5),q=>dtoq(6));
    register6 :reg port map(s=>s, e=>e ,clk=>clk,clkh=>clkh ,data=>data(6) ,d=>dtoq(6),q=>dtoq(7));
    register7 :reg port map(s=>s, e=>e ,clk=>clk,clkh=>clkh ,data=>data(7) ,d=>dtoq(7),q=>dtoq(8));
    register8 :reg port map(s=>s, e=>e ,clk=>clk,clkh=>clkh ,data=>data(8) ,d=>dtoq(8),q=>dtoq(9));
    register9 :reg port map(s=>s, e=>e ,clk=>clk,clkh=>clkh ,data=>data(9) ,d=>dtoq(9),q=>dtoq(10));
    register10:reg port map(s=>s, e=>e ,clk=>clk,clkh=>clkh ,data=>data(10) ,d=>dtoq(10),q=>dtoq(11));
    register11:reg port map(s=>s, e=>e ,clk=>clk,clkh=>clkh ,data=>data(11) ,d=>dtoq(11),q=>dtoq(0));
    qs<=dtoq(0);
end structure;
