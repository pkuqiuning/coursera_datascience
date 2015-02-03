# Codebook
We present combined and summarized data set of 180 observations (30 test subjects, 6 kind of activities) with 68 entries, which was processed from the [UCI Human Activity Recognition Using Smartphones Data Set](http://archive.ics.uci.edu/ml/datasets/Human+Activity+Recognition+Using+Smartphones) (UCI HAR Dataset)

## UCI HAR Dataset
The original data set was separated into training set (8977 observations) and test set (2947 observations) with the following variables: 
- 561 features: numerical (0, 1)
- subject number: integer (1-30)
- activity: factor (1-6)

## Data Processing
- The subject number was recorded as subject (1-30)
- The activity was transformed into a factor activity (WALKING, WALKING_UPSTAIRS, WALKING_DOWNSTAIRS, SITTING, STANDING, LAYING). 
- Features in the test set and the training set were temporarily combined into one single table. Only 66 of them representing mean and standard deviation of original measurements were selected. We then created 66 numerical entries by taking the mean of them grouped by subject and activity. We named them by translating the names of the old features using the following translation table:

In Old Names | In New Names | Meaning                   | Note
-------------|--------------|---------------------------|---------------------
t            | t            | Time domain signal        | prefix
f            | f            | Frequency domain signal   | prefix
Acc          | Accelerator  | Accelerator measurements  | gravity unit 'g'
Gyro         | Gyroscope    | Gyroscope measurements    | unit: radius/second
-mean()      | Mean         | Moving average            |
-std()       | STD          | Standard deviation        |
Mag          | Magnitude    | Magnitude of measurements |
-X           | _X           | X axis                    | suffix
-Y           | _Y           | Y axis                    | suffix
-Z           | _Y           | Z axis                    | suffix


## Variable Name List

| Entry Name                              |
|-----------------------------------------|
| subject                                 |
| activity                                |
| tBodyAccelerometerMean_X                |
| tBodyAccelerometerMean_Y                |
| tBodyAccelerometerMean_Z                |
| tBodyAccelerometerSTD_X                 |
| tBodyAccelerometerSTD_Y                 |
| tBodyAccelerometerSTD_Z                 |
| tGravityAccelerometerMean_X             |
| tGravityAccelerometerMean_Y             |
| tGravityAccelerometerMean_Z             |
| tGravityAccelerometerSTD_X              |
| tGravityAccelerometerSTD_Y              |
| tGravityAccelerometerSTD_Z              |
| tBodyAccelerometerJerkMean_X            |
| tBodyAccelerometerJerkMean_Y            |
| tBodyAccelerometerJerkMean_Z            |
| tBodyAccelerometerJerkSTD_X             |
| tBodyAccelerometerJerkSTD_Y             |
| tBodyAccelerometerJerkSTD_Z             |
| tBodyGyroscopeMean_X                    |
| tBodyGyroscopeMean_Y                    |
| tBodyGyroscopeMean_Z                    |
| tBodyGyroscopeSTD_X                     |
| tBodyGyroscopeSTD_Y                     |
| tBodyGyroscopeSTD_Z                     |
| tBodyGyroscopeJerkMean_X                |
| tBodyGyroscopeJerkMean_Y                |
| tBodyGyroscopeJerkMean_Z                |
| tBodyGyroscopeJerkSTD_X                 |
| tBodyGyroscopeJerkSTD_Y                 |
| tBodyGyroscopeJerkSTD_Z                 |
| tBodyAccelerometerMagnitudeMean         |
| tBodyAccelerometerMagnitudeSTD          |
| tGravityAccelerometerMagnitudeMean      |
| tGravityAccelerometerMagnitudeSTD       |
| tBodyAccelerometerJerkMagnitudeMean     |
| tBodyAccelerometerJerkMagnitudeSTD      |
| tBodyGyroscopeMagnitudeMean             |
| tBodyGyroscopeMagnitudeSTD              |
| tBodyGyroscopeJerkMagnitudeMean         |
| tBodyGyroscopeJerkMagnitudeSTD          |
| fBodyAccelerometerMean_X                |
| fBodyAccelerometerMean_Y                |
| fBodyAccelerometerMean_Z                |
| fBodyAccelerometerSTD_X                 |
| fBodyAccelerometerSTD_Y                 |
| fBodyAccelerometerSTD_Z                 |
| fBodyAccelerometerJerkMean_X            |
| fBodyAccelerometerJerkMean_Y            |
| fBodyAccelerometerJerkMean_Z            |
| fBodyAccelerometerJerkSTD_X             |
| fBodyAccelerometerJerkSTD_Y             |
| fBodyAccelerometerJerkSTD_Z             |
| fBodyGyroscopeMean_X                    |
| fBodyGyroscopeMean_Y                    |
| fBodyGyroscopeMean_Z                    |
| fBodyGyroscopeSTD_X                     |
| fBodyGyroscopeSTD_Y                     |
| fBodyGyroscopeSTD_Z                     |
| fBodyAccelerometerMagnitudeMean         |
| fBodyAccelerometerMagnitudeSTD          |
| fBodyBodyAccelerometerJerkMagnitudeMean |
| fBodyBodyAccelerometerJerkMagnitudeSTD  |
| fBodyBodyGyroscopeMagnitudeMean         |
| fBodyBodyGyroscopeMagnitudeSTD          |
| fBodyBodyGyroscopeJerkMagnitudeMean     |
| fBodyBodyGyroscopeJerkMagnitudeSTD      |
