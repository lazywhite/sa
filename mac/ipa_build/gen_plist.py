#!/usr/bin/env python
# -*- coding: utf-8 -*-
from lxml import etree
from ipa import IPAFile
import os
import sys


def create_plist_file(ipa_path=None, url=None):
    '''
        ipa path should be a absolute path
    '''

    ipafile = IPAFile(ipa_path)
    ipa = ipafile.app_info


    s = """<?xml version="1.0" encoding="UTF-8"?>
    <plist version="1.0" />"""

    tree = etree.fromstring(s)
    dict_root = etree.SubElement(tree,'dict')
    key_root = etree.SubElement(dict_root,'key')
    key_root.text = "items"

    array_root = etree.SubElement(dict_root,'array')
    dict_second = etree.SubElement(array_root,'dict')

    #1
    key_second = etree.SubElement(dict_second,'key')
    key_second.text = "assets"

    #2
    array_second = etree.SubElement(dict_second,'array')
    #2-1 dict
    dict_second_1 = etree.SubElement(array_second,'dict')

    #2-1-1 key
    key_second_1 = etree.SubElement(dict_second_1,'key')
    key_second_1.text = "kind"

    #2-1-2 string
    string_second_2 = etree.SubElement(dict_second_1,'string')
    string_second_2.text = "software-package"

    #2-1-3 key
    key_second_3 = etree.SubElement(dict_second_1,'key')
    key_second_3.text = "url"

    #2-1-4 string
    string_second_4 = etree.SubElement(dict_second_1,'string')
    string_second_4.text = url

    #3
    key_third = etree.SubElement(dict_second,'key')
    key_third.text = "metadata"

    #4
    dict_fourth = etree.SubElement(dict_second,'dict')

    # #4-1 key
    key_fourth_1 = etree.SubElement(dict_fourth,'key')
    key_fourth_1.text = "bundle-identifier"

    #4-2 string
    key_fourth_2 = etree.SubElement(dict_fourth,'string')
    key_fourth_2.text = ipa['CFBundleIdentifier']

    #4-3 key
    key_fourth_3 = etree.SubElement(dict_fourth,'key')
    key_fourth_3.text = "bundle-version"

    #4-4 string
    key_fourth_4 = etree.SubElement(dict_fourth,'string')
    key_fourth_4.text = ipa['CFBundleVersion']

    #4-5 key
    key_fourth_5 = etree.SubElement(dict_fourth,'key')
    key_fourth_5.text = "kind"

    #4-6 string
    key_fourth_6 = etree.SubElement(dict_fourth,'string')
    key_fourth_6.text = "software"

    #4-7 key
    key_fourth_7 = etree.SubElement(dict_fourth,'key')
    key_fourth_7.text = "title"

    #4-8 string
    key_fourth_8 = etree.SubElement(dict_fourth,'string')
    key_fourth_8.text = ipa['CFBundleName']

    e = etree.tostring(tree, encoding="UTF-8",
                         xml_declaration=True,
                         pretty_print=True,
                         doctype='<!DOCTYPE plist PUBLIC "-//Apple//DTD PLIST 1.0//EN" "http://www.apple.com/DTDs/PropertyList-1.0.dtd">')


    plist_dir = os.path.dirname(ipa_path)
    ipa_name = os.path.basename(ipa_path)
    plist_name = ipa_name.split('.')[0] + '.plist'
    plist_path = os.path.join(plist_dir, plist_name)
    ########### 将DOM对象doc写入文件
    with open(plist_path, 'w') as f:
        f.write(e)
    return plist_path
   

if __name__ == '__main__':
    ipa_path = sys.argv[1]
    url = sys.argv[2]
    print create_plist_file(ipa_path, url)
