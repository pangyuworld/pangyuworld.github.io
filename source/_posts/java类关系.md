---
title: java类关系
date: 2019-05-14 16:21:48
author: 小胖儿
mathjax: true
cover: /assets/1575087573085.png
tags:
	- Easy Coding
	- 面向对象
	- Java
---

**面向对象编程（Object-Oriented Programming，OOP）**是划时代的编程思想变革，推动了高级语言的快速发展和工业化进程。而面向对象的一个基础就是**类（Class）**。

关系是指事物之间存在单向或者相互的作用力或者影响力的状态。

类与类之间的关系可以分为两种：有关系的和没有关系的（抄的书上的废话），难点在于确定类与类之间是否存在相互作用。

类之间的关系是**设计模式**的前提，而设计模式是设计一个优秀的**框架**的前提。

<!-- more -->

## 类关系有哪些？

类关系一般分为下面6种情况：

| 类关系 |                           简单解释                           |
| :----: | :----------------------------------------------------------: |
|  继承  |                       extends（is-a）                        |
|  实现  |                     implement（can-do）                      |
|  组合  |                  类是成员变量（contains-a）                  |
|  聚合  |                    类是成员变量（has-a）                     |
|  依赖  | 是除组合和聚合外的单向弱关系。比如使用另一个类的属性、方法或以其作为方法的参数输入，或以其作为方法的返回值输出（depends-a） |
|  关联  |               是互相平等的依赖关系（links-a）                |

其实读了上面这个表格就真的明白了类关系了吗？可能大部分读者看完上面的表格都只能是明白了**继承**和**实现**这两种关系，剩下的比如**组合**和**聚合**傻傻分不清，**依赖**和**关联**完全没有看懂……

好吧，上面的表格只是先大概列出来类关系有哪些，具体的解释我们继续往下看。

## 类关系是什么？

### 继承

继承这个我们再熟悉不过了，毕竟它对应了一个关键字**extends**。

我们再来重新认识一下继承关系吧：

> 当一个类获取另一个类中所有非私有的数据和操作的定义作为自己的部分或全部成分时，就称这两个类之间具有继承关系。
>
> ——摘自《JAVA语言与面向对象设计（第2版）》

继承的代码实现也很简单，如下所示：

```java
public class FatherClass {
    private String firstName;
    protected String lastName;

    public String getName() {
        return firstName + " " + lastName;
    }

    public FatherClass(String firstName, String lastName) {
        this.firstName = firstName;
        this.lastName = lastName;
    }
}

public class SonClass extends FatherClass {
    private String className;

    public SonClass(String firstName, String lastName) {
        super(firstName, lastName);
    }
}
```

此时，`FatherClass`和`SonClass`类之间就称为继承关系。

其UML类图也很好画，如下图：

![1557824997782](/assets/1557824997782.png)

这其中，SonClass类拥有FatherClass中的所有非private属性和方法，包括：lastName，getName()。

说到继承关系就不得不说抽象类，抽象类的关键字是**abstract**，而抽象类不能直接创建，他必须要另外一个类通过继承（extentds）来实现。

通过上面的解释，我们在来看一下刚刚表格中对继承关系的描述**“is-a”**，如上例所示，可得这样一个说法，“Son is a father’s son.”

### 实现

**实现**也一样，我们再熟悉不过了，毕竟它也对应着两个关键字**interface**和**implement**。

有实现关系的地方就有**接口**，而接口是什么呢？

> 接口是用来组织应用中的各类并调节他们的相互关系的一种结构。
>
> ——摘自《JAVA语言与面向对象设计（第2版）》

接口和继承有一点最大的不同是：继承只能**单根继承**（即类只能继承一个直接父类），而接口可以继承多个接口（即多继承，使用“,”分格要继承的接口）。

接口的简单实现如下：

```java
public interface DogAction {
    
    void bark();

    void eat();
}

public class Doa implements DogAction {
    
    private String DogName;

    public void bark() {
        System.out.println("汪汪汪...");
    }

    public void eat() {
        System.out.println("吃骨头ing...");
    }
}
```

此时，Dog类和DogAction接口便是实现关系（Dog类实现了DogAction接口），Dog类包含DogAction接口中的所有方法（行为）。

其UML类图也很简单，如下所示：

![1557826957031](/assets/1557826957031.png)

说到这里，上面表格中的实现关系的间接“**can-do**”就可以很清楚的理解了，在这里可以这么说：“Dog can do dog’action.”

### 组合

组合和聚合在上面的表格中不分雌雄，但是既然分开叫了，那么他们两个肯定都有自己的特点。那么，什么是组合呢？

> 组合在汉语中的含义是把若干个独立部分组成整体，各个部分都有其独立的使用价值和生命周期。而类关系中的组合是一种完全绑定的关系，所有成员共同完成一件使命，它们的生命周期是一样的。组合体现的是非常强的整体与部分关系，同生共死，部分不能在整体之间共享。
>
> ——摘自《Easy Coding》

看了上面的解释，我估计大家心里已经有了一点点感觉，大概明白了什么是组合，不过就是那种说不出来的感觉。其实举个例子大家就知道了：

​	我们用手机壳（暂不考虑手机壳有其他奇葩功能）来做例子：手机壳一定是在有手机的情况下才有作用，而如果这个世界上没有了手机，那么手机壳也没有任何的存在意义了。这里的手机壳和手机就是一组组合关系，因为手机壳不能脱离手机单独生存。

如果还有什么不太清楚的，那就看一下下一节对聚合的解释然后再回过头来看看组合，应该会更加清晰。

代码示例如下所示：

```java
/** 
 * 手机壳类
 */
public class PhoneShell {
    
}

/**
 * 手机类
 */
public class Phone {
    /**
     * 手机的手机壳
     */
    private PhoneShell myPhoneShell;
    
}
```

上面的代码中，实际逻辑是，PhoneShell类只能应用在Phone类中，如果Phone类的对象被销毁了，那么对应的PhoneShell的类对象同时会被销毁，这就是组合。

组合关系的UML类图如下所示：

![1557969827919](/assets/1557969827919.png)

然后我们来对应到表格中的contains-a，翻译过来为：“A phone contains a phone shell”

