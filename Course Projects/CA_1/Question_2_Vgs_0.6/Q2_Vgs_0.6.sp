First line of the netlist must be blank.

*------------------------------------------
*****load library*****

*.lib '45nm_PTM.txt' 45nm
.include '45nm_PTM.txt'

*------------------------------------------
*****define param****** 

.temp 27

*------------------------------------------
*****define new NMOS Model****** 

.model nmos_simple NMOS (LEVEL = 1 + VT0=0.34 KP=210u LAMBDA=0.1 PHI=0.6)

*------------------------------------------


****** Main Code*******
*M(name)	ND	NG	NS	NB	Modelname	W				L
		
M1			vds	vgs	0	0	nmos		W='1u'	L='100n' 
M2			vds	vgs	0	0	nmos_simple		W='1u'	L='100n' 

***********************************************************************

*--------------------------------------------------------------------------
*********************Source Voltages**************
Vgs		vgs		 0 0.6
Vds		vds		0 1

*------------------------------------------------------------------------
*************Type of Analysis********

.op
.DC Vds 0 1 0.01		***.DC Vi start stop step 


.print dc  i(M1) i(M2)

*-------------------------------------------------------------------

.end


