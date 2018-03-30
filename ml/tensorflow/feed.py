# -*- coding: utf-8 -*-
import tensorflow as tf

input1 = tf.placeholder(tf.float32)
input2 = tf.placeholder(tf.float32)
output = tf.multiply(input1, input2)

# 图中存在变量, 必须初始化
init_op = tf.global_variables_initializer()


with tf.Session() as sess:
    sess.run(init_op)
    print(sess.run([output], feed_dict={input1:[7.], input2:[8.]}))
