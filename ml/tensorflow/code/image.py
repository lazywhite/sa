# -*- coding: utf-8 -*-
#
# Copyright © 2018 white <white@Whites-Mac-Air.local>
#
# Distributed under terms of the MIT license.

"""
"""
import tensorflow as tf
import numpy as np
import matplotlib.pyplot as plt

def add_layer(inputs, in_size, out_size, activation_function=None):
    Weights = tf.Variable(tf.random_normal([in_size, out_size]))
    bias = tf.Variable(tf.zeros([1, out_size]) + 0.1)

    outputs = tf.matmul(inputs, Weights) + bias

    if activation_function:
        outputs = activation_function(outputs)
    return outputs


x_data = np.linspace(-1, 1, 100)[:, np.newaxis]
noise = np.random.normal(0, 0.1, x_data.shape)
y_data = np.square(x_data) + noise

xs = tf.placeholder(tf.float32, [None, 1])
ys = tf.placeholder(tf.float32, [None, 1])

layer1 = add_layer(xs, 1, 10, tf.nn.relu)
prediction = add_layer(layer1, 10, 1, None)

loss = tf.reduce_mean(tf.reduce_sum(np.square(ys - prediction), 
                            reduction_indices=[1]))

step = tf.train.GradientDescentOptimizer(0.1).minimize(loss)

init = tf.global_variables_initializer()

figure = plt.figure()
ax = figure.add_subplot(1, 1, 1)
ax.scatter(x_data, y_data)
plt.ion()
plt.show()
with tf.Session() as session:
    session.run(init)
    for i in range(1000):
        session.run(step, feed_dict={xs:x_data, ys: y_data})
        if i % 50 == 0:
            try:
                ax.lines.remove(lines[0])
            except:
                pass
            #print(session.run(loss, feed_dict={xs:x_data, ys:y_data}))
            prediction_values = session.run(prediction, feed_dict={xs: x_data, ys: y_data})
            lines = ax.plot(x_data, prediction_values, 'r-', lw=5)
            plt.pause(0.1)
