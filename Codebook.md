#Introduction

This codebook will discuss about all the steps taken to reach from raw datasets mentioned in Readme.md to the Tidy Data Set.


##Step 1.

We will loading the Library(Dplyr) as we we will be using some functions of the dplyr package

We will read the test data files(X_TEST) and training data files (X_TRAIN) from our working directory where the complete Zip file is extracted and unpacked.

We will be using commands such as cbind() to combine Activity ID , and the Subject IDs with the test and training data for preparing our data. We will be using rbind() command to combine test and train data(there should 10299 Rows of Data)

##Step 2.

In the start, we were provided 561 Column vector for the data. However, we are only interested in columns with mean and std in them. We will use grep() command to extract only those columns which have mean and std in them. 

## Step 3.

In the step 1, we have extracted the activity ids . However, we would need proper Activity labels to present information in a more consumable manner in each data row.

## Step 4.

We wil now be labelling datasets with more meaningful and descriptive variable names.

In the Tidy Data set , there will be 81 transformed variables. We have used sub() command to find and replace various patters.For example, I have created a sample table with transformations listed for the variables. 

|OldValue|NewValue|
|--------|--------|
|tBodyAcc-mean()-X|Time.Domain.Signal.Body.Linear.Acceleration.Average.Value.along.X.axis.of.Smartphone|
|tBodyAccJerk-std()-X|Time.Domain.Signal.Body.Linear.Acceleration.JerkStandard.Deviation.along.X.axis.of.Smartphone|
|tGravityAcc-mean()-Z|Time.Domain.Signal.Gravity.Acceleration.Average.Value.along.Z.axis.of.Smartphone|
|fBodyBodyGyroJerkMag-std()|Fourier.Transformation.Body Angular Velocity MagnitudeStandard.Deviation|
|tBodyAccJerkMag-std()|Time.Domain.Signal.Body.Linear.Acceleration.JerkMagStandard.Deviation|

## Step 5.

Finally, we will take the 10299 observations of 81 variables and use aggregate function to take mean of all the 81 variables, for the grouping condition of Subject and Activity.

We will then order the data based on each subject and write the table to a text file called tidy.text with tab seperator.

##Subjects
The Tidy Dataset's column name "Subject" represents the 30 subjects with values ranging from 1 to 30. 

##Activity Labels
|Value|Activity|Description|
|-----|--------|-----------|
|1|Walking|Subject was walking|
|2|Walking_Upstairs|Subject was walking Upstairs on the staircase|
|3|Walking_Downstairs|Subject was Downstarts on the staircase|
|4|Sitting|Subject was sitting|
|5|Standing|Subject was standing|
|6|Laying|Subject was laying|
