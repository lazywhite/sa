# -*- coding: utf-8 -*-

from sklearn import svm 
x = [[0, 0], [1, 1]]
y = [0, 1]

#clf = svm.SVC(kernel="linear")
'''
kernel
    rbf: 曲线
    linear:
    poly
    precomputed
gamma
C
'''
clf = svm.SVC()
clf.fit(x, y)


print(clf.predict([2, 2]))
print(clf.predict([-1, -1]))
