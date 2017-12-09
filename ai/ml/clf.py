# -*- coding: utf-8 -*-

from sklearn import datasets
iris = datasets.load_iris()
from sklearn.tree import DecisionTreeClassifier

X = iris.data
Y = iris.target

print(iris.data[0])

from sklearn.cross_validation import train_test_split
X_train, X_test, Y_train, Y_test = train_test_split(X, Y, test_size=.5)

from scipy.spatial import distance
def euc(a, b):
    return distance.euclidean(a, b)

## simple classifier
class MyKNN():
    def fit(self, x, y):
        self.x = x
        self.y = y
    def predict(self, x):
        predictions = []
        for row in x:
            label = self.closest(row)
            predictions.append(label)
        return predictions
    def closest(self, row):
        best_dist = euc(row, self.x[0])
        best_index = 0
        for i in range(1, len(self.x)):
            dist = euc(row, self.x[i])
            if dist < best_dist:
                best_dist = dist
                best_index = i

        return self.y[best_index]


from sklearn.neighbors import KNeighborsClassifier
#clf = KNeighborsClassifier()
#clf = DecisionTreeClassifier()
clf = MyKNN()

'''
from tensorflow.contrib import learn
import tensorflow as tf
feature_name = "flow_features"
feature_columns = ['sepal length (cm)', 'sepal width (cm)', 'petal length (cm)', 'petal width (cm)']
clf = learn.DNNClassifier(hidden_units=[10, 20, 10], n_classes=3, feature_columns=feature_columns)
#clf.fit(X_train, Y_train, steps=200)

'''
clf.fit(X_train, Y_train)

prediction = clf.predict(X_test)

from sklearn.metrics import accuracy_score
print(accuracy_score(Y_test, prediction))
