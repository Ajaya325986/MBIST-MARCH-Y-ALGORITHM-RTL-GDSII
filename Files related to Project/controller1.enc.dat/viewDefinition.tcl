if {![namespace exists ::IMEX]} { namespace eval ::IMEX {} }
set ::IMEX::dataVar [file dirname [file normalize [info script]]]
set ::IMEX::libVar ${::IMEX::dataVar}/libs

create_library_set -name slow\
   -timing\
    [list ${::IMEX::libVar}/mmmc/slow.lib]
create_library_set -name Fast\
   -timing\
    [list ${::IMEX::libVar}/mmmc/fast.lib]
create_rc_corner -name RC\
   -cap_table ${::IMEX::libVar}/mmmc/gpdk090.lef.extended.CapTbl\
   -preRoute_res 1\
   -postRoute_res 1\
   -preRoute_cap 1\
   -postRoute_cap 1\
   -postRoute_xcap 1\
   -preRoute_clkres 0\
   -preRoute_clkcap 0\
   -qx_tech_file ${::IMEX::libVar}/mmmc/RC/gpdk090_9l.tch
create_delay_corner -name Max\
   -library_set slow\
   -rc_corner RC
create_delay_corner -name Min\
   -library_set Fast\
   -rc_corner RC
create_constraint_mode -name Genus_gen_Constraint\
   -sdc_files\
    [list /dev/null]
create_analysis_view -name WC -constraint_mode Genus_gen_Constraint -delay_corner Max
create_analysis_view -name BC -constraint_mode Genus_gen_Constraint -delay_corner Min
set_analysis_view -setup [list WC] -hold [list BC]
