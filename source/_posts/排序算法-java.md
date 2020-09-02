---
title: 排序算法(java)
date: 2019-04-13 15:30:21
author: 小胖儿
mathjax: true
cover: /assets/1575087132732.png
tags: 
	- Java
	- 算法
---
# 算法学习（一）——排序算法

参考：[排序](https://hrbust-acm-team.gitbooks.io/acm-book/content/basic/pai_xu.html "排序")

## 1、冒泡排序

冒泡排序是一种很简单也很常见的排序算法，我们在初学编程语言，尤其是初学数组的时候，应该都了解过冒泡排序，下面就当复习吧。

<!-- more -->

```java
public static void pubbleSprt(int array[], int left, int right) {
    for (int i = left; i <= right; i++) {
        for (int j = i; j <= right-1; j++) {
            if (array[j] > array[j + 1]) {
                //swap(array[j],array[j+1]);
                int cont = array[j];
                array[j] = array[j + 1];
                array[j + 1] = cont;
            }
        }
    }
}
```

冒泡排序：从数组下标left开始，依次比较相邻两个元素的值，如果前面的数大于后面的数，则互换这两个数，每轮比较之后left+1，直到left=right为止。
时间复杂度：$ O(n^2) $，空间复杂度： $O(n) $。

## 2、选择排序

首先在未排序序列中找到最小（大）元素，存放到排序序列的起始位置，然后，再从剩余未排序元素中继续寻找最小（大）元素，然后放到已排序序列的末尾。以此类推，直到所有元素均排序完毕。

```java
public static void selectSort(int array[], int left, int right) {
    int minIndex;//minIndex为最大值下标
    for (int i = left; i <= right; i++) {
        minIndex = i;//minIndex默认值为排序数组初下标
        for (int j = i; j <= right; j++) {
            if (array[minIndex] > array[j]) {
                minIndex=j;
            }
        }
        if (minIndex != i) {
            //swap(array[i],array[minIndex]);
            int cont = array[i];
            array[i] = array[minIndex];
            array[minIndex] = cont;
        }
    }
}
```

时间复杂度：$ O(n^2) $，空间复杂度： $O(n) $。

## 3、直接插入排序

插入排序（Insertion Sort）的算法描述是一种简单直观的排序算法。它的工作原理是通过构建有序序列，对于未排序数据，在已排序序列中从后向前扫描，找到相应位置并插入。插入排序在实现上，通常采用inplace排序（即只需用到O(1)的额外空间的排序），因而在从后向前扫描过程中，需要反复把已排序元素逐步向后挪位，为最新元素提供插入空间。

```java
public static void insertSort(int array[], int left, int right) {
    for (int i = left + 1; i <= right; i++) {
        int temp = array[i];//保存当前的值
        int j = i - 1;
        while (j >= left && array[j] > temp) {
            array[j + 1] = array[j];
            j--;
        }
        //也可以改写成下面这种形式
        /*
        while (j>=left){
            if (array[j]<=temp)
                break;
            array[j+1]=array[j];
            j--;
        }
         */
        array[j + 1] = temp;
    }
}
```

时间复杂度：$ O(n^2) $，空间复杂度： $O(n) $。

## 4、快速排序

上面写了三个排序以后，终于到了快排了。快排怎么说呢，是我认为高级排序算法里面我能够理解的一类简单算法了。
快排的基本思想其实也很简单，大概就是分治法（分治是啥我也不太懂）。
基本思想：从序列中选出一个关键字，然后根据关键字将序列分成两部分（比关键字大、比关键字小），然后将左右两侧的序列分别按照刚才的方法对其进行排序，直到序列不可再分为止。

```java
public static void quickSort(int array[], int left, int right) {
   if (left >= right)//如果左边界大于右边界，则停止递归
        return;
    int i = left, j = right;//获取左右边界
    int temp = array[i];//取序列第一个值为参考值
    while (i < j) {
        while (i < j && array[j] >= temp) {
            j--;
        }
        array[i] = array[j];
        while (i < j && array[i] <= temp) {
            i++;
        }
        array[j] = array[i];
    }
    array[i] = temp;
    quickSort(array, left, i - 1);//递归左边
    quickSort(array, i + 1, right);//递归右边
}
```

时间复杂度：$ O(nlog(n)) $，空间复杂度： $O(n) $。
这里可以看到，快速排序的时间复杂度要比前三种排序方法低了很多。

## 5、归并排序

归并排序是一种稳定的算法，采用分治的思想，有序的子序列合并得到有序序列。
实现步骤：
1、将序列分成长度为 n/2的两部分
2、对于左右两部分采用分治的方法得到有序序列
3、将左右两个有序序列合并得到整个有序序列 
![归并排序算法](https://hrbust-acm-team.gitbooks.io/acm-book/content/basic/%E5%9B%BE%E7%89%872.png)

```java
public static void splitArray(int array[], int left, int right) {
    //拆分
    if (left >= right)
        return;
    int mid = (left + right) / 2;
    splitArray(array, left, mid);//递归拆分左边
    splitArray(array, mid + 1, right);//递归拆分右边
    mergeArray(array, left, mid, right);//实现归并
}

public static void mergeArray(int array[], int left, int mid, int right) {
    //归并
    if (left > right)
        return;
    int i = left, j = mid + 1;//设置两个起始点
    int index=0;//新数组的下标
    int temp[]=new int[right-left+1];//新建一个数组，保存数据
    while (i<=mid&&j<=right){//把较小的数存入数组
        if (array[i]<array[j]){
            temp[index++]=array[i++];
        }else{
            temp[index++]=array[j++];
        }
    }
    while (i<=mid){//把左数组放入新数组
        temp[index++]=array[i++];
    }
    while (j<=right){//把右数组放入新数组
        temp[index++]=array[j++];
    }
    //将新数组覆盖掉旧数组
    index=0;
    while (left<=right){
        array[left++]=temp[index++];
    }
}
```

*PS：不简单啊，归并算法看了好久好久然后才写出来，一直想找一个不用新建数组的方法，但是最后还是没有找到，用数组也搞了很久，不过还好，认识到了归并怎么用了*
时间复杂度：$ O(nlog(n)) $，空间复杂度： $O(n) $。

## 6、二分插入排序

二分（折半）插入（Binary insert sort)排序是一种在直接插入排序算法上进行小改动的排序算法。其与直接排序算法最大的区别在于查找插入位置时使用的是二分查找的方式，在速度上有一定提升。

```java
public static void binaryInsertSort(int array[], int left, int right){
    for (int i=left+1;i<=right;i++){
        int low=left,high=i-1;
        while(low<=high){//利用二分法找到要插入的地方
            int mid=(high+low)/2;
            if (array[mid]>array[i]){
                high=mid-1;
            }else{
                low=mid+1;
            }
        }
        int temp=array[i];
        for (int j=i;j>high+1;j--){
            array[j]=array[j-1];
        }
        array[high+1]=temp;
    }
}
```

时间复杂度：$ O(n^2) $，空间复杂度： $O(n) $。

## 7、鸡尾酒排序

鸡尾酒排序等于是冒泡排序的轻微变形。不同的地方在于从低到高然后从高到低，而冒泡排序则仅从低到高去比较序列里的每个元素。他可以得到比冒泡排序稍微好一点的效能，原因是冒泡排序只从一个方向进行比对(由低到高)，每次循环只移动一个项目。

```java
public static void cocktailSort(int array[], int left, int right){
    int low=left,high=right;//初始化边界
    while (low<high){
        for (int i=low;i<high;i++){
            if (array[i]>array[i+1]){
                int cont=array[i];
                array[i]=array[i+1];
                array[i+1]=cont;
            }
        }
        high--;
        for (int i=high;i>low;i--){
            if (array[i]<array[i-1]){
                int cont=array[i];
                array[i]=array[i-1];
                array[i-1]=cont;
            }
        }
        low++;
    }
}
```

时间复杂度：小于 $O(n^2)$ 且大于 $O(n)$ 。