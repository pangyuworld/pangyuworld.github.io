---
title: 一文带你使用Github page搭建自己的博客
author: 小胖儿
date: 2019-12-02 11:30:01
cover: /assets/github.png
tags:
	- Github Page
	- 建站
---

![](/assets/github.png)

# 一、什么是Github page？

> GitHub Pages is a static site hosting service that takes HTML, CSS, and JavaScript files straight from a repository on GitHub, optionally runs the files through a build process, and publishes a website.
>
> ——摘自[Github官网](https://help.github.com/en/github/working-with-github-pages/about-github-pages)

简单来说，Github page就是一个可以让用户部署自己的HTML、CSS、JavaScript代码的地方。因为我们如果没有公网服务器的话，写出来好看的前端界面就只能自己在本地浏览，而不能发布到公网上；而Github page则提供了我们将自己写好的界面发布到公网上的服务。

当然，不只是Github有这个服务，gitee和gitlab也有相应的page服务，其他的代码托管平台也有，而他们的操作大同小异，这里我们只介绍Github的操作。

# 二、提前准备

一个Github账号，hexo环境（需要nodejs支持），git客户端。

# 三、开始搭建

## 1、创建仓库

创建仓库的时候有一个限制，就是仓库名必须为**自己的Github账号名.github.io**(例如我的”pangyuworld.github.io“)，*其实不这样做也没有问题，但是访问静态资源的时候可能会有些麻烦，所以还是建议使用 账号名.github.io 的形式*

如下所示（这里我使用的是组织的名）



![](/assets/1575259170417.png)

创建好的仓库如下所示

![](/assets/1575259298183.png)

## 2、将仓库克隆到本地

使用git客户端将仓库克隆到本地，使用指令`git clone 仓库地址.git`

## 3、修改README.md文件

注意是Markdown语法，如果不熟悉Markdown语法可以参考我之前的文章[markdown从入门到入坑](/2019/07/10/markdown从入门到入坑/)，下面是我做的一些测试改动

```markdown
# 这是测试文件

## hello world

​```js
console.log("hello world")
​```

# t
```

## 4、将修改上传到Github，并且开启Github page

上传修改的操作就不说了，这里直说如何开启Github page服务。

### 开启Github page服务

1. 点击项目中的`settings`按钮进入项目设置界面

![](/assets/1575261778388.png)

2. 进入设置界面后，找到如下图所示的界面

   ![](/assets/1244049-17c06633980370c2.webp)

红框左边是选择分支，我们默认为主分支（建议新建一个gh-pages分支并使用该分支），右边save按钮既开启Github page服务，如下：

![](/assets/1575261867301.png)

## 5、测试访问

点击上面的网址，进行测试访问，看看我们的page服务是否配置完成。下面是我的访问结果

![](/assets/1575262089453.png)

至此，我们的page服务算是打开了，我们可以通过上传不同的HTML文件或者md文件，然后通过修改url来进行访问，这里就不展示了，感兴趣的同学可以自己尝试一下。

# 四、开始我们的定制化过程

前面我们让大家准备了hexo环境，hexo是什么？

> Hexo 是一个快速、简洁且高效的博客框架。Hexo 使用 [Markdown](http://daringfireball.net/projects/markdown/)（或其他渲染引擎）解析文章，在几秒内，即可利用靓丽的主题生成静态网页。
>
> ——摘自[hexo官网](https://hexo.io/zh-cn/docs/)

话不多说，直接开整。

## 1、初始化

首先，我们先新建一个空文件夹，因为**hexo的初始化必须在一个空的文件夹进行**。然后在新的文件夹下打开终端，执行指令`hexo init`进行初始化。

![](/assets/1575262672274.png)

当出现`INFO Start blogging with Hexo!`以后，即初始化成功。

## 2、本地预览hexo

我们可以在hexo文件夹下执行`hexo server`（简写为`hexo s`）来预览一下hexo，下面是我我预览的界面：

![](/assets/1575263059711.png)

是不是比以前好看到了。

## 3、将hexo上传到自己的github

首先在hexo文件夹下执行`hexo build`指令，然后我们会发现项目下多了一个`public`文件夹，我们将里面的所有文件和文件夹都复制到刚刚的git仓库文件夹里面，然后上传仓库。

上传到仓库结果如下：

![](/assets/1575263509403.png)

然后我们再尝试访问一下刚才的网站，这时网站应该变为刚才我们预览的样子了。（如果没有就稍等一下然后再刷新，Github page更新略慢）

然后下面的演示我将使用`hexo server`进行演示，因为上传太麻烦了。

## 4、hexo文件结构

![](/assets/1575263851415.png)

## 5、修改hexo的配置文件

hexo的配置文件内容参考官网：https://hexo.io/zh-cn/docs/configuration

然后下面放上我的配置文件：https://github.com/pangyuworld/pangyuworld.github.io/blob/matery/_config.yml

## 6、新建文章

我们可以直接在`_post`文件夹下新建md文件，我这里推荐使用hexo指令：`hexo new ‘标题’`

执行完该指令后，我们的`_post`文件夹下多了一个新的文件，我们点开这个文件，发现文件里面已经有一些内容了。

![](/assets/1575264258418.png)

这些内容就是来自`/scaffolds/post.md`，上面文件目录结构介绍了，这个就是模板。然后我们随意对这个文件做一些修改，然后再运行`hexo server`

```markdown 
---
title: 测试
date: 2019-12-02 13:23:40
tags:
---

# hello
```

下面是执行结果：

![](/assets/1575264365422.png)

至此，我们的网站已经算是一个Markdown语法的博客了。

## 7、使用主题

当然，你可能会问，为什么我的博客这么帅，而我只能用hexo呢？这是因为我使用了主题。

然后大家想找主题的话，可以到官网来看看：https://hexo.io/themes/

如果官网上面你没有看到心仪的主题，也可以在你收藏的心仪的博客（使用hexo搭建的），找到页脚，页脚处一般会把主题标记出来，如我的博客：

![](/assets/1575264570002.png)

然后点击那个主题就可以跳转到这个主题的仓库啦（并不是所有主题都有，这个看建站的人）

一般主题仓库下都有对该主题的详细介绍和使用教程，这里就不展开了。

