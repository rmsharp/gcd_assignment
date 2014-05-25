# Making a Tidy Data Set from the UCI HAR Dataset

## Combining of Data
The combined data are in a directory names "all" that is parallel to the
"train" and "test" directories. All files of the same name between
the "train" and "test" directories were concatenated to make the 
combined files of the same names in the "all" directory.

## Extracting Measurements of Means and Standard Deviations
The measurement features with the text "mean()" or "std()" were used
to select the columns of interest.

## Appropriately Labeled Columns

Hyphens and Parentheses Were Removed from Column Names
The tidy data file is "mean_std_tidy_data.txt"