# Making graph
# Full data set's (except collectionCode and habitat) recall and precision vs remove one attribute
No_lo_p <- c(0.914572864321608,0.9597989949748744,0.9396984924623115,0.9396984924623115,0.9045226130653267)
No_lo_r <- c(0.8792270531400966,0.9408866995073891,0.9303482587064676,0.9257425742574258,0.8866995073891626)

No_hc_p <- c(0.7688442211055276,0.7487437185929648,0.7185929648241206,0.7688442211055276,0.7135678391959799)
No_hc_r <- c(0.7391304347826086,0.7339901477832512,0.7114427860696517,0.7574257425742574,0.6995073891625616)

c1 <- c(0.949748743718593,0.9447236180904522,0.9547738693467337,0.9195979899497487,0.9346733668341709)
p1 <- c(0.9130434782608695,0.9261083743842364,0.945273631840796,0.905940594059406,0.916256157635468)

x <- seq(1,5)

# precision rank
plot(x, c1,ylim = c(0.8,1), type = "o",col = "red", xlab = "Cross Validation", ylab = "Score", 
     main = "Label precision rank (all didn't cover collectioncode and habitat and higherGeography)")

lines(x, No_hc_p, type = "o", col = "grey")
lines(x, No_lo_p, type = "o", col = "blue")

legend("bottomright", legend = c("full","remove_higherClassification",'remove_locality'), 
       fill=c("red","grey","blue"), cex = 0.75)


# recall rank
plot(x, p1,ylim = c(0.8,1), type = "o",col = "red", xlab = "Cross Validation", ylab = "Score", 
     main = "Label recall rank (all didn't cover collectioncode and habitat and higherGeography)")

lines(x, No_hc_r, type = "o", col = "grey")
lines(x, No_lo_r, type = "o", col = "blue")

legend("bottomright", legend = c("full","remove_higherClassification",'remove_locality'), 
       fill=c("red","grey","blue"), cex = 0.75)

# T-test
# Full data set's precision t-test

# without No_lo_p
df2 = data.frame(x,c1,No_lo_p)
t.test(df2$c1, df2$No_lo_p)

# without No_hc_p
df4 = data.frame(x,c1,No_hc_p)
t.test(df4$c1, df4$No_hc_p)


# Full data set's recall t-test

# without No_lo_r
df2 = data.frame(x,c1,No_lo_r)
t.test(df2$c1, df2$No_lo_r)

# without No_hc_r
df4 = data.frame(x,c1,No_hc_r)
t.test(df4$c1, df4$No_hc_r)
