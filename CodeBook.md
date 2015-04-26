# Codebook
##Background
The tidy dataset set created by the run_analysis.R script is made by merging several datasets together. The resulting dataset is "tidy," with one row per observation.

Data comes from the Human Activity Recognition Using Smartphones Dataset Version 1.0. www.smartlab.ws
http://archive.ics.uci.edu/ml/datasets/Human+Activity+Recognition+Using+Smartphones

##Variable
See the original source documentation for more detail. Variable names have been changed so that "f" variables are now clearly labeled "Freq" for frequency, and time variables are clearly indicated instead of T.

Observations are done by subject and activity (WALKING, WALKING_UPSTAIRS, WALKING_DOWNSTAIRS, SITTING, STANDING, LAYING)

##Assumptions
* Assume that the UCI HAR Dataset has already been been downloaded to the working directory and unzipped.
* The script loads the libraries plyr and dplyr. These must have been installed.

