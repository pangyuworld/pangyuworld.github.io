---
title: jfinal之Generator无法正常生成
date: 2019-04-03 13:30:21
author: 小胖儿
mathjax: true
cover: https://www.jfinal.com/assets/img/jfinallogo.png
tags:
	- jfinal
typora-root-url: ..
---

今天在部署jfinal的demo的时候，我自己在数据库添加了一个表，然后打算使用jfinal的Generator去生成相关信息，运行和很多遍都失败了，然后上网查询解决办法，解决办法倒是没有，<!-- more -->只有[波总，为何我用maven jfinal generator无法生成model呢？](http://www.jfinal.com/feedback/112)这样一个问题。参考了这个问题，我发现我的数据库信息声称在了WebRoot下的src路径。
知道哪里错了我还要知道怎么改，其实就是一个简单的文件操作，在
`String baseModelOutputDir = PathKit.getWebRootPath() + "/src/main/java/com/demo/common/model/base";`
这一行代码处的双引号里，前面加上/..，改完后的效果为
`String baseModelOutputDir = PathKit.getWebRootPath() + "/../src/main/java/com/demo/common/model/base";`

