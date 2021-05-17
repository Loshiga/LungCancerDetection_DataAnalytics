install.packages('caret')
install.packages("ggplot2")
install.packages("lattice")
library(ggplot2)
library(lattice)
library(caret)
install.packages('rpart.plot')
install.packages("rpart")
library(rpart)
library(rpart.plot)
liver <- read.csv("~/Desktop/LosProject/cancer-patient-data-sets.csv")
View(liver)
set.seed(250)
intrain <- createDataPartition(y =liver$Level, p= 0.6, list = FALSE)
training <- liver[intrain,2:25]
testing <- liver[-intrain,2:25]
anyNA(liver)
trctrl <- trainControl(method = "repeatedcv", number = 10, repeats = 3)
set.seed(250)
dtree_fit <- train(Level ~., data = training, method = "rpart",
                   parms = list(split = "information"),
                   trControl=trctrl,tuneLength = 17)
dtree_fit
prp(dtree_fit$finalModel, box.palette = "Reds", tweak = 1.2)
predict(dtree_fit, newdata = testing[1,])
#`  Levels:1 2
library(tree)
test_pred <- predict(dtree_fit, newdata = testing, type= "raw")
test_pred=factor(c(test_pred))
str(test_pred)
testing$Level=factor(c(testing$Level))
str(testing$Level)
confusionMatrix(test_pred, testing$Level )
#Testing done


