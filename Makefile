sim:
	xrun -sv -f tb_lab1.f +access+rwc

sim_xprop:
	xrun -sv -f tb_lab1.f +access+rwc -xverbose -xprop C
