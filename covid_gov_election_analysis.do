clear all 
import delimited /Users/sandaz/cunycorn/election_gov_covid.csv

reg incumbent_vote_margin c.mask_mandate##i.is_gop govenor_approval unemployment_rate, vce(robust)

predict vm_hat_2

graph twoway scatter  incumbent_vote_margin vm_hat_2 , mlabel(state)  || function y = x, ra(incumbent_vote_margin) clpat(dash) mlab(state)

graph twoway scatter  incumbent_vote_margin vm_hat_2 , mlabel(state) legend(off) ytitle("Incumbent Vote Margin Actual") xtitle("Incumbent Vote Margin Predicted") || function y = x, ra(incumbent_vote_margin) clpat(dash) mlab(state)
