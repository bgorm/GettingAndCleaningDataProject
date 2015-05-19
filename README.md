---
title: "Getting and Cleaning Data Project"
author: bgorm
output: html_document
---

This project contains the following files:

* "run_analysis.R": script that reads human activity recognition (HAR) data from the UCI machine learning repository, then cleans, merges, and reshapes the data

* "CodeBook.MD": Description of all variables in the data set.

The following files were written by the script:  

* "HAR_full_tidy_dataset.txt": full tidy data set (combining both training and test data sets) with merged features, labels, and subject IDs 

* "descriptive_stats.txt": mean and standard deviation of each feature variable

* "feature_mean_per_subject.class.txt": means of each feature variable aggregated per subject ID and class label  


Data source:
========

"The experiments have been carried out with a group of 30 volunteers within an age bracket of 19-48 years. Each person performed six activities (WALKING, WALKING_UPSTAIRS, WALKING_DOWNSTAIRS, SITTING, STANDING, LAYING) wearing a smartphone (Samsung Galaxy S II) on the waist. Using its embedded accelerometer and gyroscope, we captured 3-axial linear acceleration and 3-axial angular velocity at a constant rate of 50Hz. The experiments have been video-recorded to label the data manually. The obtained dataset has been randomly partitioned into two sets, where 70% of the volunteers was selected for generating the training data and 30% the test data."

[1] Davide Anguita, Alessandro Ghio, Luca Oneto, Xavier Parra and Jorge L. Reyes-Ortiz. Human Activity Recognition on Smartphones using a Multiclass Hardware-Friendly Support Vector Machine. International Workshop of Ambient Assisted Living (IWAAL 2012). Vitoria-Gasteiz, Spain. Dec 2012

This dataset is distributed AS-IS and no responsibility implied or explicit can be addressed to the authors or their institutions for its use or misuse. Any commercial use is prohibited.
