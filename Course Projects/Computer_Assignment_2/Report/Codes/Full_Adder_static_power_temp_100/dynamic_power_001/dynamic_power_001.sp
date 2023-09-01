First line of the netlist must be blank.

*------------------------------------------
*****load library*****

*.lib 'mm018.l' 180nm
.lib 'mm018.l' TT

*------------------------------------------
*****define param******
.param Lmin=180nm
.param Wmin=220nm
+vdd=1.8V

.global vdd

.temp 100

*------------------------------------------
****** SUB_CIRCUIT inverter*******

.SUBCKT INVERTER VDD OUT IN
Mn OUT IN 0   0    nmos    W='Wmin'     L='1.0*Lmin'
Mp OUT IN VDD VDD  pmos    W='2.0*Wmin' L='1.0*Lmin'

.ENDS INVERTER*-----------------------------

****** Main Code*******

*M(name)	ND	NG	NS	NB	Modelname	W				L
M_P11			Drain_P_11	B	vdd	vdd	pmos		W='6.0*Wmin'	L='1.0*Lmin'
M_P12			Drain_P_12	A	vdd	vdd	pmos		W='6.0*Wmin'	L='1.0*Lmin'
M_P13			Drain_P_13	Cin	vdd	vdd	pmos		W='6.0*Wmin'	L='1.0*Lmin'
M_P14			Drain_P_14	Cout_bar	Vdd	vdd	pmos		W='6.0*Wmin'	L='1.0*Lmin'


M_P1			Drain_P_12	A	Drain_P_11	vdd	pmos		W='6.0*Wmin'	L='1.0*Lmin'
M_P2			Drain_P_14	A	Drain_P_13	vdd	pmos		W='6.0*Wmin'	L='1.0*Lmin'


M_P21			Cout_bar	Cin	Drain_P_11	vdd	pmos		W='6.0*Wmin'	L='1.0*Lmin'
M_P22			Cout_bar	B	Drain_P_12	vdd	pmos		W='6.0*Wmin'	L='1.0*Lmin'
M_P23			Sum_bar	Cout_bar	Drain_P_13	vdd	pmos		W='6.0*Wmin'	L='1.0*Lmin'
M_P24			Sum_bar	B	Drain_P_14	vdd	pmos		W='6.0*Wmin'	L='1.0*Lmin'


M_N11			Drain_N_11	B	0	0	nmos		W='2.0*Wmin'	L='1.0*Lmin'
M_N12			Drain_N_12	A	0	0	nmos		W='2.0*Wmin'	L='1.0*Lmin'
M_N13			Drain_N_13	Cin	0	0	nmos		W='2.0*Wmin'	L='1.0*Lmin'
M_N14			Drain_N_14	Cout_bar	0	0	nmos		W='2.0*Wmin'	L='1.0*Lmin'


M_N1			Drain_N_12	A	Drain_N_11	0	nmos		W='2.0*Wmin'	L='1.0*Lmin'
M_N2			Drain_N_14	A	Drain_N_13	0	nmos		W='2.0*Wmin'	L='1.0*Lmin'


M_N21			Cout_bar	Cin	Drain_N_11	0	nmos		W='2.0*Wmin'	L='1.0*Lmin'
M_N22			Cout_bar	B	Drain_N_12	0	nmos		W='2.0*Wmin'	L='1.0*Lmin'
M_N23			Sum_bar	Cout_bar	Drain_N_13	0	nmos		W='2.0*Wmin'	L='1.0*Lmin'
M_N24			Sum_bar	B	Drain_N_14	0	nmos		W='2.0*Wmin'	L='1.0*Lmin'

X_Cout	vdd   Cout	Cout_bar  INVERTER     ** Instance of Inverter
X_Sum		vdd   Sum	Sum_bar   INVERTER     ** Instance of Inverter 
 
*------------------------------------------------------------------------

*********************Source Voltages**************
V1		vdd		 0     1.8
Vina  	A   	 	 GND   0
Vinb  	B  		 GND   0
Vinc 		Cin	 	 GND   vdd


*************Type of Analysis********

.op
.tran 10p 170n 			***.TRAN start stop (step)
.measure tran pow AVG power from=1ns to=170ns

********************************************

.print tran V(Sum) V(Cout) V(A) V(B) V(Cin)

*-------------------------------------------------------------------


.end
