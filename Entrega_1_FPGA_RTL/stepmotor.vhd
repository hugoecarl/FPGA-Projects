--
-- Rafael C.
-- ref:
--   - https://www.intel.com/content/www/us/en/programmable/quartushelp/13.0/mergedProjects/hdl/vhdl/vhdl_pro_state_machines.htm
--   - https://www.allaboutcircuits.com/technical-articles/implementing-a-finite-state-machine-in-vhdl/
--   - https://www.digikey.com/eewiki/pages/viewpage.action?pageId=4096117

library IEEE;
use IEEE.std_logic_1164.all;

entity stepmotor is
    port (
        -- Gloabals
        clk   : in  std_logic;

        -- controls
        en      : in std_logic;                     -- 1 on/ 0 of
        dir     : in std_logic;
        but     : in std_logic;
		  but1     : in std_logic;  -- 1 clock wise
        vel     : in std_logic_vector(1 downto 0);  -- 00: low / 11: fast

        -- I/Os
        phases  : out std_logic_vector(3 downto 0)
  );--
end entity stepmotor;

architecture rtl of stepmotor is

   TYPE STATE_TYPE IS (s0, s1, s2, s3);
   SIGNAL state  : STATE_TYPE := s0;
   signal enable : std_logic  := '0';
   signal topCounter : integer range 0 to 50000000;
	signal topCounter1 : std_logic  := '0';
	
  
begin
  process(clk)
  variable counter : integer range 0 to 50000000 := 0;
  begin
    if (rising_edge(clk)) then
		CASE state IS
      WHEN s0=>
        if (enable = '1' or topCounter1 = '1') then
			state <= s1;
        end if;
      WHEN s1=>
        if (enable = '1' or topCounter1 = '1') then
			 state <= s2;
        end if;
      WHEN s2=>
        if (enable = '1' or topCounter1 = '1') then
			 state <= s3;
        end if;
      WHEN s3=>
        if (enable = '1' or topCounter1 = '1') then     
			 state <= s0;
        end if;
      when others=>
        state <= s0;
      END CASE;
      
		if (counter < topCounter) then
        counter := counter + 1;
        enable  <= '0';
		  topCounter1 <= '0';
      elsif (en = '1') then
		  counter := 0;
		  enable  <= '1';
		elsif (but = '0') then 
			counter := 0;
			topCounter1 <= '1';
      end if;
	 end if;
  
        if (vel = "00") then 
			topCounter <= 10000000;
		elsif (vel = "01") then	
			topCounter <= 1000000;
		elsif (vel = "10") then	
			topCounter <= 500000;
		elsif (vel = "11") then	
			topCounter <= 100000;
	   end if;
  
  end process;

  PROCESS (state)
   BEGIN
      CASE state IS
        WHEN s0 =>
          if (dir = '0') then
				phases <= "0001";
			  else
			   phases <= "1000";
			 end if;
        WHEN s1 =>
          if (dir = '0') then
			   phases <= "0010";
			 else
			   phases <= "0100";
			 end if;
        WHEN s2 =>
          if (dir = '0') then
			 phases <= "0100";
			 else
			   phases <= "0010";
			 end if;			 
        when s3 =>
          if (dir = '0') then
			   phases <= "1000";
			 else
			   phases <= "0001";
				end if;
        when others =>
          phases <= "0000";
      END CASE;
   END PROCESS;

  
end rtl;
