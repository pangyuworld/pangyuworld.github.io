---
title: 'Spring Boot: No identifier specified for entity报错解决办法'
date: 2019-04-03 13:26:31
author: 小胖儿
mathjax: true
cover: /assets/u=2656353677,2997395625&fm=26&gp=0.jpg
tags:
	- spring boot
	- Java
---

遇到这种情况一般是因为实体类没有声明主键或者是`@Id`的位置放得不对。解决办法就是声明主键或者将`@Id`放在对应字段的get()方法上。

<!-- mroe -->

当然，世界BUG无奇不有，我今天遇到了一种奇葩的BUG。
代码如图：

![blob.jpg](/assets/5c20ce6d92b1d-1562131772082-1562131773467.jpg)

注意这里的第14行代码（其实就是换行，大不了再加4个空格），但是如果有第14行这个代码就要报错：No identifier specified for entity。如果把14行删除了代码就没问题了。

