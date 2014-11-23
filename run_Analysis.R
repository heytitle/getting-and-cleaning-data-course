library("data.table");

# Step 1: Load all dataset that we need
print ( "LOADING.. DATASETS" );
featureDT       <- data.table( read.table( "UCI HAR Dataset/features.txt" ) );
X_trainDT       <- data.table( read.table( "UCI HAR Dataset/train/X_train.txt" ) );
X_testDT        <- data.table( read.table( "UCI HAR Dataset/test/X_test.txt" ) );
subject_trainDT <- data.table( read.table( "UCI HAR Dataset/train/subject_train.txt" ) );
subject_testDT  <- data.table( read.table( "UCI HAR Dataset/test/subject_test.txt" ) );
Y_trainDT       <- data.table( read.table( "UCI HAR Dataset/train/Y_train.txt" ) );
Y_testDT        <- data.table( read.table( "UCI HAR Dataset/test/Y_test.txt" ) );
activity_label  <- data.table( read.table( "UCI HAR Dataset/activity_labels.txt" ) );

# Step 2: Merge train and test dataset
print ( "Merging.. DATASETS" );
X_mergedDT       <- rbind( X_trainDT, X_testDT );
Y_mergedDT       <- rbind( Y_trainDT, Y_testDT );
subject_mergedDT <- rbind( subject_trainDT, subject_testDT );

# Step 3: Select mean() and std() columns
print ( "Filtering.. columns" );
neededFeatures <- subset( featureDT, grepl('(mean|std)\\(\\)', V2 ) );
colIndex <- neededFeatures[[1]];
X_filterFeature <- X_mergedDT[, colIndex, with = FALSE ];

# Step 4: Set table headers using feature
print ( "Setting.. proper column name" );
setnames( X_filterFeature, as.character(neededFeatures[[2]]) );
setnames( subject_mergedDT, 'SubjectID' )
setnames( Y_mergedDT, 'Activity' );

# Step 5: Replace each Activity ID ( Y_mergedDT ) with activity label
print ( "Replacing.. active ID with its label" );
Y_mergedDT[ , Activity := activity_label[ Activity, 'V2', with=FALSE ] ];

# Step 6: Merge 3 tables( subject, activity and feature ) together
print ( "Merging.. subject, activity and feature data togother" );
result <- cbind( subject_mergedDT, Y_mergedDT, X_filterFeature );

# Step 7: Write final result to `output.txt`
print ( "Writing.. result" );
write.table( result, file = "output.txt", row.name=FALSE )
