# R基础知识 {#basic}
## 编程基础语法
# 以下代码用于展示r的数据操作、基本数据结构和常用的函数。


#' =================================================
x = seq(1, 10, by=0.1)  # 生产一组数列，间隔为0.1
y = 2 * sin( x )      # 包含 Sin 函数
plot(x, y)      # 绘制出(x,y)的曲线。

plot(x=x, y=y, 
     xlab='x value', ylab = bquote(2 * sin( x ) ), col=2,
     type='o')
lines(x=x, y=abs(y), col='blue')
mtext(side = 3, text = 'Sin(x)', cex=2, line=-2)
grid()

length(x)

mat.v = cbind(x, y)
mat.h = rbind(x, y)

boxplot(mat.v)

class(mat.v)
dim(mat.v)
dim(mat.h)

nrow(mat.v)
ncol(mat.v)

#' =================================================
#' 函数定义
#' 文件1`Exercise/Functions/fun.add.R`内容：

fun.add <- function(a, b){
  return (a + b)
}


source('Exercise/Functions/fun.add.R')
fun.add(2, 3)


#' =================================================
#' 文件管理

## 数据类型与结构
# 1. 数字：numeric
# 即一维数组， 常用的函数`length`, `class`等。
x0 = rnorm(100)
plot(x0)


#' =================================================
#' 1. 数据框：data.frame
x=readRDS('Exercise/Data_RDS/JCR.RDS')
length(x)
dim(x)
head(x) #前5组元素

#' =================================================



#' =================================================
View(x)
#' =================================================
# 1. 字符：character
levels(x$name)[1:5]



# 1. 向量：vector
vec = cbind(1:10)
plot(vec)

#' =================================================
# 1. 矩阵：matrix
x.mat = as.matrix(x)
class(x.mat)
length(x.mat)


#' =================================================
#' 1. 因子：factor
library(ggplot2)
head(levels(x$c1))


#' =================================================
#' 1. 逻辑：logical
x = seq(-pi*2, pi * 2, by=0.01)
y = sin(x)
tf = (y > 0)
df = data.frame(x, y, tf)

plot(x, y, type = 'o', pch = 19, col = tf+1, xlab='X', ylab = 'Y = sin(x)')
abline(v = 0, col='red', lwd=4) #在x = 0处添加垂直线条，
abline(h = 0, col='blue', lwd=4) #在y = 0处添加水平线条，
grid()  # 添加坐标网格

#' =================================================
#' 可视化
par(mar = c(4, 4, .1, .1))  # 绘图的四边边界
x = seq(-pi*2, pi * 2, by=0.01)
y = sin(x)
plot(x, y, type = 'l', pch = 19, xlab='X', ylab = 'Y = sin(x)')
abline(v = 0, col='red', lwd=4) #在x = 0处添加垂直线条，
abline(h = 0, col='blue', lwd=4) #在y = 0处添加水平线条，
grid()  # 添加坐标网格

#' =================================================
n=1000
x = 1:n
y = abs(rnorm(n, mean=10, sd=3))
y.sort = sort(y)
par(mfrow=c(2,2))
plot(x, y.sort, log=''); grid()
plot(x, y.sort, log='x'); grid()
plot(x, y.sort, log='y'); grid()
plot(x, y.sort, log='xy'); grid()

#' =================================================
#' 三维可视化
install.package('rgl')
library(rgl)
with(iris, plot3d(Sepal.Length, Sepal.Width, Petal.Length, 
                  type="s", col=as.numeric(Species)))


