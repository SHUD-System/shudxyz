---
# Page title
title: FAQ

# Title for the menu link if you wish to use a shorter link title, otherwise remove this option.
linktitle: 5. 常见问题

# Page summary for search engines.
summary: FAQ

# Date page published
date: 2020-02-23

# Academic page type (do not modify).
type: book

# Position of this page in the menu. Remove this option to sort alphabetically.
weight: 999
---



## 1. 关于SHUD模型
### 为什么使用非结构网格(unstructured mesh)，而不使用规则网格(structured grid)?

  水文计算中非结构网格有以下几个优点：

  - 通常，非结构域中的计算单元数量远少于结构域。
  - 由于自然环境中的变量和特征从来不是横平竖直的规则分布，因此非结构域比规则域更易于表达空间异质性特征，包括海拔、地形、土壤、图例利用等等。
  - 非结构域的边界较为灵活，在不显著增加计算单元的情况下，可以详细描述计算域的边界形状。
  - 非结构域的单元大小灵活，可根据模型和研究区域的特征在特定区域加密计算单元，而同时在外围地区保持较粗单元，即保证的计算域的边界影响最小，有能保证在所关心区域内的高精度高分辨率的模拟。
  - 非结构网格更容易表达复杂边界。当研究区域边界复杂时，规则域的计算单元以指数级增长，实现对复杂边界和空间异质性的表达，而非结构域则无此限制。

  非结构域的缺点：
  - 比较难以建立
  - 建立非结构域的算法多种多样，用户需要有较长的学习过程。
  - 建立求解过程相比于规则域要复杂
  - 空间数据的解读不如规则域简单直观，通常空间数据的可视化中——需要对非结构域结果进行空间插值，实现规则域形式的可视化。

  Reference: [https://en.wikipedia.org/wiki/Grid_classification](https://en.wikipedia.org/wiki/Grid_classification)

### SHUD模型和PIHM的区别?

SHUD模型是PIHM的继承者，采用了1996年Duffy提出的二相耦合概念模型并继承了PIHM 1.0和2.0的一些成熟经验。作者对模型的部分过程、计算和实现语言进行了修改。由于SHUD模型不再与PIHM模型兼容，因此使用新名称对其进行命名。

SHUD与PIHM的区别：

1. SHUD使用C++面向对象编程，将计算封装，避免了PIHM常见的内存泄漏等问题。
2. SHUD使用了不同的坡面与河道的交互方式。PIHM中，河道与两个三角形坡面相邻，存在以下四个问题：(1) 河道的长度对计算单元数量极大影响，用户不得不在简单河道和计算单元数量之间做出取舍。(2) 平原地区的曲折河道导致大量微小三角形单元和非结构三角形，使得模型计算容易突破CFL条件，降低模型计算效率。(3) 容易形成局部积水点和拖慢整个流域的求解速度。(4) 为解决以上问题，模型用户需要反复手动对河流形状进行修改，降低了模型的可重复性和效率。在SHUD模型中，河道覆盖在三角形单元之上，坡面和河道之间的水量交换，计算河道水位和地下水、地表水的坡度，从而提高了整体计算效率。
3. SHUD模型中的公式计算入渗、地下水补给和河流交互不同于PIHM。采用的公式基于经验和模型设计需求。未来将进行模型对比，展示两个模型的差异。
4. SHUD模型确保了计算中的水量平衡。

在技术层面SHUD模型：

- 支持CVODE 5.0及以上版本。
- 支持OpenMP并行计算。
- 采用与PIHM不同的数据结构和算法。
- 支持输出可读性强的输入和输出文件。
- 实现统一的时间序列数据操作。
- 可指定步长输出模型状态，作为后续模型运行的初始条件。
- 实现自动检查模型的输入数据和参数的有效性。
- 增加模型调试选项，可监控每一步长内的非法值和内存操作。



### SHUD模型需要什么数据来驱动？

* 空间数据：高程、流域边界、河流、土壤分类、地质背景、土地利用、气象站点

* 属性数据： 土壤/地质特征、河道剖面几何特征、土地利用参数

* 时间序列数据：气象驱动（包括降雨，气温，湿度，风速和净辐射），叶面积指数，用于蒸发计算的粗糙度，融雪指数。

  部分数据缺失的时候，可以使用SHUD模型的默认数据。具体请参考SHUD理论指南[https://www.shud.xyz/Book_CN/](https://www.shud.xyz/Book_CN/).

### SHUD模型在全球有哪些适用的流域？

SHUD模型作为物理性水文模型，理论上可适用于任何流域和区域，而且SHUD模型非常灵活，可适应各种不同的背景和研究目的。

至今最小的模拟区域是Vauclin试验——模拟 $2m \times 3m \times 0.05 m $ ($ 高 \times 长 \times 宽 $)的水槽箱，顶部投影面结仅仅$ 0.1 m^2$，计算单元面积小于$ 0.1 cm^2$，本试验关注土壤水和地下水的计算精度。

最大应用案例为模拟萨克拉门托河流域40年水资源变化状况，面积700,000 $km^2$。使用 ~$7 km^2$面积的分辨率，每两小时完成一年模拟，计算时间步长小于10分钟。

部分应用案例可从链接 [https://www.shud.xyz/book_cn/application.html](https://www.shud.xyz/book_cn/application.html)查看.


## 2. 模型安装与运行

### 那里下载SHUD模型源码？
SHUD模型源码可以从github（[https://github.com/SHUD-System/SHUD](https://github.com/SHUD-System/SHUD)），SHUD网站（[shud.xyz](https://www.shud.xyz)），以及作者处（[shulele@lzb.ac.cn](mailto:shulele@lzb.ac.cn)）获取

###  SHUD支持的操作系统平台有哪些？

SHUD模型由C++书写，rSHUD使用了R，因此SHUD模拟环境可以在Windows, Linux, Mac OS, Unix等等各种操作系统平台上无缝迁移。在各种平台上都需要安装C/C++编译器， R运行环境来支持模型构建和运行。

###  如何安装SUNDIALS/CVODE?

SUNDIALS (https://computing.llnl.gov/projects/sundials) 是一个强大的数学库，能够高效求解工程物理和科学问题。CVODE是SUNDIALS套件中的一个求解器，用于求解初值问题的常微分方程。SHUD模型需要使用CVODE，因此用户需要编译和安装CVODE保证模型运行。关于SUNDIAL/CVODE安装过程，请参考：[https://www.shud.xyz/book_cn/modeling.html](https://www.shud.xyz/book_cn/modeling.html)。除了使用SUNDIALS/CVODE的安装器之外，还可以使用源码中的文件 `configure`来安装。

###  SHUD模型计算效率如何？

理论上的计算效率与5个要素有关：

1. 空间单元分辨率和河流长度。计算单元和河道数量越多，计算所需时间越长。同时，当计算单元越小，隐式数值方法所需要的时间不长也越小，导致计算效率变低。因此，用户需要权衡模拟空间精度与模拟效率，选择合适的分辨率。
2. 参数集；作为物理性数值方法模型，当不合理参数出现时，将会极大的影响计算空间中的变化速率，变化速率变大，会导致迭代的时间步长变小甚至出现异常数值。
3. 流域地形特征；坡度较陡的地形也会使得计算的变化速率过快，导致计算效率变慢。通常这类情况出现在局部山区，通过调整格网位置或者局部加粗分辨率可以得到改善。
4. 计算资源；并行计算通常要比单线程计算效率高，并且耗时更可预测。
5. 降雨强度；当发生大暴雨时，整个计算空间中的地表水和河道水都快速变化，模型会自动缩小迭代时间不长——通常小于1分钟，会极大降低模拟效率，当暴雨结束、洪水退去之后，模型进入较为稳定状态，运行效率会恢复到较高水平。

已有案例中，较为常见的模拟效率为：面积 192 $km^2$，划分1100个单元，约5小时可以完成17年模拟，约每小时3年； 更常见的情况时每小时实现半年模拟。

### 如何开启SHUD并行模式？
首先，你需要安装OpenMP。然后测试`-fopen`编译选项是否可用。

然后，开启OpenMP的条件下重新编译CVODE，请参考：[https://www.shud.xyz/book_cn/modeling.html](https://www.shud.xyz/book_cn/modeling.html)。

最后，编译并行版的SHUD模型：

```
make shud_omp
```
测试并行：
```
./shud_omp ccw
```

### 计算单元最优的面积大小，或者最优计算单元的数量？

此问题没有绝对答案。计算单元大小高度依赖研究的问题和研究区域特征。 分辨率可跨越$ \sim 1 cm^2$ 到 $ \sim 10 km^2$，根据研究的需求决定。

## 3. rSHUD工具箱

### 如何安装rSHUD?
首先你需要有R环境——先安装R，再推荐使用Rstudio。

在R中，首先需要安装devtools, 然后通过GitHub安装rSHUD。
```
install.packages("devtools")
devtools::install_github("SHUD-System/rSHUD")
```
###  rSHUD是否已经提交R CRAN?

尚未提交。 曾经试图提交，但是CRAN的管理员提出需要提交若干详细的案例和引用文献，费时费力，而且rSHUD的用户是模型使用者，应该可以驾驭几行简单的命令行——使用两行命令实现安装。但是未来我们还是会尽力向CRAN提交整个开发包。

###  rSHUD的源代码

源代码可以通过GitHub获取：[https://github.com/SHUD-System/rSHUD](https://github.com/SHUD-System/rSHUD)。但使用仅限非商业用途，商业用途请直接联系作者。
