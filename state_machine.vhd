----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 05/22/2024 04:27:18 AM
-- Design Name: 
-- Module Name: state_machine - Behavioral
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

entity state_machine is
    Port ( in0         : in STD_LOGIC;
           clk,s,r     : in STD_LOGIC:='0';
           stop        : out std_logic:='0';
           out0        : out STD_LOGIC_vector(11 downto 0):=(others =>'0');
           state_out_i : out std_logic_vector(3 downto 0);
           ssout       : out std_logic:='0';
           run_out     : out std_logic
           );
end state_machine;

architecture Behavioral of state_machine is
signal state:std_logic_vector(3 downto 0):=(others=>'0');
signal run  :std_logic:='0';
begin
process(state,s,in0,run)
begin
run<= ((not state(0))and(not state(1))and (not state(2))and (not state(3)) and s)or in0;
end process;
process(clk,state,run,r)
begin    
    if rising_edge (clk) then
        if r = '1' then
            state <= "0000";
            stop<='0';
            ssout<='0';
            out0<="000000000000";
        else
            case state is 
                when "0000" =>
                    if run='1' then
                        state<="0001";
                        stop<='0'; 
                        ssout<='0';
                        out0<="000000000000";  
                    else
                        state<="0000";
                        ssout<='0';
                    end if;   
                when "0001" => 
                 stop<='0';
                    if run='1'then
                        state<="0010";
                        out0(0)<='1';
                    else
                        state<="0000";
                        out0(0)<='0';
                        stop<='1';
                    end if;   
                when "0010" => 
                    if run='1'then
                        state<="0011";
                        out0(1)<='1';
                    else
                        state<="0000";
                        out0(1)<='0';
                        stop<='1';
                    end if;   
                when "0011" => 
                    if run='1'then
                        state<="0100";
                        out0(2)<='1';
                    else
                        state<="0000";
                        out0(2)<='0';
                        stop<='1';
                    end if;   
                when "0100" => 
                    if run='1'then
                        state<="0101";
                        out0(3)<='1';
                    else
                        state<="0000";
                        out0(3)<='0';
                        stop<='1';
                    end if;   
                when "0101" => 
                    if run='1'then
                        state<="0110";
                        out0(4)<='1';
                    else
                        state<="0000";
                        out0(4)<='0';
                        stop<='1';
                    end if;   
                when "0110" => 
                    if run='1'then
                        state<="0111";
                        out0(5)<='1';
                    else
                        state<="0000";
                        out0(5)<='0';
                        stop<='1';
                    end if;   
                when "0111" =>
                    if run='1'then
                        state<="1000";
                        out0(6)<='1';
                    else
                        state<="0000";
                        out0(6)<='0';
                        stop<='1';
                    end if;   
                when "1000" => 
                    if run='1'then
                        state<="1001";
                        out0(7)<='1';
                    else
                        state<="0000";
                        out0(7)<='0';
                        stop<='1';
                    end if;   
                when "1001" => 
                    if run='1'then
                        state<="1010";
                        out0(8)<='1';
                    else
                        state<="0000";
                        out0(8)<='0';
                        stop<='1';
                    end if;   
                when "1010" => 
                    if run='1'then
                        state<="1011";
                        out0(9)<='1';
                    else
                        state<="0000";
                        out0(9)<='0';
                        stop<='1';
                    end if;   
                when "1011" => 
                    if run='1'then
                        state<="1100";
                        out0(10)<='1';
                    else
                        state<="0000";
                        out0(10)<='0';
                        stop<='1';
                    end if;   
                when "1100" => 
                    if run='1'then
                        state<="1101";
                        out0(11)<='1';
                        ssout<='1';
                    else
                        state<="0000";
                        stop<='1';
                        out0(11)<='0';
                    end if;    
                when others =>
            end case;
        end if;
    end if;
end process;
state_out_i<=state;
run_out  <=run;
end Behavioral;
