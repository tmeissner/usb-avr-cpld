set signals [list]
lappend signals "top.cpldtestt.s_cpld_clk"
lappend signals "top.cpldtestt.s_cpld_gpio"
set num_added [ gtkwave::addSignalsFromList $signals ]
