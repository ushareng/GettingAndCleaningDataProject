Basic Description of the project(Quoted from UCI website) :

The experiments have been carried out with a group of 30 volunteers within an age bracket of 19-48 years.
Each person performed six activities (WALKING, WALKING_UPSTAIRS, WALKING_DOWNSTAIRS, SITTING, STANDING, 
LAYING)wearing a smartphone (Samsung Galaxy S II) on the waist. Using its embedded accelerometer and 
gyroscope, we captured 3-axial linear acceleration and 3-axial angular velocity at a constant rate of 50Hz.
The experiments have been video-recorded to label the data manually. The obtained dataset has been randomly
partitioned into two sets, where 70% of the volunteers was selected for generating the training data and 30%
the test data. 

The sensor signals (accelerometer and gyroscope) were pre-processed by applying noise filters and then sampled
in fixed-width sliding windows of 2.56 sec and 50% overlap (128 readings/window). The sensor acceleration signal,
which has gravitational and body motion components, was separated using a Butterworth low-pass filter into body
acceleration and gravity. The gravitational force is assumed to have only low frequency components, therefore a
filter with 0.3 Hz cutoff frequency was used. From each window, a vector of features was obtained by calculating
variables from the time and frequency domain. See 'features_info.txt' for more details.

Transformation made to the Data :


1. Test and training data is merged together and stored in MergeData. The functions used for this are cbind() and rbind().
2. Only the features mentioned in features.txt is extracted from MergeData using subsetting.
3. Post that only the measurements which contain mean and standard deviation is extracted. This is achieved
   using grep()
4. Descriptive names are given to the activities and then it is merged with the MergeData using merge()
5. Post that the data set is labelled with descriptive variable names . This is achieved by manipulating the variable names
   using gsub function. 
6. The average of each variable for each subject and activity is achieved using dplyr verbs group_by(), summarise_all()
   and arrange.
7. Using write.table() the output data file is stored in tidy.txt.

Variables in tidy.txt :

The following are the variables in tidy.txt

 activityName
 subjectId
 timeBodyAccMagnitudeMean 
 timeBodyAccMagnitudeStdDev     
 timeGravityAccMagnitudeMean
 timeGravityAccMagnitudeStdDev 
 timeBodyAccJerkMagnitudeMean 
 timeBodyAccJerkMagnitudeStdDev 	 
 timeBodyGyroMagnitudeMean    
 timeBodyGyroMagnitudeStdDev
 timeBodyGyroJerkMagnitudeMean 
 timeBodyGyroJerkMagnitudeStdDev   
 freqBodyAccMagnitudeMean     
 freqBodyAccMagnitudeStdDev   
 freqBodyAccJerkMagnitudeMean  
 freqBodyAccJerkMagnitudeStdDev 
 freqBodyGyroMagnitudeMean  
 freqBodyGyroMagnitudeStdDev 
 freqBodyGyroJerkMagnitudeMean 
 freqBodyGyroJerkMagnitudeStdDev

 
Brief explanation of the variables :

1. The variables which end with Mean are mean values of multiple measurements of the original 
   variables. Type: Real number

2. The variables which end with StdDev are Standard deviation of multiple measurements of the original
   variables. Type: Real number

3. activityName: Descriptive name of each subject's activity Type: Factor Values: WALKING, WALKING_UPSTAIRS,
   WALKING_DOWNSTAIRS, SITTING, STANDING, LAYING

4. subjectId :	Identifier, identifying each subject Type: Integer Values: 1 : 30
