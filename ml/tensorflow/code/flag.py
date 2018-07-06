# -*- coding: utf-8 -*-
#
# Copyright © 2018 white <white@Whites-Mac-Air.local>
#
# Distributed under terms of the MIT license.

"""
python flag.py --param1 test 
python flag.py --param1 test --param2
python flag.py --param1 test --param2 True
"""

import tensorflow as tf

flags = tf.flags

flags.DEFINE_string("param1", "default", "description")
flags.DEFINE_bool("param2", False, "description")


def main():
    print(flags.FLAGS.param1)
    print(flags.FLAGS.param2)
    

if __name__ == '__main__':
    main()
