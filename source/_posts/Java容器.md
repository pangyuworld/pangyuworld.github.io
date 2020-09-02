---
title: Java容器
date: 2019-04-03 13:43:52
author: 小胖儿
mathjax: true
cover: /assets/1575087573085.png
tags:
	- Java
	- 数据结构
---

我们要储存多个对象可以怎么做?没接触“容器”之前我们都是使用的数组，但是有个局限，就是数组是定长的，我们没法去动态改变数组的长度，这就出现了这么一个问题，要么多余的数组浪费了，要么数组容量不够大……
为了使数组动态改变长度成为可行性，引入“容器”的概念。

<!-- more -->

## 1、最常见的容器类ArrayList

### ArrayList构造器

```java
public ArrayList();
```

默认构造器，将会以默认（16）的大小来初始化内部的数组。

```java
public ArrayList(int);
```

用指定大小来初始化内部的数组

```java
public ArrayList(ICollection);
```

用一个ICollection对象来构造，并将该集合的元素添加到ArrayList。

- 为了方便介绍，我们新建一个全局的ArrayList对象al，即ArrayList al=new ArrayList();

### 添加方法add()

```java
al.add(Object);
/*第一种用法是直接添加对象*/
al.add(int,Object);
/*第二种用法是在指定位置添加对象*/
```

### 删除方法remove()

```java
al.remove(int);
/*第一种用法是删除指定位置的对象*/
al.remove(Object);
/*第二种用法是删除指定对象*/
```

### 替换方法set()

```java
al.set(int,Object);
/*用于将容器指定位置里的对象替换为参数对象*/
```

### 判断是否存在方法contains()

```java
al.contains(Object);
/*判断某个对象是否在容器里面存在*/
```

### 获取指定对象位置方法indexOf()

```java
al.indexOf(Object);
/*获取某个对象在容器中的位置*/
```

### 获取指定位置对象方法get()

```java
al.get(int);
/*获取容器中某个位置的对象*/
```

### 获取大小方法size()

```java
al.size();
/*获取容器的大小*/
```

### 转换为数组方法toArray()

```java
al.toArray();
/*将容器对象转换为数组对象*/
```

### 把另一个容器所有对象都加进来addAll()

```java
al.addAll(ArrayList);
/*把另一个容器所有对象都加进来*/
```

### 清空方法clear()

```java
al.clear();
/*清空一个容器*/
```

## 2、实现接口List

ArrayList实现了接口List
常见的写法会把引用声明为接口List类型

## 注意：是java.util.List,而不是java.awt.List

常见写法

```java
List al=new ArrayList();
```

## 3、Generic泛型

### 为什么引入泛型

到这里，我还不知道泛型是什么，但是学容器的时候会有这么一个问题：

> 容器里面可以放很多种对象（基本数据类型也是对象），但是每种对象的方法不一样，使用的方法不是自己的方法的时候，编译器就会抛出异常。当我们放的对象太多的时候，根本就记不清楚容器里面究竟哪个对象是哪个类型了。

### 泛型如何在容器里使用

- 不指定泛型的容器，可以存放任何类型的元素
- 指定了泛型的容器，只能存放指定类型的元素以及其子类

```java
List<Object> al=new ArrayList<Object>();
```

上面就是泛型在容器里的使用，构造了一个指定了某种泛型的容器。

## 4、遍历

### for循环遍历

前面提到了size()方法和get()方法，通过这两个方法然后结合for循环就可以遍历出容器里面的内容。
结构如下：

```java
for(int i=0;i<al.size();i++){
	System.out.println(al.get(i));
}
```

### 迭代器遍历

使用迭代器Iterator遍历集合中的元素

```java
Iterator it=al.iterator();
//如果容器制定了泛型的话，在声明Iterator时候也要制定泛型，例如Iterator<Object> it=al.iterator();
while(it.hasNext()){
	System.out.println(it.next());
}
//从最开始的位置判断"下一个"位置是否有数据
//如果有就通过next取出来，并且把指针向下移动
//直到"下一个"位置没有数据
```

### 用增强型for循环

```java
for(Object h:al){
	System.out.println(h);
}
```