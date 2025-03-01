questa_sim: 
	vlib.exe work 
	vlog.exe -sv -vopt -work work -f filelist.f

	vsim.exe -t 1ps -L work -L altera_mf_ver -L altera_lnsim_ver -voptargs="+acc" tb -do " do wave.do; run -all; "

.PHONY: clean

clean:
	if [ -d "work" ]; then  vdel.exe -lib work -all; fi
	rm -rf trans* vsim*

.PHONY: questa

questa: questa_sim clean
