---
title: git使用
date: 2019-04-13 15:31:56
author: 小胖儿
mathjax: true
cover: https://timgsa.baidu.com/timg?image&quality=80&size=b9999_10000&sec=1575097580565&di=0331a0672f5fdf2cd6ceeadda21b4d34&imgtype=0&src=http%3A%2F%2Fi1.hdslb.com%2Fbfs%2Farchive%2Feb419fc6b38007d4155c2309b56c11018b85ad77.jpg
tags:
	- git 
	- 工具
typora-root-url: ..
---

# git使用简介

首先是一个教程，超完美的教程[git廖雪峰的官方网站](https://www.liaoxuefeng.com/wiki/0013739516305929606dd18361248578c67b8067c8c017b000)

<!-- more -->

## 1、安装git

从[git官网](https://git-scm.com/downloads)下载最新版的git

![](/assets/5bfe4259538c5-1555141636561.jpg)

下载好以后运行，然后就一路疯狂**next**吧
安装好以后，右键桌面，看看有没有git的两个图标，如图所示

![](/assets/5bfe4351284a0-1555141662460.jpg)

有的话，就是安装成功，再稍微配置一下，就开始疯狂敲指令了。

## 2、配置git

打开那个**git bash**，在命令行输入：

```bash
git config --global user.name "注册时的用户名，比如我的pangyuworld"
git config --global user.email "注册时的邮箱，比如123456@qq.com"
```

下面，就开始疯狂敲指令吧！

## 3、在git bash 上clone代码（下载代码）

在你自己的工程文件夹下面，右键找到刚才的**git bash**，打开它，然后输入指令
`git clone 目标网页`
即可clone项目代码，其中，目标网页可以是任何的git仓库里面的代码，比如gitee（码云）、GitHub（咳咳）、gitlab以及其他自己的git仓库，这里使用我自己的GitHub仓库做例子：

> 想要使用git客户端下载我的Pang-Blog这个项目的源码，就可以输入`git clone https://github.com/pangyuworld/Pang-Blog
>
> clone完代码以后，你会发现一个文件夹，然后点入一个文件夹，看看有没有一个**.git**文件（是隐藏文件），截图为下
> ![blob.jpg](/assets/5bfe7f44477ee.jpg)
> 然后在现在这个文件夹下面重新打开git bash然后再执行下面的操作。(或者直接使用`cd 目标文件夹`指令也可以)

## 4、使用git bash更新代码

更新代码指的是在已有的仓库下面更新别人新上传的代码，（如果不是你们共同改过的文件的话，一般情况下不会发生冲突）
更新代码指令为
`git pull origin <分支名称>`（如果是master主分支就不用写）
例如

> `git pull origin master`从主分支上更新代码
> `git pull origin spring`从spring分支上更新代码

## 5、使用git bash创建分支

分支主要是用来构建不稳定代码的（比如有bug的代码），而master主分支是用来保存稳定的代码的（正常运行，几乎无bug），所以，在实际开发中，如果是多人协作的项目的话，尽量不要直接上传主分支，而是将自己的代码上传到自己的分支，以免使bug影响他人操作。
创建分支指令为
`git checkout -b <分支名称>`
这里的`-b`是创建新的分支的意思， checkout是切换到指定分支的意思。由此可以引出：`git checkout <分支名称>`为切换到指定分支。
代码示例:

> `git checkout -b vue`创建并切换到vue分支

## 6、使用git bash上传代码

上面讲了这么多下载代码、更新代码、创建分支，git最主要的上传代码功能还没有说。
在使用git bash上传代码的时候是有一整套流程的:

### 1）. 使用`git add`添加文件

这个添加文件可以理解为：*到最后上传到服务器的是一个大的书包，而git add指令就是往这个书包里面放书放东西*
代码示例：

> `git add ./`将.git文件所在的文件夹下面的所有文件添加到“书包”里面
> `git add mytext/test.txt`将mytext文件夹下面的test.txt文件添加到“书包里面”

### 2）. 使用`git commit -m '文本内容'`为书包贴上名字

上面的书包已经装好了，下面我们需要给书包贴上一个名字，方便告诉别人我们的书包里面装的是什么。
示例代码：

> `git commit -m '第一次提交'`为书包贴上一个“第一次提交”的标签。
> 注意，这一步是必须的，而且代码不能少，你可以把引号里面的内容填为空

### 3）. 使用`git push`上传代码

书包都装好了，现在我们可以把书包“扔”出去了。不过在扔出去之前，还希望你可以慎重的考虑一下，到底要扔到哪个分支上面（尽量不要直接扔到master上面）
示例代码如下

> `git push`如果你是在在master分支上，那么这条指令就是把书包扔到master分支上，如果你不是在master分支上，那么会报错。
> `git push origin out`将书包扔到out分支上(前提是要有这个分支)