##read data sets into R
labels <- read.table("C:/Users/Elyse/Documents/R/UCIHAR/activity_labels.txt")
xtest <- read.table("C:/Users/Elyse/Documents/R/UCIHAR/test/X_test.txt")
xtrain <- read.table("C:/Users/Elyse/Documents/R/UCIHAR/train/X_train.txt")
ytest <- read.table("C:/Users/Elyse/Documents/R/UCIHAR/test/y_test.txt")
ytrain <- read.table("C:/Users/Elyse/Documents/R/UCIHAR/train/y_train.txt")
subtrain <- read.table("C:/Users/Elyse/Documents/R/UCIHAR/train/subject_train.txt")
subtest <- read.table("C:/Users/Elyse/Documents/R/UCIHAR/test/subject_test.txt")
features <- read.table("C:/Users/Elyse/Documents/R/UCIHAR/features.txt")

##bind data sets together into one data frame
subs <- rbind(subtest,subtrain)
activities <- rbind(ytest,ytrain)
data <- rbind(xtest,xtrain)
colnames(data) <- features[,2]
alldata <- cbind(subs,activities,data)
colnames(alldata)[1] <- "Subjects"
colnames(alldata)[2] <- "Activities"

##extract measurements on mean and standard deviation for each measurement
tidy <- cbind(subs,activities)
means <- grep("mean\\(\\)",names)
stds <- grep("std",names)
for (i in means) {
    x <- alldata[,i]
    tidy <- cbind(tidy,x)
}

for (i in stds) {
    x <- alldata[,i]
    tidy <- cbind(tidy,x)
}

##rename columns in tidy
colnames(tidy)[1] <- "Subjects"
colnames(tidy)[2] <- "Activities"
meannames <- names(alldata[,means])
colnames(tidy)[3:32] <- meannames
stdnames <- names(alldata[,stds])
colnames(tidy)[33:68] <- stdnames

