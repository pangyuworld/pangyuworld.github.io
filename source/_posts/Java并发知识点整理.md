---
title: Java并发知识点整理（1）
author: 小胖儿
mathjax: true
cover: /assets/1575087573085.png
date: 2019-10-18 16:26:06
tags:
	- Java
	- 高并发
typora-root-url: ..
---

![](/assets/jva.jpg)

Java多线程知识点整理。

今天才学习完[尚硅谷Java视频_JUC 视频教程_哔哩哔哩 (゜-゜)つロ 干杯~-bilibili](https://www.bilibili.com/video/av21398578)，然后结合自己对于Java多线程的理解，汇总了下面的知识点，这是第一篇，后面还要出一篇。

不过这点Java多线程知识远远不够，后面应该在校招之前还要继续看高并发的东西然后再出几篇博客……

<!-- more -->

# 一、Java创建线程的四种方式

这里说的是**创建线程**的四种方式，然后很多教材和博客上会说*创建线程的方式有三种*，其实创建线程池也是创建了线程，只是不执行任务而已。

## 1. 继承Thread类实现多线程

核心方法：`public void run()`

示例代码如下：

```java
public class MyThread extends Thread{
    public void run(){
        for(int i=0;i<10;i++){
            // 输出当前线程名 + 当前的i值
            System.out.println(Thread.currentThread().getName() + " : " + i);
        }
    }
    public static void main(String...args){
        MyThread t1=new MyThread();
        MyThread t2=new MyThread();
        MyThread t3=new MyThread();
        t1.start();
        t2.start();
        t3.start();
    }
}
```

## 2. 实现Runnable接口实现多线程

核心方法：`public void run()`

示例代码如下：

```java
public class MyThread implements Runnable{
    @Override
    public void run(){
        for(int i=0;i<10;i++){
            // 输出当前线程名 + 当前的i值
            System.out.println(Thread.currentThread().getName() + " : " + i);
        }
    }
    public static void main(String...args){
      	MyThread t1=new MyThread();
        new Thread(t1).start();
        new Thread(t1).start();
        new Thread(t1).start();
    }
}
```

>`java.lang.Thread`和`java.lang.Runnable`的异同：
>
>1. 通过查阅JDK文档，我们可以看到，`Thread`类也实现了`Runnable`接口
>2. `Thread`类由于Java单继承限制，因此通过继承实现多线程的灵活性较差；而`Runnable`接口可以让类实现多个接口，比较灵活
>3. 在实现`Runnable`这种方式中，使用了简单的代理模式：`MyThread`类负责业务操作，而`Thread`类负责资源调度与线程创建

## 3. 实现Callable<T>接口实现多线程（jdk1.5以后）

核心方法：`public T call()`

示例代码如下：

```java
public class MyThread implements Callable<Integer>{
    @Override
    public Integer call(){
        int sum=0;
        for(int i=0;i<10;i++){
            sum+=new Randow().nextInt(10);//随机数之和
        }
        return sum;
    }
    
    public static void main(String...args){
        MyThread t1=new MyThread();
        FutureTask<Integer> task=new FutureTask<>(t1);
        new Thread(task).start();// 运行线程
        try {
            System.out.println(result.get());//打印结果
        } catch (InterruptedException e) {
            e.printStackTrace();
        } catch (ExecutionException e) {
            e.printStackTrace();
        }
    }
}
```

> `java.util.concurrent.Callable<T>`接口和`java.lang.Runnable`接口异同
>
> 1. 实现了`Callable<T>`的对象并不能直接运行，需要以其为参数实现一个`java.util.concurrent.FutureTask<V>`对象，然后才可以放到`Thread`对象里面执行
> 2. `Callable<T>`支持返回值，泛型为返回值类型，并且可以抛出异常
> 3. 接受的返回值通过`FutureTask<V>`对象的`get()`方法获得
> 4. `FutureTask<V>`可以用于**闭锁**

## 4. 创建线程池

线程池负责线程的使用与调度，但不负责线程内部的业务逻辑，因此创建线程池仅仅是创建了线程，如果要执行相应的业务逻辑，还是需要使用上述三种方式创建线程实现的类。

示例代码如下：

```java
public MyThread{
    public static void main(String...args){
        ExecutorService pool = Executors.newFixedThreadPool(2);//创建一个仅有2个线程的线程池实例
        // 向线程池添加任务
        pool.submit(new Runnable(){
            @Override
            public void run(){
                for(int i=0;i<10;i++){
                    System.out.println(Thread.currentThread().getName()+" : "+i);
                }
            }
        });
        // 当线程池中的任务都完成后，关闭线程池
        pool.shutdown();
    }
}
```

# 二、Thread类详解

下面来仔细介绍几个`Thread`类中的重要方法……

## 1. 构造方法

### 1.1 Thread()

构造一个新的Thread对象

### 1.2 Thread(Runnable target)

构造一个新的Thread对象，并且将Runnable接口参数作为自己的运营对象。即当执行`start()`方法后，执行的将是`target.run()`方法

### 1.3 Thread(Runnable target, String name)

构造一个新的Thread对象，实现`Thread(Runnable target)`构造方法，并且将这个新的Thread对象的线程名设置为`name

## 2. static Thread currentThread()

返回当前正在执行的线程对象的引用。

这个静态方法的作用一般是用于在通过实现`Runnable`接口或`Callable`接口的线程类中，需要使用到当前执行的线程对象的引用。例如获取当前执行的线程的线程名就要在`run()`方法中这么写`Thread.currentThread().getName()`

## 3. 获取线程信息

### 3.1 public long getId()

获取线程的标识符。这个线程ID是创建线程时候自动生成的唯一ID，在线程销毁后可以复用。

### 3.2 public String getName()

获取线程名。线程名可以通过程序自动生成，也可以通过构造方法来指定线程名，还可以通过`serName(String name)`来设置线程名

### 3.3 public int getStackTrace()

获取线程的优先级。线程优先级可以通过`setPriority(int newPriority)`来设置优先级（一般为0到10）

线程优先级越高，该线程越可能被分配到CPU资源。

### 3.4 public boolean isDaemon()

获取这个线程是否为守护线程。可以通过`setDaemon(boolean on)`方法来设置该线程是否为守护线程。

## 4. 线程控制

### 4.1 public void start()

开始执行线程，Java虚拟机开始调用此线程的`public void run()`方法

### 4.2 public void join()/public void join(long millis)

将该线程加入到主线程，等待最多millis毫秒的时间（默认为无穷），当主线程执行到`join()`方法时，主线程会挂起，只有当超时或该线程完成操作后，主线程才会继续往下执行。

下面是个例子，通过例子自行体会其中的奥秘：

```java
public class TestJoin {
    public static void main(String...args){
        Thread td=new Thread(new Runnable() {
            @Override
            public void run() {
                for (int i=0;i<10;i++){
                    System.out.println(i);
                    try {
                        Thread.sleep(200);
                    } catch (InterruptedException e) {
                        e.printStackTrace();
                    }
                }
            }
        });
        td.start();
        try {
            td.join(200);
        } catch (InterruptedException e) {
            e.printStackTrace();
        }
        try {
            Thread.sleep(300);
        } catch (InterruptedException e) {
            e.printStackTrace();
        }
        System.out.println("--------");
    }
}
```

### 4.3 public static void sleep(long millis)

是当前正在执行的线程停留millis毫秒的时间。

### 4.4 其他控制线程的方法

#### `Object.wait()`/`Object.wait(long timeout)`

可以看到，这是Object内置的一个方法，该方法可以导致当前线程等待，直到超时（默认为无穷）或另一个线程调用`Object.notify()`方法或`Object.notifyAll()`方法。

#### `Object.notify()`/`Object.notifyAll()`

唤醒当前对象或唤醒全部对象。这两个方法可以配合上面`Object.wait()`方法来解决同步问题（又叫**等待-唤醒**机制）。

例：

```java
public class Clerk {
    private int product = 0;

    //进货
    public synchronized void get() {
        while (product >= 1) {
            System.out.println("产品已满，无法添加");
            try {
                this.wait();
            } catch (InterruptedException e) {
                e.printStackTrace();
            }
        }
        System.out.println(Thread.currentThread().getName() + " : " + ++product);
        this.notifyAll();

    }

    //卖货
    public synchronized void sale() {
        while (product <= 0) {
            System.out.println("缺货！");
            try {
                this.wait();
            } catch (InterruptedException e) {
                e.printStackTrace();
            }
        }
        System.out.println(Thread.currentThread().getName() + " : " + --product);
        this.notifyAll();

    }
}
```

# 三、同步（并发）问题

多线程的同步问题指的是多个线程同时修改一个数据的时候，可能导致的问题

## 1. 产生同步问题的案例

```java
public class ConcurrencyTest implements Runnable {
    static int cont = 0;

    @Override
    public void run() {
        for (int i = 0; i < 5000; i++) {
            cont += 1;
        }
    }

    public void getCont() {
        System.out.println(cont);
    }

    public static void main(String[] agrs) throws InterruptedException {
        ConcurrencyTest c1 = new ConcurrencyTest();
        Thread t1 = new Thread(c1);
        Thread t2 = new Thread(c1);
        t1.start();
        t2.start();
        // 让主线程等待子线程完成
        t1.join();
        t2.join();
        c1.getCont();
    }

}
```

上面这个案例逻辑很简单，就是让程序开辟两个线程同时对`cont`进行+1操作5000次，我们预期的结果应该是**10000**，但是多运行几次我们会发现，结果并不像我们预期的那样，而总是一个小于等于10000的数，而这个数我们一般称为**脏数据**。

上面这个就是一个典型的多线程同步问题。

## 2. 解决多线程同步问题-`synchronized`

对于`synchronized`关键字的解释将在[四、2.  理解`synchronized`关键字](##2. 理解`synchronized`关键字)说明，这里仅仅先展示其用法。

代码修改如下：

```java
public class ConcurrencyTest implements Runnable {
    static int cont = 0;

    /** 
     * 第一种方式
     */
    @Override
    public void run() {
        synchronized (this) { // 这里为对象添加了synchronized关键字
            for (int i = 0; i < 5000; i++) {
                cont += 1;
            }
        }
    }
    /** 
     * 第二种方式
     */
    @Override
    public synchronized void run() { // 这里为对象修饰符处添加了synchronized关键字
        for (int i = 0; i < 5000; i++) {
            cont += 1;
        }
    }

    public void getCont() {
        System.out.println(cont);
    }

    public static void main(String[] agrs) throws InterruptedException {
        ConcurrencyTest c1 = new ConcurrencyTest();
        Thread t1 = new Thread(c1);
        Thread t2 = new Thread(c1);
        t1.start();
        t2.start();
        // 让主线程等待子线程完成
        t1.join();
        t2.join();
        c1.getCont();
    }

}
```

这个改进的案例展示了`synchronized`关键字的两种使用方式：

- 使用在代码块处，括号中的参数为需要同步的**对象**，案例中需要同步的对象是其本身，因此是`synchronized(this)`
- 使用在方法声明处，与访问修饰符、静态修饰符同级，表示对该方法进行同步

## 3. 解决多线程同步问题-`java.util.concurrent.Lock`

对于`java.util.concurrent.Lock`的解释将在[四、3. 显示锁`java.util.concurrent.Lock`](##3. 显示锁`java.util.concurrent.Lock`)进行解释，这里仅仅展示它的使用方法。

```java
public class ConcurrencyTest implements Runnable {
    static int cont = 0;
    private Lock lock=new ReentrantLock(); // 获取锁

    @Override
    public void run() {
        lock.lock();// 加锁
        for (int i = 0; i < 5000; i++) {
            cont += 1;
        }
        lock.unlock();// 释放锁
    }

    public void getCont() {
        System.out.println(cont);
    }

    public static void main(String[] agrs) throws InterruptedException {
        ConcurrencyTest c1 = new ConcurrencyTest();
        Thread t1 = new Thread(c1);
        Thread t2 = new Thread(c1);
        t1.start();
        t2.start();
        // 让主线程等待子线程完成
        t1.join();
        t2.join();
        c1.getCont();
    }

}
```

这段代码和使用`synchronized`的代码最终效果是一样的，都可以输出`10000`，然后`Lock`显示锁的一般使用方法就是这样子的，但是要注意，一定要执行`unlock()`方法，否则对象会一直持有锁，导致程序阻塞。

## 4. 剖析产生并发问题的原因

首先我们先理解一个概念叫**内存可见性**：当多个线程操作共享数据时候，彼此不可见

大概意思就是在多线程项目中，我们的内存可以简单的理解为**主存**和**线程缓存**，而线程的所有操作都是先从主存中获取变量的当前值，然后在自己的线程缓存中进行的，如下图：

![1571452781443](/assets/1571452781443.png)

在案例中，线程1和线程2每次执行运算操作都要先从主存中获取当前的x，然后再对x做一个+1操作，然后把结果返回给主存；但是由于线程是**并行**执行的，因此很可能出现线程1还没有将自己的运算结果返回给主存，然后线程2就读取了主存中的x值，这样一来，线程2就相当于做了一次重复的运算，并且这个结果还会返回给主存导致后面的运算全部出错……由此，产生了脏数据。

# 四、锁

## 1. 什么是锁

在Java多线程编程中，锁可以理解为对象拥有的一种资源或标志。通常情况下，持有锁的对象只能有一个线程对齐进行操作，而其他线程尝试访问的时候会被阻止。

对比上面的剖析，我们可以认为，每次某个线程需要操作数据的时候，一定会确认其他线程已经完成了对这个数据的操作，并且成功的返回到了主存中，此时该线程才会从主存中读取数据然后进行计算。

Java中的锁大概有两类：

- `synchronized`关键字
- `java.util.concurrent`包下面的锁

## 2. 理解`synchronized`关键字

这里参考了*《Java编程思想》p677*

> 当任务要执行被`synchronized`关键字保护的代码片段的时候，它将检查锁是否可用，然后获得锁，执行代码，释放锁。
>
> 所有对象都自动含有单一的锁（也称为监视器）。当在对象上调用包含`synchronized`关键字的方法的时候，该对象会被加锁，这个时候该对象上的其他被`synchronized`关键字修饰的方法需要等待上一个方法执行完毕并释放锁后才可以被执行。

上面第一段说的是锁的作用；第二段表名锁是针对整个对象而言的，而不是针对某一个方法而言的。

示例代码如下所示：

```java
public class ConcurrencyTest implements Runnable {

    private boolean b;

    public ConcurrencyTest(boolean b) {
        this.b = b;
    }

    @Override
    public void run() {
        if (b){
            getA();
        }else {
            getB();
        }
    }

    public synchronized void getA(){
        for (int i=0;i<50;i++){
            System.out.print('a');
        }
    }
    public synchronized void getB(){
        for (int i=0;i<50;i++){
            System.out.print('b');
        }
    }

    public static void main(String[] agrs) throws InterruptedException {
        ConcurrencyTest c1 = new ConcurrencyTest(true);
        ConcurrencyTest c2 = new ConcurrencyTest(false);
        Thread t1 = new Thread(c1);
        Thread t2 = new Thread(c2);
        t1.start();
        t2.start();
        // 让主线程等待子线程完成
        t1.join();
        t2.join();
        System.out.println();
    }

}
```

对于上面的代码中的`getA()`和`getB()`方法有如下三种情况：

- 两个方法同时没有添加`synchronized`关键字，输出的a和b是乱序的，证明在执行任意方法的时候，另一个方法可以同时执行
- 两个方法同时添加`synchronized`关键字，输出的是整齐的字符串，证明在执行任一方法的时候，另一个方法都必须等待上一个方法执行完才可以执行
- 其中一个方法添加`synchronized`关键字，被修饰的方法输出的是整齐的字符串，但是其开头和结尾会插入另一个方法的字符，这个情况就可以证明前面说的第二段内容

刚才所说，`synchronized`是给对象加锁，那么修饰方法的`synchronized`关键字就可以理解为下面这一段代码：

```java
synchronized(this){
    // 方法代码
}
```

有时候，方法会被`static`修饰，如果一个方法同时被`static synchronized`两个关键字修饰，那么这个方法就被称为**静态同步方法**，此时，`synchronized`关键字就不是给`this`加锁了，而是给这个类的`Class`对象加锁，类似于下面的代码：

```java
synchronized(Object.class){
    // 方法代码
}
```

## 3. 显示锁`java.util.concurrent.Lock`

显示锁对应的是隐式锁，隐式锁就是通过`synchronized`修饰的方法或者对象，其为对象加的锁我们成为**隐式锁**，而使用`java.util.concurrent.Lock`对象来给对象加锁，我们称为**显示锁**。

`Lock`是一个接口，其接口中定义了一下几个方法：

- `void lock()`获得锁
- `Condition newCondition()`返回一个新的Condition绑定到Lock实例，对于Condition下面会进行讲解
- `boolean tryLock()`如果锁没有被其他线程占有的时候，则该方法返回`true`且和`lock()`方法作用相同，如果锁被其他线程占有，则返回`false`，然后不再等待释放锁，而是直接跳过执行；一般要和if…else…配合使用
- `void unLock()`释放锁

使用显示锁的一大好处就是**更加灵活**，在使用的时候，只要在需要加锁的代码段前面使用`lock()`方法获取锁，然后在需要加锁的代码段后面使用`unlock()`释放锁即可，而`synchorinzed`关键字只能用在一个 代码块或者一个方法上，相比之下灵活性较弱。

使用`Lock`的方式很简单，只需要在类中定义一个`Lock`对象即可：`Lock lock=new ReentranLock()`，然后根据上面的描述使用`lock`对象即可。

### 3.1 `java.concurrent.locks.Condition`类

上面所讲，我们可以通过Lock对象的`newCondition()`方法得到一个新的`Condition`对象绑定到`Lock`对象。

这个`Condition`是什么呢？这个类大概就是实现了对于Lock接口的`Object.wait()`方法和`Object.notify()/Object.notifyAll()`方法。他有如下几个重要的方法：

- `public void awite()` 导致当前线程暂停，类似于`Object.wait()`方法
- `public void signal()` 唤醒当前线程，类似于`Object.notify()`方法
- `public void signalAll()` 唤醒所有线程，类似于`Object.notifyAll()`方法

# 五、关键字`volatile`

## 1. `volatile`关键字的使用

在了解`volatile`关键字之前，我们先看一下下面这个例子：

```java
public class TestVolatile {

    public static void main(String... args) {
        ThreadDemo td = new ThreadDemo();
        new Thread(td).start();

        while (true) {
            if (td.isFlag()) {
                System.out.println("--------------");
                break;
            }
        }
    }

}

class ThreadDemo implements Runnable {

    private boolean flag = false;

    @Override
    public void run() {
        try {
            Thread.sleep(200);
        } catch (InterruptedException e) {
            e.printStackTrace();
        }
        flag = true;
        System.out.println("flag = " + isFlag());
    }

    public boolean isFlag() {
        return flag;
    }
}
```

上面这个程序，我们预计的输出应该是

```
flag = true
--------------
```

但是，我们将这段代码放到编译器中执行，发现程序只输出`flag = true`，然后主线程就**阻塞**了……

这是为什么呢？我们来分析一下上面案例中的代码：

> 1. 程序一共有两个线程：主线程和子线程
> 2. 子线程中有修改`flag`的操作，即写入数据；而主线程中有读取`flag的操作，即读取数据
> 3. 子线程中延迟了0.2s然后才对flag进行修改
> 4. 主线程中读取`flag`的操作卸载了`while(true)`中，即死循环中，除非`flag`为真才停止

然后我们利用前面第三节**剖析产生并发问题的原因**中所介绍的，主线程也是线程，主线程读取数据也应该从主存中进行读取，然后再进行操作。不过呢，由于while的执行效率极其之高，导致主线程中的死循环代码无法读取到更新后的`flag`值（可以通过在while(true)里面添加一个1ms的延迟来观看效果）。

至于解决办法，确实可以使用我们上面的`synchronized`关键字或`Lock`锁使操作同步，但是这里我们换一种实现方式：使用`volatile`关键字修饰变量。

解决方式为：将上面第19行代码，即声明`flag`处的代码改为：`private volatile boolean flag = false`

添加了`volatile`关键字修饰后的`flag`变量，对其的写操作会比对其的读操作先发生*参考《深入理解Java虚拟机》p376*，由于此案例两个线程分别包含了对`flag`的读操作和写操作，那么对于`volatile`的规则则是允许的。

## 2. `volatile`与`synchronized`的区别

- `volatile`是一种较为轻量级的**同步策略**，它提供的是一种**非阻塞同步**，而`synchronized`以及锁都是一种**阻塞同步**
- `volatile`不具备“互斥性”（互斥性：当一个线程占有锁的时候，其他线程不可以访问锁住的数据）
- `volatile`不能保证变量的“原子性”

前两点我们可以通过上面的案例很好理解。首先，阻塞同步的性能在于处理器进行线程阻塞或唤醒线程带来的性能问题，而`volatile`并不会对线程进行阻塞或唤醒（或者说是需要的时候再进行这些操作）；其次，“互斥性”等同于“互斥同步”或“阻塞同步”，所以`volatile`不具备“互斥性”

下面我们着重对第三点进行讲解。

### 2.1 原子性

首先再看个案例：

```java
public class ConcurrencyTest implements Runnable {
    static volatile int cont = 0;

    @Override
    public void run() {
        for (int i = 0; i < 5000; i++) {
            cont ++;
        }
    }

    public void getCont() {
        System.out.println(cont);
    }

    public static void main(String[] agrs) throws InterruptedException {
        ConcurrencyTest c1 = new ConcurrencyTest();
        Thread t1 = new Thread(c1);
        Thread t2 = new Thread(c1);
        t1.start();
        t2.start();
        // 让主线程等待子线程完成
        t1.join();
        t2.join();
        c1.getCont();
    }

}
```

这个案例就是之前的产生同步问题的案例，不过我们为那个共享的变量添加了一个刚刚学习的`volatile`关键字，但是我们运行之后并不能得到我们期待的结果10000。

由此，我们引出了**原子性**问题：

> **i++ 原子性问题**：i++的操作实际上分为三步，即**读-改-写**，翻译成代码如下：`int temp=i;i=temp+1;return i;`。因为i++的操作分成了三个步骤，且中间有个临时变量生成，因此我们不能只使用`volatile`修饰变量来保证i++的正常执行。

### 2.2 原子变量

jdk1.5以后，java.util.concurrent.atomic包下提供了大量**原子变量**，这些原子变量就是专门为了解决原子性问题的。

首先我们来看看原子变量都有哪些：

`AtomicBoolean`
`AtomicInteger`
`AtomicLong`
`AtomicReference`
`AtomicLongArray`
`AtomicReferenceArray`
`AtomicIntegerFieldUpdater`
`AtomicReferenceFieldUpdater`
`LongAdder`
`LongAccumulator`
`DoubleAdder`
`DoubleAccumulator`

这些原子变量几乎包含了所有我们在实际开发中要使用到的变量类型。

然后是这些原子变量的使用：

```java
public class ConcurrencyTest implements Runnable {
    static volatile AtomicInteger cont = new AtomicInteger(0);

    @Override
    public void run() {
        for (int i = 0; i < 5000; i++) {
            cont.getAndIncrement();
        }
    }

    public void getCont() {
        System.out.println(cont);
    }

    public static void main(String[] agrs) throws InterruptedException {
        ConcurrencyTest c1 = new ConcurrencyTest();
        Thread t1 = new Thread(c1);
        Thread t2 = new Thread(c1);
        t1.start();
        t2.start();
        // 让主线程等待子线程完成
        t1.join();
        t2.join();
        c1.getCont();
    }
}
```

对于这些原子变量的使用，我们可以参考jdk文档。

### 2.3 原子变量实现原理（CAS算法）

原子变量的实现原理主要是**CAS（Compare-And-Swap）**算法。下面就来说说到底什么是CAS算法

>CAS定义了三个操作数：1. 内存值**V**  2. 预估值**B**  3. 更新值**A**
>
>在执行更新操作的时候，**当且仅当V\=\=A时，才会使得V\=\=B，否则不进行任何操作**，但是无论是否更新了V的值，都会返回V的旧值

这个CAS算法的简单实现我们可以参考下面的代码：

```java
class CompareAndSwap {
    private int value;

    // 获取内存值
    public synchronized int get() {
        return value;
    }

    // 比较
    public synchronized int compareAndSwap(int expectedValue, int newVale) {
        int oldValue = value;

        if (oldValue == expectedValue) {
            this.value = newVale;
        }
        return oldValue;
    }


    public synchronized boolean compareAndSet(int expectedValue, int newValue) {
        return expectedValue == compareAndSwap(expectedValue, newValue);
    }
}
```

