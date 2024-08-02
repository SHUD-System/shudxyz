+++
title = "Ubuntu安装Slurm教程脚本"
date = "2023-01-20"
draft = false

# Tags and categories
# For example, use `tags = []` for no tags, or the form `tags = ["A Tag", "Another Tag"]` for one or more tags.
tags = ["Post", "SHUD", "水文模型", "计算集群"]
categories = []

# Featured image
# To use, add an image named `featured.jpg/png` to your page's folder.
[image]
  # Caption (optional)
  caption = ""

  # Focal point (optional)
  # Options: Smart, Center, TopLeft, Top, TopRight, Left, Right, BottomLeft, Bottom, BottomRight
  focal_point = ""
+++


研究组需要构建一个SHUD模型并行计算使用的计算集群。选择操作系统为Ubuntu
20.04，使用slurm作为计算集群的作业管理软件。
初步建设规划一个计算+存储节点，8个计算节点。

## Slurm安装主要要完成任务

0. 再管理、存储和计算节点共享hosts信息。这些信息有助于系统内各个节点快速访问。
1. slurm.conf的配置文件。该文件要求管理节点与计算节点的文件完全相同。其中包含计算集群的名称、各节点计算资源信息、计算分区的设定、以及若干程序运行需要的文件路径。
2. 管理节点： 安装slurmctld、munge、nfs-server、NIS四个服务。四个服务分别是slurm的管理程序、用户无密码认证程序、网络磁盘共享服务、用户信息分析。
3. 计算节点：安装slurmd、munge、nfs-commom、NIS四个服务。
4. 将管理节点的slurm.conf、munge.key文件复制到计算节点
5. 管理/存储节点开启NFS和NIS服务，并在计算节点加入共享存储的挂载信息。

## 计算集群结构

## slurm.conf文件

## 主节点安装脚本

## 计算节点安装脚本


## 集群测试



