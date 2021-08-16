# T-test
data <- read.csv('test.csv',header = TRUE)
x <- seq(1,5)

# full attribute set's precision t-test
full <- as.numeric(data[which(data$filename == "cleanedData_full_remove.txt"), "precision"],digits = 20)
collectionCode <- as.numeric(data[which(data$filename == "cleanedData_collectionCode_remove.txt"), "precision"],digits = 20)
habitat <- as.numeric(data[which(data$filename == "cleanedData_habitat_remove.txt"), "precision"],digits = 20)
higherGeography <- as.numeric(data[which(data$filename == "cleanedData_higherGeography_remove.txt"), "precision"],digits = 20)
locality <- as.numeric(data[which(data$filename == "cleanedData_locality_remove.txt"), "precision"],digits = 20)
higherClassification <- as.numeric(data[which(data$filename == "cleanedData_higherClassification_remove.txt"), "precision"],digits = 20)

# without full_p
df0 <- data.frame(x,full,collectionCode)
t0 <- t.test(df0$full, df0$collectionCode)
chars <- capture.output(print("full compare with cc T-test"), print(t0))
write(chars, file = "T-test.txt")

# without No_ha_p
df <- data.frame(x,full,habitat)
t1 <- t.test(df$full, df$habitat)
chars <- capture.output(print("full compare with ha T-test"), print(t1))
write(chars, file = "T-test.txt")

# without No_hg_p
df1 <- data.frame(x,full,higherGeography)
t2 <-t.test(df1$full, df1$higherGeography)
chars <- capture.output(print("full compare with hg T-test"), print(t2))
write(chars, file = "T-test.txt", append=TRUE)

# without No_lo_p
df2 <- data.frame(x,full,locality)
t3 <- t.test(df2$full, df2$locality)
chars <- capture.output(print("full compare with lo T-test"), print(t3))
write(chars, file = "T-test.txt", append=TRUE)

# without No_hc_p
df3 <- data.frame(x,full,higherClassification)
t4 <- t.test(df3$full, df3$higherClassification)
chars <- capture.output(print("full compare with hc T-test"), print(t4))
write(chars, file = "T-test.txt", append=TRUE)


# No collectionCode data set's precision t-test
Title <- ("No_collectionCode_T-test")

no_cc_full <- as.numeric(data[which(data$filename == "cleanedData_no_cc_full_remove.txt"), "precision"],digits = 20)
no_cc_habitat <- as.numeric(data[which(data$filename == "cleanedData_no_cc_habitat_remove.txt"), "precision"],digits = 20)
no_cc_higherGeography <- as.numeric(data[which(data$filename == "cleanedData_no_cc_higherGeography_remove.txt"), "precision"],digits = 20)
no_cc_locality <- as.numeric(data[which(data$filename == "cleanedData_no_cc_locality_remove.txt"), "precision"],digits = 20)
no_cc_higherClassification <- as.numeric(data[which(data$filename == "cleanedData_no_cc_higherClassification_remove.txt"), "precision"],digits = 20)

# without No_ha_p
df <- data.frame(x,no_cc_full,no_cc_habitat)
t1 <- t.test(df$no_cc_full, df$no_cc_habitat)
chars <- capture.output(print("No_cc compare with No_cc_ha T-test"), print(t1))
write(chars, file = "No_collectionCode_T-test.txt")

# without No_hg_p
df1 <- data.frame(x,no_cc_full,no_cc_higherGeography)
t2 <-t.test(df1$no_cc_full, df1$no_cc_higherGeography)
chars <- capture.output(print("No_cc compare with No_cc_hg T-test"), print(t2))
write(chars, file = "No_collectionCode_T-test.txt", append=TRUE)

# without No_lo_p
df2 <- data.frame(x,no_cc_full,no_cc_locality)
t3 <- t.test(df2$no_cc_full, df2$no_cc_locality)
chars <- capture.output(print("No_cc compare with No_cc_lo T-test"), print(t3))
write(chars, file = "No_collectionCode_T-test.txt", append=TRUE)

# without No_hc_p
df3 <- data.frame(x,no_cc_full,no_cc_higherClassification)
t4 <- t.test(df3$no_cc_full, df3$no_cc_higherClassification)
chars <- capture.output(print("No_cc compare with No_cc_hc T-test"), print(t4))
write(chars, file = "No_collectionCode_T-test.txt", append=TRUE)


# No collectionCode and habitat data set's precision t-test
Title <- ("No_collectionCode_habitat_T-test")

no_cc_ha_full <- as.numeric(data[which(data$filename == "cleanedData_no_cc_ha_full_remove.txt"), "precision"],digits = 20)
no_cc_ha_higherGeography <- as.numeric(data[which(data$filename == "cleanedData_no_cc_ha_higherGeography_remove.txt"), "precision"],digits = 20)
no_cc_ha_locality <- as.numeric(data[which(data$filename == "cleanedData_no_cc_ha_locality_remove.txt"), "precision"],digits = 20)
no_cc_ha_higherClassification <- as.numeric(data[which(data$filename == "cleanedData_no_cc_ha_higherClassification_remove.txt"), "precision"],digits = 20)

# without No_hg_p
df1 <- data.frame(x,no_cc_ha_full,no_cc_ha_higherGeography)
t2 <-t.test(df1$no_cc_ha_full, df1$no_cc_ha_higherGeography)
chars <- capture.output(print("No_cc compare with no_cc_ha_hg T-test"), print(t2))
write(chars, file = "No_collectionCode_habitat_T-test.txt")

# without No_lo_p
df2 <- data.frame(x,no_cc_ha_full,no_cc_ha_locality)
t3 <- t.test(df2$no_cc_ha_full, df2$no_cc_ha_locality)
chars <- capture.output(print("No_cc compare with no_cc_ha_lo T-test"), print(t3))
write(chars, file = "No_collectionCode_habitat_T-test.txt", append=TRUE)

# without No_hc_p
df3 <- data.frame(x,no_cc_ha_full,no_cc_ha_higherClassification)
t4 <- t.test(df3$no_cc_ha_full, df3$no_cc_ha_higherClassification)
chars <- capture.output(print("No_cc compare with no_cc_ha_hc T-test"), print(t4))
write(chars, file = "No_collectionCode_habitat_T-test.txt", append=TRUE)


# No collectionCode,habitat and higherGeography data set's precision t-test
Title <- ("No_collectionCode_habitat_higherGeography_T-test")

no_cc_ha_hg_full <- as.numeric(data[which(data$filename == "cleanedData_no_cc_ha_hg_full_remove.txt"), "precision"],digits = 20)
no_cc_ha_hg_higherGeography <- as.numeric(data[which(data$filename == "cleanedData_no_cc_ha_hg_higherGeography_remove.txt"), "precision"],digits = 20)
no_cc_ha_hg_locality <- as.numeric(data[which(data$filename == "cleanedData_no_cc_ha_hg_locality_remove.txt"), "precision"],digits = 20)
no_cc_ha_hg_higherClassification <- as.numeric(data[which(data$filename == "cleanedData_no_cc_ha_hg_higherClassification_remove.txt"), "precision"],digits = 20)

# without No_lo_p
df2 <- data.frame(x,no_cc_ha_hg_full,no_cc_ha_hg_locality)
t3 <- t.test(df2$no_cc_ha_hg_full, df2$no_cc_ha_hg_locality)
chars <- capture.output(print("No_cc compare with no_cc_ha_hg_lo T-test"), print(t3))
write(chars, file = "No_collectionCode_habitat_higherGeography_T-test.txt")

# without No_hc_p
df3 <- data.frame(x,no_cc_ha_hg_full,no_cc_ha_hg_higherClassification)
t4 <- t.test(df3$no_cc_ha_hg_full, df3$no_cc_ha_hg_higherClassification)
chars <- capture.output(print("No_cc compare with no_cc_ha_hg_hc T-test"), print(t4))
write(chars, file = "No_collectionCode_habitat_higherGeography_T-test.txt", append=TRUE)


# T-test(Recall)
data <- read.csv('test.csv',header = TRUE)
x <- seq(1,5)

# full attribute set's recall T-test(Recall)
full <- as.numeric(data[which(data$filename == "cleanedData_full_remove.txt"), "recall"],digits = 20)
collectionCode <- as.numeric(data[which(data$filename == "cleanedData_collectionCode_remove.txt"), "recall"],digits = 20)
habitat <- as.numeric(data[which(data$filename == "cleanedData_habitat_remove.txt"), "recall"],digits = 20)
higherGeography <- as.numeric(data[which(data$filename == "cleanedData_higherGeography_remove.txt"), "recall"],digits = 20)
locality <- as.numeric(data[which(data$filename == "cleanedData_locality_remove.txt"), "recall"],digits = 20)
higherClassification <- as.numeric(data[which(data$filename == "cleanedData_higherClassification_remove.txt"), "recall"],digits = 20)

# without full_p
df0 <- data.frame(x,full,collectionCode)
t0 <- t.test(df0$full, df0$collectionCode)
chars <- capture.output(print("full compare with cc T-test(Recall)"), print(t0))
write(chars, file = "T-test(Recall).txt")

# without No_ha_p
df <- data.frame(x,full,habitat)
t1 <- t.test(df$full, df$habitat)
chars <- capture.output(print("full compare with ha T-test(Recall)"), print(t1))
write(chars, file = "T-test(Recall).txt")

# without No_hg_p
df1 <- data.frame(x,full,higherGeography)
t2 <-t.test(df1$full, df1$higherGeography)
chars <- capture.output(print("full compare with hg T-test(Recall)"), print(t2))
write(chars, file = "T-test(Recall).txt", append=TRUE)

# without No_lo_p
df2 <- data.frame(x,full,locality)
t3 <- t.test(df2$full, df2$locality)
chars <- capture.output(print("full compare with lo T-test(Recall)"), print(t3))
write(chars, file = "T-test(Recall).txt", append=TRUE)

# without No_hc_p
df3 <- data.frame(x,full,higherClassification)
t4 <- t.test(df3$full, df3$higherClassification)
chars <- capture.output(print("full compare with hc T-test(Recall)"), print(t4))
write(chars, file = "T-test(Recall).txt", append=TRUE)


# No collectionCode data set's recall T-test(Recall)
Title <- ("No_collectionCode_T-test(Recall)")

no_cc_full <- as.numeric(data[which(data$filename == "cleanedData_no_cc_full_remove.txt"), "recall"],digits = 20)
no_cc_habitat <- as.numeric(data[which(data$filename == "cleanedData_no_cc_habitat_remove.txt"), "recall"],digits = 20)
no_cc_higherGeography <- as.numeric(data[which(data$filename == "cleanedData_no_cc_higherGeography_remove.txt"), "recall"],digits = 20)
no_cc_locality <- as.numeric(data[which(data$filename == "cleanedData_no_cc_locality_remove.txt"), "recall"],digits = 20)
no_cc_higherClassification <- as.numeric(data[which(data$filename == "cleanedData_no_cc_higherClassification_remove.txt"), "recall"],digits = 20)

# without No_ha_p
df <- data.frame(x,no_cc_full,no_cc_habitat)
t1 <- t.test(df$no_cc_full, df$no_cc_habitat)
chars <- capture.output(print("No_cc compare with No_cc_ha T-test(Recall)"), print(t1))
write(chars, file = "No_collectionCode_T-test(Recall).txt")

# without No_hg_p
df1 <- data.frame(x,no_cc_full,no_cc_higherGeography)
t2 <-t.test(df1$no_cc_full, df1$no_cc_higherGeography)
chars <- capture.output(print("No_cc compare with No_cc_hg T-test(Recall)"), print(t2))
write(chars, file = "No_collectionCode_T-test(Recall).txt", append=TRUE)

# without No_lo_p
df2 <- data.frame(x,no_cc_full,no_cc_locality)
t3 <- t.test(df2$no_cc_full, df2$no_cc_locality)
chars <- capture.output(print("No_cc compare with No_cc_lo T-test(Recall)"), print(t3))
write(chars, file = "No_collectionCode_T-test(Recall).txt", append=TRUE)

# without No_hc_p
df3 <- data.frame(x,no_cc_full,no_cc_higherClassification)
t4 <- t.test(df3$no_cc_full, df3$no_cc_higherClassification)
chars <- capture.output(print("No_cc compare with No_cc_hc T-test(Recall)"), print(t4))
write(chars, file = "No_collectionCode_T-test(Recall).txt", append=TRUE)


# No collectionCode and habitat data set's recall T-test(Recall)
Title <- ("No_collectionCode_habitat_T-test(Recall)")

no_cc_ha_full <- as.numeric(data[which(data$filename == "cleanedData_no_cc_ha_full_remove.txt"), "recall"],digits = 20)
no_cc_ha_higherGeography <- as.numeric(data[which(data$filename == "cleanedData_no_cc_ha_higherGeography_remove.txt"), "recall"],digits = 20)
no_cc_ha_locality <- as.numeric(data[which(data$filename == "cleanedData_no_cc_ha_locality_remove.txt"), "recall"],digits = 20)
no_cc_ha_higherClassification <- as.numeric(data[which(data$filename == "cleanedData_no_cc_ha_higherClassification_remove.txt"), "recall"],digits = 20)

# without No_hg_p
df1 <- data.frame(x,no_cc_ha_full,no_cc_ha_higherGeography)
t2 <-t.test(df1$no_cc_ha_full, df1$no_cc_ha_higherGeography)
chars <- capture.output(print("No_cc compare with no_cc_ha_hg T-test(Recall)"), print(t2))
write(chars, file = "No_collectionCode_habitat_T-test(Recall).txt")

# without No_lo_p
df2 <- data.frame(x,no_cc_ha_full,no_cc_ha_locality)
t3 <- t.test(df2$no_cc_ha_full, df2$no_cc_ha_locality)
chars <- capture.output(print("No_cc compare with no_cc_ha_lo T-test(Recall)"), print(t3))
write(chars, file = "No_collectionCode_habitat_T-test(Recall).txt", append=TRUE)

# without No_hc_p
df3 <- data.frame(x,no_cc_ha_full,no_cc_ha_higherClassification)
t4 <- t.test(df3$no_cc_ha_full, df3$no_cc_ha_higherClassification)
chars <- capture.output(print("No_cc compare with no_cc_ha_hc T-test(Recall)"), print(t4))
write(chars, file = "No_collectionCode_habitat_T-test(Recall).txt", append=TRUE)


# No collectionCode,habitat and higherGeography data set's recall T-test(Recall)
Title <- ("No_collectionCode_habitat_higherGeography_T-test(Recall)")

no_cc_ha_hg_full <- as.numeric(data[which(data$filename == "cleanedData_no_cc_ha_hg_full_remove.txt"), "recall"],digits = 20)
no_cc_ha_hg_higherGeography <- as.numeric(data[which(data$filename == "cleanedData_no_cc_ha_hg_higherGeography_remove.txt"), "recall"],digits = 20)
no_cc_ha_hg_locality <- as.numeric(data[which(data$filename == "cleanedData_no_cc_ha_hg_locality_remove.txt"), "recall"],digits = 20)
no_cc_ha_hg_higherClassification <- as.numeric(data[which(data$filename == "cleanedData_no_cc_ha_hg_higherClassification_remove.txt"), "recall"],digits = 20)

# without No_lo_p
df2 <- data.frame(x,no_cc_ha_hg_full,no_cc_ha_hg_locality)
t3 <- t.test(df2$no_cc_ha_hg_full, df2$no_cc_ha_hg_locality)
chars <- capture.output(print("No_cc compare with no_cc_ha_hg_lo T-test(Recall)"), print(t3))
write(chars, file = "No_collectionCode_habitat_higherGeography_T-test(Recall).txt")

# without No_hc_p
df3 <- data.frame(x,no_cc_ha_hg_full,no_cc_ha_hg_higherClassification)
t4 <- t.test(df3$no_cc_ha_hg_full, df3$no_cc_ha_hg_higherClassification)
chars <- capture.output(print("No_cc compare with no_cc_ha_hg_hc T-test(Recall)"), print(t4))
write(chars, file = "No_collectionCode_habitat_higherGeography_T-test(Recall).txt", append=TRUE)


   
