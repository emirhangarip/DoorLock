----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 05/22/2024 12:03:14 AM
-- Design Name: 
-- Module Name: b_s - Behavioral
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

entity b_s is
    Port ( b_in,clkh,clk : in STD_LOGIC;
           b_out : out STD_LOGIC);
end b_s;

architecture Behavioral of b_s is
    signal god:std_logic;
    signal p  :std_logic;
    signal o2d:std_logic;
    signal d2d:std_logic:='0';
begin
process(clkh,clk,god)
begin
    god  <= b_in xor p;
    
    b_out<= p;
    
    if god='1' then
            o2d<=b_in;
        else
            o2d<=d2d;
    end if;
    
    if rising_edge (clkh) then
        d2d<=o2d;
    end if;
    
    if rising_edge (clk) then
        p<=d2d;
    end if;
    
end process;
end Behavioral;
