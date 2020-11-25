---

title: Jenkins+docker一键部署Spring Boot项目
author: 小胖儿
mathjax: true
typora-root-url: ..
date: 2020-11-21 10:21:05
cover:
tags:
	- Spring Boot
	- Jenkins
	- Docker
typora-root-url: ..
---

# 一、系统环境

以下环境皆为必要系统环境；以下环境皆为我测试机的环境，实际操作不一定要如此高的版本

- Ubuntu 20.04LTS
- Java 8
- Maven 3.6.3
- Docker 19.03.13
- Jenkins 2.249.3
- git 2.25.1

# 二、创建一个简单的Spring Boot项目

## 1、创建项目

使用IDEA等创建一个简单的Spring Boot项目，注意下面标红的几个点

![image-20201125105510326](/assets/Jenkins-docker%E4%B8%80%E9%94%AE%E9%83%A8%E7%BD%B2Spring-Boot%E9%A1%B9%E7%9B%AE/image-20201125105510326.png)![image-20201125105537719](/assets/Jenkins-docker%E4%B8%80%E9%94%AE%E9%83%A8%E7%BD%B2Spring-Boot%E9%A1%B9%E7%9B%AE/image-20201125105537719.png)

然后创建一个类`Hello0Controller`，添加如下代码

```java
@RestController
public class HelloController {

    @RequestMapping("/hello")
    public String hello(String str){
        return "hello "+str;
    }
}
```

此时，运行这个项目，访问`http://localhost:port/hello?str=world`以得到一串字符串`hello world`。以此来测试项目是否创建成功，是否运行成功。

## 2、打包项目

在 项目根目录处运行指令`mvn package`，对这个项目进行打包，正常情况下，项目会生成target文件夹，文件夹下的`xxx-0.0.1-SNAPSHOT.jar`即为打包生成的可执行jar包（xxx为项目的`artifactId`）

为了测试打包的jar包是否正确，我们可以使用指令执行该jar包，然后进行访问查看效果。执行指令如下

```sh
cd targer/
java -jar xxx-0.0.1-SNAPSHOT.jar
```

访问`http://localhost:port/hello?str=world`以得到一串字符串`hello world`。以此来测试项目是否创建成功，是否运行成功。

## 3、将该项目上传到GitHub

省略……

# 三、使用Jenkins自动部署Spring Boot项目

我们先不使用Docker，直接用Jenkins部署这个SpringBoot项目。

先来统计一下，我们用到的指令如下

```sh
git clone https://github.com/xxx.git
cd xxx
mvn package
cd target
java -jar xxx-0.0.1-SNAPSHOT.jar
```

如果我们自己在服务器终端，直接运行以上几个指令即可在服务器运行起我们的SpringBoot项目。Jenkins其实也只是将这些指令集成一下，做到一键即可部署。

## 1、安装、运行Jenkins

建议直接看文档进行安装：[Jenkins官网](https://www.jenkins.io/zh)

安装完后运行时安装插件选择推荐插件即可，遇到的大部分Jenkins问题都可自行搜索解决。

## 2、配置环境

访问服务器运行的Jenkins主页，选择Manage Jenkins  -> Global Tool Configuration，进入到全局环境变量配置，将需要配置的环境（Java、Maven、Git）填入即可。

## 3、在Jenkins上新建项目

访问服务器运行的Jenkins主页，选择“新建Item（New Item）”

然后输入该项目名称，并选择“流水线”后，点击确定新建项目

![image-20201125113416654](/assets/Jenkins-docker%E4%B8%80%E9%94%AE%E9%83%A8%E7%BD%B2Spring-Boot%E9%A1%B9%E7%9B%AE/image-20201125113416654.png)

## 4、编写自定义流水线

点击确定按钮以后，跳转到配置页面，在配置页面，我们只用关心流水线脚本，其余配置若感兴趣可自行查阅其作用。

![image-20201125114310541](/assets/Jenkins-docker%E4%B8%80%E9%94%AE%E9%83%A8%E7%BD%B2Spring-Boot%E9%A1%B9%E7%9B%AE/image-20201125114310541.png)

对于pipeline语法可以浏览官网进行学习，本篇文章所使用的都是简单的指令。本篇文章的脚本如下（注意根据自己的项目进行修改）

```groovy
pipeline {
    agent any
    stages {
        stage('使用git下载代码') {
            steps {
                // echo 可以用来做简单的输出
                echo 'git from github...'
                // 使用pipeline的git指令进行下载，如果分支是master，也可以使用 git 'https://github.com/xxx.git'
                git url: 'https://github.com/xxx.git', branch: 'main'
            }
        }
        stage('使用Maven构建') {
            steps {
                echo "maven build start..."
                // 使用sh指令linux执行，Windows的话，可以使用bat
                sh "mvn -Dmaven.test.skip=true clean package"
            }
        }
        stage('运行项目') {
            steps {
                echo "Spring boot start..."
                sh "java -jar target/xxx-0.0.1-SNAPSHOT.jar"
            }
        }
    }
}
```

## 5、一键构建

进入到项目页面，点击按钮“Build Now”即可构建

![image-20201125150210237](/assets/Jenkins-docker%E4%B8%80%E9%94%AE%E9%83%A8%E7%BD%B2Spring-Boot%E9%A1%B9%E7%9B%AE/image-20201125150210237.png)

下面是构建完成的截图

![image-20201125154325447](/assets/Jenkins-docker%E4%B8%80%E9%94%AE%E9%83%A8%E7%BD%B2Spring-Boot%E9%A1%B9%E7%9B%AE/image-20201125154325447.png)

注意这里由于我们的指令问题，是不会构建完成，而是卡在运行项目这里，点击左下角`#12`左边的圆圈按钮即可查看输出信息

---

到此，Jenkins配合Spring Boot实现自动化部署已经完成，每次上传完代码以后直接点击BuildNow按钮即可重新部署。但是，目前运行项目这个步骤一直无法完成，这个问题有两个解决办法：

1. 使用`nohup java -jar xxx.jar & `指令，但是如果使用这个指令需要用单引号包住这个指令且jar文件需要是绝对路径，感兴趣可以尝试一下。
2. 使用Docker构建镜像并运行镜像

# 四、配合Docker

为了解决上述问题，我们引入Docker。引入Docker不光是为了解决上面那个问题，容器化已经是大势所趋，具体使用Docker有哪些好处可以自行搜索。

## 1、Docker将Spring Boot项目打包成镜像

Docker对Spring Boot项目打包的方式有很多种，这里我参考官方推荐的一种，参考网址：https://spring.io/guides/gs/spring-boot-docker/

### 新建Dockerfile

在项目根目录新建一个名为Dockerfile的文件，注意没有后缀名，其内容如下

```dockerfile
FROM java:8
VOLUME /tmp
COPY target/xxx-0.0.1-SNAPSHOT.jar app.jar
ENTRYPOINT ["java","-jar","/app.jar"]
```

> Dockerfile 是一个用来构建镜像的文本文件，文本内容包含了一条条构建镜像所需的指令和说明。
>
> [Dockerfile指令|菜鸟教程](https://www.runoob.com/docker/docker-dockerfile.html)

### 在本地构建镜像（测试用，可跳过）

如果你本地有Docker环境的话，可以在本地进行构建镜像。

在项目根目录运行指令`docker build -t spring-demo .`即可

运行该镜像的话，只用执行指令`docker run -d -p 8080:8080 spring-demo`即可，`8080:8080`指**本地端口8080(第一个)映射到容器端口8080(第二个)**

## 2、将Dockerfile上传到GitHub

省略....

## 3、修改pipeline脚本

修改后的脚本如下

```groovy
pipeline {
    agent any
    stages {
        stage('停止旧容器') {
            steps {
                echo "stop if project is running..."
                sh 'docker ps -f name=spring-demo -q | xargs --no-run-if-empty docker container stop'
                sh 'docker ps -a -f name=spring-demo -q | xargs --no-run-if-empty docker container rm'
            }
        }
        stage('使用git下载代码') {
            steps {
                // echo 可以用来做简单的输出
                echo 'git from github...'
                // 使用pipeline的git指令进行下载，如果分支是master，也可以使用 git 'https://github.com/xxx.git'
                git url: 'https://github.com/xxx.git', branch: 'main'
            }
        }
        stage('使用Maven构建') {
            steps {
                echo "maven build start..."
                // 使用sh指令linux执行，Windows的话，可以使用bat
                sh "mvn -Dmaven.test.skip=true clean package"
            }
        }
        stage('Docker构建') {
            steps {
                echo "docker build start..."
                sh "docker build -t spring-demo ."
            }
        }
        stage('Docker运行') {
            steps {
                echo "docker image start..."
                sh "docker run -d -p 8080:8080 --name spring-demo spring-demo"
            }
        }
    }
}
```

## 5、一键构建

先将没有集成Docker的那个构建停止，然后重新点击BuildNow即可

---

以上，Jenkins+Docker+SpringBoot的自动部署就实现完成了，我的项目代码地址：https://github.com/pangyuworld/spring-demo 仅供参考