# -*- coding: utf-8 -*-
import tensorflow as tf

'''
keyword
    graph: 计算任务
    op (operation, 节点), 接受n个tensor, 产生m个tensor
    session: graph执行的上下文
    context
    tensor: 多维数组
        rank
        shape
        type
    variable: 维护图执行过程中的状态信息
    feed, fetch: 从arbitrary operation赋值或获取值

default graph
source op: 不接受输入, 产生输出并传递给其他op
为graph添加op
如果需要使用除第一个外其他的GPU, 需要显示的指定


运算
    tf.mul(a, b) 乘
    tf.add(a, b) 加
    tf.assign(a, b) 赋值
    tf.multiply(a, b) 乘
    tf.subtract(a, b) 减

datatypes
    tf.float32
    tf.float32: 32-bit single-precision floating-point.
    tf.float64: 64-bit double-precision floating-point.
    tf.bfloat16: 16-bit truncated floating-point.
    tf.complex64: 64-bit single-precision complex.
    tf.int8: 8-bit signed integer.
    tf.uint8: 8-bit unsigned integer.
    tf.int32: 32-bit signed integer.
    tf.int64: 64-bit signed integer.
    tf.bool: Boolean.
    tf.string: String.
    tf.qint8: Quantized 8-bit signed integer.
    tf.quint8: Quantized 8-bit unsigned integer.
    tf.qint32: Quantized 32-bit signed integer.

'''
matrix1 = tf.constant([[3., 3.]])
matrix2 = tf.constant([[2.], [2.]])
product = tf.matmul(matrix1, matrix2)

'''
sess = tf.Session()
result = sess.run(product)
print(result)
sess.close()
'''
'''
Session支持with协议
'''
with tf.Session() as sess:
    result = sess.run(product)
    print(result)

