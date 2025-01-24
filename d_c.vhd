----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 05/21/2024 04:11:09 PM
-- Design Name: 
-- Module Name: d_c - Behavioral
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

entity d_c is
    Port ( data_in,e,clkh : in STD_LOGIC;
           data_out       : out STD_LOGIC
          );
end d_c;

architecture Behavioral of d_c is
signal data2d : std_logic;
signal hold   : std_logic;
begin
process(data_in,e,clkh,data2d,hold)
begin
        if e= '1' then
            data2d<=data_in;
        else
            data2d<=hold;
        end if;
        if rising_edge (clkh) then
           hold<=data2d;     
        end if;
data_out<=hold;
    end process;
end Behavioral;
