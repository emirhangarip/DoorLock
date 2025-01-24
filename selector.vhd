----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 05/22/2024 12:24:26 AM
-- Design Name: 
-- Module Name: selector - Behavioral
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

entity selector is
    Port ( god       : in STD_LOGIC;
           in0       :in STD_LOGIC_vector(11 downto 0);
           out0,out1 : out STD_LOGIC_vector (11 downto 0));
end selector;

architecture Behavioral of selector is

begin
process(in0,god)
begin
    if god='1' then
        out1<=in0;
    else
        out0<=in0;
    end if;
end process;
end Behavioral;
