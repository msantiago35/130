proc print data=hw.heart;
run;

proc contents data=hw.heart;
run;


*** 1;
** a;
proc means data=hw.heart;
run;

** d;
proc means data=hw.heart min median max maxdec=2;
	var Age RestingBP Cholesterol MaxHR;
	by ChestPainType;
run;

** e;
proc means data=hw.heart min median max maxdec=2;
	var Age RestingBP Cholesterol MaxHR;
	class ChestPainType;
run;


*** 2;
** a;
proc freq data=hw.heart;
run;

** b;
proc format;
	value Agefmt
		20-29 = 'Twenties'
 		30-39 = 'Thirties'
		40-49 = 'Forties'
		50-59 = 'Fifties'
		60-69 = 'Sixties'
		70-79 = 'Seventies';
run;

proc freq data=hw.heart;
	format Age Agefmt.;
run;

** c;

proc freq data=hw.heart;
	format Age Agefmt.;
	tables Age ChestPainType;
run;

** d;
proc freq data=hw.heart;
	format Age Agefmt.;
	tables Age * ChestPainType;
run;

** e;
proc format;
	value $CPTfmt
		'asy'='ASY'
		'TA'='ATA'
		'nap'='NAP';
		
run;

proc freq data=hw.heart;
	format Age Agefmt.;
	format ChestPainType $CPTfmt.;
	tables Age * ChestPainType;
run;


*** 3;
** a;
data heart1;
	set hw.heart;
	if Cholesterol=0 then Cholesterol=.;
	if Age=0 then Age=.;
run;

proc print data=heart1;
run;

** b;
*need two table statements since they are both one-way;

proc tabulate data=heart1;
	class ChestPainType Age;
	var Cholesterol;
	table  ChestPainType; 
	table Age*Cholesterol*median;
	format Age Agefmt. ChestPainType $CPTfmt.;
run;

** c;
proc format;
	value Cholesterolfmt
		low-<200 = 'Good'
		200-239 = 'Borderline'
		240-high = 'High';
run;

proc print data=heart1;
	format Cholesterol Cholesterolfmt.;
run;

** d;
proc tabulate data=heart1;
	class Age Cholesterol;
	table Age all, 
		  Cholesterol all;
	format Cholesterol Cholesterolfmt. Age Agefmt.;
run;

** g;
proc tabulate data=heart1;
	class Age Cholesterol;
	var MaxHR;
	table Age, Cholesterol*MaxHR*mean;
	format Cholesterol Cholesterolfmt. Age Agefmt.;
run;


*** 4;
** a;
ods listing file='/home/u59557716/section/heart1.lst';
proc report data=heart1;
	column ChestPainType Age MaxHR;
	format ChestPainType $CPTfmt. Age Agefmt. Cholesterol Cholesterolfmt.;
run;	
ods listing close;

** b;
ods listing file='/home/u59557716/section/heart2.lst';
options nodate pageno=3;
proc report data=heart1 headskip;
	title 'Average Max Heart Rate by Chest Pain Type and Age Group';
	column ChestPainType Age MaxHR;
	define Age / group;
	define ChestPainType / group width=5 'Chest Pain Type';
	format ChestPainType $CPTfmt. Age Agefmt. Cholesterol Cholesterolfmt.;
	define MaxHR / width=5 'Max Heart Rate' mean format=3.;
	break after ChestPainType / summarize ol ul;
	rbreak after /summarize dol;
run;	
ods listing close;
	