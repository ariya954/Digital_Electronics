First line of the netlist must be blank.

*------------------------------------------
*****load library*****

*.lib '45nm_PTM.txt' 45nm
.include '45nm_PTM.txt'

*------------------------------------------
*****define param******
.param Lmin=45nm
.param Beta=2
+vdd=1V
+cx=20fF

.global vdd

.temp 27

*------------------------------------------

****** Main Code*******
*M(name)	ND	NG	NS	NB	Modelname	W				L
M1			out	in	Vdd	vdd	pmos		W='2.0*Lmin*Beta'	L='1.0*Lmin'		
M2			out	in	0	0	nmos		W='2.0*Lmin'	L='1.0*Lmin' 

***********************************************************************
*X1		in 	xx INV1     ** Instance of Invetter

cl		out	0	cx       ** Capacitance of output 
*--------------------------------------------------------------------------
*********************Source Voltages**************
V1		vdd		 0 vdd
vin		in		0	pulse	0	vdd		0n	10p	10p		20n		100n ***tran

*------------------------------------------------------------------------
*************Type of Analysis********

.op
.tran 0.1ns 200ns 			***.TRAN start stop (step)

********************************************

.probe tran i(m1)
.print tran V(out)

*-------------------------------------------------------------------



*******************Measurements*************************************

.MEASURE TRAN t_rise
+ trig V(out) val = '0.1*vdd'  rise = 1
+ targ V(out) val = '0.9*vdd'  rise = 1

.MEASURE TRAN t_fall
+ trig V(out) val = '0.9*vdd'  fall = 1
+ targ V(out) val = '0.1*vdd'  fall = 1

.end


