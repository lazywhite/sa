# -*- coding: utf-8 -*-

from sklearn import datasets
iris = datasets.load_iris()
from sklearn.tree import DecisionTreeClassifier

X = iris.data
Y = iris.target


from sklearn.cross_validation import train_test_split
X_train, X_test, Y_train, Y_test = train_test_split(X, Y, test_size=.5)

from tensorflow.contrib import learn
import tensorflow as tf
feature_name = "flow_features"
feature_columns = [tf.feature_column.numeric_column(feature_name,
                                                    shape=[4])]

clf = tf.estimator.DNNClassifier(
    feature_columns=feature_columns,
    n_classes=3,
    model_dir="/tmp/iris_model",
    hidden_units=[100, 70, 50, 25])


def input_fn(dataset):
    def _fn():
        features = {feature_name: tf.constant(dataset.data)}
        label = tf.constant(dataset.target)
        return features, label
    return _fn

# Fit model.
clf.train(input_fn=input_fn(X_train),
               steps=1000)
print("fit done")
