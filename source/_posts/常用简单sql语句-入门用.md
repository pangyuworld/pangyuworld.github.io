---
title: 常用简单sql语句(入门用)
author: 小胖儿
mathjax: true
date: 2019-10-17 15:58:21
cover: /assets/ac6eddc451da81cb037c289d5366d016082431c3.jpg
tags:
	- 数据库
	- MySQL
typora-root-url: ..
---

![](/assets/ac6eddc451da81cb037c289d5366d016082431c3.jpg)

整理了一些简单的数据库增删改查语句，适用于入门，稍微复杂点的查询还需要专项学习一下SQL语句。

所有的SQL语句都是基于同一个数据库来完成，搭建这个数据库的教程在文章最后，如果是第一次看到这个教程可以先将数据库创建好。

所有的数据库关键字使用**大写**表示，其他非数据库关键字用小写表示

<!-- more -->

# 数据库结构

![](/assets/1571302691493.png)

# 数据库基本语句教程

## 1、插入语句

### 基本格式

```sql
INSERT INTO 数据表名(字段名,字段名) VALUES(字段值,字段值)
```

### demo-1 插入学生信息

插入语句一般都是对单个数据表进行操作，当然，如果有外键的限制，那外键的约束也在考虑范围之内。

这里我们先以**插入学生信息**为任务来编写sql语句:

```sql
INSERT INTO t_student(stu_name,stu_num) VALUES("小红","5120180020")
```

*注意这里我创建数据库的时候做了一个限制，就是**学号不能重复***

### demo-2 插入组织信息

**插入组织信息**

```sql
INSERT INTO t_organization(organization_name,organization_tell) VALUES("新建的组织","1300000000")
```

### demo-3 插入活动信息

**插入活动信息**，这里要注意两点

1. 因为`t_activity`表里面有一个外键`organization_id`，所以这里插入的时候，`organization_id`一定是要为`t_organization`表里面已经存在的`organization_id`
2. 时间格式在这里为`yyyy-MM-dd HH:mm:ss`

```sql
INSERT INTO t_activity(activity_name,activity_start_time,organization_id) VALUES("新的活动","2019-10-17 16:49:39",1)
```

### 其他

插入语句一般不会插入主键（id），因为主键一般都是自增长的

## 2、更新语句

### 基本格式

```sql
UPDATE 数据表名 SET 字段名=新值,字段名=新值
```

不过，上面的基本格式会把我们数据表里面相应字段的全部的值都改为新值，因此这里我们要加上`where`来限制，下面是修改后的**基本格式**

```SQL
UPDATE 数据表名 SET 字段名=新值,字段名=新值 WHERE 条件表达式
```

**条件表达式**：类似于编程语言中的`a>b`这种，下面看demo一点一点理解

### demo-1 修改学生姓名

**修改学生姓名**：

1. 修改id为3的学生的姓名为张三

```sql
UPDATE t_student SET stu_name='张三' WHERE stu_id=3 
```

2. 修改stu_num为5120180005的学生的名为阿伟

```sql
UPDATE t_student SET stu_name='阿伟' WHERE stu_num='5120180005'
```

### demo-2 修改活动信息

**修改活动信息**：修改活动名为“英雄联盟网吧联赛”的活动，使其活动名为“LOL网吧联赛”并且属于`origanization_id=2`的组织。这里还是要注意一下外键约束

```sql
UPDATE t_activity SET activity_name='LOL网吧联赛',organization_id=2 WHERE activity_name='英雄联盟网吧联赛'
```

### 其他

更新语句中，一般我们都会加上`WHERE`来进行限制，不然会造成灾难性的后果（和删库后果差不多了）

WHERE后面的限制一般使用主键进行限制，次要使用包含**索引**的字段进行限制，一般不会使用其他字段进行限制。

## 3、删除语句

### 基本格式

```sql
DELETE FROM 数据表名
```

当然了，这里如果不加上`WHERE`进行限定的话，那就会迎来删表的危险，所以改进以后的格式为：

```sql
DELETE FROM 数据表名 WHERE 条件表达式
```

### demo 删除活动信息

**删除活动信息**：删除活动id为2的活动

```sql
DELETE FROM t_activity WHERE activity_id=2
```

### 其他

如果存在外键约束，可能会导致删除信息失败，原因是外键约束了当前信息。例如：当id为1的组织下面有两个活动，这时候删除id为1的组织信息，那可能就会失败。当然，这也不是不可避免的，在设计数据库的时候可以添加外键约束的动作来使其能做出相应反应。

## 4、查询语句

终于到了查询语句了，作为数据库里面我个人认为最为复杂也最为常用的语句，如何利用好其将会是判断程序员能力的一个指向标。话不多说，开讲。

### 4.1 基础格式

```sql
SELECT 字段名,字段名 FROM 数据表
```

最简单的数据库查询就是这个样子的，直接写个demo吧。

#### demo-1 查询所有学生的姓名和学号

```sql
SELECT
 stu_name,
 stu_num
FROM
 t_student
```

### 4.2 带条件的查询语句

SQL查询语句也可以设置查询条件。

#### demo-2 查询id为2的学生的姓名和学号

```sql
SELECT
 stu_name,
 stu_num
FROM
 t_student
WHERE 
 stu_id=2
```

### 4.3 对查询结果进行排序

#### demo-3 查询所有学生信息并根据学号逆序输出

```sql
SELECT
 stu_name,
 stu_num
FROM
 t_student
ORDER BY stu_num DESC
```

这里主要看第6行代码，`ORDER BY 字段名`表示查询结果根据字段进行排序，默认排序`ASC`是从小到大，`DESC`是从大到小排序

### 4.4 计算查询结果总数

#### demo-4 查询组织id为1的活动总数

```sql
SELECT
 COUNT(*)
FROM 
 t_activity
WHERE
 organization_id=2
```

`COUNT()`函数是计算查询总数，类似的函数还有`SUM()``MAX()``MIN()`等，详情可以百度…..

还有一个就是，有些情况需要使用`GROUP BY 字段名`进行分组

### 4.5 多表联查

#### demo-5 查询学生姓名和学生参加的活动名

```sql
SELECT
	a.stu_name,
	c.activity_name
FROM t_student a
INNER JOIN t_student_activity b ON b.stu_id=a.stu_id
INNER JOIN t_activity c ON c.activity_id=b.activity_id
```

这里需要在创建数据表的时候，要有外键约束，然后才能使用`INNER JOIN`

这个语句的大概格式就是`INNER JOIN 表名 [表别名] ON 表名.字段 = 表名.字段`，详情可以参考上面的demo

# 创建数据库教程

## 1、下载数据库备份文件

<a href="https://pangyuworld.github.io/assets/demo.sql" type="download">下载链接</a>

## 2、在Navicat上新建一个数据库

![](/assets/1571299736776.png)

注意这里，字符集一定要选`utf8`，排序规则可以默认也可以选择`utf8_general_ci`

## 3、将下载的数据库备份文件添加到新建的数据库中

![](/assets/1571299822088.png)

先打开数据库，然后右键，然后点击**运行SQL文件**

![](/assets/1571299870599.png)

然后从右边的`...`处找到自己刚下载的SQL文件，然后点击开始。

![](/assets/1571302624170.png)

创建成功。