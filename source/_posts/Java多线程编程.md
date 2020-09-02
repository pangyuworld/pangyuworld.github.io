---
title: Java多线程编程
date: 2019-04-03 13:47:28
author: 小胖儿
mathjax: true
cover: /assets/1575087573085.png
tags:
	- 高并发
	- Java
---

emmmm，多线程在C++ 里面就没正儿八经的看过，也不知道咋个用，实战一次也就是哪个鼠标乱动的程序，使用多线程配合输出函数。不过还好，在C++唯一一次多线程编程还是成功了的。
多线程是什么呢，对于我这种对操作系统一概不知的小白来说，多线程就是摒弃了一心一用的传统概念，让处理器每个单位时间内把每个任务都推进一点。

<!-- more -->

#### 多线程第一个demo

说得再多不如先放一个demo跑跑，明白多线程是个什么。

```java
/* 代码来源于菜鸟教程http://www.runoob.com */
class RunnableDemo implements Runnable {
   private Thread t;
   private String threadName;
   
   RunnableDemo( String name) {
      threadName = name;
      System.out.println("Creating " +  threadName );
   }
   
   public void run() {
      System.out.println("Running " +  threadName );
      try {
         for(int i = 4; i > 0; i--) {
            System.out.println("Thread: " + threadName + ", " + i);
            // 让线程睡眠一会
            Thread.sleep(50);
         }
      }catch (InterruptedException e) {
         System.out.println("Thread " +  threadName + " interrupted.");
      }
      System.out.println("Thread " +  threadName + " exiting.");
   }
   
   public void start () {
      System.out.println("Starting " +  threadName );
      if (t == null) {
         t = new Thread (this, threadName);
         t.start ();
      }
   }
}
 
public class TestThread {
 
   public static void main(String args[]) {
      RunnableDemo R1 = new RunnableDemo( "Thread-1");
      R1.start();
      
      RunnableDemo R2 = new RunnableDemo( "Thread-2");
      R2.start();
   }   
}
```

运行结果：

> Creating Thread-1
> Starting Thread-1
> Creating Thread-2
> Starting Thread-2
> Running Thread-1
> Thread: Thread-1, 4
> Running Thread-2
> Thread: Thread-2, 4
> Thread: Thread-1, 3
> Thread: Thread-2, 3
> Thread: Thread-1, 2
> Thread: Thread-2, 2
> Thread: Thread-1, 1
> Thread: Thread-2, 1
> Thread Thread-1 exiting.
> Thread Thread-2 exiting.

从这个demo中就可以看出来多线程的效果是个什么样子的了，我就不多解释了（内心PS：我解释也解释不出来了）

#### 解析上面的程序（实现Runnalbe接口）

Java创建线程有两种方法：1、实现Runnable接口（就是上面的demo）；2、扩展Thread类，其实就是继承Thread类
好了，第一行，实现Runnable接口，这是菜鸟教程上对Runnable接口的介绍：

> 创建一个线程，最简单的方法是创建一个实现 Runnable 接口的类。
> 为了实现 Runnable，一个类只需要执行一个方法调用 run()，声明如下：
> public void run()
> 你可以重写该方法，重要的是理解的 run() 可以调用其他方法，使用其他类，并声明变量，就像主线程一样。
> 在创建一个实现 Runnable 接口的类之后，你可以在类中实例化一个线程对象。
> Thread 定义了几个构造方法，下面的这个是我们经常使用的：
> Thread(Runnable threadOb,String threadName);
> 这里，threadOb 是一个实现 Runnable 接口的类的实例，并且 threadName 指定新线程的名字。
> 新线程创建之后，你调用它的 start() 方法它才会运行。
> void start();

也没啥可介绍的了，继续往下把。
声明一个Thread类的对象，这一步非常必要（当然，如果你创建了线程，不让他运行的话，那就没这个对象什么事情了）。
然后是声明定义私有变量、构造函数都不说了。
然后是实现run()函数。这一步有必要说明一下：	
​	*就像上面所说，实现一个Runnable接口其实只需要一个run()函数，这个run()函数就是线程的主体，和main()函数差不多，这个run()函数里面可以像主线程那样子调用其他方法，引用其他类，声明变量啥的，都可以做到。*
​	*仅有的不同是run()函数在程序中确立另一个并发的线程执行入口，当run()返回时，该线程结束。*
然后，run()函数里面这个异常处理的结构不是很懂，但是在编写Java代码的时候，如果要使用Thread类的静态函数的话，就必须要使用这个异常处理的结构，当个重点画起来。
后面这个start()函数就是上面声明那个Thread对象的必要性的原因。可以看到start()函数里面首先判断这个对象是否为空（有点不明白，如果不为空会怎么样），然后实例化这个对象，然后调用这个对象的start()函数。这个Thread::start()函数执行的其实是对run()的调用。
再往下，就是主类里面定义对象并调用类函数的过程，不多说。

#### 扩展Thread类

上面说到可以使用两种方法创建线程，其实这两种方法没有太大区别。（目前在我眼里它俩只是写法不同）
这是菜鸟教程的描述：

> 创建一个线程的第二种方法是创建一个新的类，该类继承 Thread 类，然后创建一个该类的实例。
> 继承类必须重写 run() 方法，该方法是新线程的入口点。它也必须调用 start() 方法才能执行。
> 该方法尽管被列为一种多线程实现方式，但是本质上也是实现了 Runnable 接口的一个实例。
> 这里也不用浪费笔墨多写一大段代码了，小白可以直接把上面的demo的第一行改为

```java 
class ThreadDemo extends Thread
```

#### 两种方法的异同？

我小白一个也不知道有啥异同，抄书了炒熟了：

> 到这里，你一定会奇怪为什么Java有两种创建子线程的方法，哪一种更好呢。所有的问题都归于一点。Thread类定义了多种方法可以被派生类重载。对于所有的方法，惟一的必须被重载的是run()方法。这当然是实现Runnable接口所需的同样的方法。很多Java程序员认为类仅在它们被加强或修改时应该被扩展。因此，如果你不重载Thread的其他方法时，最好只实现Runnable 接口。这当然由你决定。

#### Thread方法

这里考试要考，画上重点（皮一下）
**这是Thread类非静态方法：**

------

- 1	public void start()
  使该线程开始执行；Java 虚拟机调用该线程的 run 方法。

- - -

- 2	public void run()
  如果该线程是使用独立的 Runnable 运行对象构造的，则调用该 Runnable 对象的 run 方法；否则，该方法不执行任何操作并返回。

- - -

- 3	public final void setName(String name)
  改变线程名称，使之与参数 name 相同。

- - -

- 4	public final void setPriority(int priority)
   更改线程的优先级。

- - -

- 5	public final void setDaemon(boolean on)
  将该线程标记为守护线程或用户线程。

- - -

- 6	public final void join(long millisec)
  等待该线程终止的时间最长为 millis 毫秒。

- - -

- 7	public void interrupt()
  中断线程。

- - -

- 8	public final boolean isAlive()
  测试线程是否处于活动状态。

- ------

  **这是Thread类静态方法**

- - -

- 1	public static void yield()
  暂停当前正在执行的线程对象，并执行其他线程。

- - -

- 2	public static void sleep(long millisec)
  在指定的毫秒数内让当前正在执行的线程休眠（暂停执行），此操作受到系统计时器和调度程序精度和准确性的影响。

- - -

- 3	public static boolean holdsLock(Object x)
  当且仅当当前线程在指定的对象上保持监视器锁时，才返回 true。

- - -

- 4	public static Thread currentThread()
  返回对当前正在执行的线程对象的引用。

- - - 

- 5	public static void dumpStack()
  将当前线程的堆栈跟踪打印至标准错误流。

- - - 

#### 线程优先级

看了看，不会用，直接甩书上的教程把。

> 线程优先级被线程调度用来判定何时每个线程允许运行。理论上，优先级高的线程比优先级低的线程获得更多的CPU时间。实际上，线程获得的CPU时间通常由包括优先级在内的多个因素决定（例如，一个实行多任务处理的操作系统如何更有效的利用CPU时间）。一个优先级高的线程自然比优先级低的线程优先。举例来说，当低优先级线程正在运行，而一个高优先级的线程被恢复（例如从沉睡中或等待I/O中），它将抢占低优先级线程所使用的CPU。
> 理论上，等优先级线程有同等的权利使用CPU。但你必须小心了。记住，Java是被设计成能在很多环境下工作的。一些环境下实现多任务处理从本质上与其他环境不同。为安全起见，等优先级线程偶尔也受控制。这保证了所有线程在无优先级的操作系统下都有机会运行。实际上，在无优先级的环境下，多数线程仍然有机会运行，因为很多线程不可避免的会遭遇阻塞，例如等待输入输出。遇到这种情形，阻塞的线程挂起，其他线程运行。但是如果你希望多线程执行的顺利的话，最好不要采用这种方法。同样，有些类型的任务是占CPU的。对于这些支配CPU类型的线程，有时你希望能够支配它们，以便使其他线程可以运行。
>
> ------
>
> 设置线程的优先级，用setPriority()方法，该方法也是Tread 的成员。它的通常形式为：
> final void setPriority(int level)
> 这里，level指定了对所调用的线程的新的优先权的设置。Level的值必须在MIN_PRIORITY到MAX_PRIORITY范围内。通常，它们的值分别是1和10。要返回一个线程为默认的优先级，指定NORM_PRIORITY，通常值为5。这些优先级在Thread中都被定义
> 为final型变量。
> 你可以通过调用Thread的getPriority()方法来获得当前的优先级设置。该方法如下：
> final int getPriority( )

PS:上面的勉强看懂了，放着吧，反正不会用。

------

## 分界线：

因为我在自己使用线程优先级编写例程的时候，没有发现线程的优先级区别，所以特意从网上找了找相关的博客，发现了这么一句话：

> 线程的优先级仍然无法保障线程的执行次序。
> 只不过，优先级高的线程获取CPU资源的概率较大，优先级低的并非没机会执行。
> 如果CPU有空闲，即使是低优先级的线程，也可以得到足够的执行时间，接近满负荷执行。 
> 如果CPU比较繁忙，优先级的作用就体现出来了，优先级高的线程能得到比较多的执行时间，优先级比较低的线程也能得到一些执行时间，但会少一些；CPU越繁忙，差异通常越明显。

------

在放一个demo：

```java 
class clicker implements Runnable {
    int click = 0;
    Thread t;
    private volatile boolean running = true;
    public clicker(int p) {
        t = new Thread(this);
        t.setPriority(p);
    }
    public void run() {
        while (running) {
            click++;
        }
    }
    public void stop() {
        running = false;
    }
    public void start() {
        t.start();
    }
}
class HiLoPri {
    public static void main(String args[]) {
        Thread.currentThread().setPriority(Thread.MAX_PRIORITY);
        clicker hi = new clicker(Thread.NORM_PRIORITY + 2);
        clicker lo = new clicker(Thread.NORM_PRIORITY - 2);
        lo.start();
        hi.start();
        try {Thread.sleep(10000);
        } catch (InterruptedException e) {
            System.out.println("Main thread interrupted.");
        }
        lo.stop();
        hi.stop();
// Wait for child threads to terminate.
        try {
            hi.t.join();
            lo.t.join();
        } catch (InterruptedException e) {
            System.out.println("InterruptedException caught");
        }
        System.out.println("Low-priority thread: " + lo.click);
        System.out.println("High-priority thread: " + hi.click);
    }
}
```

> 上述程序还有个值得注意的地方。注意running前的关键字volatile。用在此处以确保running的值在下面的循环中每次都得到验证。
> while (running) {
> click++;
> }
> 如果不用volatile，Java可以自由的优化循环：running的值被存在CPU的一个寄存器中，每次重复不一定需要复检。volatile的运用阻止了该优化，告知Java running可以改变，改变方式并不以直接代码形式显示。

#### 线程同步

大家可以参考这位前辈的文章，他讲的比我详细[Java多线程同步问题:一个小Demo完全搞懂 ](https://www.cnblogs.com/leipDao/p/8295766.html)

##### 为什么要线程同步

> 当两个或两个以上的线程需要共享资源，它们需要某种方法来确定资源在某一刻仅被一个线程占用。达到此目的的过程叫做同步（synchronization）。

##### 使用同步方法

其实我最羡慕的就是Java很多在C/C++里面超级复杂的东西都被简单化了（尽管在内存上开销有点大，但是现在还是觉得Java这种高级语言很方便）。

> Java中同步是简单的，因为所有对象都有它们与之对应的隐式管程。进入某一对象的管程，就是调用被synchronized关键字修饰的方法。当一个线程在一个同步方法内部，所有试图调用该方法（或其他同步方法）的同实例的其他线程必须等待。为了退出管程，并放弃对对象的控制权给其他等待的线程，拥有管程的线程仅需从同步方法中返回。

首先放一个没有使用线程同步的demo

```java
class runables implements Runnable {
    private Thread t;
    private String name;
    public runables(String s){
        name=s;
    }
    /*添加synchronized的效果*/
    private void call(String s){
        for (int i=0;i<s.length();i++) {
            System.out.print(s.charAt(i));
        }
        System.out.println("");
    }
    public void run(){
        call(name);
    }
    public void start(){
        if(t==null){
            t=new Thread(this,name);
            t.start();
        }
    }
}

public class Main {
    public static void main(String[] agrs){
        runables a=new runables("aaaaaaaaaaaaaaaaaaaaaaaaaa");
        runables b=new runables("bbbbbbbbbbbbbbbbbbbbbbbbbb");
        a.start();
        b.start();
    }
}
```

大家应该都能猜到了，运行出来的结果是a,b混排，比如：

aaaaaaaaaaaaaaaaaaaaaaaaaabbbbbbbbbbbbbbbbbbbbbbbbbb

可是现在我们想得到的结果并不是这个样子的，我们想要输出a就是a，b就是b，那么该怎么办呢？
这个时候线程同步就可以使用了。看下面修改过后的demo：

```java
class runables implements Runnable {
    private Thread t;
    private String name;
    public runables(String s){
        name=s;
    }
    /*添加synchronized的效果*/
    synchronized private void call(String s){
        for (int i=0;i<s.length();i++){
            System.out.print(s.charAt(i));

        }
        System.out.println("");
    }
    public void run(){
        call(name);
    }
    public void start(){
        if(t==null){
            t=new Thread(this,name);
            t.start();
        }
    }
}

public class Main {
    public static void main(String[] agrs){
        runables a=new runables("aaaaaaaaaaaaaaaaaaaaaaaaaa");
        runables b=new runables("bbbbbbbbbbbbbbbbbbbbbbbbbb");
        a.start();
        b.start();
    }
}
```

应该可以注意到代码第9行的变化，其实就是加了一个synchronized修饰符。上面都说了，在Java里面，线程同步是简单的，其实就是这么简单。
运行一下，发现，哎，这回可以得到我们想要的输出了：
aaaaaaaaaaaaaaaaaaaaaaaaaa
bbbbbbbbbbbbbbbbbbbbbbbbbb

##### 同步语句

上面的同步方法已经很简答了，那为什么还要引入一个同步语句呢？

> 尽管在创建的类的内部创建同步方法是获得同步的简单和有效的方法，但它并非在任何时候都有效。这其中的原因，请跟着思考。假设你想获得不为多线程访问设计的类对象的同步访问，也就是，该类没有用到synchronized方法。而且，该类不是你自己，而是第三方创建的，你不能获得它的源代码。这样，你不能在相关方法前加synchronized修饰符。怎样才能使该类的一个对象同步化呢？很幸运，解决方法很简单：你只需将对这个类定义的方法的调用放入一个synchronized块内就可以了。

其实这个也不复杂，话不多说，直接看demo吧：

```java
class runables implements Runnable {
    private Thread t;
    private String name;
    public runables(String s){
        name=s;
    }
    /*添加synchronized的效果*/
    private void call(String s){
        synchronized(runables.class){
            for (int i=0;i<s.length();i++){
                System.out.print(s.charAt(i));
            }
        }
        System.out.println("");
    }
    public void run(){
        call(name);
    }
    public void start(){
        if(t==null){
            t=new Thread(this,name);
            t.start();
        }
    }
}

public class Main {
    public static void main(String[] agrs){
        runables a=new runables("aaaaaaaaaaaaaaaaaaaaaaaaaa");
        runables b=new runables("bbbbbbbbbbbbbbbbbbbbbbbbbb");
        a.start();
        b.start();
    }
}
```

看到没有，其实这个同步语句只是在第9行加了一个synchronized语句。说一下这个语句的使用方法：

```java
synchronized(object){
	//执行语句
}
```

其中，object是被同步对象的引用，如果你想要同步的只是一个语句，那么不需要花括号。一个同步块确保对object成员方法的调用仅在当前线程成功进入object管程后发生。

#### 线程通信

线程通信其实是一个很好玩的东西。你可以想象一下，两个小孩子同时去抢糖，不论谁拿到了糖，糖都会少一点。线程通信也是这么一个道理：

> 线程通信本质上就是“共享内存”式的通信。多个线程需要访问同一个共享变量，谁拿到了锁（获得了访问权限），谁就可以执行。

这一节教科书上讲的也不多，主要是几个方法：

------

- wait( ) 告知被调用的线程放弃管程进入睡眠直到其他线程进入相同管程并且调用notify( )。

- notify( ) 恢复相同对象中第一个调用 wait( ) 的线程。

- notifyAll( ) 恢复相同对象中所有调用 wait( ) 的线程。具有最高优先级的线程最先运行

- ------

  这些方法都在Object被声明，如下所示：

- - -

- final void wait( ) throws InterruptedException

- final void notify( )

- final void notifyAll( )

- - - wait()存在的另外的形式允许你定义等待时间。
      上面说了这么多，不如放一个demo：

```java
public class no1{
    public int x;
    no1(int y){
        x=y;
    }
}

class runables implements Runnable {
    private no1 ob;
    private Thread t;
    private boolean b1;
    public runables(boolean p,no1 bo1){
        ob=bo1;
        b1=p;
    }
    public void put(boolean b,no1 ob1){
        for (int i=0;i<10;i++){
            if(b==true){
                System.out.println("up:x="+ ++ob1.x);
            }
            else{
                if(ob1.x>0)
                    System.out.println("down:x="+ --ob1.x);
                else
                    System.out.println("x<0");
            }
        }
    }
    public void run(){
        put(b1,ob);
    }
    public void start(){
        if(t==null){
            t=new Thread(this);
            t.start();
        }
    }
}

public class Main {
    public static void main(String[] args){
        no1 p=new no1(0);
        runables R1=new runables(true,p);
        runables R2=new runables(false,p);
        R1.start();
        R2.start();
    }
}
```

差不多就是这么一个道理吧,不过现在我还不太明白。