libname home "/home/u59557716"



proc print data = data1.chicago label noobs;
	var Date Flight Boarded Transfer;
	label Date = "Departure Date"
			Flight = "Flight Number"
				Boarded = "Passengers Boarded"
					Transfer = "Passengers Transferred";
	sum Boarded;
	run;
	
				


data tech_co label;
	input company$ yr_founded ceo$ revenue_2020;
	label company = "Company"
			yr_founded = "Year Founded"
				ceo = "Chief Executive Officer"
					revenue_2020 = "2020 Revenue (billions USD)";
	datalines;
	Amazon 1994 Jassy 386.1 
	Apple 1976 Cook 274.5 
	Google 1998 Pichai 181.7 
	Microsoft 1975 Nadella 143 
	Netflix 1997 Hastings 25
	;
	run;
proc print data=tech_co label noobs;
run;	


