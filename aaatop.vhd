----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date:    21:10:34 03/08/2017 
-- Design Name: 
-- Module Name:    aaatop - Behavioral 
-- Project Name: 
-- Target Devices: 
-- Tool versions: 
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
-- any Xilinx primitives in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity aaatop is
    Port ( rx : in  STD_LOGIC;
           tx : inout  STD_LOGIC;
           W1A : inout  STD_LOGIC_VECTOR (15 downto 0);
           W1B : inout  STD_LOGIC_VECTOR (15 downto 0);
           W2C : inout  STD_LOGIC_VECTOR (15 downto 0);
           clk : in  STD_LOGIC);
end aaatop;

architecture Behavioral of aaatop is
signal dbus_in  : std_logic_vector (7 DOWNTO 0);
signal dbus_mem  : std_logic_vector (7 DOWNTO 0);
signal intr     : std_logic := '0';
signal nmi      : std_logic := '0';
signal por      : std_logic;
signal abus     : std_logic_vector (19 DOWNTO 0);
signal dbus_out : std_logic_vector (7 DOWNTO 0);
signal cpuerror : std_logic;
--signal inta     : std_logic;
signal iom      : std_logic;
signal rdn      : std_logic;
signal resoutn  : std_logic;
signal wran     : std_logic;
signal wrn     : std_logic;
begin
	tx <= '0';
--	dbus_in <= (others => '0');
--	dbus_in <= x"90";
--	case abus is
--		when x"ffff0" => dbus_in <= x"ff";
--		when x"ffff1" => dbus_in <= x"c0";
--		when others => dbus_in <= x"90";
--	end case;
--	dbus_in <= x"ff" when abus=x"ffff0" else x"c0" when abus=x"ffff1" else x"90";
--	dbus_in <= x"eb" when abus=x"ffff0" else x"fe" when abus=x"ffff1" else x"cc";
	dbus_mem <=
--		x"f7" when abus=x"ffff0" else
--		x"d0" when abus=x"ffff1" else
--		x"e2" when abus=x"ffff0" else
--		x"fe" when abus=x"ffff1" else
--		x"40" when abus=x"ffff0" else
--		x"40" when abus=x"ffff1" else
--		x"eb" when abus=x"ffff2" else
--		x"fc" when abus=x"ffff3" else
		x"6f" when abus=x"0ffff" else		-- don't forget that DS=0 at boot
		x"61" when abus=x"00001" else
		x"4e" when abus=x"ffff0" else
		x"8e" when abus=x"ffff1" else
		x"de" when abus=x"ffff2" else
		x"8e" when abus=x"ffff3" else
		x"c6" when abus=x"ffff4" else
		x"46" when abus=x"ffff5" else
		x"41" when abus=x"ffff6" else
--		x"bf" when abus=x"ffff6" else
--		x"47" when abus=x"ffff7" else
--		x"04" when abus=x"ffff7" else
		x"90" when abus=x"ffff7" else
--		x"f3" when abus=x"ffff8" else	-- => f046
		x"90" when abus=x"ffff8" else
--		x"47" when abus=x"ffff8" else
--		x"00" when abus=x"ffff8" else
--		x"a6" when abus=x"ffff9" else	-- => f046 (PF ZF)
		x"90" when abus=x"ffff9" else
--		x"40" when abus=x"ffffa" else
		x"38" when abus=x"ffffa" else
--		x"40" when abus=x"ffffb" else
		x"c8" when abus=x"ffffb" else
--		x"e8" when abus=x"ffffb" else
		x"eb" when abus=x"ffffc" else
		x"fe" when abus=x"ffffd" else
		x"ff" when abus=x"ffffe" else
		x"ff" when abus=x"fffff" else
		x"cc";
	process(clk)
	begin
		if rising_edge(clk) then
			dbus_in <=x"00";
			if rdn='0' and iom='0' then
				dbus_in <=dbus_mem;
			end if;
		end if;
	end process;
	w1a<=abus(15 downto 0);
	w1b(3 downto 0) <=abus(19 downto 16);
	w1b(4)<='Z';
	por<=w1b(4);
	cpu0: ENTITY work.cpu86
   PORT map( 
      clk      => clk,
      dbus_in  => dbus_in,
      intr     => intr,
      nmi      => nmi,
      por      => por,
      abus     => abus,
      dbus_out => dbus_out,
      cpuerror => cpuerror,
      inta     => open,
      iom      => iom,
      rdn      => rdn,
      resoutn  => resoutn,
      wran     => wran,
      wrn      => wrn
   );

end Behavioral;
