library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;


entity CpldTestT is
end entity CpldTestT;


architecture rtl of CpldTestT is


  component CpldTestE is
    port (
      -- globals
      XcClk_i    : in    std_logic;
      -- avr
      AvrData_io : inout std_logic_vector(13 downto 0);
      AvrSck_i   : in    std_logic;
      AvrMosi_i  : in    std_logic;
      AvrMiso_o  : out   std_logic;
      -- spi flash
      SpfRst_n_o : out   std_logic;
      SpfCs_n_o  : out   std_logic;
      SpfSck_o   : out   std_logic;
      SpfMosi_o  : out   std_logic;
      SpfMiso_i  : in    std_logic;
      -- gpio
      Gpio_io    : inout std_logic_vector(4 downto 0)
    );
  end component CpldTestE;

  signal s_cpld_clk  : std_logic := '0';
  signal s_cpld_gpio : std_logic_vector(4 downto 0);

begin


  s_cpld_clk <= not(s_cpld_clk) after 20 ns;

  i_CpldTestE : CpldTestE
  port map
    (
      -- globals
      XcClk_i    => s_cpld_clk,
      -- avr
      AvrData_io => open,
      AvrSck_i   => '0',
      AvrMosi_i  => '0',
      AvrMiso_o  => open,
      -- spi flash
      SpfRst_n_o => open,
      SpfCs_n_o  => open,
      SpfSck_o   => open,
      SpfMosi_o  => open,
      SpfMiso_i  => '0',
      -- gpio
      Gpio_io    => s_cpld_gpio
    );


end architecture rtl;
