create_clock -period 20.000 -name sys_clk_pin -waveform {0.000 10.000} [get_ports clk]
set_property PACKAGE_PIN N18 [get_ports clk]
set_property IOSTANDARD LVCMOS33 [get_ports clk]

set_property PACKAGE_PIN P16 [get_ports btn_2]
set_property IOSTANDARD LVCMOS33 [get_ports btn_2]

set_property PACKAGE_PIN T12 [get_ports btn_1]
set_property IOSTANDARD LVCMOS33 [get_ports btn_1]

set_property PACKAGE_PIN P15 [get_ports led_1]
set_property IOSTANDARD LVCMOS33 [get_ports led_1]

set_property PACKAGE_PIN U12 [get_ports led_2]
set_property IOSTANDARD LVCMOS33 [get_ports led_2]