library ieee;
  use ieee.std_logic_1164.all;
  use ieee.numeric_std.all;


entity CpldTestE is
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
end entity CpldTestE;


architecture rtl of CpldTestE is


begin


  -- test gpio pins
  Gpio_io <= "10101";


end architecture rtl;
