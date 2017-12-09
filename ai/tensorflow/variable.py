# -*- coding: utf-8 -*-
import tensorflow as tf

## 变量赋值
state = tf.Variable(0, name="counter")
one = tf.constant(1)
new_value = tf.add(state, one)
update = tf.assign(state, new_value)

input1 = tf.constant(3.0)
input2 = tf.constant(2.0)
input3 = tf.constant(5.0)

intermed = tf.add(input2, input3)
mul = tf.multiply(input1, intermed)

# 图中存在变量, 必须初始化
init_op = tf.global_variables_initializer()


with tf.Session() as sess:
    sess.run(init_op)
    print(sess.run(state))

    for _ in range(3):
        sess.run(update)
        print(sess.run(state))

    # fetch data
    result = sess.run([mul, intermed])
    print(result) 
