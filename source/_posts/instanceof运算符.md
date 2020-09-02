---
title: instanceof运算符
date: 2019-04-03 13:46:04
author: 小胖儿
mathjax: true
cover: /assets/1575087573085.png
tags:
    - Java
---

instanceof是Java、php的一个二元操作符（运算符），和==，>，<是同一类东西。由于它是由字母组成的，所以也是Java的保留关键字。它的作用是判断其左边对象是否为其右边类的实例，返回boolean类型的数据。可以用来判断继承中的子类的实例是否为父类的实现。（摘自百度百科）

<!-- more -->

其用法为：

```java
boolean result = object instanceof class
/*Result：布尔类型。
Object：必选项。任意对象表达式。
class：必选项。任意已定义的对象类。*/
```

