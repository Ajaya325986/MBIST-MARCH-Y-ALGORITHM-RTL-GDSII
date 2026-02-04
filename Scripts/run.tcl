
set_db init_lib_search_path /home/install/FOUNDRY/digital/90nm/dig/lib/
     
set_db library  slow.lib
    
read_hdl {./controller1.v}

elaborate

read_sdc ./constraints_top.sdc

syn_generic
syn_map
syn_opt

write_hdl > controller_netlist.v
write_sdc  > controller_tool.sdc
   
gui_show

report_timing > controller_timing.rpt
report_power > controller_power.rpt
report_area > controller_cell.rpt
report_gates > controller_gates.rpt
   
