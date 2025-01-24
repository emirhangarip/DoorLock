----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 05/16/2024 02:49:03 PM
-- Design Name: 
-- Module Name: clk_dvd - Behavioral
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

entity clock_divider is
--generic(counter0_limit : integer:= 50000000 ; counter1_limit : integer:=50000);
    Port ( clkh : in STD_LOGIC:= '0';
           clk  : out std_logic:='0';
           clkm : out std_logic:='0'
           );
end clock_divider;

architecture Behavioral of clock_divider is

signal count0 : integer   :=0;
signal count1 : integer   :=0;
signal b      : std_logic :='0';
signal a      : std_logic :='0';

begin

 --clk generation.For 100 MHz clock this generates 1 Hz clock.
process(clkh,b) 
begin
    if(rising_edge(clkh)) then
        count0 <=count0+1;
            if(count0 = 50000000) then
                b <= not b;
                count0 <=0;
            end if;
                       
    end if;
clk<=b;
end process;
process(clkh,a)
begin
    if(rising_edge(clkh)) then
        count1 <=count1+1;
            if(count1 = 50000) then
                a <= not a;
                count1 <=0;
            end if;
                       
    end if;
clkm<=a;
end process;
end;
