First line of the netlist must be blank.

*------------------------------------------
*****load library*****

*.lib '32nm_bulk.pm' 32nm
.include '32nm_bulk.pm'


*------------------------------------------
*****define param******
.param Lmin=32nm
.param Wmin=220nm
+vdd=1V

.global vdd

*------------------------------------------
****** SUB_CIRCUIT inverter*******

.SUBCKT INVERTER VDD OUT IN
Mn OUT IN 0   0    nmos    W='Wmin'     L='1.0*Lmin'
Mp OUT IN VDD VDD  pmos    W='2.0*Wmin' L='1.0*Lmin'

.ENDS INVERTER*-----------------------------

****** Main Code*******

*M(name)	ND	NG	NS	NB	Modelname	W				L
M_P_1 			out	A	B	vdd	pmos		W='2.0*Wmin'	L='1.0*Lmin'

M_N_1 			out	A     B_bar	0	nmos		W='Wmin'	L='1.0*Lmin'

M_P_2 			out	B	A	vdd	pmos		W='2.0*Wmin'	L='1.0*Lmin'

M_N_2 			out	B_bar A	0	nmos		W='Wmin'	L='1.0*Lmin'


X_B   	vdd   B_bar	    B   INVERTER     ** Instance of Inverter
 
*------------------------------------------------------------------------

*********************Source Voltages**************
V1		vdd		 0     1

*************Type of Analysis********

.op
.tran 10p 170n 			***.TRAN start stop (step)
.measure tran pow AVG power from=1ns to=170ns

.param t=10p

Vina A 0 PWL 0n 0, '15n-t' 0, 15n vdd, '35n-t' vdd, 35n 0, '50n-t' 0, 50n vdd, '52.5n-t' vdd, 52.5n 0, '55n-t' 0, 55n vdd, 
+ '57.5n-t' vdd, 57.5n 0, '60n-t' 0, 60n vdd, '62.5n-t' vdd, 62.5n 0, '65n-t' 0, 65n vdd, '67.5n-t' vdd, 67.5n 0,  
+ '80n-t' 0, 80n vdd, '100n-t' vdd, 100n 0, '102.5n-t' 0, 102.5n vdd, '105n-t' vdd, 105n 0, '107.5n-t' 0, 107.5n vdd, 
+ '110n-t' vdd, 110n 0, '112.5n-t' 0, 112.5n vdd, '115n-t' vdd, 115n 0, '117.5n-t' 0, 117.5n vdd, '125n-t' vdd, 125n 0,
+ '127.5n-t' 0, 127.5n vdd, '130n-t' vdd, 130n 0, '132.5n-t' 0, 132.5n vdd, '135n-t' vdd, 135n 0, '137.5n-t' 0, 137.5n vdd, 
+ '140n-t' vdd, 140n 0, '142.5n-t' 0, 142.5n vdd, '145n-t' vdd, 145n 0, '147.5n-t' 0, 147.5n vdd, '150n-t' vdd, 150n 0,
+ '152.5n-t' 0, 152.5n vdd, '155n-t' vdd, 155n 0, 162.5n 0


Vinb B 0 PWL 0n 0, '7.5n-t' 0, 7.5n vdd, '12.5n-t' vdd, 12.5n 0, '20n-t' 0, 20n vdd, '32.5n-t' vdd, 32.5n 0, '37.5n-t' 0, 37.5n vdd, 
+ '47.5n-t' vdd, 47.5n 0, '50n-t' 0, 50n vdd, '52.5n-t' vdd, 52.5n 0, '55n-t' 0, 55n vdd, '57.5n-t' vdd, 57.5n 0, 
+ '62.5n-t' 0, 62.5n vdd,
+ '87.5n-t' vdd, 87.5n 0, '97.5n-t' 0, 97.5n vdd, '112.5n-t' vdd, 112.5n 0, '120n-t' 0, 120n vdd, '122.5n-t' vdd, 122.5n 0, 
+ '125n-t' 0, 125n vdd, '127.5n-t' vdd, 127.5n 0, '135n-t' 0, 135n vdd, '137.5n-t' vdd, 137.5n 0, '140n-t' 0, 140n vdd, 
+ '142.5n-t' vdd, 142.5n 0, '147.5n-t' 0, 147.5n vdd, '150n-t' vdd, 150n 0, '152.5n-t' 0, 152.5n vdd, 162.5n vdd


********************************************

.print tran V(out) V(A) V(B)

*-------------------------------------------------------------------

.end
