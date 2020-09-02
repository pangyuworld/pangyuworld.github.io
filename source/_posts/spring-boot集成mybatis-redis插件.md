---
title: spring boot集成mybatis-redis插件
date: 2019-05-09 12:49:25
author: 小胖儿
mathjax: true
cover: https://ss1.bdstatic.com/70cFvXSh_Q1YnxGkpoWK1HF6hhy/it/u=1281671216,487733849&fm=26&gp=0.jpg
tags:	
	- Java
	- spring
	- mybatis
	- redis
---

这篇文章讲述了如何在spring boot中集成阿里巴巴开源的mybatis-redis插件，包括简单demo和我自己遇到的问题。

插件网址在这里：http://www.mybatis.org/redis-cache/index.html

<!--more-->

## 创建项目

首先，你需要一个集成了mybatis和redis的spring boot项目，创建项目的过程就不在这里多说了。

## 集成插件

### 1、在pom.xml文件中添加以下代码：

```xml
 <dependency>
    <groupId>org.mybatis.caches</groupId>
    <artifactId>mybatis-redis</artifactId>
    <version>1.0.0-beta2</version>
 </dependency>
```

### 2、在resource文件夹下创建redis.properties配置文件

这里要注意一下，mybatis-redis插件是不支持访问application.properties配置的，而是支持默认访问redis.properties配置文件。在redis.properties文件中添加如下基本配置（这里仅展示一小部分，更多redis配置请参阅redis配置文档）

```
redis.database=0
redis.host= localhost
redis.port= 6379
redis.timeout= 2000ms
redis.password= 
```

### 3、在mybatis的mapper.xml文件中添加缓存

示例如下

```
<mapper namespace="org.acme.FooMapper">
  <cache type="org.mybatis.caches.redis.RedisCache" />
  ...
</mapper>
```

至此，mybatis-redis插件就已经集成好了，这个时候可以来测试一下，是否真正的缓存了。

## 问题方法

当然，上面的步骤都是一些官方的教程，真正使用的时候还是有一些问题需要自己解决的，下面就是我遇到的问题以及解决方法

### 问题1

首先先看报错吧：

```
/usr/local/java/jdk-10.0.2/bin/java -XX:TieredStopAtLevel=1 -noverify -Dspring.output.ansi.enabled=always -Dcom.sun.management.jmxremote -Dspring.jmx.enabled=true -Dspring.liveBeansView.mbeanDomain -Dspring.application.admin.enabled=true -javaagent:/snap/intellij-idea-ultimate/139/lib/idea_rt.jar=46107:/snap/intellij-idea-ultimate/139/bin -Dfile.encoding=GBK -classpath /home/iotat/pang/QualityBaby/target/classes:/home/iotat/.m2/repository/org/springframework/boot/spring-boot-starter-cache/2.1.4.RELEASE/spring-boot-starter-cache-2.1.4.RELEASE.jar:/home/iotat/.m2/repository/org/springframework/boot/spring-boot-starter/2.1.4.RELEASE/spring-boot-starter-2.1.4.RELEASE.jar:/home/iotat/.m2/repository/org/springframework/boot/spring-boot/2.1.4.RELEASE/spring-boot-2.1.4.RELEASE.jar:/home/iotat/.m2/repository/org/springframework/boot/spring-boot-autoconfigure/2.1.4.RELEASE/spring-boot-autoconfigure-2.1.4.RELEASE.jar:/home/iotat/.m2/repository/org/springframework/boot/spring-boot-starter-logging/2.1.4.RELEASE/spring-boot-starter-logging-2.1.4.RELEASE.jar:/home/iotat/.m2/repository/ch/qos/logback/logback-classic/1.2.3/logback-classic-1.2.3.jar:/home/iotat/.m2/repository/ch/qos/logback/logback-core/1.2.3/logback-core-1.2.3.jar:/home/iotat/.m2/repository/org/apache/logging/log4j/log4j-to-slf4j/2.11.2/log4j-to-slf4j-2.11.2.jar:/home/iotat/.m2/repository/org/apache/logging/log4j/log4j-api/2.11.2/log4j-api-2.11.2.jar:/home/iotat/.m2/repository/org/slf4j/jul-to-slf4j/1.7.26/jul-to-slf4j-1.7.26.jar:/home/iotat/.m2/repository/javax/annotation/javax.annotation-api/1.3.2/javax.annotation-api-1.3.2.jar:/home/iotat/.m2/repository/org/yaml/snakeyaml/1.23/snakeyaml-1.23.jar:/home/iotat/.m2/repository/org/springframework/spring-context-support/5.1.6.RELEASE/spring-context-support-5.1.6.RELEASE.jar:/home/iotat/.m2/repository/org/springframework/spring-beans/5.1.6.RELEASE/spring-beans-5.1.6.RELEASE.jar:/home/iotat/.m2/repository/org/springframework/spring-context/5.1.6.RELEASE/spring-context-5.1.6.RELEASE.jar:/home/iotat/.m2/repository/org/springframework/boot/spring-boot-starter-data-redis/2.1.4.RELEASE/spring-boot-starter-data-redis-2.1.4.RELEASE.jar:/home/iotat/.m2/repository/org/springframework/data/spring-data-redis/2.1.6.RELEASE/spring-data-redis-2.1.6.RELEASE.jar:/home/iotat/.m2/repository/org/springframework/data/spring-data-keyvalue/2.1.6.RELEASE/spring-data-keyvalue-2.1.6.RELEASE.jar:/home/iotat/.m2/repository/org/springframework/data/spring-data-commons/2.1.6.RELEASE/spring-data-commons-2.1.6.RELEASE.jar:/home/iotat/.m2/repository/org/springframework/spring-tx/5.1.6.RELEASE/spring-tx-5.1.6.RELEASE.jar:/home/iotat/.m2/repository/org/springframework/spring-oxm/5.1.6.RELEASE/spring-oxm-5.1.6.RELEASE.jar:/home/iotat/.m2/repository/org/springframework/spring-aop/5.1.6.RELEASE/spring-aop-5.1.6.RELEASE.jar:/home/iotat/.m2/repository/io/lettuce/lettuce-core/5.1.6.RELEASE/lettuce-core-5.1.6.RELEASE.jar:/home/iotat/.m2/repository/io/netty/netty-common/4.1.34.Final/netty-common-4.1.34.Final.jar:/home/iotat/.m2/repository/io/netty/netty-handler/4.1.34.Final/netty-handler-4.1.34.Final.jar:/home/iotat/.m2/repository/io/netty/netty-buffer/4.1.34.Final/netty-buffer-4.1.34.Final.jar:/home/iotat/.m2/repository/io/netty/netty-codec/4.1.34.Final/netty-codec-4.1.34.Final.jar:/home/iotat/.m2/repository/io/netty/netty-transport/4.1.34.Final/netty-transport-4.1.34.Final.jar:/home/iotat/.m2/repository/io/netty/netty-resolver/4.1.34.Final/netty-resolver-4.1.34.Final.jar:/home/iotat/.m2/repository/io/projectreactor/reactor-core/3.2.8.RELEASE/reactor-core-3.2.8.RELEASE.jar:/home/iotat/.m2/repository/org/reactivestreams/reactive-streams/1.0.2/reactive-streams-1.0.2.jar:/home/iotat/.m2/repository/org/springframework/boot/spring-boot-starter-data-redis-reactive/2.1.4.RELEASE/spring-boot-starter-data-redis-reactive-2.1.4.RELEASE.jar:/home/iotat/.m2/repository/org/springframework/boot/spring-boot-starter-jdbc/2.1.4.RELEASE/spring-boot-starter-jdbc-2.1.4.RELEASE.jar:/home/iotat/.m2/repository/com/zaxxer/HikariCP/3.2.0/HikariCP-3.2.0.jar:/home/iotat/.m2/repository/org/springframework/spring-jdbc/5.1.6.RELEASE/spring-jdbc-5.1.6.RELEASE.jar:/home/iotat/.m2/repository/org/springframework/boot/spring-boot-starter-web/2.1.4.RELEASE/spring-boot-starter-web-2.1.4.RELEASE.jar:/home/iotat/.m2/repository/org/springframework/boot/spring-boot-starter-json/2.1.4.RELEASE/spring-boot-starter-json-2.1.4.RELEASE.jar:/home/iotat/.m2/repository/com/fasterxml/jackson/datatype/jackson-datatype-jdk8/2.9.8/jackson-datatype-jdk8-2.9.8.jar:/home/iotat/.m2/repository/com/fasterxml/jackson/datatype/jackson-datatype-jsr310/2.9.8/jackson-datatype-jsr310-2.9.8.jar:/home/iotat/.m2/repository/com/fasterxml/jackson/module/jackson-module-parameter-names/2.9.8/jackson-module-parameter-names-2.9.8.jar:/home/iotat/.m2/repository/org/springframework/boot/spring-boot-starter-tomcat/2.1.4.RELEASE/spring-boot-starter-tomcat-2.1.4.RELEASE.jar:/home/iotat/.m2/repository/org/apache/tomcat/embed/tomcat-embed-core/9.0.17/tomcat-embed-core-9.0.17.jar:/home/iotat/.m2/repository/org/apache/tomcat/embed/tomcat-embed-el/9.0.17/tomcat-embed-el-9.0.17.jar:/home/iotat/.m2/repository/org/apache/tomcat/embed/tomcat-embed-websocket/9.0.17/tomcat-embed-websocket-9.0.17.jar:/home/iotat/.m2/repository/org/hibernate/validator/hibernate-validator/6.0.16.Final/hibernate-validator-6.0.16.Final.jar:/home/iotat/.m2/repository/javax/validation/validation-api/2.0.1.Final/validation-api-2.0.1.Final.jar:/home/iotat/.m2/repository/org/jboss/logging/jboss-logging/3.3.2.Final/jboss-logging-3.3.2.Final.jar:/home/iotat/.m2/repository/org/springframework/spring-web/5.1.6.RELEASE/spring-web-5.1.6.RELEASE.jar:/home/iotat/.m2/repository/org/springframework/spring-webmvc/5.1.6.RELEASE/spring-webmvc-5.1.6.RELEASE.jar:/home/iotat/.m2/repository/org/springframework/spring-expression/5.1.6.RELEASE/spring-expression-5.1.6.RELEASE.jar:/home/iotat/.m2/repository/org/mybatis/spring/boot/mybatis-spring-boot-starter/2.0.1/mybatis-spring-boot-starter-2.0.1.jar:/home/iotat/.m2/repository/org/mybatis/spring/boot/mybatis-spring-boot-autoconfigure/2.0.1/mybatis-spring-boot-autoconfigure-2.0.1.jar:/home/iotat/.m2/repository/org/mybatis/mybatis/3.5.1/mybatis-3.5.1.jar:/home/iotat/.m2/repository/org/mybatis/mybatis-spring/2.0.1/mybatis-spring-2.0.1.jar:/home/iotat/.m2/repository/mysql/mysql-connector-java/8.0.15/mysql-connector-java-8.0.15.jar:/home/iotat/.m2/repository/org/projectlombok/lombok/1.18.6/lombok-1.18.6.jar:/home/iotat/.m2/repository/net/bytebuddy/byte-buddy/1.9.12/byte-buddy-1.9.12.jar:/home/iotat/.m2/repository/org/springframework/spring-core/5.1.6.RELEASE/spring-core-5.1.6.RELEASE.jar:/home/iotat/.m2/repository/org/springframework/spring-jcl/5.1.6.RELEASE/spring-jcl-5.1.6.RELEASE.jar:/home/iotat/.m2/repository/io/springfox/springfox-swagger2/2.7.0/springfox-swagger2-2.7.0.jar:/home/iotat/.m2/repository/io/swagger/swagger-annotations/1.5.13/swagger-annotations-1.5.13.jar:/home/iotat/.m2/repository/io/swagger/swagger-models/1.5.13/swagger-models-1.5.13.jar:/home/iotat/.m2/repository/com/fasterxml/jackson/core/jackson-annotations/2.9.0/jackson-annotations-2.9.0.jar:/home/iotat/.m2/repository/io/springfox/springfox-spi/2.7.0/springfox-spi-2.7.0.jar:/home/iotat/.m2/repository/io/springfox/springfox-core/2.7.0/springfox-core-2.7.0.jar:/home/iotat/.m2/repository/io/springfox/springfox-schema/2.7.0/springfox-schema-2.7.0.jar:/home/iotat/.m2/repository/io/springfox/springfox-swagger-common/2.7.0/springfox-swagger-common-2.7.0.jar:/home/iotat/.m2/repository/io/springfox/springfox-spring-web/2.7.0/springfox-spring-web-2.7.0.jar:/home/iotat/.m2/repository/org/reflections/reflections/0.9.11/reflections-0.9.11.jar:/home/iotat/.m2/repository/org/javassist/javassist/3.21.0-GA/javassist-3.21.0-GA.jar:/home/iotat/.m2/repository/com/google/guava/guava/18.0/guava-18.0.jar:/home/iotat/.m2/repository/com/fasterxml/classmate/1.4.0/classmate-1.4.0.jar:/home/iotat/.m2/repository/org/slf4j/slf4j-api/1.7.26/slf4j-api-1.7.26.jar:/home/iotat/.m2/repository/org/springframework/plugin/spring-plugin-core/1.2.0.RELEASE/spring-plugin-core-1.2.0.RELEASE.jar:/home/iotat/.m2/repository/org/springframework/plugin/spring-plugin-metadata/1.2.0.RELEASE/spring-plugin-metadata-1.2.0.RELEASE.jar:/home/iotat/.m2/repository/org/mapstruct/mapstruct/1.1.0.Final/mapstruct-1.1.0.Final.jar:/home/iotat/.m2/repository/io/springfox/springfox-swagger-ui/2.7.0/springfox-swagger-ui-2.7.0.jar:/home/iotat/.m2/repository/com/github/penggle/kaptcha/2.3.2/kaptcha-2.3.2.jar:/home/iotat/.m2/repository/javax/servlet/javax.servlet-api/4.0.1/javax.servlet-api-4.0.1.jar:/home/iotat/.m2/repository/com/jhlabs/filters/2.0.235-1/filters-2.0.235-1.jar:/home/iotat/.m2/repository/io/jsonwebtoken/jjwt/0.9.1/jjwt-0.9.1.jar:/home/iotat/.m2/repository/com/fasterxml/jackson/core/jackson-databind/2.9.8/jackson-databind-2.9.8.jar:/home/iotat/.m2/repository/com/fasterxml/jackson/core/jackson-core/2.9.8/jackson-core-2.9.8.jar:/home/iotat/.m2/repository/cn/hutool/hutool-all/4.1.21/hutool-all-4.1.21.jar:/home/iotat/.m2/repository/com/alibaba/fastjson/1.2.51/fastjson-1.2.51.jar:/home/iotat/.m2/repository/com/alibaba/druid/1.1.12/druid-1.1.12.jar:/home/iotat/.m2/repository/com/github/pagehelper/pagehelper/5.1.8/pagehelper-5.1.8.jar:/home/iotat/.m2/repository/com/github/jsqlparser/jsqlparser/1.2/jsqlparser-1.2.jar:/home/iotat/.m2/repository/javax/xml/bind/jaxb-api/2.3.0/jaxb-api-2.3.0.jar:/home/iotat/.m2/repository/org/mybatis/caches/mybatis-redis/1.0.0-beta2/mybatis-redis-1.0.0-beta2.jar:/home/iotat/.m2/repository/redis/clients/jedis/2.9.3/jedis-2.9.3.jar:/home/iotat/.m2/repository/org/apache/commons/commons-pool2/2.6.1/commons-pool2-2.6.1.jar com.swust.fund.FundApplication

  .   ____          _            __ _ _
 /\\ / ___'_ __ _ _(_)_ __  __ _ \ \ \ \
( ( )\___ | '_ | '_| | '_ \/ _` | \ \ \ \
 \\/  ___)| |_)| | | | | || (_| |  ) ) ) )
  '  |____| .__|_| |_|_| |_\__, | / / / /
 =========|_|==============|___/=/_/_/_/
 :: Spring Boot ::        (v2.1.4.RELEASE)

2019-05-07 13:46:08.436  INFO 22801 --- [           main] com.swust.fund.FundApplication           : Starting FundApplication on yank with PID 22801 (/home/iotat/pang/QualityBaby/target/classes started by iotat in /home/iotat/pang/QualityBaby)
2019-05-07 13:46:08.438  INFO 22801 --- [           main] com.swust.fund.FundApplication           : No active profile set, falling back to default profiles: default
2019-05-07 13:46:09.595  INFO 22801 --- [           main] .s.d.r.c.RepositoryConfigurationDelegate : Multiple Spring Data modules found, entering strict repository configuration mode!
2019-05-07 13:46:09.596  INFO 22801 --- [           main] .s.d.r.c.RepositoryConfigurationDelegate : Bootstrapping Spring Data repositories in DEFAULT mode.
2019-05-07 13:46:09.617  INFO 22801 --- [           main] .s.d.r.c.RepositoryConfigurationDelegate : Finished Spring Data repository scanning in 12ms. Found 0 repository interfaces.
2019-05-07 13:46:09.883  INFO 22801 --- [           main] trationDelegate$BeanPostProcessorChecker : Bean 'org.springframework.transaction.annotation.ProxyTransactionManagementConfiguration' of type [org.springframework.transaction.annotation.ProxyTransactionManagementConfiguration$$EnhancerBySpringCGLIB$$3853b6fa] is not eligible for getting processed by all BeanPostProcessors (for example: not eligible for auto-proxying)
2019-05-07 13:46:10.166  INFO 22801 --- [           main] o.s.b.w.embedded.tomcat.TomcatWebServer  : Tomcat initialized with port(s): 19316 (http)
2019-05-07 13:46:10.177  INFO 22801 --- [           main] o.a.coyote.http11.Http11NioProtocol      : Initializing ProtocolHandler ["http-nio-19316"]
2019-05-07 13:46:10.187  INFO 22801 --- [           main] o.apache.catalina.core.StandardService   : Starting service [Tomcat]
2019-05-07 13:46:10.187  INFO 22801 --- [           main] org.apache.catalina.core.StandardEngine  : Starting Servlet engine: [Apache Tomcat/9.0.17]
2019-05-07 13:46:10.257  INFO 22801 --- [           main] o.a.c.c.C.[Tomcat].[localhost].[/]       : Initializing Spring embedded WebApplicationContext
2019-05-07 13:46:10.258  INFO 22801 --- [           main] o.s.web.context.ContextLoader            : Root WebApplicationContext: initialization completed in 1749 ms
2019-05-07 13:46:10.514  WARN 22801 --- [           main] ConfigServletWebServerApplicationContext : Exception encountered during context initialization - cancelling refresh attempt: org.springframework.beans.factory.UnsatisfiedDependencyException: Error creating bean with name 'activityController': Unsatisfied dependency expressed through field 'activityService'; nested exception is org.springframework.beans.factory.UnsatisfiedDependencyException: Error creating bean with name 'activityService': Unsatisfied dependency expressed through field 'activityMapper'; nested exception is org.springframework.beans.factory.UnsatisfiedDependencyException: Error creating bean with name 'activityMapper' defined in file [/home/iotat/pang/QualityBaby/target/classes/com/swust/fund/dao/ActivityMapper.class]: Unsatisfied dependency expressed through bean property 'sqlSessionFactory'; nested exception is org.springframework.beans.factory.BeanCreationException: Error creating bean with name 'sqlSessionFactory' defined in class path resource [org/mybatis/spring/boot/autoconfigure/MybatisAutoConfiguration.class]: Bean instantiation via factory method failed; nested exception is org.springframework.beans.BeanInstantiationException: Failed to instantiate [org.apache.ibatis.session.SqlSessionFactory]: Factory method 'sqlSessionFactory' threw exception; nested exception is org.springframework.core.NestedIOException: Failed to parse mapping resource: 'file [/home/iotat/pang/QualityBaby/target/classes/mapping/ActivityMapper.xml]'; nested exception is org.apache.ibatis.builder.BuilderException: Error parsing Mapper XML. The XML location is 'file [/home/iotat/pang/QualityBaby/target/classes/mapping/ActivityMapper.xml]'. Cause: org.apache.ibatis.cache.CacheException: Could not instantiate cache implementation (class org.mybatis.caches.redis.RedisCache). Cause: java.lang.reflect.InvocationTargetException
2019-05-07 13:46:10.516  INFO 22801 --- [           main] o.apache.catalina.core.StandardService   : Stopping service [Tomcat]
2019-05-07 13:46:10.534  INFO 22801 --- [           main] ConditionEvaluationReportLoggingListener : 

Error starting ApplicationContext. To display the conditions report re-run your application with 'debug' enabled.
2019-05-07 13:46:10.538 ERROR 22801 --- [           main] o.s.b.d.LoggingFailureAnalysisReporter   : 

***************************
APPLICATION FAILED TO START
***************************

Description:

An attempt was made to call a method that does not exist. The attempt was made from the following location:

    org.mybatis.caches.redis.RedisCache.<init>(RedisCache.java:45)

The following method did not exist:

    redis.clients.jedis.JedisPool.<init>(Lorg/apache/commons/pool2/impl/GenericObjectPoolConfig;Ljava/lang/String;IIILjava/lang/String;ILjava/lang/String;)V

The method's class, redis.clients.jedis.JedisPool, is available from the following locations:

    jar:file:/home/iotat/.m2/repository/redis/clients/jedis/2.9.3/jedis-2.9.3.jar!/redis/clients/jedis/JedisPool.class

It was loaded from the following location:

    file:/home/iotat/.m2/repository/redis/clients/jedis/2.9.3/jedis-2.9.3.jar


Action:

Correct the classpath of your application so that it contains a single, compatible version of redis.clients.jedis.JedisPool


Process finished with exit code 1

```

上面是我第一次运行的时候的报错代码，看看报错说明，应该是jar包冲突，网上找了很多资料也是说是jar包冲突。好吧，冲突那么我就来解决冲突吧。哎，等等，不对，网上说的是jedis要从2.9.0以下的版本升级到2.9.0，可是我都用到了2.9.3了……

问题肯定还是因为jar包冲突，然后考虑到这是我前几天刚创建的spring boot工程，肯定不是因为jedis版本太高导致的（如果真是这样，那感觉也没有什么学习的必要了），那是不是因为2.9.3版本还是太低呢？好吧，去maven仓库上看看就知道了。果不其然，maven仓库中jedis已经更新到3.1.0m了，那我就勉强试试3.0.1吧。

添加如下依赖

```
<!-- https://mvnrepository.com/artifact/redis.clients/jedis -->
<dependency>
    <groupId>redis.clients</groupId>
    <artifactId>jedis</artifactId>
    <version>3.0.1</version>
</dependency>
```

然后再尝试运行一下，奇迹发生了，运行畅通无阻，那么肯定就是jedis的版本问题了。

在查看一下spring-boot-starter-data-redis和mybatis-redis这两个的依赖中，jedis版本分别为2.9.3和2.8.0，

怪不得，怪不得。

最后贴上我的项目的仓库，不是demo，是自己最近在做的项目，其中缺少配置文件，重要的配置文件都在文章里面：https://github.com/pangyuworld/QualityBaby