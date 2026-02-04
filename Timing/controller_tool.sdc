# ####################################################################

#  Created by Genus(TM) Synthesis Solution 21.14-s082_1 on Wed Nov 27 12:34:25 IST 2024

# ####################################################################

set sdc_version 2.0

set_units -capacitance 1000fF
set_units -time 1000ps

# Set the current design
current_design controller1

create_clock -name "clk" -period 10.0 -waveform {0.0 5.0} [get_ports clk] 
set_input_delay -clock [get_clocks clk] -add_delay 2.0 [get_ports rst]
set_output_delay -clock [get_clocks clk] -add_delay 1.0 [get_ports {dataout[7]}]
set_output_delay -clock [get_clocks clk] -add_delay 1.0 [get_ports {dataout[6]}]
set_output_delay -clock [get_clocks clk] -add_delay 1.0 [get_ports {dataout[5]}]
set_output_delay -clock [get_clocks clk] -add_delay 1.0 [get_ports {dataout[4]}]
set_output_delay -clock [get_clocks clk] -add_delay 1.0 [get_ports {dataout[3]}]
set_output_delay -clock [get_clocks clk] -add_delay 1.0 [get_ports {dataout[2]}]
set_output_delay -clock [get_clocks clk] -add_delay 1.0 [get_ports {dataout[1]}]
set_output_delay -clock [get_clocks clk] -add_delay 1.0 [get_ports {dataout[0]}]
set_wire_load_mode "enclosed"
