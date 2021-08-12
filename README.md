# Attribute_Ranking
Find the attribute that has the most significant influence on vocabulary mapping in machine learning.

## Introduction
In the iSample project, we need to map the sample from SESAR、GEOME、openContext and Smithsonian into different iSamples vocabularies. We hope to map a large number of vocabularies through machine learning.  We are wondering which attribute plays the most important role in the process. We take a thousand Smithsonian records of the Smithsonian as examples. Through the manual mapping of these 995 records, we found the 5 attributes that are most likely to have an impact on machine learning. The five attributes are collectionCode, habitat, higherGeography, locality, higherClassification.
```
-collectionCode: contains 7 different values, "Invertebrate Zoology", "Fishes", "Amphibian %26 Reptiles", "Birds", "Botany", "Entomology" and "Mammals".
-higherGeography: the broad geography information.
-habitat: the habitat of the record sample.
-locality: the location where the record was found in detail.
-higherClassification: the taxon of the records. 
```
During this process,  we would mainly use two statistical ways to analyze. First, there are Cross-Validation and T-test. Cross-validation is for evaluating estimator performance, and T-test is for investigating how each attribute influences the result.

## Cross Validation
Cross-validation, sometimes called rotation estimation or out-of-sample testing, is any of various similar model validation techniques for assessing how the results of a statistical analysis will generalize to an independent data set. It is mainly used in settings where the goal is prediction, and one wants to estimate how accurately a predictive model will perform in practice. From Wikipedia (https://en.wikipedia.org/wiki/Cross-validation_(statistics))

## T-test
A t-test is a type of inferential statistic used to determine if there is a significant difference between the means of two groups, which may be related in certain features. 
From investopedia (https://www.investopedia.com/terms/t/t-test.asp)

## Processes for Ranking attribute (Only for smithsonia)
1. Using [the new dataset](data/Raw data/steve_mapping_1000.csv) labeled by expert (Mr Steve) to train the model.
2. Use the trainSet and fastText pretrained word vector(wiki-news-300d-1M.vec) to train a fastText supervised models.
3. Use 5-cross validation to evaluate the model.
	- After we use 5-cross validation to evaluate the model, we will get 5 sets of data, there are precision and recall
4. Remove one of the attribute and do the 5-cross validation again. 
	- By removing different attributes, we will find that the accuracy and the overall change of the call; we want to remove an attribute in this way to help the whole cause the biggest change.
5. Do t-test through original attribute set. 
	- By t-testing the data set, we will get p-value, p-value is the probability of obtaining test results at least as extreme as the results actually observed, under the assumption that the null hypothesis is correct. From Wikipedia (https://en.wikipedia.org/wiki/P-value)
6. find the largest p-value and remove the attribute (large p-value means two data set are very close with each others). Start from step 3 again. Until one attribute left in the attribute set.  
	- Until the remain attribute are not allowed to remove, when the p-value is lower than 0.05.(when the p-value lower than 0.05, it means those two data set don't have great connection) 

## Prerequisites
  Download pretrained word vector file "wiki-news-300d-1M.vec.zip" from https://fasttext.cc/docs/en/english-vectors.html
  And put "wiki-news-300d-1M.vec" file in the data folder
  (Alternative: "wiki-new-300d-1M-subword.vec.zip")

## FastText folders 
  1. [data folder](data)
       - contains all data we used. 
         - steve_mapping_1000.csv.
  2. [dataPreprocessing](dataPreprocessing)
       - contains 5 files
         - [dataPreprocessing_Full.ipynb] include all attribute, and remove one of the attribute
         - [dataPreprocessing_No_cc.ipynb] include all attribute except collectionCode, and remove one of the attribute
         - [dataPreprocessing_No_cc_ha.ipynb] include all attribute except collectionCode and habitat, and remove one of the attribute
         - [dataPreprocessing_No_cc_ha_hg.ipynb] only include locality and higherClassification, and remove one the attribute
         - [dataPreprocessing_No_cc_ha_hg_lo.ipynb] only include higherClassification
  3. [crossValidation](crossValidation)
       - get the result from 2[dataPreprocessing] and use the filename to run this script
  4. [trans](trans)
       - contains two files.
        -[text.py] transfer data from dataPreprocessing to format that easier read by R scrpit
	-[exa.txt] save the result from dataPreprocessing.
  5. [R folder](R)
       - contains R code for output t-test result and graph.
