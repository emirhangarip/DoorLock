----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 05/26/2024 02:51:48 AM
-- Design Name: 
-- Module Name: password_holder - Behavioral
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

entity password_holder is
    Port ( e,clkh         : in STD_LOGIC;
           m              : in std_logic;
           data_in        : in std_logic_vector(11 downto 0);
           data_out       : out STD_LOGIC_vector(11 downto 0)
          );
end password_holder;

architecture Behavioral of password_holder is
signal data2dp: std_logic_vector(11 downto 0);
signal holdp  : std_logic_vector(11 downto 0);
signal runner : std_logic;
begin
process(m,e,runner)
begin
    runner <= e and (not m);
end process;
process(data_in,e,clkh,data2dp,holdp,m,runner)
begin
        if runner= '1' then
            data2dp<=data_in;
        else
            data2dp<=holdp;
        end if;
        if rising_edge (clkh) then
           holdp<=data2dp;     
        end if;
data_out<=holdp;
    end process;
end Behavioral;
