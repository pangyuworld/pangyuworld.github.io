---
title: ubuntu下安装网易云音乐
date: 2019-04-03 13:39:59
author: 小胖儿
mathjax: true
cover: https://timgsa.baidu.com/timg?image&quality=80&size=b9999_10000&sec=1575097965880&di=fdc16ec7d40ce41dec45da8c59d1f492&imgtype=0&src=http%3A%2F%2Fwww.91wzg.com%2Fuploads%2Fallimg%2F170712%2F14001450Y_0.png
tags:
	- ubuntu
---

作为一个新人入坑，我又下载安装了ubuntu，这次的打算是赖死在linux上了。

当然，ubuntu的路上并不那么顺利，比如这个网易云音乐。

<!-- more -->

windows下，我是一个酷狗音乐的死忠，其实就是因为懒，所以就没换过音乐播放器。但是，ubuntu上竟然没有酷狗音乐，只有网易云音乐，无奈之下，安装网易云把。

不过，一切并不是那么顺利，翻阅了数十篇文档、博客才最后安张下载了网易云音乐，至少这波不亏。

## 第一坑：安装网易云音乐

参考博客[Ubunut 下安装网易云音乐](https://blog.csdn.net/u013372308/article/details/80234197)

linux可不像windows一样，有很多傻瓜式一键安装，好像用命令行也还是一键安装，不管了，反正很难就对了。

第一次照着网上的教程作，就是从官网上下载linux版本的网易云音乐，然后输入指令

`sudo dpkg -i netease-cloud-music_1.1.0_amd64_ubuntu.deb`

以为一切都要这么顺利，然后报错了，各种各样的依赖包都没有，有的网上教程还说对这名字一个一个下载，我尝试这下载了第一个，恩，又是缺失了一大堆依赖包，生无可怜。

终于，翻到了上面那篇博客，指令

`sudo apt-get -f install`

才是正解。

总结一下：

- 1、下载网易云linux版本
- 2、进入安装包所在文件夹（默认为/下载）
- 3、`sudo dpkg -i netease-cloud-music_1.1.0_amd64_ubuntu.deb`
- 4、如果上述步骤缺少依赖包则运行`sudo apt-get -f install`
- 5、安装成功

## 第二坑：解决无法通过图表打开网易云音乐

参考博客   [（已解决）ubuntu下网易云音乐无法打开]( https://blog.csdn.net/Handoking/article/details/81026651)

安装好了网易云音乐，本来想开开心心的来听几首劲爆歌曲的，结果，打不开是什么鬼！！！

好吧好吧，继续百度。哦，原来是权限问题。

还是说解决办法吧：

- 用root权限修改文件/usr/share/applications/netease-cloud-music.desktop
  比如：sudo vim /usr/share/applications/netease-cloud-music.desktop 
- 修改执行参数：找到 exec 那一行 ，在 %U 前面加上 `--no-sandbox`。 
- 修改完后保存，更新软件或者重启。
- 必须要重启，亲侧有效，我听歌去了。