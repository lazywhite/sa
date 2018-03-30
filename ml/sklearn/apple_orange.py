#-*- coding: utf-8 -*-
from sklearn import tree

# 重量和表面光滑度决定水果种类
# [140, 1]: 
    weight 140 
    smooth: 1
# labels
    0: apple
    1: orange

features = [[140, 1], [130, 1], [150, 0], [170, 0]]
labels = [0, 0, 1, 1]

classifier = tree.DecisionTreeClassifier()
classifier.fit(features, labels)

print(classifier.predict([[135, 0]]))
