library(dplyr)
#Read the Test Data for all the 564 Variables
testdata<-read.table("X_Test.TXT")
#Read the Test Data for all the Activites 
activity_test<-read.table("y_test.txt")
#Read the Test Data for all the Subjects  
subject_test<-read.table("subject_test.txt")
#Change the name of the Column of Test to "Subject"
colnames(subject_test)[1]<-"Subject"
#Read the Train Data for all the Subjects  
subject_train<-read.table("subject_train.txt")
#Change the name of the Column of Train to "Subject"
colnames(subject_train)[1]<-"Subject"
#Combine Test Data Columns with Activities Columns as we get closer to 
#Today
testdata<-cbind(testdata,activity_test)
#Rename the last column of testdata to ActivityName as we are interested
#in that data
colnames(testdata)[562]<-c("ActivityName")
#Read Activity Details such as "Standing" etc
activity_label<-read.table("activity_labels.txt")
colnames(activity_label)[1]<-c("ActivityName")
#Join Test Data with Activity Label , which is descriptive
testdata<-left_join(testdata,activity_label,by = "ActivityName")
#Combine Test Data with Subject on whom the experiements were performed
testdata<-cbind(testdata,subject_test)
# Similarly Prepare Train Data by
#a)Reading and combining the experiment data with
#b)Activity Description Data and with
#c)Subject Name
traindata<-read.table("X_Train.TXT")
activity_train<-read.table("y_train.txt")
traindata<-cbind(traindata,activity_train)
colnames(traindata)[562]<-c("ActivityName")
traindata<-left_join(traindata,activity_label,by = "ActivityName")
traindata<-cbind(traindata,subject_train)
#Combine Train Data and Test Data Together
# 1........The First Answer of our Course Project"
mergeddata<-rbind(testdata,traindata)
# Now we will add Descriptive Features Details instead of V1/V2/V3/V4.. 
tablecolumns<-read.table("Features.txt")
tablecolumns_a<-tablecolumns
tablecolumns<-tablecolumns[,2]
colnames(mergeddata)<-tablecolumns
#3 The Third Answer - I just changed the order . Column # 563 is 
#Descriptive Activity
colnames(mergeddata)[563]<-c("Descriptive.Activity")
colnames(mergeddata)[564]<-c("Subject")
# Now we will only add all the columns that have a Mean/Standard Deviation
#Descriptive Activity / Subject
definecolumns_indices<-grep("mean()|std()|Descriptive.Activity|Subject",colnames(mergeddata))
#2... The Second Answer
#Extracts only the measurements on the mean and 
#standard deviation for each measurement. 
mergeddata<-mergeddata[definecolumns_indices]
definecolumns_values<-grep("mean()|std()|Descriptive.Activity|Subject",colnames(mergeddata),value = TRUE)
definecolumns<-cbind(definecolumns_indices,definecolumns_values)
definecolumns<-data.frame(definecolumns)
definecolumns$definecolumns_values<-sub(" ","",
                                        definecolumns$definecolumns_values
                                        ,ignore.case = FALSE,fixed = TRUE)
definecolumns$definecolumns_values<-sub("X",".along.X.axis.of.Smartphone",
                                       definecolumns$definecolumns_values
                                       ,ignore.case = FALSE,fixed = TRUE)
definecolumns$definecolumns_values<-sub("Y",".along.Y.axis.of.Smartphone",
                                        definecolumns$definecolumns_values
                                        ,ignore.case = FALSE,fixed = TRUE)
definecolumns$definecolumns_values<-sub("Z",".along.Z.axis.of.Smartphone",
                                        definecolumns$definecolumns_values
                                        ,ignore.case = FALSE,fixed = TRUE)
definecolumns$definecolumns_values<-sub("std","Standard.Deviation",
                                        definecolumns$definecolumns_values
                                        ,ignore.case = FALSE,fixed = TRUE)
definecolumns$definecolumns_values<-sub("mean","Average.Value",
                                        definecolumns$definecolumns_values
                                        ,ignore.case = FALSE,fixed = TRUE)
definecolumns$definecolumns_values<-sub("mag",".Magnitude",
                                        definecolumns$definecolumns_values
                                        ,ignore.case = FALSE,fixed = TRUE)
definecolumns$definecolumns_values<-sub("tBodyAcc","Time.Domain.Signal.Body.Linear.Acceleration.",
                                        definecolumns$definecolumns_values
                                        ,ignore.case = FALSE,fixed = TRUE)
definecolumns$definecolumns_values<-sub("tGravityAcc","Time.Domain.Signal.Gravity.Acceleration.",
                                        definecolumns$definecolumns_values
                                        ,ignore.case = FALSE,fixed = TRUE)
definecolumns$definecolumns_values<-sub("tBodyGyro","Time.Domain.Signal.Angular.Velocity.",
                                        definecolumns$definecolumns_values
                                        ,ignore.case = FALSE,fixed = TRUE)
definecolumns$definecolumns_values<-sub("fBodyAcc","Fourier.Transformation.Body.Linear.Acceleration.",
                          definecolumns$definecolumns_values
                          ,ignore.case = FALSE,fixed = TRUE)
definecolumns$definecolumns_values<-sub("fGravityAcc","Fourier.Transformation.Gravity.Acceleration.",
                                        definecolumns$definecolumns_values
                                        ,ignore.case = FALSE,fixed = TRUE)
definecolumns$definecolumns_values<-sub("fBodyGyro","Fourier.Transformation.Angular.Velocity.",
                                        definecolumns$definecolumns_values
                                        ,ignore.case = FALSE,fixed = TRUE)
definecolumns$definecolumns_values<-sub("fBodyBodyAccJerkMag","Fourier.Transformation.Angular.Velocity.Jerk.Magnitude.",
                                        definecolumns$definecolumns_values
                                        ,ignore.case = FALSE,fixed = TRUE)
definecolumns$definecolumns_values<-sub("fBodyBodyGyroMag","Fourier.Transformation.Angular.Velocity Magnitude",
                                        definecolumns$definecolumns_values
                                        ,ignore.case = FALSE,fixed = TRUE)
definecolumns$definecolumns_values<-sub("fBodyBodyGyroJerkMag","Fourier.Transformation.Body Angular Velocity Magnitude",
                                        definecolumns$definecolumns_values
                                        ,ignore.case = FALSE,fixed = TRUE)
definecolumns$definecolumns_values<-sub("()","",
                                        definecolumns$definecolumns_values
                                        ,ignore.case = FALSE,fixed = TRUE)
definecolumns$definecolumns_values<-gsub("-","",
                                        definecolumns$definecolumns_values
                                        ,ignore.case = TRUE,fixed = FALSE)
#4... In this step the data set is appropriately labeled
#with descriptive variable names. 
colnames(mergeddata)<-definecolumns$definecolumns_values
tidydata<-aggregate(.~mergeddata$Subject+mergeddata$Descriptive.Activity,mergeddata,mean)
colnames(tidydata)[1:2]<-c("Subject","Activity")
#5....Creation of a Tidy Data Set
tidydata<-tidydata[,1:81]
write.table(tidydata,file ="tidy.txt",sep = "\t" ,row.names = FALSE)
