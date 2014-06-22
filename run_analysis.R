# 
#   The purpose of this project is to demonstrate your ability to collect,
#   work with, and clean a data set. The goal is to prepare tidy data that
#   can be used for later analysis.
#
#   You will be graded by your peers on a series of yes/no questions related
#   to the project.
#
#   You will be required to submit:
#
#   1)  a tidy data set as described below,
#
#   2)  a link to a Github repository with your script for performing the analysis, and;
#
#   3)  a code book that describes the variables, the data, and any transformations
#       or work that you performed to clean up the data called CodeBook.md.
#
#   You should also include a README.md in the repo with your scripts. 
#   This repo explains how all of the scripts work and how they are connected.
# 
#   One of the most exciting areas in all of data science right now is wearable computing - see for example this article . Companies like Fitbit, Nike, and Jawbone Up are racing to develop the most advanced algorithms to attract new users. The data linked to from the course website represent data collected from the accelerometers from the Samsung Galaxy S smartphone. A full description is available at the site where the data was obtained: 
# 
#       http://archive.ics.uci.edu/ml/datasets/Human+Activity+Recognition+Using+Smartphones 
# 
#   Here are the data for the project: 
# 
#       https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip 
# 
#   You should create one R script called run_analysis.R that does the following:
#
#       1)  Merges the training and the test sets to create one data set.
#
#       2)  Extracts only the measurements on the mean and standard deviation
#           for each measurement.
#
#       3)  Uses descriptive activity names to name the activities in the data set
#
#       4)  Appropriately labels the data set with descriptive variable names.
#
#       5)  Creates a second, independent tidy data set with the average of each
#           variable for each activity and each subject. 
#

#
#   function har.get.data.fullpath(in.data.file)
#
#   Returns the full path to the specified HAR data file
#   by simply 
#
har.get.data.fullpath <- function(in.data.file) {
    sprintf("%s/%s", har.data.folder, in.data.file)
}

#
#   function har.get.fwf.widths(in.indices, in.collength)
#
#       Returns an integer vector giving the widths of the fixed-width fields,
#       as specified for the "width" parameter of the 'read.fwf{utils}' function
#   
#
har.get.fwf.widths <- function(in.indices, in.collength) {
    
    lengths <- diff(sort(unique(c(0, in.indices))) * in.collength)
    
    cols <- c()
    for (n in lengths) {
        if (n != in.collength) {
            cols <- c(cols, in.collength - n)
        }
        cols <- c(cols, in.collength)
    }
    
    cols
}

#
#   function har.read.features.matching.pattern(
#       in.features.file,
#       in.matching.pattern
#   )
#
#       Reads and returns a subset of the "features" file containing
#       the index and the name of the features whose name matches the
#       supplied regular expression.
#
#       Returns a data frame having two columns:
#
#           feature.index - index of the matching feature column
#           feature.name - name of the matching feature column
#
#       The default regular expression will match all features whose
#       names end in either "mean()" or "std()", as described as the
#       variables representing "Mean value" or "Standard deviation"
#       in the raw data "features info" document).
#
har.read.features.matching.pattern <- function(
    in.features.file = "features.txt",
    in.matching.pattern = "(mean|std)\\(\\)" 
) {
    
    # read the features data frame
    all.features <- read.table(
        har.get.data.fullpath(in.features.file), 
        sep = " ",
        col.names = c("feature.index", "feature.name"),
        stringsAsFactors = FALSE
    )
    
    # keep only the features whose names match the pattern
    subset(all.features, grepl(in.matching.pattern, feature.name))
    
}

#
#   function har.read.activity.labels(in.activity.labels.file)
#
#       Reads the activity labels file, returning a data frame
#       having two columns:
#
#           activity.id - the numeric activity identifier
#           activity.name - the human-readable label for the activity
#
har.read.activity.labels <- function(
    in.activity.labels.file = "activity_labels.txt"
) {
    
    read.table(
        har.get.data.fullpath(in.activity.labels.file), 
        sep = " ",
        col.names = c("activity.id", "activity.name")
    )
    
}

#
#   function har.read.activity.data(
#       in.activity.data.file,
#       in.activity.labels
#   )
#
#   Reads and returns the specified activity data file as a vector
#   having the (mapped, human-readable) activity factor label
#   corresponding to the activity code for each record in the
#   measurement data for the same series.
#
#   See also:
#       har.read.activity.labels()
#
har.read.activity.data <- function(in.activity.data.file, in.activity.labels) {
    
    activity.data <- read.table(
        har.get.data.fullpath(in.activity.data.file), 
        sep = " ",
        col.names = c("activity.id")
    )
    
    merge.data.frame(
        activity.data, 
        in.activity.labels,
        sort = FALSE
    )$activity.name
}

#
#   function har.read.subject.data(in.subject.data.file)
#
#   Reads and returns the specified subject data file as a vector
#   having the subject identifier (as a factor) for each record
#   in the measurement dataset for the corresponding series.
#
har.read.subject.data <- function(in.subject.data.file) {

    read.table(
        har.get.data.fullpath(in.subject.data.file), 
        sep = " ",
        colClasses = c("factor")
    )[,1]
    
}

#
#   function har.read.measurement.data(
#       in.measurement.data.file, 
#       in.features, 
#       in.col.width
#   )
#
#   Reads and returns a data frame containing measurement data:
#
#       - from the file specified by "in.measurement.data.file"
#       - for the feature(s) specified by "in.features"
#
#   See also:
#       har.read.features.matching.pattern()
#
har.read.measurement.data <- function(
    in.measurement.data.file, 
    in.features
) {
    
    # 16: all columns in the HAR data are 16 characters wide
    fwf.widths <- har.get.fwf.widths(in.features$feature.index, 16)
    
    read.fwf(
        har.get.data.fullpath(in.measurement.data.file), 
        fwf.widths,
        col.names = in.features$feature.name
    )
    
}

#
#   function har.read.tidy.series(in.data.series)
#
#   Reads and returns measurement data feature subset for the specified series.
#   The default series c("train", "test") are used if not provided.
#
har.read.tidy.series <- function(in.data.series = c("train", "test")) {
    
    selected.features <- har.read.features.matching.pattern()
    activity.labels <- har.read.activity.labels()
    
    result <- data.frame()    
    for (data.series in in.data.series) {
        
        files <- c(
            subjects = sprintf("%1$s/subject_%1$s.txt", data.series),
            activities = sprintf("%1$s/y_%1$s.txt", data.series),
            measurements = sprintf("%1$s/X_%1$s.txt", data.series)            
        )
        
        har.subjects <- har.read.subject.data(files["subjects"])
        har.activities <- har.read.activity.data(files["activities"],  activity.labels)        
        har.measurements <- har.read.measurement.data(files["measurements"], selected.features)
        
        result <- rbind(
            result,
            data.frame(
                data.series = data.series,
                subject.id = har.subjects,
                activity.name = har.activities,
                har.measurements
            )
        )
    }
    
    result
}

#
#   function har.build.tidy.agg(in.tidy.series)
#
#   Returns an "aggregated" data frame with averaged measurements
#   for rows in "in.tidy.series" for each combination of variables
#   "data.series", "activity.name" and "subject.id", and adds
#   a variable named "n.measurements" containing the number of
#   rows in the original dataset (in.tidy.series) represented
#   by the aggregated row.
#
#   See also:
#       har.read.tidy.series
#
require(data.table)
har.build.tidy.agg <- function(in.tidy.series) {
    
    numeric.columns <- names(in.tidy.series)[
        sapply(
            in.tidy.series, 
            is.numeric
        )
    ]

    tidy.agg = aggregate(
        # aggregate the numeric columns only
        subset(
            in.tidy.series, 
            select = numeric.columns
        ),
        list(
            data.series = in.tidy.series$data.series,
            activity.name = in.tidy.series$activity.name,
            subject.id = in.tidy.series$subject.id
        ),
        mean
    )
    
    tidy.agg.count = data.table(in.tidy.series)[
        ,
        list(n.measurements = .N), 
        by = list(data.series, activity.name, subject.id)
    ]
    
    merge.data.frame(
        tidy.agg.count, 
        tidy.agg,
        sort = FALSE
    )
    
}

#
#   function har.build.tidy.agg.molten(in.tidy.agg)
#
#   Logically "pivots" the aggregated measurements passed in "in.tidy.agg"
#   so that each record contains exactly one aggregated measurement.  In
#   other words, transforms the "wide" dataset represented by "in.tidy.agg"
#   into a "tall" dataset, representing the aggregated measurement as a
#   column factor value.
#   
#   See also:
#       har.build.tidy.agg
#
require(reshape2)
har.build.tidy.agg.molten = function(in.tidy.agg) {
    
    melt(
        in.tidy.agg,
        c(
            "n.measurements", 
            "data.series", 
            "activity.name", 
            "subject.id"
        )
    )
    
}


#
#   har.data.folder -   the base folder location where the HAR data files are stored
#                       (use "." if the data files are stored in the current working directory)
#
#har.data.folder <- "C:/Users/rossma/Documents/My Notes/Personal/Learning/Getting and Cleaning Data/Artifacts/Project/UCI HAR Dataset"
har.data.folder <- "."

#
#
#   Perform the full sequence of steps to extract, transform and save
#   the desired HAR data according to the assignment:
#
#       1. extract the desired measurements from the HAR data
#       2. aggregate the data calculating mean measurement values
#       3. save the aggregated records to a file
#
har.create.and.write.datasets = function(in.output.file = "tidy.agg.csv") {

    print("reading tidy series");
    tidy.series = har.read.tidy.series();
    
    print("aggregating tidy series");
    tidy.agg = har.build.tidy.agg(tidy.series);
    
    # optional: un-comment the line below to produce a "molten" (narrow) version of the tidy data
    # tidy.agg = har.build.tidy.agg.molten(tidy.agg)
    
    print("writing aggregated tidy series");
    write.csv(tidy.agg,  in.output.file);
    
    tidy.data
}

# end of file
