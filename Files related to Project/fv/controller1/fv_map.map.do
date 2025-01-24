
//input ports
add mapped point clk clk -type PI PI
add mapped point rst rst -type PI PI

//output ports
add mapped point status status -type PO PO
add mapped point dataout[7] dataout[7] -type PO PO
add mapped point dataout[6] dataout[6] -type PO PO
add mapped point dataout[5] dataout[5] -type PO PO
add mapped point dataout[4] dataout[4] -type PO PO
add mapped point dataout[3] dataout[3] -type PO PO
add mapped point dataout[2] dataout[2] -type PO PO
add mapped point dataout[1] dataout[1] -type PO PO
add mapped point dataout[0] dataout[0] -type PO PO

//inout ports




//Sequential Pins
add mapped point status/q status_reg168/Q -type DLAT DLAT
add mapped point count[4]/q count_reg[4]/Q -type DFF DFF
add mapped point count[3]/q count_reg[3]/Q -type DFF DFF
add mapped point CA[3]/q CA_reg[3]/Q -type DFF DFF
add mapped point CA[1]/q CA_reg[1]/Q -type DFF DFF
add mapped point CA[2]/q CA_reg[2]/Q -type DFF DFF
add mapped point CA[0]/q CA_reg[0]/Q -type DFF DFF
add mapped point orig[1]/q orig_reg[1]/Q -type DFF DFF
add mapped point orig[4]/q orig_reg[4]/Q -type DFF DFF
add mapped point orig[3]/q orig_reg[3]/Q -type DFF DFF
add mapped point orig[0]/q orig_reg[0]/Q -type DFF DFF
add mapped point orig[2]/q orig_reg[2]/Q -type DFF DFF
add mapped point count[2]/q count_reg[2]/Q -type DFF DFF
add mapped point count[0]/q count_reg[0]/Q -type DFF DFF
add mapped point count[1]/q count_reg[1]/Q -type DFF DFF
add mapped point orig[5]/q orig_reg[5]/Q -type DFF DFF
add mapped point orig[7]/q orig_reg[7]/Q -type DFF DFF
add mapped point orig[6]/q orig_reg[6]/Q -type DFF DFF
add mapped point nextstate[1]/q nextstate_reg[1]/Q -type DFF DFF
add mapped point element_done/q element_done_reg/Q -type DFF DFF
add mapped point nextstate[0]/q nextstate_reg[0]/Q -type DFF DFF
add mapped point re/q re_reg/Q -type DFF DFF
add mapped point we/q we_reg/Q -type DFF DFF
add mapped point datain[0]/q datain_reg[0]/Q -type DFF DFF
add mapped point Test/q Test_reg/Q -type DFF DFF
add mapped point element_operation[2]/q element_operation_reg[2]/Q -type DFF DFF
add mapped point element_operation[0]/q element_operation_reg[0]/Q -type DFF DFF
add mapped point element_operation[1]/q element_operation_reg[1]/Q -type DFF DFF
add mapped point fresh_state/q fresh_state_reg/Q -type DFF DFF



//Black Boxes
add mapped point u u -type BBOX BBOX



//Empty Modules as Blackboxes
