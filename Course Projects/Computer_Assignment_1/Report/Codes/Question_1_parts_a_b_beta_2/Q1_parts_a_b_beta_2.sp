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

.global vdd

.temp 27

*------------------------------------------

****** Main Code*******
*M(name)	ND	NG	NS	NB	Modelname	W				L
M1			out	in	Vdd	vdd	pmos		W='2.0*Lmin*Beta'	L='1.0*Lmin'		
M2			out	in	0	0	nmos		W='2.0*Lmin'	L='1.0*Lmin' 

***********************************************************************
*X1		in 	xx INV1     ** Instance of Invetter


*--------------------------------------------------------------------------
*********************Source Voltages**************
V1		vdd		 0 vdd
vin		in		0 1

*------------------------------------------------------------------------
*************Type of Analysis********

.op
.DC vin 0.01 1 0.001		***.DC Vi start stop step 

********************************************

.print dc  V(out)

*-------------------------------------------------------------------

.end


