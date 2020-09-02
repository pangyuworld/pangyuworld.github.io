---
title: HTTP详解
author: 小胖儿
mathjax: true
cover: /assets/865913c28ac84196972d029d97683314_th.jpg
date: 2019-09-13 16:38:58
tags:
	- 计算机网络
	- HTTP
	- 培训
---

![图片来源于网络](/assets/865913c28ac84196972d029d97683314_th.jpg)

本文大纲：

- HTTP概念以及工作方式
- HTTP请求与HTTP响应
- HTTP头部字段概要
- HTTP协议常用状态码详解

<!-- more -->

## 1. HTTP概念以及作用方式

### 1.1 HTTP概念

> **超文本传输协议**（英語：**H**yper**T**ext **T**ransfer **P**rotocol，缩写：**HTTP**）是一种用于分布式、协作式和[超媒体](https://zh.wikipedia.org/wiki/超媒體)信息系統的[应用层](https://zh.wikipedia.org/wiki/应用层)[协议](https://zh.wikipedia.org/wiki/网络传输协议)[[1\]](https://zh.wikipedia.org/wiki/超文本传输协议#cite_note-ietf2616-1)。HTTP是[全球资讯网](https://zh.wikipedia.org/wiki/全球資訊網)的数据通信的基础。
>
> ——摘自《维基百科》

用自己的白话说就是：HTTP是一种协议，传输的是一些超文本（可以理解为包含更多信息的文本）。然后所有我们在浏览网页的时候，大部分输入的`http://网址`中的HTTP就代表使用的是HTTP协议，由此可见HTTP十分常见。

### 1.2 HTTP工作方式

准确的说，应该是HTTP协议的运作方式，不过差不太多。

根据上面的概念我们了解到，HTTP一般作用于网页应用（当然也有其他的使用场景）。我们这里就根据网页应用来了解一下HTTP的工作方式。

#### 1.2.1 HTTP协议是基于TCP/IP协议的应用层协议

关于TCP/IP协议族的知识这里不展开，以后考虑写一篇文章专门复习TCP/IP以及UDP等的计算机网络知识。

这里呢，我们只需要了解TCP/IP是一种在计算机网络中常用的，可以实现可靠数据传输的协议。

然后HTTP协议是基于TCP/IP协议的应用层协议，因此，HTTP协议也是一套可以实现可靠数据传输的协议。

当然，HTTP协议既然是基于TCP/IP协议的协议，那么它也应该遵循TCP/IP协议的工作流程。

#### 1.2.2 HTTP协议应用于B/S（Browser/Server）架构模式

相对于C/S（Client/Server）架构模式，HTTP协议一般应用于B/S架构模式。下面是二者的联系和区别：

![](/assets/f636afc379310a55879022abef97e6ad8326100b.jpeg)

上面的就是典型的C/S架构模式，例如我们的QQ客户端与其服务器之间就是C/S架构模式。

而下面的是典型的B/S架构模式，这个可以直接联想浏览器。

当然，C/S和B/S本质上还是没有区别的，他们都是基于TCP或者UDP的一种架构模式，主要还是因为TCP或者UDP协议总是需要一个所谓的服务器因此才衍生出这么两套体系。

然而在编程的时候，我们要为应用C/S架构的系统编写固定的客户端和服务器，而B/S架构下只需要编写前端代码和服务器即可完成系统的构建。

#### 1.2.3 HTTP协议的工作流程

1. HTTP客户端（例如浏览器）发起建立连接请求
2. HTTP服务端接收请求，建立连接（这一步和第一步是TCP连接的三次握手）
3. HTTP客户端发送请求报文
4. HTTP服务器接收请求报文并发送响应报文
5. HTTP客户端接收响应报文
6. 断开连接（TCP的四次握手断开连接）

## 2. HTTP请求与HTTP响应

上面的工作流程里面提到了两个概念：**HTTP请求报文**和**HTTP响应报文**。

其实HTTP请求报文/响应报文只不过是为了支持HTTP协议的一种文本格式，就是那种肉眼看一眼看不懂，但是仔细看大概知道这些个文本是什么意思的格式。当然，计算机识别这种文本格式可是很快的。下面我们就来了解一下这两个报文吧。

### 2.1 HTTP请求（request）报文

顾名思义，请求报文就是在发起HTTP请求的时候所使用的的一种报文格式，一般它生成于客户端。它大概长下面这个样子：

```http
GET /api/user/1 HTTP/1.1
Host: pang.yank-tenyond.cn
Pragma: no-cache
Sec-Fetch-Site: cross-site
Accept-Encoding: gzip, deflate, br
User-Agent: Mozilla/5.0 (iPhone; CPU iPhone OS 10_2 like Mac OS X) AppleWebKit/602.3.12 (KHTML, like Gecko) Mobile/14C92 Safari/601.1 wechatdevtools/1.02.1907300 MicroMessenger/6.7.3 Language/zh_CN webview/
content-type: application/json
Accept: */*
Cache-Control: no-cache
Sec-Fetch-Dest: empty
Referer: https://servicewechat.com/wx017564df57f167fd/devtools/page-frame.html
Sec-Fetch-User: ?F
Connection: keep-alive
cache-control: no-cache
```

现在只需要简单看一下这个报文的内容就好，详细的解释后面会讲。不过这段报文应该是很明显验证了我刚才说的话，就是*那种肉眼看一眼看不懂，但是仔细看大概知道这些个文本是什么意思的格式*。

### 2.2 HTTP响应（response）报文

同上，响应报文就是在响应HTTP请求时候所使用的一种报文格式，一般它生成于服务端。然后后面再放一个例子：

```http
HTTP/1.1 200 OK
Server: nginx/1.10.3 (Ubuntu)
Date: Fri, 13 Sep 2019 10:07:47 GMT
Content-Type: application/json;charset=UTF-8
Transfer-Encoding: chunked
Connection: keep-alive

响应报文内容
```

emmm，好像这个响应报文看起来更简单一些，是吗？当然不是，只是因为我取用的这两个例子里面好多不必要的字段我都没有删除。其实HTTP的请求报文和响应报文的最小格式都是很简单的，下面我贴一段最简单的HTTP请求和响应报文大家自行感受一下。

### 2.3 HTTP请求报文和响应报文的简单格式

HTTP请求报文：

```http
GET / HTTP/1.1
Host: hackr.jp
```

HTTP响应报文：

```http
HTTP/1.1 200 OK
Date: Fri, 13 Sep 2019 10:07:47 GMT
Content-Type: application/json;charset=UTF-8

响应报文内容
```

上面就是最简单的报文格式（好像是还能精简或者是我少了几个必要字段，后面再详细检查一下），怎么样，是不是特别简单。

### 2.4 报文的基本组成

嗯，这个时候再来说一下报文的基本组成形式。不论是请求报文还是响应报文，他们的组成形式都大致相同。

HTTP请求报文的组成：

![](/assets/1568369965996.png)

HTTP响应报文的组成：

![](/assets/1568369986662.png)

*以上两张图片摘抄自《图解HTTP》*

## 3. HTTP头部字段概要

终于到了重中之重了，前面铺垫了很久很久才把路铺到了这里，所以这里一定是重点高发区了，快拿小本本记下来。

头部字段基础格式：`字段名: 字段值`

### 3.1 HTTP请求头部字段

先放上基础格式，然后我们一步一步解析：

```http
GET /api/user/1 HTTP/1.1
Host: pang.yank-tenyond.cn
Pragma: no-cache
Sec-Fetch-Site: cross-site
Accept-Encoding: gzip, deflate, br
User-Agent: Mozilla/5.0 (iPhone; CPU iPhone OS 10_2 like Mac OS X) AppleWebKit/602.3.12 (KHTML, like Gecko) Mobile/14C92 Safari/601.1 wechatdevtools/1.02.1907300 MicroMessenger/6.7.3 Language/zh_CN webview/
content-type: application/json
Accept: */*
Cache-Control: no-cache
Sec-Fetch-Dest: empty
Referer: https://servicewechat.com/wx017564df57f167fd/devtools/page-frame.html
Sec-Fetch-User: ?F
Connection: keep-alive
```

#### 3.1.1 请求行	`GET /api/user/1 HTTP/1.1`

这里包含了用于请求的方法（`GET`）、请求URI（`/api/user/1`）和HTTP版本（`HTTP/1.1`）

##### 请求方法

请求方法包含八种（黑体为常用，斜体为几乎不用）：**GET**、**POST**、PUT、DELETE、*CONNECT*、*OPTIONS*、*TRACE*、*HEAD*

作用参考下表：

|  方法   |                             作用                             |
| :-----: | :----------------------------------------------------------: |
|   GET   |                获取资源（rest中表示查找资源）                |
|  POST   | 传输实体主体，加密请求参数，比如账号密码（rest中表示添加资源） |
|   PUT   |                传输文件（rest中表示修改资源）                |
| DELETE  |                删除文件（rest中表示删除资源）                |
|  HEAD   |                         获得报文首部                         |
| OPTIONS |                        询问支持的方法                        |
|  TRACE  |                           追踪路径                           |
| CONNECT |                    要求用隧道协议连接代理                    |

> 上面讲到了REST，REST（Representational State Transfer，表述性状态传递）是一种软件架构风格，即为仅传递数据，通过不同的请求方法标识不同的动作，如上表所示。详情请自行查阅。

##### 请求URI

URI，是uniform resource identifier，统一资源标识符，用来唯一的标识一个资源。这个资源可以是文本、HTML文档、图像、视频、程序等。例如本例中`/api/user/1`就表示获取用户id为1的用户信息。当然，这些表示是由程序开发者来规定的，我的解释也仅仅作用于我自己编写的程序。

另一个例子为：`/upload/background.jpeg`，首先我们看到`.jpeg`就知道其是一个图片，所以，这个URI表示获取upload文件夹下的background.jpeg这个图片，这就相当于文件路径。

URI一般由三个部分组成：

1. 访问资源的命名机制
2. 存放资源的主机名
3. 资源自身的名称，由路径表示，着重强调于资源。

##### HTTP版本 

HTTP请求所使用的的HTTP版本，当前大部分网站使用的是HTTP 1.1版本，具体各个版本的不同还请自行百度。

#### 3.1.2 请求头部

嗯，这里包含了很多很多的东西，常用的不常用的都在里面，作为区分，下面我就来使用`*`来表示那些比较常用的请求头吧。

##### Host(*)	请求资源所在服务器

即我们要向哪台服务器发起请求，一般为ip地址或域名

##### Accept-Encoding	优先的内容编码

浏览器告诉服务器浏览器支持的编码类型，各种类型自行查阅。

##### User-Agent(*)	HTTP客户端程序的信息

浏览器告诉服务器浏览器的程序信息，包括了浏览器类型、内核、平台等信息。

至于标星号是因为正好今天使用这个字段来做了接口拦截。

##### Accept	用户代理可处理的媒体类型

浏览器告诉服务器浏览器可以处理的编码类型，例如`Accept: text/html`表示浏览器告诉服务器浏览器只支持处理文本和HTML文件。

##### Referer	对请求中URI的原始获取方

大概可以理解为浏览器当前所在的界面的路径。

### 3.2 HTTP响应头部字段

同理，我们先放上一段响应字段的基础格式：

```http
HTTP/1.1 200 OK
Server: nginx/1.10.3 (Ubuntu)
Date: Fri, 13 Sep 2019 10:07:47 GMT
Content-Type: application/json;charset=UTF-8
Transfer-Encoding: chunked
Connection: keep-alive
```

#### 3.2.1 状态行	`HTTP/1.1 200 OK`

状态行由状态码(`HTTP/1.1`)和状态码(`200 OK`)组成

##### HTTP版本

和请求行的HTTP版本解释一样。

##### 状态码

告知从服务器端返回的请求结果。借助状态码，用户可以知道服务器端是正常处理了请求还是出现了错误。

当然，提到状态码，大家一定忘不了被**404**和**500**的支配的恐惧，我们下来就来具体看看这些状态码都代表什么吧。

首先是一个概要：

![](/assets/1568374519669.png)

然后具体解释一下（重要的用`*`标出来）（当然是抄书了，苦逼ing）：

|           状态码            |                      作用                      |
| :-------------------------: | :--------------------------------------------: |
|          200  OK*           |    从客户端发来的请求在服务器被正常的处理了    |
|       204  No Content       |   请求被正常处理但是返回的响应报文中不含实体   |
|    206  Partial Content     | 客户端进行了范围请求且服务器成功执行了这些请求 |
|   301  Moved Permanently    |                  永久性重定向                  |
|         302  Found          |                 临时性的重定向                 |
|       303  See Other        |                   类似于302                    |
|      304  Not Modified      |         资源已经找到，但不满足访问条件         |
|   307  Temporary Redirect   |            临时性重定向，与302相同             |
|      400  Bad Request*      |     请求报文中存在语法错误，服务器无法理解     |
|     401  Unauthorized*      |             请求需要认证且认证失败             |
|       403  Forbidden*       |    请求资源被拒绝（可以没有理由，就是拒绝）    |
|       404  Not Found*       |        无法找到请求的资源（这个真没有）        |
| 500  Internal Server Error* |  服务器端处理请求出现了故障（怪就怪后端垃圾）  |
|  503  Service Unavailable*  |            服务器正忙，无法处理请求            |                              |

#### 3.2.2 响应头部

##### Server	HTTP服务器的安装信息

表示服务器是安装在什么系统上的，使用的是哪种服务器巴拉巴拉…



### 3.3 公共头部字段

##### Pragma	报文指令

这是一个历史遗留的字段，仅作为与http的向后兼容而定义，规范定义的唯一形式`Pragme:no-cache`，如果所有的服务器都是使用HTTP/1.1为标准的话，则完全可以用`Cache-Control:no-cache`代替。

##### Content-Type(*)	实体主体的媒体类型

报文实体的类型，例如`text/html`表示文本或HTML文件，`application/json`表示json格式字符串等。

进行WEB开发的时候一定要注意这个东西，类型如果写错的话，很多封装好的包或者API是无法识别的。

##### Cache-Control(*)	控制缓存的行为

上面`Pragma`已经说过这个指令。然后这个指令的作用就是表示是否要缓存请求或者是资源。然后其具体值可以参看[百度百科-Cache-control](https://baike.baidu.com/item/Cache-control/1885913?fr=aladdin)。

##### Connection(*)	逐跳首部、连接的管理

其有两个作用：

- 控制不在转发给代理的首部字段（说实话，我也不太清楚这个的具体作用是啥，只知道表现是啥）
- 管理持久连接（这个才是为什么标星号的原因）

参数值一般情况下有两个：`Keep-Alive`和`Close`，分别表示保持持久连接和不保持持久连接。

##### Date	创建报文的日期时间

咳咳，不解释，这就是创建报文的时间。