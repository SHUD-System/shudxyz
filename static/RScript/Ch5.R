rm(list=ls())
library(stats)   # 统计学库
library(NbClust) # 聚类分析
library(factoextra) # 聚类
library(cluster)
library(class)
library(dendextend)

library(rpart) ## recursive partitioning
library(rpart.plot)


library(e1071) # SVM 支持向量机
library(colorspace) # 绘图色彩库
library(ggplot2)  # 绘图库
library(ggraph)   # 绘图库
library(GGally)   # 绘图库


# ================================================================
# 原始数据
# ================================================================
data(iris)
x=iris
str(x)
ggpairs(x, aes(colour = Species, alpha = 0.4), columns = 1:5, upper=NULL)



# ================================================================
# PCA
# ================================================================
# 基本PCA结果
x.pca <- prcomp(iris[, -5])
summary(x.pca)

# biplot(x.pca)

# PCA下的iris数据
df= data.frame(x.pca$x, 'Species'=x$Species)
ggpairs(df, aes(colour = Species, alpha = 0.4), columns = 1:5, upper=NULL)


# ================================================================
# k-means clustering
# ================================================================

# 方法1
data(iris)
x = iris
idx=as.numeric(x$Species)
species = levels(x$Species)
y = stats::kmeans(x[, 1:3], centers = 3, nstart = 10, iter.max=10)
z = table(y$cluster,species[idx])
knitr::kable(
  z/50, caption = 'k-means分类精度',
  booktabs = TRUE
)

# 方法2
library(factoextra)
data(iris)
x=iris[, 1:4]
pm= pam(x, k=3)
factoextra::fviz_cluster(list(data = x, cluster = pm$clustering),
                         frame.type = "norm", geom = "point", stand = FALSE)

# 不同k值的结果
ks <- 1:6
tot_within_ss <- sapply(ks, function(k) {
  cl <- kmeans(x[, 1:4], k, nstart = 10)
  cl$tot.withinss
})
graphics.off()
plot(ks, tot_within_ss, type = "b", ylab = "Total within squared distances", xlab = "Values of k tested")
grid()
# --------------------
par(mfrow=c(2,3))
for(i in ks){
  cl <- pam(x,i)
  clusplot(cl, main=paste('K =', i), col.p=cl$clustering)
}

# ================================================================
# 分层聚类(Hierarchical clsutering)
# ================================================================
# Reference: https://cran.r-project.org/web/packages/dendextend/vignettes/Cluster_Analysis.html
library(dendextend)
d_iris <- dist(iris) # method="man" # is a bit better
hc_iris <- hclust(d_iris, method = "complete")
iris_species <- rev(levels(iris[,5]))

dend <- as.dendrogram(hc_iris)
# order it the closest we can to the order of the observations:
dend <- rotate(dend, 1:150)

# Color the branches based on the clusters:
dend <- color_branches(dend, k=3) #, groupLabels=iris_species)

# Manually match the labels, as much as possible, to the real classification of the flowers:
labels_colors(dend) <-
  rainbow_hcl(3)[sort_levels_values(
    as.numeric(iris[,5])[order.dendrogram(dend)]
  )]

# We shall add the flower type to the labels:
labels(dend) <- paste(as.character(iris[,5])[order.dendrogram(dend)],
                      "(",labels(dend),")", 
                      sep = "")
# We hang the dendrogram a bit:
dend <- hang.dendrogram(dend,hang_height=0.1)
# reduce the size of the labels:
# dend <- assign_values_to_leaves_nodePar(dend, 0.5, "lab.cex")
dend <- set(dend, "labels_cex", 0.5)
# And plot:
graphics.off()
plot(dend, 
     main = "Clustered Iris data set
     (the labels give the true flower species)",   
     horiz =  TRUE,  nodePar = list(cex = .007))
legend("topleft", legend = iris_species, fill = rainbow_hcl(3))



# ================================================================
# 监督分类方法
# ================================================================


# ================================================================
# KNN - k-nearest neighbour classification
# ================================================================
set.seed(12L)
tr <- sample(150, 50)
ts <- sample(150, 50)
x=iris[, 1:4]
knn_model <- knn(train = x[tr, ],test = x[ts,], iris$Species[tr])
head(knn_model)
res = table(knn_model, iris$Species[ts])
knitr::kable(
  res, caption = 'k-means分类精度',
  booktabs = TRUE
)
mean(knn_model == iris$Species[ts])


# ================================================================
# 决策树(Decision trees)
# ================================================================
x=iris
dt_model <- rpart::rpart(Species ~ ., data = x,
           method = "class")
graphics.off()
rpart.plot::rpart.plot(dt_model)
# -----------------------
p <- predict(dt_model, x, type = "class")
res = table(p, x$Species)

knitr::kable(
  res, caption = '分类精度',
  booktabs = TRUE
)





# ================================================================
# 支持向量机(SVM)
# ================================================================
# reference: https://rstudio-pubs-static.s3.amazonaws.com/515710_c0433490253f45c281f74b286c455419.html
data(iris)
svm_model <- svm(Species ~ ., data=iris,
                 kernel="radial") #linear/polynomial/sigmoid/radial
summary(svm_model)

graphics.off()
plot(svm_model, data=iris, col=rainbow_hcl(3),
     Petal.Width~Petal.Length,
     slice = list(Sepal.Width=3, Sepal.Length=4) )

#------------
pred = predict(svm_model,iris)
res = table(Predicted=pred, Actual = iris$Species)

knitr::kable(
  res, caption = '分类精度',
  booktabs = TRUE
)

1-sum(diag(res)/sum(res))


# ================================================================
# 随机森林(Random Forest)
# ================================================================
# Reference: https://lmavila.github.io/markdown_files/RF_Toy.html
library(randomForest)
set.seed(12L)
tr <- sample(150, 100)
ts <- sample(150, 50)
x=iris
rf_model <- randomForest(Species~.,data=x[tr,],ntree=100,proximity=TRUE)
print(rf_model)

res= table(predict(rf_model),x$Species[tr])
knitr::kable(
  res, caption = '训练集分类精度',
  booktabs = TRUE
)

x.pred<-predict(rf_model,newdata=x[ts,])
res = table(x.pred, x$Species[ts])
knitr::kable(
  res, caption = '测试集分类精度',
  booktabs = TRUE
)
