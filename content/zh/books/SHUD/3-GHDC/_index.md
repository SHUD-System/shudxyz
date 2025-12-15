---
# Page title
title: 全球水文数据云(GHDC)

# Title for the menu link if you wish to use a shorter link title, otherwise remove this option.
linktitle: 3. 全球水文数据云(GHDC)

# Page summary for search engines.
summary: 全球水文数据云

# Date page published
date: 2020-11-23

# Academic page type (do not modify).
type: book

# Position of this page in the menu. Remove this option to sort alphabetically.
weight: 30

---

![](/ghdc_CN/Figure/logo_cn.png)

## 数据平台介绍

全球水文数据云（Global Hydrologic Data Cloud，GHDC）是一个云平台，旨在快速获取水文建模基础数据，以实现快速模型部署。平台可实现全球任意流域、任意大陆、任意国家范围内的快速水文模型部署。用户只需提供欲建模的流域边界，GHDC即可自动化完成数据前处理。此处理不仅生成建模所需的基础数据（如高程、土地利用、土壤质地和水系等数据），还能制备SHUD（Simulator of Hydrologic Unstructured Domains）模型所需的输入数据。用户可以根据需要进行水文模拟、空间分析和数据挖掘等工作。

GHDC中文说明书：[https://shud.xyz/cn/ghdc_cn](https://shud.xyz/cn/ghdc_cn)

![GHDC的工作流程](/ghdc_CN/Figure/GHDC_flow.png)


### 版权和权益
GHDC不生成数据，仅提供数据处理服务。原始数据的版权和权益全部归属于数据的作者。当前平台所处理的数据全部为开放版权的数据产品，允许数据处理、修改和重新发布，并放弃数据版权权益。本平台不提供未使用开放版权的数据产品的数据处理服务。例如，GLDAS、NLDAS和FLDAS数据均使用了开放版权，本平台可以提供数据处理服务。但是，部分再分析数据资料未使用开放版权，因此本平台无法提供数据处理服务。若用户需要未开放版权的数据集的处理任务，请联系网站作者（shulele@lzb.ac.cn）商讨。

### 原始数据源
当前可用数据见表：

| 数据分类 | 数据名称 | 数据属性 | 数据版权 | 数据源 |
|:---------|:---------|:---------|:---------|:---------|
| 高程 | ASTER GDEM |  全球 30m| Public Domain |  |
| 高程 | Merit Hydro DEM |  全球 90m| Public Domain |  |
| 土地利用 | USGS Land Cover  | 全球 500m | Public Domain |  |
| 土壤质地 |  HWSD v1.0 |   全球 1km | Public Domain |  |
| 气象再分析资料 | GLDAS | 全球 0.25度，3hr, 2000-至今 | Public Domain |  |
| 气象再分析资料 | FLDAS | 全部部分区域 0.1度，3hr, 1979至今 | Public Domain |  |
| 气象再分析资料 | NLDAS | 美国 0.125度，1hr, 1979至今 | Public Domain |  |
| 气象再分析资料 | CMFD | 中国 0.1度， 3hr, 1979-2018 | **Public Domain** |  |
| 气象再分析资料 | CLDAS |  中国 0.125度 | **版权私有** |  |
| | | | | |

![ASTER Global DEM](/ghdc_CN/Figure/Aster_GDEM.png)
![GLDAS, FLDAS, NLDAS, NCA-LDAS覆盖范围](/ghdc_CN/Figure/ldas-domain.jpg)

## 如何获取数据

1. 提供流域边界，文件格式为ESRI Shapefile。请将Shapefile包含的四个基本子文件(.shp, .shx, .dbf, .shx)打包为.zip文件，并上传。
2. 提供模拟所需要的参数，包含项目名称、模拟年份、最小单元数，最大单元面积，含水层厚度等。
3. 填写邮箱地址，并提交任务。 请查看您的邮箱，GHDC会发送一封邮件；请点击邮箱内的确认链接。点击确认链接之后，GHDC才会启动数据处理任务。
4. GHDC数据处理完成后，会向您的邮箱再发送一封邮件，包含数据下载链接。
5. 请通过数据下载链接下载处理好的数据。
6. 模拟愉快~~~




