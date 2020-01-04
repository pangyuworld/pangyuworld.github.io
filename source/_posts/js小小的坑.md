---
title: js小小的坑
date: 2019-05-13 20:14:57
author: 小胖儿
mathjax: true
cover: https://ss1.bdstatic.com/70cFuXSh_Q1YnxGkpoWK1HF6hhy/it/u=3544507729,2758517078&fm=26&gp=0.jpg
tags:
	- JavaScript
---

![img](/assets/html.jpeg)

JavaScript作为一门弱类型的非编译型编程语言，很多坑都是特有的。前几天有一个公司来的架构师老师（下面简称为“老师”）给我出了几道相对还比较简单的JavaScript面试题，出了3道，我跪了3道，这可不得行。所以，还是把这三道简单的JavaScript题记录在这里吧，谨防下次在遇到还是不会。

当然，上周日在做项目的时候，队友还遇到了一个问题，这个问题涉及到了基本类型变量和对象的存储位置的问题，详情下面会说，这里还是记录一下。

<!-- more -->

### 面试题1：JavaScript中的this作用域

#### 原题如下：

```javascript
var object = { 
	a: 1,
	get: function() { 
		console.log(this.a);
	} 
};
object.get(); // 打印什么? 
var get = object.get; 
get(); // 打印什么 
```

#### 打印结果：

```javascript
1
undefine
```

#### 解题思路：

在JavaScript中，内部函数的`this`并不会根据其的使用位置绑定到`object`对象上，而是根据其访问的位置来进行引用。

比如这里，如果执行`object.get()`，那么`console.log(this.a)`中的`this`指向的是`object`这个对象，注意这里是通过对象调用其函数来执行的内部函数，所以会正常输出。

那么`var get = object.get`以后再执行`get()`呢？

这里要注意，其实`var get = object.get`这句话起到的作用是**将get这个变量指向了`object.get`这个内部函数**，所以下面执行`get()`的时候，其实就是直接执行了`object`对象里面的`get`函数，并不是通过对象访问到的；但是这里还是有`this`，这个`this`指向的是谁呢？通过下面的代码，得到的结果是：

```javascript
var object = {
      a: 1,
      get: function () {
        console.log(this);//注意这里改成了this
      }
    };
    object.get(); // 打印什么? 
    var get = object.get;
    get(); // 打印什么 
```

```javascript
{a:1,get:f}
undefine
```

原来什么都没有指向……这里当时老师给我们讲的是，JavaScript的this指针会向上寻址，直到指向全局，即window。

### 面试题2：var和let的区别

#### 原题如下：

```
var a = 10; 
function print() {
	console.log(a); 
	var a = 100; 
	console.log(a);
}
print(); // 分别打印出什么?
```

#### 打印结果：

```
undefine
100
```

#### 解题思路：

写过静态语言的同学肯定还清楚一个概念：**全局变量**。

JavaScript中也有全局变量的概念，但是我们看到上面的输出结果却令人大吃一惊。是的，如果按照静态语言的编程思路，上面应该输出10和100，可是JavaScript却很任性。那么这是为什么呢？

编写过C/CPP的同学肯定特别清楚两个概念：**声明**和**定义**。

声明：可以比拟为给未出生的孩子起一个名字。

定义：可以比拟为孩子出生。

当然，你可以声明的时候就定义，但是我上C语言课的时候老师教导我要先在头文件中进行声明，然后再在.c文件中进行定义。那么，这个跟JavaScript有什么关系呢？

其实通过打印结果来看，我们已经有了一些眉目，即**a变量在第一次输出的时候声明了但是没有定义**。确实是这个样子。JavaScript中，通过`var`创建的变量，会在**块最开始的位置（可以理解为左花括号开始的时候进行声明）**，而在真正的执行到了`var a = 100; `这条语句的时候才会真正的定义a变量。

如果有上述的描述，想必大家就能理解为什么会是这种输出结果了。

但是，代码之道、变幻万千，有的时候我们还真的不得不去这样编写代码，这种bug隐藏的如此之深，甚至js本来就已经不够严谨了，还要出这么不够严谨的bug，我们应该如何避免或者如何在编码时候发现呢？

有点JavaScript基础的同学都知道，变量的创建既可以通过`var`也可以通过`let`进行创建。

但是通过`let`创建的变量，就可以完美的解决上面的这个问题，示例代码如下：

```javascript
var a = 10; 
function print() {
	console.log(a); 
	let a = 100; 
	console.log(a);
}
print(); // 分别打印出什么?
```

其打印结果为：

```
VM123:3 Uncaught ReferenceError: Cannot access 'a' before initialization
    at print (<anonymous>:3:19)
    at <anonymous>:7:5
```

哦豁，报错了。是的呢，报错就是我们想要的结果，报错了我们才知道自己哪里错了，我们才知道要怎么debug，如果像上面一样使用var的时候不报错而输出undefine，可能我们排查bug都要花上几个小时的时间。

### 面试题3：JavaScript中的多线程

#### 原题如下：

```javascript
var arr=[1,2,3,4,5]; 
for (var i = 0; i < arr.length; i++) { 
	setTimeout(function() { 			
        console.log(arr[i]); },1000);                    	
	}  
}
// 打印什么? 
```

#### 打印结果：

```javascript
undefine
undefine
undefine
undefine
undefine
```

#### 解题思路：

其实这道题我错的是千不该万不该，因为我的回答是`55555`。

好吧，以后这种低级错误千万不要再犯了，下面就来说说这里为什么是`undefine x5`吧。

多线程在java中使用的相当广泛，因为java开发大部分是服务器开发，而服务器就会面临多个用户进行访问，其中每个用户就是一个线程……扯远了，这里仅仅是顺嘴提一下，**JavaScript也有多线程**。

比如上面的代码，其实很好理解，就是在循环中，有一个定时器，规定延时1000ms以后再执行`console.log(arr[i]); },1000)`这条语句。关键是`setTimeout()`这个函数，它会临时开辟一个线程进行延时，而不影响主线程。这样一来，就实现了JavaScript最简单的多线程了。

那么我们再看看代码，输出的是`arr[i]`，在多线程情况下，资源还是唯一的，所以每个线程对**变量i**的操作都会影响变量I的值。

即主线程仍然是在1000ms内完成了循环，同时子线程每隔1000ms执行一次打印语句(注意这个时候i的值已经随主线程执行的循环而变成了6)。

通过上述描述，因而得到输出的5次为`arr[6]`，所以会是undefine。

当然，这个问题其实要相当留意一下，因为以后在写js脚本的时候，尤其是请求API的时候，大多数使用的是异步访问，即多线程访问。访问API的过程并不会阻塞主线程的执行，所以在使用变量的时候要十分小心，不能直接在主线程里面赋值，而要在其回调函数中进行赋值。

### 附加题：JavaScript中的变量存储

#### 题目如下：

```javascript
var obj = {
    a:1
}
var temp = obj;
temp.a=10;
console.log(obj.a);
```

#### 打印结果：

```
10
```

#### 解题思路：

学习过java的同学应该很清楚，创建对象的语句是`Object obj = new Object()`这样的new语句，而像这种`Object temp = obj`，其实并不是创建了一个新的对象，而是将`temp`这个引用指向了`obj`指向的变量区。即现在这种情况下，`obj`和`temp`都指向了堆内存中的同一内存区。

其实上面的JavaScript代码和java的是一模一样，`obj`和`temp`都指向了同一内存区，所以对temp的改变即为对obj的改变。

那么想保留obj的拷贝应该如何做呢？答案是使用`Object.assign() `函数进行对象的浅拷贝。（当然，深拷贝也是可以的，其中具体的区别还请自行查阅资料）。

解决代码如下：

```javascript
var obj = {
    a:1
}
var temp = Object.assign({},obj);
temp.a=10;
console.log(obj.a);
```

此时输出为：

1

