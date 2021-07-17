library(tidyverse)
library(dplyr)
library(stringr)
df <- read.csv("DwC mapping.csv")
#load the simple records and difficult records
simple_60 <- df[1:60,]
difficult_60 <- read.csv("difficult.csv")
colnames(difficult_60) <- c("collectionCode", "habitat", "higherGeography", "locality", "CoreTerm")
dataset <- rbind(simple_60, difficult_60)

#clean the records text 
cleanText <- function(x){
  text <- x %>% select(collectionCode, habitat, higherGeography, locality)
  text$content <- apply(text, 1, paste, collapse = " ")
  text$content <- str_replace_all(text$content, "[[:punct:]]", "")
  text$content <- gsub("[^[:alnum:][:blank:]?&/\\-]", "", text$content)
  text$content <- gsub("[\t]", "", text$content)
  text$content <- tolower(text$content)
  return(text$content)
}
datasetText <- cleanText(dataset)

#clean the records label
cleanLabel <- function(x) {
  label <- ifelse(is.na(x), "", str_trim(x)) 
  label <- ifelse(label == "", "", str_replace_all(label, "[[:punct:]]", ""))
  label <- ifelse(label == "", "", str_replace_all(label," ", "-"))
  label <- ifelse(label == "", "", paste0("__label__", label))
  label  <- tolower(label )
  return(label)
}
library(plyr)       

#concatenate label and text
dataset_label <- strsplit(as.character(dataset$CoreTerm), ",", fixed = TRUE)
dataset_label <- ldply(dataset_label, rbind)
colnames(dataset_label) <- c("label1", "label2", "label3")
dataset_label$label1 <- cleanLabel(dataset_label$label1)
dataset_label$label2 <- cleanLabel(dataset_label$label2)
dataset_label$label3 <- cleanLabel(dataset_label$label3)
dataset_label$label <- apply(dataset_label, 1, paste, collapse = " ")
dataset_records <- data.frame(cbind(dataset_label$label, datasetText))
colnames(dataset_records) <- c("label", "text")

write.table(dataset_records, "halfhalf.train", row.names = F, col.names = F, quote = F)

library(fastText)
list_params = list(command = 'supervised',
                   lr = 0.1, 
                   dim = 300, #this must match the dimension of the pretrained vector
                   input = file.path(getwd(), "halfhalf.train"),
                   output = file.path(getwd(), "halfhalf.model"),
                   verbose = 2,
                   pretrainedVectors = file.path(getwd(), "crawl-300d-2M-subword.vec"),
                   thread = 1)

res = fasttext_interface(list_params,
                         path_output = file.path(getwd(), 'fasttext.logs_supervise_halfhalf.txt'),
                         MilliSecs = 5)

#test

list_params = list(command = 'test',
                   model = file.path(getwd(), 'halfhalf.model.bin'),
                   test_data = file.path(getwd(), 'DwC.valid'),
                   k = 1,
                   th = 0.0)
res = fasttext_interface(list_params)
