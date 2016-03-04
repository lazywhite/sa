module(class(resource))-->node 'FQDN' { class1, class2 } --> catalog --> agent(facter)



常用的资源类型：
    group, user
    package
    file
    service
    notify
    yumrepo
    exec 
    cron
    mount


资源引用：
    类型['资源名称']
    引用时，类型的首字母要大写；

    before => 资源引用

    require => 资源引用

资源：metaparameters

puppet的数据类型：
    字符型：直接字符串
    数组：['element1','elemet2']


在资源属性中，所有标记namevar，默认值为title；
puppet变量：
    1、使用$开头，无论是定义还是引用；
    2、变量有其作用域
        class, module

FQN
    $::abc

$abc='hello puppet'

$abc=undef


abc[0], abc[1]

{ key1 => hello, key2 => world}

hash[key1]

puppet支持条件判断:
    if, case, selector


/^(CentOS|RedHat)/Linux/ig

(?i-mx:^(CentOS|Redhat))




字符型，数值型，数组[,,]，布尔型，映射{key1 => val1,...}，undef，正则表达式（只能用于支持使用=~, !~这种符号的场景中）
puppet：资源申报, manifest，资源清单(.pp)

class：代表了一个完整的应用，或某应用的独立片断；

module: 目录
    files/
    manifests/*.pp

master/agent: 
    master: 定义节点
        node 'FQDN' {
            class
        }

manifest文件可能包含编程结构，master要首先运行程序（不是应用资源或者类），catalog


type {'title':
    attribute => value,
    ...
}

资源引用：Type['title']

顺序和通知
    顺序：before => , require => 
    通知：notify => , subscribe => 


# puppet describe -l
# puppet describe type

定义：

class class_name {
    
}

class class_name ($para1='val1',$para2='val2') {
    
}


class {'class_name':}

class {'class_name':
    para1 => new_val1,
    para2 => new_val2,
}

类可以继承：

class parent_class::class_name inherits parent_class {
    require +> [],
}


class class_name {
    class sub_class_name_1 {

    }

    class sub_class_name_2 {

    }
}


站点清单：/etc/puppet/manifests/
    site.pp
        node 'FQDN' {
            include class
        }

master/agent


puppet类不支持多重继承，因此，不能多次继承，也不直接继承自多个类。


站点清单：site.pp

节点也可以继承

node 'base' {
        include nginx
}

node 'node2.test.com' inherits 'base' {
    include nginx::nginx_web
}


import 'abc.pp'
import '*.pp'
import 'abc/*.pp'




顺序，通知
before, require
notify, subscribe

编程结构：
if CONDITION {
    
}

and, or, !
==, =~, !~, in

$operatinsystem in ['abc','efg']


case CON_EXP {
    case1, ...: { expression }
    ...
    default: {  }
}


selector CON_EXP ? {
    case: value
    ...
    default: value
}
