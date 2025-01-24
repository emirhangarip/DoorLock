----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 05/22/2024 09:17:11 PM
-- Design Name: 
-- Module Name: led_decider - Behavioral
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
use IEEE.STD_LOGIC_ARITH.ALL;
use IEEE.STD_LOGIC_UNSIGNED.ALL;
-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
--use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx leaf cells in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity led_decider is
    Port ( m,run,ssout,e,clk,clkh,clkm          : in STD_LOGIC;
           stop                                 : in std_logic;
           state_in                             : in std_logic_vector(3 downto 0);
           data                                 : in std_logic_vector(11 downto 0);
           anode                                : out std_logic_vector (3 downto 0);
           led_out                              : out STD_LOGIC_vector(6 downto 0)
        );
end led_decider;

architecture Behavioral of led_decider is
    type segment_pattern is array (0 to 19) of STD_LOGIC_VECTOR(6 downto 0);
    signal patterns : segment_pattern := (
        "0011101",      -- high
        "1111110",      -- low
        "0000001",      -- 0
        "0011000",      -- P
        "0110000",      -- E
        "0001001",      -- n
        "0111000",      -- F
        "0001000",      -- A
        "1110001",      -- L
        "0100100",      -- S
        "1000010",      -- d  
        "1001111",      -- 1
        "0010010",      -- 2
        "0000110",      -- 3
        "1001100",      -- 4
        "0100100",      -- 5
        "0100000",      -- 6
        "0001111",      -- 7
        "0000000",      -- 8
        "0000100"       -- 9
        );
    signal n            : std_logic:='0';
    signal current_digit: integer range 0 to 3;
    signal mode0_c       : std_logic:='0';
    signal mode1_c       : std_logic:='0';
    
begin
-- generation of n 
process (clk,n)
begin
    if rising_edge (clk) then
        n<= not n;
    end if;
end process;
--generation of mode console signals
process (e,m,mode0_c,mode1_c)
begin
    mode0_c<= e and (not m);
    mode1_c<= e and m;
end process;
-- current digit loop
process(current_digit,clkm)
begin
    if rising_edge (clkm) then
        current_digit <= (current_digit+1) mod 4;
    end if;
end process;
--- writing process    
process(e,clk,n,m,run,ssout,e,clkh,current_digit,mode0_c,patterns,data,mode1_c,stop,state_in)
begin
    case current_digit is
        when 0 => anode <="0111";
        when 1 => anode <="1011";
        when 2 => anode <="1101";
        when 3 => anode <="1110";
        when others => anode <="1111";
    end case;
if m='1'then

    if ssout='1' then
        --open
                                case current_digit is
                        when 0 => led_out <= patterns(2); 
                        when 1 => led_out <= patterns(3); 
                        when 2 => led_out <= patterns(4); 
                        when 3 => led_out <= patterns(5); 
                        when others => led_out <= "1111111"; 
                    end case;

    end if;
    
    if stop='1' then
        --false
            		if n='1' then
                    case current_digit is
                        when 0 => led_out <= patterns(7); 
                        when 1 => led_out <= patterns(8); 
                        when 2 => led_out <= patterns(9); 
                        when 3 => led_out <= patterns(4); 
                        when others => led_out <= "1111111"; 
                    end case;
	    	else
		case current_digit is
                        when 0 => led_out <= patterns(6); 
                        when 1 => led_out <= patterns(7); 
                        when 2 => led_out <= patterns(8); 
                        when 3 => led_out <= patterns(9); 
                        when others => led_out <= "1111111"; 
                    end case;
	
		end if;
    end if;
    
    if run ='1' then
        if ssout='0' then
            if stop='0' then
                -- clock
                 if n='1' then                 
                    case current_digit is
                        when 0 => led_out <= patterns(0); 
                        when 1 => led_out <= patterns(1); 
                        when 2 => led_out <= patterns(0); 
                        when 3 => led_out <= patterns(1); 
                        when others => led_out <= "1111111"; 
                    end case;
                 else
                    case current_digit is
                        when 0 => led_out <= patterns(1); 
                        when 1 => led_out <= patterns(0); 
                        when 2 => led_out <= patterns(1); 
                        when 3 => led_out <= patterns(0); 
                        when others => led_out <= "1111111"; 
                    end case;
                 end if;

            end if;
        end if;
    else
        if stop='0' then
        if ssout='0'then
            if mode1_c ='0' then
                --load
                if state_in <="0000" then
                  case current_digit is
                        when 0 => led_out <= patterns(8); 
                        when 1 => led_out <= patterns(2); 
                        when 2 => led_out <= patterns(7); 
                        when 3 => led_out <= patterns(10); 
                        when others => led_out <= "1111111"; 
                  end case;
                end if;
            else
                --write number
                                        case current_digit is
                        when 0 => led_out <= "1111110";
                        when 1 =>
                            case data(3 downto 0) is
                                when "0000" => LED_out <= "0000001"; -- "0"     
                                when "1000" => LED_out <= "1001111"; -- "1" 
                                when "0100" => LED_out <= "0010010"; -- "2" 
                                when "1100" => LED_out <= "0000110"; -- "3" 
                                when "0010" => LED_out <= "1001100"; -- "4" 
                                when "1010" => LED_out <= "0100100"; -- "5" 
                                when "0110" => LED_out <= "0100000"; -- "6" 
                                when "1110" => LED_out <= "0001111"; -- "7" 
                                when "0001" => LED_out <= "0000000"; -- "8"     
                                when "1001" => LED_out <= "0000100"; -- "9" 
                                when others => led_out <= "1111110";
                            end case;  
                        when 2 =>  
                            case data(7 downto 4) is
                               when "0000" => LED_out <= "0000001"; -- "0"     
                                when "1000" => LED_out <= "1001111"; -- "1" 
                                when "0100" => LED_out <= "0010010"; -- "2" 
                                when "1100" => LED_out <= "0000110"; -- "3" 
                                when "0010" => LED_out <= "1001100"; -- "4" 
                                when "1010" => LED_out <= "0100100"; -- "5" 
                                when "0110" => LED_out <= "0100000"; -- "6" 
                                when "1110" => LED_out <= "0001111"; -- "7" 
                                when "0001" => LED_out <= "0000000"; -- "8"     
                                when "1001" => LED_out <= "0000100"; -- "9" 
                                when others => led_out <= "1111110";

                            end case;  
                        when 3 =>
                            case data(11 downto 8) is
                                when "0000" => LED_out <= "0000001"; -- "0"     
                                when "1000" => LED_out <= "1001111"; -- "1" 
                                when "0100" => LED_out <= "0010010"; -- "2" 
                                when "1100" => LED_out <= "0000110"; -- "3" 
                                when "0010" => LED_out <= "1001100"; -- "4" 
                                when "1010" => LED_out <= "0100100"; -- "5" 
                                when "0110" => LED_out <= "0100000"; -- "6" 
                                when "1110" => LED_out <= "0001111"; -- "7" 
                                when "0001" => LED_out <= "0000000"; -- "8"     
                                when "1001" => LED_out <= "0000100"; -- "9" 
                                when others => led_out <= "1111110";

                            end case;   
                        when others => led_out <= "1111111"; 
                    end case;
            end if;
        end if;    
        end if;    
    end if;
else
    if mode0_c='0'then
                if state_in <="0000" then
                  case current_digit is
                        when 0 => led_out <= patterns(8); 
                        when 1 => led_out <= patterns(2); 
                        when 2 => led_out <= patterns(7); 
                        when 3 => led_out <= patterns(10); 
                        when others => led_out <= "1111111"; 
                  end case;
                end if;
    else
        --write number
                                case current_digit is
                        when 0 => led_out <= "1111110";
                        when 1 =>
                            case data(3 downto 0) is
                                when "0000" => LED_out <= "0000001"; -- "0"     
                                when "1000" => LED_out <= "1001111"; -- "1" 
                                when "0100" => LED_out <= "0010010"; -- "2" 
                                when "1100" => LED_out <= "0000110"; -- "3" 
                                when "0010" => LED_out <= "1001100"; -- "4" 
                                when "1010" => LED_out <= "0100100"; -- "5" 
                                when "0110" => LED_out <= "0100000"; -- "6" 
                                when "1110" => LED_out <= "0001111"; -- "7" 
                                when "0001" => LED_out <= "0000000"; -- "8"     
                                when "1001" => LED_out <= "0000100"; -- "9" 
                                when others => led_out <= "1111110";
                            end case;  
                        when 2 =>  
                            case data(7 downto 4) is
                               when "0000" => LED_out <= "0000001"; -- "0"     
                                when "1000" => LED_out <= "1001111"; -- "1" 
                                when "0100" => LED_out <= "0010010"; -- "2" 
                                when "1100" => LED_out <= "0000110"; -- "3" 
                                when "0010" => LED_out <= "1001100"; -- "4" 
                                when "1010" => LED_out <= "0100100"; -- "5" 
                                when "0110" => LED_out <= "0100000"; -- "6" 
                                when "1110" => LED_out <= "0001111"; -- "7" 
                                when "0001" => LED_out <= "0000000"; -- "8"     
                                when "1001" => LED_out <= "0000100"; -- "9" 
                                when others => led_out <= "1111110";

                            end case;  
                        when 3 =>
                            case data(11 downto 8) is
                                when "0000" => LED_out <= "0000001"; -- "0"     
                                when "1000" => LED_out <= "1001111"; -- "1" 
                                when "0100" => LED_out <= "0010010"; -- "2" 
                                when "1100" => LED_out <= "0000110"; -- "3" 
                                when "0010" => LED_out <= "1001100"; -- "4" 
                                when "1010" => LED_out <= "0100100"; -- "5" 
                                when "0110" => LED_out <= "0100000"; -- "6" 
                                when "1110" => LED_out <= "0001111"; -- "7" 
                                when "0001" => LED_out <= "0000000"; -- "8"     
                                when "1001" => LED_out <= "0000100"; -- "9" 
                                when others => led_out <= "1111110";

                            end case;   
                        when others => led_out <= "1111111"; 
                    end case;

    end if;    
end if;
end process;
end Behavioral;
