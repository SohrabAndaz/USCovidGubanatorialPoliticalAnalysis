clear all
import delimited /Users/sandaz/cunycorn/gov_covid_data.csv
gen date2 = date(date, "20YMD")
format date2 %td
gen dm = mofd(date2)
format dm %tm
xtset state_code dm

reg govenor_approval mask_mandate restaurant_closed bar_closed unemployment_rate, cl(state_code)
reg govenor_approval mask_mandate restaurant_closed bar_closed unemployment_rate i.date3 i.state_code, cl(state_code)

sepscatter govenor_approval mask_mandate, separate(state_code) leg(c(5))


* Regression with date fixed effects --> don't think you can use this b/c data is not IID
reg govenor_approval mask_mandate restaurant_closed bar_closed unemployment_rate i.date3, cl(state_code)


xtreg govenor_approval mask_mandate restaurant_closed bar_closed unemployment_rate i.date3, cl(state_code) fe

* Panel regression with state fixed effects.. I don't think you can use this b/c temporal autocorrelation in dependent variable
xtreg govenor_approval mask_mandate restaurant_closed bar_closed unemployment_rate, cl(state_code) fe

* Panel regression with lag dependent
xtreg govenor_approval mask_mandate restaurant_closed bar_closed unemployment_rate l.govenor_approval, cl(state_code) fe

* Panel regression with fixed effects for BOTH date and states --> pretty sure this is meaningless
xtreg govenor_approval mask_mandate restaurant_closed bar_closed unemployment_rate i.date3, cl(state_code) fe

* check for unit root
xtunitroot fisher govenor_approval, dfuller lag(0)

* check for serial autocorellation
xtserial govenor_approval mask_mandate

xtcointtest kao govenor_approval mask_mandate, lag(1) 

* Adding interaction term with is_gop
xtreg govenor_approval c.mask_mandate##i.is_gop restaurant_closed bar_closed unemployment_rate l.govenor_approval, cl(state_code) fe

xtreg govenor_approval c.mask_mandate##i.is_gop restaurant_closed bar_closed unemployment_rate l.govenor_approval l2.govenor_approval, cl(state_code) fe

