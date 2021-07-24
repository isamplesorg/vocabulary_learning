# Interface for predicting sampledFeature field

helping developers to predict sampledFeature fields of smithsonian biudiversity records 

## Library requirements.
  1) fasttext library installation. For more information, Please read https://pypi.org/project/fasttext/.
     ```
     pip install fasttext
     ```
  2) pandas library installation. For more information, Please read https://pandas.pydata.org/pandas-docs/stable/getting_started/index.html.
     ```
     pip install pandas
     ```

## How to use DwC_predict.py
  ```
  python DwC_predict.py [data filePath] [model filePath]
  ```
  Usage: 
  - data filePath: the path of DwC records. The data file should be txt files. For example, occurrence.txt. 
  - model filePath: the path of fasttext model. There is a pretrain model (sampledFeature.bin). For future purpose, if the developers need to train a different fasttext models with different trainset.
  
  ex: if you put the occurrence.txt in the same folder
  ```
  python DwC_predict.py occurrence.txt sampledFeature.bin
  ```
  
## How DwC_predict.py works
  1) Data Proprecessing 
    - The interface will first load the DwC data into a data frame and concatenate the five fields 'collectionCode', 'habitat', 'higherGeography', 'locality', 'higherClassification' values to the sentences to be predicted by the fasttext model.
  2) Manipulation
    - The prediction results will be merged with original data and store new records into the file 'new_dataset_with_sampledFeature.csv' file.

## Result
  - In the terminal
    ```
    Loading data
        Records loaded : 193753.
    Data successful loading: 3.3237s.

    Loading model
    model successful loading: 0.2518s.

    Predicting sampledFeature
    model successful Prediciting and add labels to raw data: 8.8831s.
    ```
    It will show how long the interface loads the data, how long the interface loads the model and how long the interface predicts sampledFeature field and store in the new file.
   - In the current folder.
   
     The interface will create a new file named 'new_dataset_with_sampledFeature.csv'. The developers could use the data to do further work.
    
