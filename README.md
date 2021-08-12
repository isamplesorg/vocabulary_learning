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
         - files with suffix "csv" are used for viewing the records.
         - files with suffix "txt" are used for models to predict labels.
         - files with suffix "train" are the trainset. 
         - files with suffix "valid" are the testset.
       - format of train files and test files. For iSamples project, the texts are the combinations of selected fields' string. (all texts are lowercase)
          ```
          __label__your_label_1 this is the first text
          __label__your_label_2 this is the second text
          ```
       - [Collection predict set folder](data/Collection_predict)
         - contains the different collections records
         - format: (all texts are lowercase)
            ```
            this is the first predict text
            this is the second predict text
            ``` 
       - [Collection Result folder](data/Collection_result)
         - contains predict results for different collections.
       - [Performance result folder](data/Performance_result)
         - contains all performance results for the different trainSet with the different train paramaters.
       - [Raw data folder](data/Raw_data)
         - contains all raw data without data preprocessing
  2. [fasttext_interface](fasttext_interface)
       - contains 3 files
         - [trainModel.ipynb](fasttext_interface) will train a fasttext model and store the model as the file (sampledFeature.bin) for furture prediction.
         - [sampledFeature.bin](fasttext_interface) is the fasttext file that can be loaded to predict text.
         - [DwC_predict.py](fastext_interface) is the python interface to add sampledFeature field in the DwC records.  
  3. [python](python)
       - contains several jupyter files.
         - [Performances.ipynb](python/Performances.ipynb) will train different models with different parameters and store data into simple_performance.csv and difficult_performance.csv in the data folder.
         - [CollectionPredict.ipynb](python/ColletionPredict.ipynb) would train fastText models with DwC_simple.train and predict DwC collection records.
         - **New** [dataPreprocessing.ipynb](python/dataPreprocessing.ipynb) is the example code to show how to clean up the raw data.
         - **New** [SESAR_preprocessing.ipynb](pyhon/SESAR_preprocessing.ipynb) shows how to clean SESAR records and convert them to three different sets.
         - **New** [openContext_preprocessing.ipynb](pyhon/openContext_preprocessing.ipynb) shows how to clean openContext records and convert them to three different sets.
         - **New** data loading.ipynb would retrieve collections' records from Mars APIs.
         - **New** [crossValidation.ipynb](python/crossValidation.ipynb) would use cross validation to evaluate the models' precisions and recalls.
  4. [R folder](R)
       - contains R code for basic data preprocessing and fastText model training.
  5. [Collections_data](Collections_data)
       - contains the data for other collections (SESAR, OpenContext)


