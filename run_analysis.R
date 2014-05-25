## run_analysis.R

#' Merges the training and the test sets to create one data set.
require(stringr, quietly = TRUE)
data_dir <- "UCI HAR Dataset/"
test_dir <- "test/"
train_dir <- "train/"
all_dir <- "all/"
get_file_vector <- function (dir, type) {
  str_c(data_dir, dir, str_split(str_c("subject_", type, ".txt, ",
               "X_", type, ".txt, ", 
               "y_", type, ".txt, ", 
               "Inertial Signals/body_acc_x_", type, ".txt, ", 
               "Inertial Signals/body_acc_y_", type, ".txt, ", 
               "Inertial Signals/body_acc_z_", type, ".txt, ", 
               "Inertial Signals/body_gyro_x_", type, ".txt, ",
               "Inertial Signals/body_gyro_y_", type, ".txt, ",
               "Inertial Signals/body_gyro_z_", type, ".txt, ",
               "Inertial Signals/total_acc_x_", type, ".txt, ",
               "Inertial Signals/total_acc_y_", type, ".txt, ",
               "Inertial Signals/total_acc_z_", type, ".txt"), ", ")[[1]])
}

train_files <- get_file_vector("train/", "train")
test_files <- get_file_vector("test/", "test")
all_files <- get_file_vector("all/", "all")
file.create(all_files)
file.append(all_files, train_files)
file.append(all_files, test_files)
#' Extracts only the measurements on the mean and standard deviation for 
#' each measurement. 
features <- read.table(str_c(data_dir, "features.txt"), header = FALSE)[ , 2]
#' Get the mean and standard deviation features.
mean_std_features_col <- str_detect(features, "mean()") |
  str_detect(features, "std()")
mean_std_features <- features[mean_std_features_col]
mean_std_features <- str_replace_all(mean_std_features, "-", ".")
mean_std_features <- str_replace_all(mean_std_features, "[()]", "")

#' Get the vector of file names of files with features
file_with_mean_std <- all_files[str_detect(all_files, "X_all.txt") &
                                   !str_detect(all_files, "Inertial Signals")]
mean_std_df <- read.table(files_with_mean_std, 
                            header = FALSE)[, mean_std_features_col]
names(mean_std_df) <- mean_std_features
subjects_all_df <- read.table(str_c(data_dir, all_dir, "subject_all.txt"), 
                              header = FALSE)
mean_std_df <- data.frame(subject = subjects_all_df[, 1], mean_std_df)
write.table(mean_std_df, file = "mean_std_tidy_data.txt", sep = ",")
#' Uses descriptive activity names to name the activities in the data set
#' 
#' Appropriately labels the data set with descriptive activity names.
#' 
#' Creates a second, independent tidy data set with the average of each variable for each activity and each subject.
library(plyr)
averages_df <- ddply(mean_std_df, .(subject), .fun = mean)
