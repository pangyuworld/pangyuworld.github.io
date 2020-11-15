---
title: 深入java基础（1）--安装java
author: 小胖儿
mathjax: true
date: 2020-11-13 11:17:40
cover: /assets/深入java基础（1）/timg
tags:
 - Java
typora-root-url: ..
---

作为新手，学习java遇到的第一件痛苦的事情就是：安装java环境。因为java并不能像我们安装游戏一样，点个安装程序，然后静待安装完成就可以直接运行了（其实如果理解了配置环境变量是在做什么，我们也完全可以不用配置环境变量）。

现在网上安装和配置java环境的教程很多，但是大部分新手并不知道我们配置的每一步都是在做什么。所以，本篇博客旨在向新手阐述如何配置java环境变量以及为什么要如此设置环境变量。以后其实不止java需要配置环境变量，大部分软件开发相关的环境都需要配置，例如：node.js、mysql、maven等，如果你觉得理解了环境变量的作用，完全可以去尝试不看教程去配置一下这些环境。

# 1、环境变量是做什么的？

首先，我们先暂时不管配置Java环境，我们来思考一下环境变量是做什么用的。（我的系统版本是Windows 10 家庭版 19042.630）

## 查看环境变量

右键我的电脑，选择高级系统设置，然后点击环境变量即可查看环境变量，如下，右图即为环境变量

![image-20201113123606963](/assets/%7Bfilename%7D/image-20201113123606963.png)

如果想验证一下环境变量是否配置成功，我们可以使用命令行窗口：`Win+R`，然后输入`cmd`打开的那个窗口。然后输入指令`echo %环境变量名%`来验证环境变量是否配置成功，如下：

![image-20201113133807031](/assets/%7Bfilename%7D/image-20201113133807031.png)

因为MAVEN_HOME这个环境变量配置成功，所以会输出变量的值，因为JAVA_HOME这个环境变量并没有配置（或没配置成功），所以输出的就是原字符串。

当然，你也可以自己在系统变量或者用户变量上随意添加新的环境变量，然后尝试一下输出，不过要注意，不要随意删除系统设置的环境变量，否则会发生各种不可预知的情况。

## 环境变量中的Path

找到环境变量Path，然后双击。Windows10针对环境变量的页面改的更人性化了，双击以后一般情况是如下界面

![image-20201113124347927](/assets/%7Bfilename%7D/image-20201113124347927.png)

那么为什么单独说一下这个环境变量？我们来做个简单的测试

1. 在D盘新建一个名为test.bat（bat是批处理文件类型）的文件，并用记事本打开，输入这段代码并保存`echo "Hello World"`
2. 打开命令行窗口，进入到D盘目录，输入`D:`即可
3. 输入`test.bat`，如下：

![image-20201113133757605](/assets/%7Bfilename%7D/image-20201113133757605.png)

4. 我们再打开一个命令行窗口，不仅如此D盘目录，直接输入指令`test.bat`，如下

![image-20201113133748209](/assets/%7Bfilename%7D/image-20201113133748209.png)

思考：为什么不进入D盘目录就无法运行指令`test.bat`？因为这个文件在D盘目录下，默认C盘没有这个文件，所以无法执行

5. 打开刚刚的Path环境变量页面，点击新建，然后在新的输入框中添加D盘根目录路径，即`D:\`，然后一路点击确定，保存环境变量

![image-20201113132258500](/assets/%7Bfilename%7D/image-20201113132258500.png)

6. 保存完毕后，重复第4步操作（我们再打开一个命令行窗口，不仅如此D盘目录，直接输入指令`test.bat`），然后此时，我们可以得到和步骤3一样的结果，即我们在非D盘的目录下运行了这个文件。

![image-20201113133733340](/assets/%7Bfilename%7D/image-20201113133733340.png)

总结：Path环境变量关系到我们在命令行窗口执行文件的路径。

思考：假如我们在`D:/`和`D:/test/`下分别有test.bat这个文件，且这两个路径我们都添加到Path环境变量中了，那么我们直接执行`test.bat`这个指令，此时系统会执行哪个文件？

# 2、配置Java开发环境

上面我们学习了环境变量的作用，下面我们来实战一下如何配置Java开发环境

## 2.1 安装jdk

从官网下载安装程序，将jdk安装到计算机某个位置，例如我的`D:\software\development\Java`

## 2.2 测试jdk安装是否成功

和其他教程不一样的是，我们先进行测试，然后再进行配置环境变量

1. 打开命令行窗口，执行以下代码（注意更换路径）`D:\software\development\Java\bin\java -version`，此时你会发现，别的教程中最后一步进行测试的步骤你在第一步就可以完成了

![image-20201113133937475](/assets/%7Bfilename%7D/image-20201113133937475.png)

​		同理，测试`javac`指令也可以如此`D:\software\development\Java\bin\javac`

![image-20201113134036792](/assets/%7Bfilename%7D/image-20201113134036792.png)

​		如果你通过上面步骤发现执行的指令不正确（一般提示‘xxx’不是内部或外部命令...）的话，那么大概率是你的jdk路径问题或者jdk安装出现了问题，输入正确的路径或重新安装jdk即可。

2. 写一段简单的Java代码，并且尝试运行。上Java的第一节课肯定是要大家用指令运行项目，其指令也非常简单，就使用到了`javac`和`java`两个指令。如下：

   新建一个文件Hello.java，并使用记事本编写如下代码：

   ```java
   public class Hello{
       public static void main(String[] args) {
           System.out.println("Hello World");
       }
   }
   ```

   打开命令行窗口，进入到该文件所处的目录

   > 小技巧：可以通过在资源管理器的目录处输入cmd然后回车，即可快速在当前路径打开命令行窗口，如图
   >
   > ![image-20201114095223550](/assets/%E6%B7%B1%E5%85%A5java%E5%9F%BA%E7%A1%80%EF%BC%881%EF%BC%89/image-20201114095223550.png)

   然后根据上一步的指令来运行这段java代码：

   - 通过指令编译.java文件`D:\software\development\Java\bin\javac Hello.java`，生成文件Hello.class
   - 通过指令运行java代码`D:\software\development\Java\bin\java Hello`，即可执行上段Java代码

   ![image-20201114100023421](/assets/%E6%B7%B1%E5%85%A5java%E5%9F%BA%E7%A1%80%EF%BC%881%EF%BC%89/image-20201114100023421.png)

到这里，我们其实已经可以正常运行**简单的Java程序**了，只不过，每次都写上Java的路径，比较麻烦，所以，下面我们来配置一下环境变量。

## 2.3 配置环境变量

### 2.3.1 Path变量

为了简单使用Java指令，我们只需要在Path变量中将`D:\software\development\Java\bin`添加上即可。

> 值得注意的是，我在尝试安装Java8环境时，发现现版本的JDK1.8安装包（不确定是不是仅有该版本安装包）会自动在Path变量中添加一个javapath，如图
>
> ![image-20201114103552219](/assets/%E6%B7%B1%E5%85%A5java%E5%9F%BA%E7%A1%80%EF%BC%881%EF%BC%89/image-20201114103552219.png)
>
> 注意与我第一张图的区别，第一行便是安装包自动添加的环境变量，然后我进入到该目录下查看，发现该目录仅有三个文件
>
> ![image-20201114103717523](/assets/%E6%B7%B1%E5%85%A5java%E5%9F%BA%E7%A1%80%EF%BC%881%EF%BC%89/image-20201114103717523.png)
>
> 此时，如果不去配置其他变量的话，我们是可以执行`java -version`这个指令，但是执行`javac`指令时会提示找不到指令。且，如果你目标的Java版本与`java -version`输出的版本不一致的话，会导致eclipse安装不上（我学弟就遇到了这个问题）。这里我建议的解决办法就是**将这个环境变量删除，自己配置环境变量**。

### 2.3.2 JAVA_HOME和CLASSPATH

其实，配置完Path变量以后，我们就已经配置好Java环境了，但是网上大部分教程还要求配置`JAVA_HOME`和`CLASSPATH`这两个环境变量。那么，我们先来了解一下为何要配置两个环境变量。

参考：[Java开发环境配置|菜鸟教程](https://www.runoob.com/java/java-environment-setup.html)

> ![image-20201114105155229](/assets/%E6%B7%B1%E5%85%A5java%E5%9F%BA%E7%A1%80%EF%BC%881%EF%BC%89/image-20201114105155229.png)

- JAVA_HOME：观察上面要配置的变量值，CLASSPATH和Path中都有`%JAVA_HOME%`，此处即为引用该环境变量，方便我们统一配置统一修改。另外，我在查询JAVA_HOME作用的时候，有文章说例如Tomcat这类软件会调用JAVA_HOME这个变量，但是这类软件应该不多，且更多可配置（如maven就是直接调用Path这个环境变量，即直接调用Java指令）
  - 结论：大多数情况下，可以选择不配置JAVA_HOME这个环境变量，不过只是一个变量而已，配置了也不会影响太多（在使用绝对路径当做Path变量值得情况下）
- CLASSPATH：这个环境变量在官方文件中已经明确说明，1.5版本以上的JDK不用设置CLASSPATH，其官方解释如下：

>![image-20201115092800647](/assets/%E6%B7%B1%E5%85%A5java%E5%9F%BA%E7%A1%80%EF%BC%881%EF%BC%89/image-20201115092800647.png)
>
>网址：https://docs.oracle.com/javase/1.5.0/docs/tooldocs/windows/classpath.html

