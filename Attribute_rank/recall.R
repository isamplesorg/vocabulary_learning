getwd()

data <- read.csv('test.csv',header = TRUE)
x <- seq(1,5)

# recall Graph include all attribute

full <- data[which(data$filename == "cleanedData_full_remove.txt"), "recall"]
collectionCode <- data[which(data$filename == "cleanedData_collectionCode_remove.txt"), "recall"]
habitat <- data[which(data$filename == "cleanedData_habitat_remove.txt"), "recall"]
higherGeography <- data[which(data$filename == "cleanedData_higherGeography_remove.txt"), "recall"]
locality <-data[which(data$filename == "cleanedData_locality_remove.txt"), "recall"]
higherClassification <-data[which(data$filename == "cleanedData_higherClassification_remove.txt"), "recall"]

# recall rank
png(file = "recall_rank_full.png")
plot(x, full,ylim = c(0.85,1), type = "o",col = "red", xlab = "Cross Validation", ylab = "Score", 
     main = "Label recall rank")

lines(x, collectionCode, type = "o", col = "yellow")
lines(x, habitat, type = "o", col = "grey")
lines(x, higherGeography, type = "o", col = "blue")
lines(x, locality, type = "o", col = "black")
lines(x, higherClassification, type = "o", col = "green")

legend("bottomright", legend = c("full","remove_collectionCode", "remove_habitat",'remove_higherGeography','remove_locality','remove_higherClassification'), 
       fill=c("red","yellow","grey","blue","black","green"), cex = 0.75)
dev.off()

# recall Graph without Collectioncode

no_cc_full <- data[which(data$filename == "cleanedData_no_cc_full_remove.txt"), "recall"]
no_cc_habitat <- data[which(data$filename == "cleanedData_no_cc_habitat_remove.txt"), "recall"]
no_cc_higherGeography <- data[which(data$filename == "cleanedData_no_cc_higherGeography_remove.txt"), "recall"]
no_cc_locality <-data[which(data$filename == "cleanedData_no_cc_locality_remove.txt"), "recall"]
no_cc_higherClassification <-data[which(data$filename == "cleanedData_no_cc_higherClassification_remove.txt"), "recall"]

# recall rank
png(file = "recall_rank_no_cc.png")
plot(x, no_cc_full,ylim = c(0.80,1), type = "o",col = "red", xlab = "Cross Validation", ylab = "Score", 
     main = "Label recall rank (all didn't cover collectioncode)")

lines(x, no_cc_habitat, type = "o", col = "grey")
lines(x, no_cc_higherGeography, type = "o", col = "blue")
lines(x, no_cc_locality, type = "o", col = "black")
lines(x, no_cc_higherClassification, type = "o", col = "green")

legend("bottomright", legend = c("full","remove_habitat",'remove_higherGeography','remove_locality','remove_higherClassification'), 
       fill=c("red","grey","blue","black","green"), cex = 0.75)
dev.off()

# recall Graph without Collectioncode and habitat

no_cc_ha_full <- data[which(data$filename == "cleanedData_no_cc_ha_full_remove.txt"), "recall"]
no_cc_ha_higherGeography <- data[which(data$filename == "cleanedData_no_cc_ha_higherGeography_remove.txt"), "recall"]
no_cc_ha_locality <-data[which(data$filename == "cleanedData_no_cc_ha_locality_remove.txt"), "recall"]
no_cc_ha_higherClassification <-data[which(data$filename == "cleanedData_no_cc_ha_higherClassification_remove.txt"), "recall"]

# recall rank
png(file = "recall_rank_no_cc_ha.png")
plot(x, no_cc_ha_full,ylim = c(0.75,1), type = "o",col = "red", xlab = "Cross Validation", ylab = "Score", 
     main = "Label recall rank (all didn't cover collectioncode and habitat)")

lines(x, no_cc_ha_higherGeography, type = "o", col = "blue")
lines(x, no_cc_ha_locality, type = "o", col = "black")
lines(x, no_cc_ha_higherClassification, type = "o", col = "green")

legend("bottomright", legend = c("full",'remove_higherGeography','remove_locality','remove_higherClassification'), 
       fill=c("red","blue","black","green"), cex = 0.75)
dev.off()

# recall Graph without Collectioncode, habitat and higherGeography

no_cc_ha_hg_full <- data[which(data$filename == "cleanedData_no_cc_ha_hg_full_remove.txt"), "recall"]
no_cc_ha_hg_locality <-data[which(data$filename == "cleanedData_no_cc_ha_hg_locality_remove.txt"), "recall"]
no_cc_ha_hg_higherClassification <-data[which(data$filename == "cleanedData_no_cc_ha_hg_higherClassification_remove.txt"), "recall"]

# recall rank
png(file = "recall_rank_no_cc_ha_hg.png")
plot(x, no_cc_ha_hg_full,ylim = c(0.70,1), type = "o",col = "red", xlab = "Cross Validation", ylab = "Score", 
     main = "Label recall rank (all didn't cover collectioncode,habitat and higherGeography)")

lines(x, no_cc_ha_hg_locality, type = "o", col = "black")
lines(x, no_cc_ha_hg_higherClassification, type = "o", col = "green")

legend("bottomright", legend = c("full",'remove_locality','remove_higherClassification'), 
       fill=c("red","black","green"), cex = 0.75)
dev.off()

# recall Graph compare without higherClassification with other

full <- data[which(data$filename == "cleanedData_full_remove.txt"), "recall"]
no_cc_full <- data[which(data$filename == "cleanedData_no_cc_full_remove.txt"), "recall"]
no_cc_ha_full <- data[which(data$filename == "cleanedData_no_cc_ha_full_remove.txt"), "recall"]
no_cc_ha_hg_full <- data[which(data$filename == "cleanedData_no_cc_ha_hg_full_remove.txt"), "recall"]
higherClassification <-data[which(data$filename == "cleanedData_higherClassification_remove.txt"), "recall"]

# recall rank
png(file = "recall_rank_remove_compare.png")
plot(x, full,ylim = c(0.85,1), type = "o",col = "red", xlab = "Cross Validation", ylab = "Score", 
     main = "Label recall rank remove compare")

lines(x, no_cc_full, type = "o", col = "yellow")
lines(x, no_cc_ha_full, type = "o", col = "grey")
lines(x, no_cc_ha_hg_full, type = "o", col = "blue")
lines(x, higherClassification, type = "o", col = "green")

legend("bottomright", legend = c("full","remove_cc", "remove_cc_ha",'remove_cc_ha_hg','remove_hg_only'), 
       fill=c("red","yellow","grey","blue","green"), cex = 0.75)
dev.off()
