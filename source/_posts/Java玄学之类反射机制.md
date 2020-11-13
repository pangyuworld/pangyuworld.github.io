---
title: Java玄学之类反射机制
date: 2019-04-03 13:41:02
author: 小胖儿
mathjax: true
cover: /assets/1575087573085.png
tags:
	- Java
	- 反射
typora-root-url: ..
---

Java玄学之类反射机制

<!-- more -->

## 1、万事万物皆对象

哦豁，这标题乍一看就好像是某个大哲学家说的话，还“万事万物皆对象”，第一眼看下去就理解不了。

### 面向对象编程

其实，万事万物皆对象再面向对象编程里面还是可以理解的，当然，不要钻牛角尖。既然学习了Java，就一定知道什么是面向对象编程了。面向对象的编程的最终目的是什么呢？面向对象的最终目的就是把世间一切的东西都抽象化成对象。emmm，好像又说了一条玄学……下面还是详细的解说一下把： 
我们创建的类有自己的对象，比如`class A`就是一个A类，我们可以`new A()`来实例化一个对象。但是不要忘了，万事万物皆对象，因此，`class A`就是某一个类的对象，除此之外，其他任何你创造的或者说Java自带的类都是某一个类的对象。那么，这个类倒是什么呢？

### Class类

上面说的所有的类其实都是Class类的实例化对象，当然，这里不要钻牛角尖，不要去问什么`Class`类又是哪个类的对象。只要大家明白所有的其他类都是Class类的实例化对象就可以了。

### Class的实例对象的三种表示方式

看下面的代码

```java	
package com.demo;
public class HelloWorld{
	public static void main(String args[]){
		Foo foo1=new Foo();
		//第一种表示
		Class c1=Foo.calss;
		//第二种表示
		Class c2=foo1.getClass();
		//第三种表示
		try{
			Class c3=Class.forName("com.demo.Foo");
		}catch(ClassNotFoundException e){
			e.printStackTrace();
		}
	}
}
class Foo(){}
```

首先解析上面的代码:

```java
Foo是一个内部类，当然，内部类也可以被实例化。
首先我们实例化了一个Foo类的对象，这里说明一下，就好比foo1是Foo的对象一样，Foo也是Class的对象。
然后下面就是Class的实例对象的三种表示方法，简单的理解一下，比如第一种方式可以理解为任何一个类里面都有一个隐藏的静态变量class；第二种方式可以理解为任何一个类里面都有一个共有的方法getClass()，其返回值是这个类的Class的实例化对象；第三种方式可以理解为Class类自己拥有一个静态方法forName()用来通过类名获取指定的Class的实例对象。
```

### 一个类的Class对象表示了这个类的类类型（class type）

这句话让我想到了之前看的一个笑话，就大概是老外汉语考级的试题——“我一把把把把住了”。竟然，在程序的世界也有这么绕口的话！！什么叫类的类类型？其实就是比如Foo这个类和c1,c2,c3的关系，c1表示的是一个Class对象，这个对象指向的是Foo这个类，然后Foo这个类自己也可以去实例化自己的对象。这是一条条理很清晰的关系链：Class→实例化→c1→表示→Foo→实例化→foo1。这个关系参考一下就行，后面到应用的时候就能有更深刻的认识了。

## 2、动态类加载

我们刚刚理解了一个哲学性的难题“万事万物皆对象”，但是，有人会问了，我明白了这么难的哲学问题为啥我觉得一点用处都没有呢，别人都是理解了一个大的哲学问题就可以化身为哲学家了啊……emmm，咳咳，我们是程序员，我们不是哲学家，我们只是代码的搬运工。但是，既然明白了什么是“万事万物皆对象”，那就再来聊聊它的简单应用吧，不然怎么能成为一个Java高级攻城狮呢。

### 动态类加载和静态类加载区别

说动态类加载之前，肯定要问，既然有动态类加载，那么肯定就有静态类加载啊，那这两个有什么区别呢？ 
首先来看一个案例（摘自imooc）

#### 案例

这个案例尽量使用命令行去编译运行，详情请看[Java动态加载类](https://www.imooc.com/video/3733)

```java
public class Office{
	public static void main(String args[]){
		if(args.equals("Word")){
			Word word=new Word();
			word.start();
		}
		if(args.equals("Excel")){
			Excel excel=new Excel();
			excel.start();
		}
	}
}
```

首先我们来编译一下这个类。显而易见，这类肯定会出错，因为我们并没有创建Word和Excel类啊，而且也没有相应的start()方法。 
既然没有，就让我们来写一个Word类吧：

```java
public class Word{
	public static void start(){
		System.out.println("Word start .....");
	}
}
```

现在我们有Word类了，让我们来运行Office吧。什么？不行？为啥？因为没有Excel？老子只想用Word改改文档，为啥因为我没有Excel就不让我运行Word啊？ 
我们现在先不讨论上面的一大串问号，我们先来说说什么是**静态加载**：

```java
静态加载就是在编译的过程中，加载所有需要用到的类，就好比上面，我们启动Office 的时候，虚拟机会自动加载需要的Word和Excel类。
```

至少，现在我们知道什么是静态加载类了吧。然后，让我们来解决上面的问题。 
现在，我只有Word类，而且我只用的到Word，和excel没有任何关系。 
让我们来修改一下Office类

```java
public class Office{
	public static void main(String args[]){
		try{
			Class c=Class.forName(args[0]);
			}catch(Exception e){
			e.printStackTrace();
		}
	}
}	
```

现在我们重新编译一下Office这个类，是不是没有报错了（报错了的手打断，代码都打不对）。然后我们运行一下这个程序 
`java Office Word` 
咳咳，现在控制台上就显示出来“Word start…”的字样了，表示我们启动Word成功。而且，别忘了，我们并没有写Excel的类。

### 动态加载类的优势

通过上面的案例，其实已经可以看出动态类加载机制的好处或者说优点了。 
比如我们现在一个程序有很多模块，然后某个模块需要更新的时候，我们就可以进行动态更新，即只更新一下这个模块的类文件，然后重新启动这个类对应的模块就可以达到更新的效果，就不用麻烦的去把程序停止运行以后再更新这么麻烦了。

## 3、通过Class类获取类信息

既然任何一个类都是Class类的对象，如果Class类可以打印出来制定类的内部信息就好了。当然，Java已经帮我们完成了这个操作的封装，我们只需要调用几个方法即可：

### getName()方法和getSimpleName()

`getName()`获取对象的全称，包括包名。 
`getSimpleName()`获取对象名称，不包括包名 
我们可以使用下面的案例来演示这两个方法：

```java
public class Office{
	public static void main(String args[]){
		Class c1=String.class;//获取String类的Class对象
		System.out.println(c1.getName());
		System.out.println(c1.getSimpleName());
	}
}
```

我们看到，输出结果是

```java
java.lang.String
String
```

### getMethods()方法和getDeclaredMethods()方法

首先理解一下“万物皆对象”，方法也是一个对象，是一个Method对象，`getMethods()`方法可以返回一个Method的对象数组。 
`getMethods()`返回类的所有共有方法，包括继承父类和自身声明的 
`getDeclaredMethods()`返回类自身的方法，包括私有的，但是不能返回继承父类的方法。 
不放例子了，大家自己按着意思来写吧。

### Method类方法

`getName()`返回方法的名字 
`getReturnType()`返回方法的返回值类型 
`getParameterTypes()`返回参数的类型，返回值为一个Class数组