# -*- coding: utf-8 -*-
#
# Copyright © 2018 white <white@Whites-Mac-Air.local>
#
# Distributed under terms of the MIT license.

"""
"""

from sklearn import tree
from sklearn.datasets import load_iris
from sklearn.cross_validation import train_test_split
from sklearn.metrics import accuracy_score
from sklearn.neighbors import KNeighborsClassifier
import random
from scipy.spatial import distance
from tensorflow.contrib import learn

def euc(a, b):
    return distance.euclidean(a, b)

class KNN():
    def fit(self, features, labels):
        self.features = features
        self.labels = labels

    def predict(self, test_data):
        predication = []
        for x in test_data:
            predication.append(self.closest(x))
        return predication

    def closest(self, data):
        best_index = 0
        best_dist = euc(data, self.features[0])
        for x in range(1, len(self.features)):
            distance = euc(data, x)
            if distance < best_dist:
                best_dist = distance
                best_index  = x
        return self.labels[best_index]


def main():
    '''
    features = [[140, 1], [130, 1], [150,0], [170,0]]
    labels = [0, 0, 1, 1]
    
    clf = tree.DecisionTreeClassifier()
    clf.fit(features, labels)
    print(clf.predict([[180, 0]]))
    '''
    iris = load_iris()
    #iris.feature_names # feature名称
    #iris.target_names # label名称

    data = iris.data # feature数据
    target = iris.target # label数据
    data_train, data_test, target_train, target_test = train_test_split(data, target, test_size=0.5)
    #clf = tree.DecisionTreeClassifier()
    #clf = KNeighborsClassifier()
    clf = KNN()
    clf.fit(data_train, target_train)
    predication = clf.predict(data_test)
    score = accuracy_score(target_test, predication)
    print(score)

   


if __name__ == '__main__':
    main()
