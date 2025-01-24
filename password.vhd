----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 05/22/2024 05:22:36 AM
-- Design Name: 
-- Module Name: comparor - Behavioral
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

entity comparor is
    Port ( c0           : in STD_LOGIC;
           state        : in std_logic_vector(3 downto 0);
           data         : in std_logic_vector(11 downto 0);
           c            : out STD_LOGIC
          );
end comparor;

architecture Behavioral of comparor is

signal compare :std_logic:='0';

begin

process(state,data,compare,c0)
begin
c <= c0 xnor compare;

    case state is 

                when "0000" =>
                    compare<=not c0;                                         
                when "0001" => 
                    compare<=data(11);                     
                when "0010" => 
                    compare<=data(10);    
                when "0011" => 
                    compare<=data(9);    
                when "0100" => 
                    compare<=data(8);    
                when "0101" => 
                    compare<=data(7);    
                when "0110" => 
                    compare<=data(6);                    
                when "0111" =>
                    compare<=data(5);    
                when "1000" => 
                    compare<=data(4);    
                when "1001" => 
                    compare<=data(3);    
                when "1010" => 
                    compare<=data(2);    
                when "1011" => 
                    compare<=data(1);
                when "1100" => 
                    compare<=data(0);                           
                when others =>
            end case;

end process;
end Behavioral;
