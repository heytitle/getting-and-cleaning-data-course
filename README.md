# Getting and Cleanning dataset

## Download dataset
```
 # OSX
curl https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip -o dataset.zip & unzip dataset.zip
```

## Usage
```
# OSX
Rscript run_Analysis.R
```

## What does the script do?
Load all required datasets ( subject number, activity, feature measurements ) and clean those dataset as describing below
- activity : replace activity id with its label for example 1 => WALKING
- feature measurement : select only mean and standard deviation of each feature ( 66 columns )

then merged the datasets together and write it to `output.txt`
