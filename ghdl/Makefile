all: work-obj93.cf

CPU86=..
TOP=..
TIME=1us

work-obj93.cf:
	ghdl -a --ieee=synopsys -fexplicit $(CPU86)/cpu86pack.vhd
	ghdl -a --ieee=synopsys -fexplicit $(CPU86)/cpu86instr.vhd

	ghdl -a --ieee=synopsys -fexplicit $(CPU86)/cpu86_struct.vhd
	ghdl -a --ieee=synopsys -fexplicit $(CPU86)/biu_struct.vhd
	ghdl -a --ieee=synopsys -fexplicit $(CPU86)/biufsm_fsm.vhd
	ghdl -a --ieee=synopsys -fexplicit $(CPU86)/formatter_struct.vhd
	ghdl -a --ieee=synopsys -fexplicit $(CPU86)/a_table.vhd
	ghdl -a --ieee=synopsys -fexplicit $(CPU86)/d_table.vhd
	ghdl -a --ieee=synopsys -fexplicit $(CPU86)/m_table.vhd
	ghdl -a --ieee=synopsys -fexplicit $(CPU86)/n_table.vhd
	ghdl -a --ieee=synopsys -fexplicit $(CPU86)/r_table.vhd
	ghdl -a --ieee=synopsys -fexplicit $(CPU86)/regshiftmux_regshift.vhd
	ghdl -a --ieee=synopsys -fexplicit $(CPU86)/datapath_struct.vhd
	ghdl -a --ieee=synopsys -fexplicit $(CPU86)/alu_rtl.vhd
	ghdl -a --ieee=synopsys -fexplicit $(CPU86)/divider_rtl_ser.vhd
	ghdl -a --ieee=synopsys -fexplicit $(CPU86)/multiplier_rtl.vhd
	ghdl -a --ieee=synopsys -fexplicit $(CPU86)/dataregfile_rtl.vhd
	ghdl -a --ieee=synopsys -fexplicit $(CPU86)/ipregister_rtl.vhd
	ghdl -a --ieee=synopsys -fexplicit $(CPU86)/segregfile_rtl.vhd
	ghdl -a --ieee=synopsys -fexplicit $(CPU86)/proc_rtl.vhd

	ghdl -a --ieee=synopsys -fexplicit $(TOP)/aaatop.vhd
	ghdl -a --ieee=synopsys -fexplicit $(TOP)/aaatop_tb.vhd


	ghdl -e --ieee=synopsys -fexplicit aaatop_tb

	\time ghdl -r --ieee=synopsys -fexplicit aaatop_tb --stop-time=$(TIME) --ieee-asserts=disable --vcd=cpu86.vcd
	\time ghdl -r --ieee=synopsys -fexplicit aaatop_tb --stop-time=$(TIME) --ieee-asserts=disable --fst=cpu86.fst


clean:
	$(RM) work-obj93.cf

clobber: clean
	$(RM) *.fst
	$(RM) *.vcd
