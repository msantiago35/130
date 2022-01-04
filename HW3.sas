** 1;
** a;
proc sort data=data1.military out=military_sorted;
	by State Type City;
run;

** this is for the the output screenshot on the hw
** proc print data=military_sorted;
** run;

** b;
options nodate number pageno=3; 
title1 'US Military';
title3 'Air Force and Army Airports';
footnote1 'Sorted by State, Military, Branch, and City';
proc print data=military_sorted N label;
	var State Type City Airport;
	label State = 'State Abbreviation'
		  Type = 'Military Branch';
	where Type = 'Air Force' or Type = 'Army';
	by State;
	pageby State;
run;
	

** 2;
** a;
data work.CarAccidents;
	infile '/home/u59557716/section/hw/CarAccidents.dat';
	input Reference$ 1-7 Day$ 29-38 Time 40-43 Severity 55 nVehicles 24 VehicleType 62-63;
run;

** this is for the the output screenshot on the hw
** proc print data=work.CarAccidents;
** run;


** b - on the hw pdf;


** c;
proc contents data=work.CarAccidents;
run;

** d;
options nonumber date pageno=120 ls=96;
title1 'Severity of Car Accidents by Vehicle Type';
proc print data=work.CarAccidents noobs;
run;

** 3;
*** a;
data work.CarAccidents2;
	infile '/home/u59557716/section/hw/CarAccidents.dat';
	input @1 Reference $8. @29 Day mmddyy10. @40 Time $4. @51 Weather $1. @24 nVehicles $1. @26 nCasualties $1.;
	format Day mmddyy10.;
run;

** this is for the the output screenshot on the hw
** proc contents data=work.CarAccidents2;
** run;


**b;
options nodate number pageno=1 ls=64;
title1 'Weather related Car Accidents';
proc print data=work.CarAccidents2;
	format Day DATE9.;
	
** 4;
** a;
data home.CarAccidents2 label;
	set work.CarAccidents2;
	label Reference = 'Reference Number'
	  	  Day = 'Date of Incident'
	      Weather = 'Weather Condition'
	  	  nVehicles = 'Number of Vehicles'
	  	  nCasualties ='Number of Casualties';
run;

proc contents data=home.CarAccidents2;
run;

** b;
proc datasets library=work;
	modify CarAccidents2;
	format Day DATE7.;
	label Reference ='Reference ID';
run;


proc contents data=work.CarAccidents2;
run;
