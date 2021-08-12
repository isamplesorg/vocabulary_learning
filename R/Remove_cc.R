# Making graph
# Full data set's recall and precision vs remove one attribute
No_ha_p <- c(0.9346733668341709,0.9597989949748744,0.9447236180904522,0.9195979899497487,0.9195979899497487)
No_ha_r <- c(0.8985507246376812,0.9408866995073891,0.9353233830845771,0.905940594059406,0.9014778325123153)

No_lo_p <- c(0.9296482412060302,0.9748743718592965,0.9246231155778895,0.9195979899497487,0.8994974874371859)
No_lo_r <- c(0.893719806763285,0.9556650246305419,0.9154228855721394,0.905940594059406,0.8817733990147784)
  
No_hg_p <- c(0.9597989949748744,0.9447236180904522,0.9547738693467337,0.914572864321608,0.9346733668341709)
No_hg_r <- c(0.9227053140096618,0.9261083743842364,0.945273631840796,0.900990099009901,0.916256157635468)

No_hc_p <- c(0.8391959798994975,0.8793969849246231,0.8743718592964824,0.8743718592964824,0.8341708542713567)
No_hc_r <- c(0.8067632850241546,0.8620689655172413,0.8656716417910447,0.8613861386138614,0.8177339901477833)

c1 <- c(0.9346733668341709,0.9597989949748744,0.9447236180904522,0.9195979899497487,0.9195979899497487)
p1 <- c(0.8985507246376812,0.9408866995073891,0.9353233830845771,0.905940594059406,0.9014778325123153)
  
x <- seq(1,5)

# precision rank
plot(x, c1,ylim = c(0.8,1), type = "o",col = "red", xlab = "Cross Validation", ylab = "Score", 
     main = "Label precision rank (all didn't cover collectioncode)")

lines(x, No_hc_p, type = "o", col = "grey")
lines(x, No_lo_p, type = "o", col = "blue")
lines(x, No_hg_p, type = "o", col = "black")
lines(x, No_ha_p, type = "o", col = "green")

legend("bottomright", legend = c("full","remove_higherClassification",'remove_locality','remove_higherGeography','remove_habitat'), 
       fill=c("red","grey","blue","black","green"), cex = 0.75)


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

# without No_ha_r
df1 = data.frame(x,c1,No_ha_r)
t.test(df1$c1, df1$No_ha_r)

# without No_lo_r
df2 = data.frame(x,c1,No_lo_r)
t.test(df2$c1, df2$No_lo_r)

# without No_hg_r
df3 = data.frame(x,c1,No_hg_r)
t.test(df3$c1, df3$No_hg_r)

# without No_hc_r
df4 = data.frame(x,c1,No_hc_r)
t.test(df4$c1, df4$No_hc_r)
