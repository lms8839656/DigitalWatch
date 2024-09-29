transcript on
if {[file exists rtl_work]} {
	vdel -lib rtl_work -all
}
vlib rtl_work
vmap work rtl_work

vlog -vlog01compat -work work +incdir+C:/quartus/project/project_watch {C:/quartus/project/project_watch/modn_cnt.v}
vlog -vlog01compat -work work +incdir+C:/quartus/project/project_watch {C:/quartus/project/project_watch/mod60.v}
vlog -vlog01compat -work work +incdir+C:/quartus/project/project_watch {C:/quartus/project/project_watch/seghex.v}
vlog -vlog01compat -work work +incdir+C:/quartus/project/project_watch {C:/quartus/project/project_watch/watch.v}

vlog -vlog01compat -work work +incdir+C:/quartus/project/project_watch {C:/quartus/project/project_watch/tb_watch.v}

vsim -t 1ps -L altera_ver -L lpm_ver -L sgate_ver -L altera_mf_ver -L altera_lnsim_ver -L cycloneive_ver -L rtl_work -L work -voptargs="+acc"  tb_watch

add wave *
view structure
view signals
run -all
