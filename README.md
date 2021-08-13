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
https://fasttext.cc/. (**NOTICE**: the fastText library might reture the same precision and recall when you use the "test" method to verify the test set. fastText library might have this bug. And fastText only calculates the micro average precision and recall.)

## DataSet
Currently, the project uses Smithsonian biodiversity data published as a Darwin Core Archive (DwC-A), which is a standardized format for sharing biodiversity data as a set of one or more data tables. The core data table contains 194517 records and 72 fields.
Data link: https://collections.nmnh.si.edu/ipt/resource?r=nmnh_material_sample

## Processes for Smithsonia (updated)
1. selecting 5 fields in the core data table.
   - collectionCode: contains 7 different values, "Invertebrate Zoology", "Fishes", "Amphibian %26 Reptiles", "Birds", "Botany", "Entomology" and "Mammals".
   - habitat: the habitat of the record sample.
   - higherGeography: the broad geography information.
   - locality: the location where the record was found in detail.
   - higherClassification: the taxon of the records. 
2. Using [the new dataset](data/Raw_data/steve_mapping_1000.csv) labeled by expert, Mr Steve to train the model.
   - Because of the new version of iSamples sampledFeature, we use [the new sampledFeature term](https://github.com/isamplesorg/metadata/blob/main/vocabulary/SampledFeatureDecisionTreeV20210703.pdf), please review.
   - randomly select 70% (696) records as trainSet. [steve_696.train](data/steve_696.train)
   - rest 30% (299) records as testSet. [steve_299.valid](data/steve_299.valid)
3. use the trainSet and fastText pretrain word vector(crawl-300d-2M-subword.vec) to train a fastText supervised models.
   - training the fastText model with different parameters (learning rate: [0.1, 0.5, 1]; epoch: [5, 10, 15, 20, 25]; k: [1, 2, 3, 4, 5]) might have different performances (precision and recall). [Performances.ipynb](python/Performances.ipynb) will store the performances information in the [Performance result folder](data/Performance_result)
   - **Result:** For the steve trainset, we found learning rate (0.5) and epoch (20) work best for the model. So, we chose these parameter to train the fasttext model to predict the different collections' records.
6. using the model trained by simple_trainSet to determine which collection contains the hardest data for machine to predict. Each file has 50 records.
   - [Amphibians_predict.txt](data/Collection_predict/Amphibians_predict.txt)
   - [Birds_predict.txt](data/Collection_predict/Birds_predict.txt)
   - [Botany_predict.txt](data/Collection_predict/Botany_predict.txt)
   - [Entomology_predict.txt](data/Collection_predict/Entomology_predict.txt)
   - [Fishes_predict.txt](data/Collection_predict/Fishes_predict.txt)
   - [Mammals_predict.txt](data/Collection_predict/Mammals_predict.txt)
   - [zoology_predict.txt](data/Collection_predict/zoology_predict.txt)
7. [CollectionPredict.ipynb](python/CollectionPredict.ipynb) predicts the 7 collection records and calculates the average probabilities.
   - **New:** the fastText model trained by steve_696.train file with learning rate (0.5) and epoch (20)
   - **New result:** The results show fasttext model could predict all collections' records with 95% average probability and more. [Probability results for the different collections](data/Collection_result/Sum_Result.csv)

## Processes for SESAR and openContext.
1. Use data loading.ipynb to retrieve SESAR records from MARS. we would get [SESAR_5000_core.csv](Collections_data/SESAR_5000_core.csv) and [SESAR_5000_original.csv](Collections_data/SESAR_5000_orginal.csv). The same steps for openContext.
2. Use SESAR_preprocessing.ipynb to clean the SESAR records and convert them to different sets. [cleanedSESAR_materialType.txt](Collections_data/cleanedSESAR_materialType.txt), [cleanedSESAR_sampeldFeature.txt](Collections_data/cleanedSESAR_sampeldFeature.txt) and [cleanedSESAR_specimenType.txt](Collections_data/cleanedSESAR_specimenType.txt).
3. [SESAR_preprocessing.ipynb](pyhon/SESAR_preprocessing.ipynb) and [openContext_preprocessing.ipynb](pyhon/openContext_preprocessing.ipynb) clean the records and converts data to fastText format. The files also draw the graphes of records' attributes distribution and iSamples control vocabularies's distributions. 
   - **Result for SESAR:** The SESAR collection is sparse data. Only few attributes could be used for fastText. And, the current records transformers based on keywords rules. Therefore, the result precision and recall are great. 
   - **Result for openContext:** The openContext original data is pretty straightful and the sampled feature for openContext is the same value, "Site of past human activities". The current iSamples core records of openContext are based on only one attribuate, "item category". Therefore, when we use fastText to verify the control vocabularies, the precision and recall are 100%.
4. Use crossValidation.ipynb to evaluate the models' precisions and recalls and draw the graphs of precision and recall.


## Prerequisites
  Download pretrained word vector file "crawl_300d-2M-subword.zip" from https://fasttext.cc/docs/en/english-vectors.html
  And put "crawl-300d-2M-subword.vec" file in the data folder
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


