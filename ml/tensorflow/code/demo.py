# -*- coding: utf-8 -*-
import tensorflow as tf
import numpy as np

x_data = np.random.rand(100)
y_data = x_data * 0.1 + 0.2

b = tf.Variable(0.3)
k = tf.Variable(0.2)

y = x_data * k + b

loss = tf.reduce_mean(tf.square(y_data - y))

optimizer = tf.train.GradientDescentOptimizer(0.2)
train = optimizer.minimize(loss)

init = tf.global_variables_initializer()

with tf.Session() as session:
    session.run(init)

    for step in range(1, 201):
        session.run(train)
        if step % 20 == 0:
            print(step, session.run([k, b]))
