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
+ '62.5n-t' 0, 62.5n vdd, '65n-t' vdd, 65n 0, '72.5n-t' 0, 72.5n vdd, '75n-t' vdd, 75n 0, '77.5n-t' 0, 77.5n vdd, 
+ '87.5n-t' vdd, 87.5n 0, '97.5n-t' 0, 97.5n vdd, '112.5n-t' vdd, 112.5n 0, '120n-t' 0, 120n vdd, '122.5n-t' vdd, 122.5n 0, 
+ '125n-t' 0, 125n vdd, '127.5n-t' vdd, 127.5n 0, '135n-t' 0, 135n vdd, '137.5n-t' vdd, 137.5n 0, '140n-t' 0, 140n vdd, 
+ '142.5n-t' vdd, 142.5n 0, '147.5n-t' 0, 147.5n vdd, '150n-t' vdd, 150n 0, '152.5n-t' 0, 152.5n vdd, 162.5n vdd


Vinc Cin 0 PWL 0n 0, '2.5n-t' 0, 2.5n vdd, '5n-t' vdd, 5n 0, '25n-t' 0, 25n vdd, '30n-t' vdd, 30n 0, '37.5n-t' 0, 37.5n vdd, 
+ '42.5n-t' vdd, 42.5n 0, '45n-t' 0, 45n vdd, '47.5n-t' vdd, 47.5n 0, '55n-t' 0, 55n vdd, '62.5n-t' vdd, 62.5n 0, 
+ '67.5n-t' 0, 67.5n vdd, '72.5n-t' vdd, 72.5n 0, '75n-t' 0, 75n vdd, '87.5n-t' vdd, 87.5n 0, '90n-t' 0, 90n vdd, 
+ '95n-t' vdd, 95n 0, '97.5n-t' 0, 97.5n vdd, '102.5n-t' vdd, 102.5n 0, '107.5n-t' 0, 107.5n vdd, '110n-t' vdd, 110n 0, 
+ '112.5n-t' 0, 112.5n vdd, '115n-t' vdd, 115n 0, '117.5n-t' 0, 117.5n vdd, '120n-t' vdd, 120n 0, '122.5n-t' 0, 122.5n vdd, 
+ '127.5n-t' vdd, 127.5n 0, '130n-t' 0, 130n vdd, '132.5n-t' vdd, 132.5n 0, '140n-t' 0, 140n vdd, '147.5n-t' vdd, 147.5n 0, 
+ '150n-t' 0, 150n vdd, '155n-t' vdd, 155n 0, 157.5n 0


********************************************

.print tran V(Sum) V(Cout) V(A) V(B) V(Cin)

*-------------------------------------------------------------------


.end

