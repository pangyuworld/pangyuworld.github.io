---
title: eclipse 小技巧
date: 2019-04-13 14:30:37
author: 小胖儿
mathjax: true
cover: http://img4.imgtn.bdimg.com/it/u=1376956266,2651901568&fm=26&gp=0.jpg
tags: 
	- Java
	- eclipse
	- IDE
---

为什么我们不用记事本写代码？因为记事本功能少。那么，eclipse功能就多吗？答案是，如果你不会使用eclipse的话，还不如使用记事本写代码。
如何使用eclipse呢？下面我介绍几点适用于java实验课的eclipse小技巧，如果想从事java开发的，还需要自行百度（因为我自己也不咋会使eclipse）

<!-- more -->

## 1、添加代码提示功能

不知道大家还记不记得当初写C语言或者C++的时候，你打一个`pri`编译器就会提示`printf`。如果你记得的话，你再去尝试一下eclipse，我猜大部分人都没有这个代码提示功能。难道eclipse没有这个功能吗？肯定不是噻，跟着我做，你就会获得一项技能**代码提示+代码补全**

### 操作步骤

 #### 1.打开eclipse

 #### 2.选择工具条的**Windows**

   ![](/assets/eclipse工具条.png)

 #### 3.选择**preferences**

   ![](/assets/eclipse选项.png)

 #### 4.选择java->Editor->Content Assist，然后在**Auto activation triggers for java**后面的输入框中输入`qwertyuiopasdfghjklzxcvbnm,.`(其实就是键盘上要用的字符按一遍)

   ![](/assets/eclipse菜单.png)

 #### 5.点击**Apply and Close**，获得新技能。

## 2、自动生成构造、get和set方法

写java的pojo类的时候很烦的就是get、set和构造方法，此时，编译器的强大就体现出来了，我们可以一键生成这些方法。而且操作简单，无需配置，是不是很刺激。继续跟着做，你将get新技能：

 #### 1.创建一个新的Student.java类用来测试

```java
public class Student{
	private int id;
	private String name;
}
```

 #### 2.右键，选择**source**

  ![](/assets/eclipse_source.png)

 #### 3.下面就是一些自动生成的按钮，分别介绍一下（就介绍要用到的，其他的自行百度吧）

![](/assets/9f67498909134c1c96a8bbaba3d6dc24.png)

 #### 4.生成get、set.选择**Generate Getters and Setters**，然后选择要生成的变量，然后点击**Generate**

![](assets/eace41cfe4684a8cb52f87242b87f8a2.png)

 #### 5.构造方法同理

 #### 6.恭喜你，get新技能!。