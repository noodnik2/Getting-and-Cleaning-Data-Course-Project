CodeBook for Tidy Data
======================

Documentation of "wide" (standard) dataset produced by the "har.create.and.write.datasets()" function in "run_analysis.R"


Overview
--------

A "wide" tidy data set containing averaged measurements from each of the train and test measurements datasets collected
as part of the HAR study.  A "wide" data set is produced by default in order to preserve the original form of the data
per the study.  The data are "tidy" in this form inasmuch as each variable holds information unrelated to any other.

Note that the script can also produce a "tall" version of this tidy dataset as documented in the README.md file.  In 
the "tall" case, exactly one "value" is produced for each "variable", and the same results are presented in a "pivoted",
tall form, the same as as described below with the grouping variables in common, and the "variable" and "value" variables
added instead of the 66 measurements variables present in the "wide" form.


Grouping Variables
------------------

1.	data.series - the data series from which the average measurements was calculated (i.e., "test" or "train")
2.	activity.name - activity name common to the averaged measurements
3.	subject.id - subject id common to the averaged measurements
4.	n.measurements - number of measurements common for the given subject, activity and data series


Measurements
------------

Averages of each of 66 measurement variables, named according to a standard R-transformation
of the original names of the HAR "mean" and "standard deviation" data variables (those HAR
variables whose name end with either "mean()" or "std()").  See the HAR codebook for the
underlying meaning of each of these measurements.

5.	tBodyAcc.mean...X
6.	tBodyAcc.mean...Y
7.	tBodyAcc.mean...Z
8.	tBodyAcc.std...X
9.	tBodyAcc.std...Y
10.	tBodyAcc.std...Z
11.	tGravityAcc.mean...X
12.	tGravityAcc.mean...Y
13.	tGravityAcc.mean...Z
14.	tGravityAcc.std...X
15.	tGravityAcc.std...Y
16.	tGravityAcc.std...Z
17.	tBodyAccJerk.mean...X
18.	tBodyAccJerk.mean...Y
19.	tBodyAccJerk.mean...Z
20.	tBodyAccJerk.std...X
21.	tBodyAccJerk.std...Y
22.	tBodyAccJerk.std...Z
23.	tBodyGyro.mean...X
24.	tBodyGyro.mean...Y
25.	tBodyGyro.mean...Z
26.	tBodyGyro.std...X
27.	tBodyGyro.std...Y
28.	tBodyGyro.std...Z
29.	tBodyGyroJerk.mean...X
30.	tBodyGyroJerk.mean...Y
31.	tBodyGyroJerk.mean...Z
32.	tBodyGyroJerk.std...X
33.	tBodyGyroJerk.std...Y
34.	tBodyGyroJerk.std...Z
35.	tBodyAccMag.mean..
36.	tBodyAccMag.std..
37.	tGravityAccMag.mean..
38.	tGravityAccMag.std..
39.	tBodyAccJerkMag.mean..
40.	tBodyAccJerkMag.std..
41.	tBodyGyroMag.mean..
42.	tBodyGyroMag.std..
43.	tBodyGyroJerkMag.mean..
44.	tBodyGyroJerkMag.std..
45.	fBodyAcc.mean...X
46.	fBodyAcc.mean...Y
47.	fBodyAcc.mean...Z
48.	fBodyAcc.std...X
49.	fBodyAcc.std...Y
50.	fBodyAcc.std...Z
51.	fBodyAccJerk.mean...X
52.	fBodyAccJerk.mean...Y
53.	fBodyAccJerk.mean...Z
54.	fBodyAccJerk.std...X
55.	fBodyAccJerk.std...Y
56.	fBodyAccJerk.std...Z
57.	fBodyGyro.mean...X
58.	fBodyGyro.mean...Y
59.	fBodyGyro.mean...Z
60.	fBodyGyro.std...X
61.	fBodyGyro.std...Y
62.	fBodyGyro.std...Z
63.	fBodyAccMag.mean..
64.	fBodyAccMag.std..
65.	fBodyBodyAccJerkMag.mean..
66.	fBodyBodyAccJerkMag.std..
67.	fBodyBodyGyroMag.mean..
68.	fBodyBodyGyroMag.std..
69.	fBodyBodyGyroJerkMag.mean..
70.	fBodyBodyGyroJerkMag.std..
