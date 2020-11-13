---
title: 将jfinal部署在自己的云服务器上
date: 2019-04-03 13:38:26
author: 小胖儿
mathjax: true
cover: https://www.jfinal.com/assets/img/jfinallogo.png
tags:
	- jfinal
	- 建站
typora-root-url: ..
---

将jfinal部署在自己的云服务器上

官方文档

[jfinal部署在tomcat上](https://my.oschina.net/jfinal/blog/353062 "jfinal部署在tomcat上")
[jfinal文档](http://www.jfinal.com/doc/1-5 "jfinal文档")

<!-- more -->

## 遇到的坑

首先，我还是先看到的第一篇文档，然后照做了。emmm，试验了大概足有6个小时吧，失败了，翻看了很多文档和论坛，就是没有找到解决办法。

## 最终解决

今天翻看jfinal文档的时候，看到了第二篇文档里面的内容：

> JFinal 项目是符合 java web 规范的普通项目，所以开发者原有的项目启动和部署知识全部有效，不需要特殊对待 JFinal 项目。
> 因此，本章介绍的所有启动方式仅仅针对于 JFinal 内部提供的 jetty 整合方式。当碰到启动问题时如果不是在使用 jfinal 整合的 jetty 在启动，那么决然与 jfinal 无关，从网上查找java web启动的知识即可解决。
> 如果不使用 JFinal 内部提供的jetty整合方式启动，那么可以去掉对 jetty-server-2018.11.jar 的依赖，maven 项目则可删掉对 jetty-server 的 dependency 配置。

上面是最终的解决办法，下面解释一下如何做的吧。

## 部署步骤

### 1、安装tomcat

不论是Ubuntu还是Windows或者其他什么坑系统吧，既然是运行在tomcat上，那么必须要安装一个tomcat，具体配置请自行百度。

## 2、查看自己有没有使用jeety包

因为我使用的是的maven工程，所以我直接在opm.xml文件中注释掉jeety包就OK了，如果没有使用maven的话，那就直接删除jeety包吧。

### 3、打包jfinal工程

就是最普通的打包web服务器的方法，自行百度。

### 4、将打包包的jfinal工程放到云服务器上

其实就是将jfinal的打包放到tomcat的webapps下面

5、启动tomcat

## 6、尝试访问

ip地址:端口号/项目名

# 大功告成

## 还是我的座右铭，办法总比困难多，有时候解决一件事不要像我一样死脑筋……