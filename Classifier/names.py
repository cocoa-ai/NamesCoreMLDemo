import pandas as pd
import numpy as np
from sklearn.utils import shuffle
from sklearn.feature_extraction import DictVectorizer
from sklearn.tree import DecisionTreeClassifier
from sklearn.pipeline import Pipeline
import coremltools

names = pd.read_csv('names_dataset.csv')
names = names.as_matrix()[:, 1:]

# We're using 80% of the data for training
TRAIN_SPLIT = 0.8

def features(name):
    name = name.lower()
    return {
        'first-letter': name[0],
        'first2-letters': name[0:2],
        'first3-letters': name[0:3],
        'last-letter': name[-1],
        'last2-letters': name[-2:],
        'last3-letters': name[-3:],
    }

# Vectorize the features function
features = np.vectorize(features)

# Extract the features for the whole dataset
X = features(names[:, 0]) # X contains the features
# Get the gender column
y = names[:, 1] # y contains the targets

# Shuffle
X, y = shuffle(X, y)
X_train, X_test = X[:int(TRAIN_SPLIT * len(X))], X[int(TRAIN_SPLIT * len(X)):]
y_train, y_test = y[:int(TRAIN_SPLIT * len(y))], y[int(TRAIN_SPLIT * len(y)):]

vectorizer = DictVectorizer()
dtc = DecisionTreeClassifier()

# Create pipeline
pipeline = Pipeline([('dict', vectorizer), ('dtc', dtc)])
pipeline.fit(X_train, y_train)

# Testing
print pipeline.predict(features(["Alex", "Emma"]))     # ['M' 'F']

# Accuracy on training set
print pipeline.score(X_train, y_train)
# Accuracy on test set
print pipeline.score(X_test, y_test)

# Convert to CoreML model
coreml_model = coremltools.converters.sklearn.convert(pipeline)
coreml_model.author = 'http://nlpforhackers.io'
coreml_model.license = 'Unknown'
coreml_model.short_description = 'Gender Classification using DecisionTreeClassifier'
coreml_model.input_description['input'] = 'A first name.'
coreml_model.output_description['classLabel'] = 'The most likely gender, for the given input. (F|M)'
coreml_model.output_description['classProbability'] = 'The probabilities for each gender, for the given input.'
coreml_model.save('Names.mlmodel')
