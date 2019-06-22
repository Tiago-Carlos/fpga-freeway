library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
 
entity divfreq is
    Port (
        input_clk: in  STD_LOGIC;
        nrst  : in  STD_LOGIC;
        output_clk1 : out STD_LOGIC;
        output_clk2 : out STD_LOGIC
    );
end divfreq;
 
architecture Behavioral of divfreq is
    signal temporal: STD_LOGIC;
    signal temporal2: STD_LOGIC;
    signal counter: integer range 0 to 83894 := 0;
    signal counter2: integer range 0 to 838942 := 0;
begin
    divf1: process (nrst, input_clk) begin
        if (nrst = '0') then
            temporal <= '0';
            counter <= 0;
        elsif rising_edge(input_clk) then
            if (counter = 83894) then
                temporal <= NOT(temporal);
                counter <= 0;
            else
                counter <= counter+1;
            end if;
        end if;
    end process;
     
        divf2: process (nrst, input_clk) begin
        if (nrst = '0') then
            temporal2 <= '0';
            counter2 <= 0;
        elsif rising_edge(input_clk) then
            if (counter2 = 32000) then
                temporal2 <= NOT(temporal2);
                counter2 <= 0;
            else
                counter2 <= counter2+1;
            end if;
        end if;
    end process; 
     
    output_clk1 <= temporal;
    output_clk2 <= temporal2;
end Behavioral;