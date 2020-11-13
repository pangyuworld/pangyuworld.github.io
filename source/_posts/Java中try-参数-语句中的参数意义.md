---
title: 'Java中try(参数){}语句中的参数意义'
date: 2019-04-03 13:43:10
author: 小胖儿
mathjax: true
cover: /assets/1575087573085.png
tags:
	- Java
	- Java8
typora-root-url: ..
---

参考[Java中带参数的try(){}语法含义是什么？ - CSDN博客](https://blog.csdn.net/llkoio/article/details/78939148)
带资源的try语句（try-with-resource）的最简形式为：

```java
try(Resource res = xxx)//可指定多个资源
{
     work with res
}  
```

try块退出时，会自动调用res.close()方法，关闭资源。