Cleaning Data Course Project
============================


Assumptions
-----------

The following packages have been installed through `install.packages`:

1. dplyr
2. reshape2

Samsung data is present in the working directory (the root of the zipped archive).


run_analysis.R
--------------
R Script responsible for cleaning up the Samsung data.

1. Load the descriptive measurement names from ./features.txt
2. Load the descriptive activity labels from ./activity_labels.txt
3. Combine the training and test datasets by concatenating (./train/y_train.txt + ./train/X_train.txt) to (./test/y_test.txt + ./test/X_test.txt)
4. Merge the activity labels from #2 into the whole dataset from #3 to get descriptive activity labels on the whole dataset
5. Select only the activity name and measurements of the mean or standard deviation
6. Melt all the measurements into a variable column
7. Cast the melted data into a summary of average values by activity label
8. Write the result to ./output-data.txt
