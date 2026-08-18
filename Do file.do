//VERSION: PWT 11.0; Feenstra, Inklaar, and Timmer (2015)//

drop if year <= 1979
keep if countrycode == "CHN"
keep countrycode country year cgdpo rgdpna pop hc cn rnna ctfp rtfpna
gen y = rgdpna/pop
gen k = rnna/pop

*********************************************
//GRAPH 1: PER-CAPITA GDP GROWTH RATE, ICOR//
*********************************************

gen gy = (y[_n]/y[_n-1]) - 1
gen gy_percent = gy*100
lowess gy_percent year, gen(lwsgy_percent) nograph

gen deltay = (y[_n]-y[_n-1])
gen deltak = (k[_n]-k[_n-1])
gen icor_inc = deltak/deltay
lowess icor_inc year, gen(lwsicor) nograph

twoway (line lwsgy_percent year, yaxis(1) lcolor(dkgreen) lwidth(medium)) (line lwsicor year, yaxis(2) lcolor(cranberry) lwidth(medium)), ylabel(0(2)12, axis(1) nogrid) ylabel(0(2)12, axis(2) nogrid) ytitle("Per-Capita GDP Growth Rate (%)", axis(1)) ytitle("Incremental Capital-Output Ratio (ICOR)", axis(2)) xlabel(1980(5)2020, nogrid) xtitle("Year") legend(off) plotregion(style(none)) graphregion(color(white)) 


****************************
//GRAPH 2: TFP GROWTH RATE//
****************************

gen gtfp = (rtfpna[_n]/rtfpna[_n-1]) - 1
gen gtfp_percent = gtfp*100
lowess gtfp_percent year, gen(lwsgtfp_percent) nograph

twoway (line lwsgtfp_percent year, yaxis(1) lcolor(purple) lwidth(medium)) (scatter gtfp_percent year, yaxis(1) mcolor(purple%20) msymbol(circle_hollow)), yline(0, lcolor(black) lpattern(dash) lwidth(thin) axis(1)) ylabel(-2(2)12, axis(1) nogrid) ytitle("Total Factor Productivity (TFP) Growth Rate (%)", axis(1)) xlabel(1980(5)2020, nogrid) xtitle("Year") legend(off) plotregion(style(none)) graphregion(color(white))


*****************************
//GRAPH 3: BANKRUPTCY CASES//
*****************************

gen bankruptcy = 0
replace bankruptcy = 32000 in 46
replace bankruptcy = 30000 in 45
replace bankruptcy = 29000 in 44
replace bankruptcy = 47000 in 43
replace bankruptcy = 13000 in 42
replace bankruptcy = 10132 in 41 
replace bankruptcy = 0 in 40
replace bankruptcy = 0 in 39
replace bankruptcy = 9100 in 38
replace bankruptcy = 5500 in 37
replace bankruptcy = 3500 in 36
replace bankruptcy = 1900 in 35
replace bankruptcy = 1800 in 34
replace bankruptcy = 1500 in 33
replace bankruptcy = 1800 in 32 //Starting year is 2011. Data from the annual work reports (2021-2026) of the Supreme People's Court of China, and INSOL International (2018).

twoway (bar bankruptcy year if year >=2011, yaxis(1) color(navy) barwidth(1)), ylabel(0(10000)50000, axis(1) nogrid) ytitle("Number of (Concluded) Bankruptcy Cases", axis(1)) xlabel(2011(2)2025, nogrid) xscale(range(2011 2025)) xtitle("Year") legend(off) plotregion(style(none)) graphregion(color(white))


*************************
//MISCELLANEOUS REMARKS//
*************************

//Graphs generated from code do not match the designs of those in the actual article; Claude was used solely to alter the graph designs using ChinaTalk's color scheme.

