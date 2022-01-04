** 1;
proc import datafile='/home/u59557716/section/hw/avengers.xlsx'
			out = work.avengers
			dbms = xlsx;
	sheet='Characters';
	getnames=yes;
run;

options date pageno=10;
proc print data=avengers;
run;

proc contents data=avengers;
run;

** 2a;
data avengers2;
	set avengers (keep=Name Appearances AvengersIntro Sex);
	YearIntro = year(AvengersIntro); 
	Days = intck('days',AvengersIntro, mdy(10,01,2021));
	Years = Days/365.25;
	format Gender $6.;
	format Years 5.2;
	if missing(AvengersIntro) then YearIntro = 1963;
	if missing(AvengersIntro) then Days = 1339;
	if Sex=0 then Gender = 'Male';
	else Gender = 'Female';
run;
proc print; run;
 
** check 09/01/1963 date for 2a;
** use date = mdy(09/01/1963);

 
** 2b;
title1 'Avenger Character History';
proc print data=avengers2 label;
	var Name Gender Appearances AvengersIntro YearIntro Years;
	format AvengersIntro mmddyy8.;
	format Appearances comma6.;
	label Name = 'Character Name'
		  Appearances = 'Number of Appearance'
		  AvengersIntro = 'Date Introduced'
		  YearIntro = 'Year Introduced'
		  Years = 'Years Since Introduction';

run;


** 2e; 
data CharPopularity;
	set avengers2 (keep = Name AvengersIntro Appearances);
 	format AvengersIntro DATE9.;
 	format Appearances comma6.;
 	format Popularity $6.;
 	if Appearances < 100 then Popularity = 'low';
 	if Appearances >= 1000 then Popularity = 'High';
 	if Appearances >= 100 and Appearances < 1000 then Popularity = 'Medium';
 run;
 

** 2f;
proc sort data=CharPopularity;
	by Popularity;
run;

title1 "Who's the Favorite Avenger"; 
proc print data=CharPopularity label N; 
	var Name AvengersIntro;
	by Popularity;
	id Popularity;
	pageby Popularity;
	label Name = 'Character Name'
		  AvengersIntro = 'Date Introduced';
run;
	
 