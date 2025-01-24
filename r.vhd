----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 05/22/2024 12:17:42 AM
-- Design Name: 
-- Module Name: r - Behavioral
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

entity r is
    Port ( in0,in1,god,clk : in STD_LOGIC;
           q : out STD_LOGIC);
end r;

architecture Behavioral of r is
signal bridge:std_logic;
begin
process(in0,in1,god,clk,bridge)
begin
    if god ='1' then
        bridge<=in1;
    else
        bridge<=in0;
    end if;
    
    if rising_edge  (clk) then
        q<=bridge;
    end if;
end process;
end Behavioral;
