#Introduction

This codebook will discuss about all the steps taken to reach from raw datasets mentioned in Readme.md to the Tidy Data Set.


##Step 1.

We will loading the Library(Dplyr) as we we will be using some functions of the dplyr package

We will read the test data files(X_TEST) and training data files (X_TRAIN) from our working directory where the complete Zip file is extracted and unpacked.

We will be using commands such as cbind() to combine Activity ID , Activity Description and the Subject IDs with the test and training data for preparing our data. We will be using rbind() command to combine test and train data(there should 10299 Rows of Data)






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
