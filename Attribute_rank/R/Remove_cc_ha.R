# Making graph
# Full data set's (except collectionCode and habitat) recall and precision vs remove one attribute
No_lo_p <- c(0.9296482412060302,0.9698492462311558,0.9296482412060302,0.9195979899497487,0.9095477386934674)
No_lo_r <- c(0.893719806763285,0.9507389162561576,0.9203980099502488,0.905940594059406,0.8916256157635468)

No_hg_p <- c(0.949748743718593,0.9447236180904522,0.9547738693467337,0.9195979899497487,0.9346733668341709)
No_hg_r <- c(0.9130434782608695,0.9261083743842364,0.945273631840796,0.905940594059406,0.916256157635468)

No_hc_p <- c(0.8341708542713567,0.8944723618090452,0.8743718592964824,0.864321608040201,0.8291457286432161)
No_hc_r <- c(0.8019323671497585,0.8768472906403941,0.8656716417910447,0.8514851485148515,0.812807881773399)

c1 <- c(0.9447236180904522,0.9597989949748744,0.9447236180904522,0.9195979899497487,0.9195979899497487)
p1 <- c(0.9082125603864735,0.9408866995073891,0.9353233830845771,0.905940594059406,0.9014778325123153)

x <- seq(1,5)

# precision rank
plot(x, c1,ylim = c(0.8,1), type = "o",col = "red", xlab = "Cross Validation", ylab = "Score", 
     main = "Label precision rank (all didn't cover collectioncode and habitat)")

lines(x, No_hc_p, type = "o", col = "grey")
lines(x, No_lo_p, type = "o", col = "blue")
lines(x, No_hg_p, type = "o", col = "black")

legend("bottomright", legend = c("full","remove_higherClassification",'remove_locality','remove_higherGeography'), 
       fill=c("red","grey","blue","black"), cex = 0.75)


# recall rank
plot(x, p1,ylim = c(0.8,1), type = "o",col = "red", xlab = "Cross Validation", ylab = "Score", 
     main = "Label recall rank (all didn't cover collectioncode and habitat)")

lines(x, No_hc_r, type = "o", col = "grey")
lines(x, No_lo_r, type = "o", col = "blue")
lines(x, No_hg_r, type = "o", col = "black")

legend("bottomright", legend = c("full","remove_higherClassification",'remove_locality','remove_higherGeography'), 
       fill=c("red","grey","blue","black"), cex = 0.75)

# T-test
# Full data set's precision t-test

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

# without No_lo_r
df2 = data.frame(x,c1,No_lo_r)
t.test(df2$c1, df2$No_lo_r)

# without No_hg_r
df3 = data.frame(x,c1,No_hg_r)
t.test(df3$c1, df3$No_hg_r)

# without No_hc_r
df4 = data.frame(x,c1,No_hc_r)
t.test(df4$c1, df4$No_hc_r)
