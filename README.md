# vocabulary_learning
Evaluating machine learning approaches for vocabulary mapping. 

## Introduction
In the iSamples project, we need to categorize the samples or specimens from SESAR, GEOME, openContext and Smithsonian into the different iSamples vocabularies. iSamples currently has three control vocabularies, ["MaterialType"](https://github.com/isamplesorg/metadata/blob/main/vocabulary/MaterialTypeDecisionTreev3.pdf), ["SpecimenType"](https://github.com/isamplesorg/metadata/blob/main/vocabulary/SpecimenTypeDecisionTreev2.pdf) and ["SampledFeature"](https://github.com/isamplesorg/metadata/blob/main/vocabulary/SampledFeatureDecisionTreeV20210703.pdf). 
```
MaterialType: What kind of material is the specimen?
SpecimenType: What kind of thing is the specimen?
SampledFeature: What was the sample collected originally to represent?
```
This repository currently focuses on "SampledFeature". For SESAR, GEOME and openContext, "SampledFeature" could infer from "locality" and other fields because the "locality" and other fields are fixed size vocabularies. We could do manually mapping to transfer records and the iSample software could run some unique value queries to deterimine best fields to use for mapping. However, For the Smithsonian, the "locality" field values are the free text which means the values use a sentence or several sentences to decribe the records, So it is hard to do manually mapping. In order to solve this problem, we decide to use machine learning algorithm, fastText. 

## fastText
fastText is an open-source, free, lightweight library that allows users to learn text representations and text classifiers. It works on standard, generic hardware. Models can later be reduced in size to even fit on mobile devices. To learn about fastText, please explore the link: 
https://fasttext.cc/

## DataSet
Currently, the project uses Smithsonian biodiversity data published as a Darwin Core Archive (DwC-A), which is a standardized format for sharing biodiversity data as a set of one or more data tables. The core data table contains 194517 records and 72 fields.
Data link: https://collections.nmnh.si.edu/ipt/resource?r=nmnh_material_sample

## Process (update)
1. selecting 4 fields in the core data table.
   - collectionCode: contains 7 different values, "Invertebrate Zoology", "Fishes", "Amphibian %26 Reptiles", "Birds", "Botany", "Entomology" and "Mammals".
   - habitat: the habitat of the record sample.
   - higherGeography: the broad geography information.
   - locality: the location where the record was found in detail.
   **New** using the new field "higherClassification"
   - higherClassification: the taxom of the records.
2. Manually mapping the top 149 DwC-A records to iSamples sampledFeature with at most 2 sampledFeature labels as the simple cases according to the 4 field we chose.
   - convert the 119 mapping records to fastText format as simple_trainSet. [simple_trainSet](FastText/data/DwC_simple.train)
   - convert the 30 mapping records to fastText format as testSet. [testSet](FastText/data/DwC_simple.valid)
3. Manually mapping other 60 DwC-A records that are hard to be mapped by students as the difficult cases (most records have more than one label).
   - conbine the 60 difficult records and another 60 simple records to fastText fornatas difficult_trainSet. [difficult_trainSet](FastText/data/DwC_difficult.train)
4. **New** Using [the new dataset](FastText/data/Raw data/steve_mapping_1000.csv) labeled by expert, Mr Steve to train the model.
   - Because of the new version of iSamples sampledFeature, we use [the new sampledFeature term](https://github.com/isamplesorg/metadata/blob/main/vocabulary/SampledFeatureDecisionTreeV20210703.pdf), please review.
   - randomly select 70% (696) records as trainSet. [steve_696.train](FastText/data/steve_696.train)
   - rest 30% (299) records as testSet. [steve_299.valid](FastText/data/steve_299.valid)
5. use the trainSet and fastText pretrain word vector(crawl-300d-2M-subword.vec) to train a fastText supervised models.
   - training the fastText model with different parameters (learning rate: [0.1, 0.5, 1]; epoch: [5, 10, 15, 20, 25]; k: [1, 2, 3, 4, 5]) might have different performances (precision and recall). [Performances.ipynb](FastText/python/Performances.ipynb) will store the performances information into [simple_performance.csv](FastText/data/Performance_result/simple_performance.csv), [difficult_performance.csv](FastText/data/Performance_result/difficult_performance.csv) and [steve_performance.csv](FastText/data/Performance_result/steve_performance.csv).
   - **Result:** The results show the different parameters have no obvious effect on improving performances for DwC_simple.train and DwC_difficult.train because the trainset is too small. 
   - **New Result** For the steve trainset, we found learning rate (0.5) and epoch (20) work best for the model. So, we chose these parameter to train the fasttext model to predict the different collections' records.
6. using the model trained by simple_trainSet to determine which collection contains the hardest data for machine to predict. Each file has 50 records.
   - [Amphibians_predict.txt](FastText/data/Collection_predict/Amphibians_predict.txt)
   - [Birds_predict.txt](FastText/data/Collection_predict/Birds_predict.txt)
   - [Botany_predict.txt](FastText/data/Collection_predict/Botany_predict.txt)
   - [Entomology_predict.txt](FastText/data/Collection_predict/Entomology_predict.txt)
   - [Fishes_predict.txt](FastText/data/Collection_predict/Fishes_predict.txt)
   - [Mammals_predict.txt](FastText/data/Collection_predict/Mammals_predict.txt)
   - [zoology_predict.txt](FastText/data/Collection_predict/zoology_predict.txt)
7. [CollectionPredict.ipynb](FastText/python/CollectionPredict.ipynb) predicts the 7 collection records and calculates the average probabilities.
   - the fastText model trained by steve_696.train file with learning rate (0.5) and epoch (20)
   - **Result:** The results show the Fish collection records are the hardest records to be categorized by fastText model. [Probability results for the different collections](FastText/data/Collection Result/Sum_Result.csv)

## Prerequisites
  Download pretrained word vector file "crawl_300d-2M-subword.zip" from https://fasttext.cc/docs/en/english-vectors.html
  And put "crawl-300d-2M-subword.vec" file in the data folder

## FastText folders 
  1. [data folder](FastText/data)
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
      - [Collection predict set folder](FastText/data/Collection_predict)
         - contains the different collections records
         - format: (all texts are lowercase)
            ```
            this is the first predict text
            this is the second predict text
            ``` 
      - [Collection Result folder](FastText/data/Collection_result)
         - contains predict results for different collections.
      - [Performance result folder](FastText/data/Performance result)
         - contains all performance results for the different trainSet with the different train paramaters.
      - [Raw data folder](FastText/data/Raw data)
         - contains all raw data without data preprocessing
  2. [python](FastText/python)
       - contains two jupyter files.
         - [Performances.ipynb](FastText/python/Performances.ipynb) will train different models with different parameters and store data into simple_performance.csv and difficult_performance.csv in the data folder.
         - [CollectionPredict.ipynb](FastText/python/CollectionPredict.ipynb) will train fastText models with DwC_simple.train and predict DwC collection records.
         - **New**[dataPreprocessing.ipynb](dataPreprocessing.ipynb) is the example code to show how to clean up the raw data.
  3. [R folder](FastText/R)
       - contains R code for basic data preprocessing and fastText model training.


