##
## This script has been created to clean the UCI HAR Dataset. It depends on the
## working directory being set to the root directory of the unzipped UCI HAR 
## Dataset. Please see the README.md and CodeBook.md for more information.
##
##
## dplyr package used for combining several distinct flat files of data
## reshape2 package used for rearranging the data from a wide format to a narrow format
library(dplyr)
library(reshape2)

# load the measurement (column) names as features
features <- select(read.table("./features.txt"), measurement_names = V2)

# load the activity labels, renaming the fields
activity_labels <- select(read.table("./activity_labels.txt"), activity_id = V1, activity_name = V2)

# load and label the data, renaming the first field to "activity_id" for easy 
# merging with the activity labels
training_set_with_labels <- cbind(
	select(read.table("./train/y_train.txt"), activity_id = V1), 
	read.table("./train/X_train.txt", col.names=features$measurement_names)
)
test_set_with_labels <- cbind(
	select(read.table("./test/y_test.txt"), activity_id = V1), 
	read.table("./test/X_test.txt", col.names=features$measurement_names)
)

# combine the training dataset and test dataset into one dataset
whole_set <- rbind(training_set_with_labels, test_set_with_labels)

# merge the activity labels with the whole set, to use descriptive activity 
# names in the dataset
whole_set_with_labels <- merge(activity_labels, whole_set)
desired_set <- select(whole_set_with_labels, activity_name, contains("mean"), contains("std"))

# melt the data down into activity_name and variable, turning every other
# column into a variable
selected_names <- names(desired_set)
melted <- melt(desired_set, id=c("activity_name"), measure.vars=selected_names[2:length(selected_names)])

# reassemble the data into a clean, wide format of activity name x variable,
# with variables aggregated by the mean
data <- dcast(melted, activity_name ~ variable, mean)

# create a file with the tidy data
write.table(data, file="./output-data.txt", row.name=FALSE)
