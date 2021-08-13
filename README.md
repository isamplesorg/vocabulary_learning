# Attribute_Ranking
Find the attributes that have the most significant influence on vocabulary mapping performance using machine learning.

## Introduction
In the iSamples project, we need to label the sample records from SESAR、GEOME、openContext and Smithsonian with different iSamples controlled vocabularies. We hope to map a large number of records through machine learning, and would like to identify the attributes that play the most important role in the prediction. We took a thousand Smithsonian records as a case study. Through a manual labeling process of 995 records (to create a training set), we found 5 attributes that were most informative to human labelers. The five attributes were collectionCode, habitat, higherGeography, locality, and higherClassification.
```
-collectionCode: contains 7 different values, "Invertebrate Zoology", "Fishes", "Amphibian %26 Reptiles", "Birds", "Botany", "Entomology" and "Mammals".
-higherGeography: contains broad geography information.
-habitat: contains free-text habitat description of a sample.
-locality: contains free-text location information where a sample was found in detail.
-higherClassification contrains taxonomic ranks of a sample (scientific names from phylum to specise). 
```
We recursively applied cross-validations and T-tests to select the best features, following the Recursive Feature Elimination method. Cross-validation is for estimating performances, and T-test is to detect performance differences that are statistically signficiant.

## Cross Validation
Cross-validation, sometimes called rotation estimation or out-of-sample testing, is any of various similar model validation techniques for assessing how the results of a statistical analysis will generalize to an independent data set. It is mainly used in settings where the goal is prediction, and one wants to estimate how accurately a predictive model will perform in practice. From Wikipedia (https://en.wikipedia.org/wiki/Cross-validation_(statistics)) We used 5-fold cross validation in this study.

## T-test
A t-test is a type of inferential statistic used to determine if there is a significant difference between the means of two groups, which may be related in certain features. 
From investopedia (https://www.investopedia.com/terms/t/t-test.asp)

## Processes for ranking attribute (Only used for smithsonia collections)
1. Use all five attributes and \[the new dataset](data/Raw data/steve_mapping_1000.csv) labeled by expert to train the first model.
2. Use the trainSet and fastText pretrained word vector(wiki-news-300d-1M.vec) to train the fastText supervised models.
3. Use 5-fold cross validation to estimate the model performance. The average precision and recall obtained from this step is the **reference performance** to which the subsequent models will be compared. 
4. Remove one attribute (A_i, i in \[1-5]) at a time from the five attributes, do step 5.
5. Use the remaining attributes, train and build another model, and do 5-fold cross validation again. 
	- Each 5-fold cross validation produces 5 sets of precision and recall scores
	- Use T-tests to decide if precision and recall scores from one model is really different from the **reference** model 
	- Through the performance comparisons, identify the attribute (A_i) that has the least impact on the model performance (i.e., removing the attribute did not result in a significant performance drop, that is, the T-test gives the largest p-value). Remove this attribute and repeat step 5. 
6. Stop when no attribute can be dropped without signficiantly reducing model performance.  

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
