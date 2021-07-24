#File: DwC_predict.py
#Purpose: read DwC raw data csv file, predict each record's sampledFeature, add sampledFeature field in raw data and store data in new file.
#Author: Quan Gan
#
#
#Usage: [data filePath]: the data file path
#            [model filePath]: the pretained model file path
#
#Output: Terminal: each step running time
#        csv file: the new output file with sampledFeature field
import sys
import fasttext
import time
import pandas as pd
import numpy as np
from typing import List

#Method: dataProprecessing
#Purpose: select the fields that used for predicting sampledFeature, clean and convert the context into the sentences.
#Parameters: df (DataFrame) : the raw data 
#return:  List[str] : a list of sentences to be predicted
def dataProprecessing(df: pd.DataFrame) -> List[str] :
    selectedFields = ['collectionCode', 'habitat', 'higherGeography', 'locality', 'higherClassification']
    data = df[selectedFields]
    data = data.replace(np.nan, "", regex=True)
    data = data.astype(str).apply(lambda x: x.str.lower())
    data['text'] = data['collectionCode'] + ' ' + data['habitat'] + ' ' + data['higherGeography'] + ' ' + data['locality'] + ' ' + data['higherClassification']
    data['text'] = data['text'].str.replace('[^\w\s]','', regex=True)
    return data['text'].tolist()

#Method: addSampledFeature
#Purpose: use pretained 
#Parameters: df (DataFrame) : the raw data 
#            context (List[str]) : the list of sentences
#            model (fasttext) : the pretrain fasttext model
#return:  List[str] : a list of sentences to be predicted
def addSampledFeature(context: List[str], model: fasttext, df: pd.DataFrame) -> pd.DataFrame:
    result = model.predict(context)
    label = pd.DataFrame(result[0], columns=['sampledFeature'])
    label['sampledFeature'] = label['sampledFeature'].map(lambda row: (row.split('__')[-1].replace('_', ' ')))
    label['sampledFeature'] = label['sampledFeature'].replace('Lake', "Lake,", regex=True)
    df = df.join(label)
    #df = df[['sampledFeature'] + df.columns.tolist()]
    return df

def main():
    if len(sys.argv) != 3: 
        print(f"Error Usage: python3 { ' '.join(sys.argv) }")
        print("Usage: python3 DwC_predict.py [data filePath] [model filePath]")
        sys.exit(1)
    
    try:
        # delete fasttext deprecation warning
        fasttext.FastText.eprint = lambda x: None

        #print running time of loading data
        print('Loading data')
        start_time = time.time()
        df = pd.read_csv(sys.argv[1], delimiter = "\t",low_memory=False)
        print(f'    Records loaded : {len(df)}.')
        print(f'Data successful loading: {round(time.time() - start_time, 4)}s.')
        print()

        #print running time of loading model
        print('Loading model')
        start_time = time.time()
        model = fasttext.load_model(sys.argv[2])
        print(f'model successful loading: {round(time.time() - start_time, 4)}s.')
        print()

        #print running time of data clean, prediction and create the new output
        print('Predicting sampledFeature')
        start_time = time.time()
        predictText = dataProprecessing(df)
        #create the ouput file
        addSampledFeature(predictText, model, df).to_csv('new_dataset_with_sampledFeature.csv', index = False)
        print(f'model successful Prediciting and add labels to raw data: {round(time.time() - start_time, 4)}s.')
    except IOError:
        print(f"Could not open file: {sys.argv[1]}" )
    except ValueError as e:
        print(e)
    


if __name__ == "__main__":
    main()
