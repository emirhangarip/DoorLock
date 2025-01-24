----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 05/22/2024 01:03:53 AM
-- Design Name: 
-- Module Name: counter - Behavioral
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
use IEEE.NUMERIC_std.all;

-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
--use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx leaf cells in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity counter is
    Port ( clk,s,r : in STD_LOGIC;
           state   : out integer);
end counter;

architecture Behavioral of counter is
signal tick:integer:=0;
signal keep:boolean;
begin
process(clk,s,r,tick,keep)
begin
    if rising_edge (s) then 
        keep<=true;
    end if; 
    
    if rising_edge (r)then
        keep<=false;
    end if;
     
    if keep = true then
        if rising_edge (clk) then
            tick <= tick+1;
        end if;
    else
    if rising_edge (clk) then
            tick <= 0;
        end if;
    end if;
    if tick = 11 then
        if rising_edge (clk) then
            tick <= 0;
        end if;
    end if;
    state<=tick;  
end process;
end Behavioral;
