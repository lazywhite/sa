# -*- coding: utf-8 -*-
from sklearn.datasets import  load_iris
from sklearn.tree import DecisionTreeClassifier
import numpy as np

iris = load_iris()


'''
print(iris.feature_names)
print(iris.target_names)
print(iris.data[0])
print(iris.target[0])


for i in range(len(iris.target)):
    print("Example %d: label %s, features %s" % (i, iris.target[i], iris.data[i]))

'''

test_idx = [0, 50, 100]

## training data
train_target = np.delete(iris.target, test_idx)
train_data = np.delete(iris.data, test_idx, axis=0)

## testing data
test_target = iris.target[test_idx]
test_data = iris.data[test_idx]

dtc = DecisionTreeClassifier()
dtc.fit(train_data, train_target)

print(test_target)
print(dtc.predict(test_data))

