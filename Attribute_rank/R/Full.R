# Making graph
# Full data set's recall and precision vs remove one attribute
No_cc_p <- c(0.9346733668341709,0.9597989949748744,0.9447236180904522,0.9195979899497487,0.9195979899497487)
No_cc_r <- c(0.8985507246376812,0.9408866995073891,0.9353233830845771,0.905940594059406,0.9014778325123153)

No_ha_p <- c(0.9396984924623115,0.9597989949748744,0.949748743718593,0.9195979899497487,0.9246231155778895)
No_ha_r <- c(0.9033816425120773,0.9408866995073891,0.9402985074626866,0.905940594059406,0.9064039408866995)

No_lo_p <- c(0.9246231155778895,0.9748743718592965,0.9246231155778895,0.9195979899497487,0.9045226130653267)
No_lo_r <- c(0.8888888888888888,0.9556650246305419,0.9154228855721394,0.905940594059406,0.8866995073891626)

No_hg_p <- c(0.9547738693467337,0.9396984924623115,0.9547738693467337,0.9195979899497487,0.9246231155778895)
No_hg_r <- c(0.9178743961352657,0.9211822660098522,0.945273631840796,0.905940594059406,0.9064039408866995)

No_hc_p <- c(0.8793969849246231,0.914572864321608,0.8944723618090452,0.9095477386934674,0.8844221105527639)
No_hc_r <- c(0.8454106280193237,0.896551724137931,0.8855721393034826,0.8960396039603961,0.8669950738916257)

c1 <- c(0.9346733668341709,0.9597989949748744,0.949748743718593,0.9195979899497487,0.9195979899497487)
p1 <- c(0.8985507246376812,0.9408866995073891,0.9402985074626866,0.905940594059406,0.9014778325123153)

x <- seq(1,5)

# precision rank
plot(x, c1,ylim = c(0.8,1), type = "o",col = "red", xlab = "Cross Validation", ylab = "Score", 
     main = "Label precision rank")

lines(x, No_cc_p, type = "o", col = "yellow")
lines(x, No_hc_p, type = "o", col = "grey")
lines(x, No_lo_p, type = "o", col = "blue")
lines(x, No_hg_p, type = "o", col = "black")
lines(x, No_ha_p, type = "o", col = "green")

legend("bottomright", legend = c("full","remove_collectioncode","remove_higherClassification",'remove_locality','remove_higherGeography','remove_habitat'), 
       fill=c("red","yellow","grey","blue","black","green"), cex = 0.75)


# recall rank
plot(x, p1,ylim = c(0.8,1), type = "o",col = "red", xlab = "Cross Validation", ylab = "Score", 
     main = "Label recall rank (all didn't cover collectioncode)")

lines(x, No_hc_r, type = "o", col = "grey")
lines(x, No_lo_r, type = "o", col = "blue")
lines(x, No_hg_r, type = "o", col = "black")
lines(x, No_ha_r, type = "o", col = "green")

legend("bottomright", legend = c("full","remove_higherClassification",'remove_locality','remove_higherGeography','remove_habitat'), 
       fill=c("red","grey","blue","black","green"), cex = 0.75)

# T-test
# Full data set's precision t-test
# without No_cc_p
df = data.frame(x,c1,No_cc_p)
t.test(df$c1, df$No_cc_p)

# without No_ha_p
df1 = data.frame(x,c1,No_ha_p)
t.test(df1$c1, df1$No_ha_p)

# without No_lo_p
df2 = data.frame(x,c1,No_lo_p)
t.test(df2$c1, df2$No_lo_p)

# without No_hg_p
df3 = data.frame(x,c1,No_hg_p)
t.test(df3$c1, df3$No_hg_p)

# without No_hc_p
df4 = data.frame(x,c1,No_hc_p)
t.test(df4$c1, df4$No_hc_p)


# Full data set's recall t-test
# without No_cc_r
df = data.frame(x,p1,No_cc_r)
t.test(df$p1, df$No_cc_r)

# without No_ha_r
df1 = data.frame(x,p1,No_ha_r)
t.test(df1$p1, df1$No_ha_r)

# without No_lo_r
df2 = data.frame(x,p1,No_lo_r)
t.test(df2$p1, df2$No_lo_r)

# without No_hg_r
df3 = data.frame(x,p1,No_hg_r)
t.test(df3$p1, df3$No_hg_r)

# without No_hc_r
df4 = data.frame(x,p1,No_hc_r)
t.test(df4$p1, df4$No_hc_r)
